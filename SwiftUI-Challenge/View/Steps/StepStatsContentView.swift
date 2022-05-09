//
//  StepStatsContentView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/9/22.
//
import SwiftUI
import SwiftUIPager


struct StepStatsContentView: View , StepsTabDelegate{
    
    
    @StateObject var stepsViewModel = StepsViewModel()
    private var fakeTab = StepsTab(tabType: .loading)
    @State private var chartPage: Page = .first()
        
    @State var selectedStep = Step(count: 0, date: Date())
    
    @State var chartDate: String = ""
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
    }

    var body: some View {
        
        NavigationView{
            GeometryReader{geo in
                ZStack(alignment: .top){
                    
                    Color
                        .black
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        ZStack(alignment: .bottomLeading){
                            Divider()
                                .background(Color.white.opacity(0.3))
                                .padding(.bottom, 5)
                                .padding(.trailing, 40)
                            Text(chartDate)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                                .background(Color.black)
                        }
                        
                        Pager(page: chartPage, data: stepsViewModel.tabItems+[fakeTab], id: \.id) { tab in
                            
                            if tab != fakeTab {
                                
                                StepStatsChartView(tabItem: tab,
                                stepsMax: getMaxStepNumberOf(steps: tab.steps),
                                delegate: self)
                                
                            } else {
                                ProgressView()
                            }
                        }
                        .horizontal(.rightToLeft)
                        .onPageChanged { newPage in
//                            guard newPage == stepsViewModel.tabItems.count else{ return }
                            
                            if newPage == stepsViewModel.tabItems.count{
                                let endDate = Calendar.current.date(byAdding: .day, value: -1, to: stepsViewModel.tabItems[newPage-1].startDate)!
                                let startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)!
                                
                                changeChartDate(from: startDate, to: endDate)
                                stepsViewModel.getNewStepTab(from: startDate,
                                                     to: endDate)
                            }else{
                                changeChartDate(from:
                                                    stepsViewModel.tabItems[newPage].startDate,
                                                to: stepsViewModel.tabItems[newPage].endDate)

                            }
                            
                        }
                        .frame(width: geo.size.width, height: geo.size.height/2.5, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 0){
                            let weekDayIndex = Calendar.current.component(.weekday, from: selectedStep.date)-1
                            let weekDay = DateFormatter().weekdaySymbols[weekDayIndex]
                            
                            Text(String(weekDay))
                                .foregroundColor(Color("mainColor"))
                            
                            HStack(alignment: .firstTextBaseline){
                                Image("stepStats")
                                    .resizable()
                                    .foregroundColor(.yellow)
                                    .frame(width: 40, height: 40)
                                    
                                
                                Text(String(selectedStep.count))
                                    .font(Font.custom("Avenir", size: 50))
                                    .foregroundColor(.white)
                                    .bold()
                                Text("steps")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                        Spacer()
                    }.padding()
                }
            }
            .navigationBarTitle(Text("Steps"))
        }.onAppear {
            if stepsViewModel.tabItems.isEmpty{
                let endDate = Date()
                let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
                changeChartDate(from: startDate, to: endDate)
                    stepsViewModel.getNewStepTab(from: startDate,
                                     to: endDate)
            }
        }
    }
    
    func stepSelected(step: Step) {
        selectedStep = step
    }
    
    
    func changeChartDate(tab: StepsTab){
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let startDate = dateFormatterPrint.string(from: tab.startDate)
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        let endDate = dateFormatterPrint.string(from: tab.endDate)
        chartDate = "\(startDate) - \(endDate)"
    }
    
    func changeChartDate(from startDate: Date, to endDate: Date){
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let startDate = dateFormatterPrint.string(from: startDate)
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        let endDate = dateFormatterPrint.string(from: endDate)
        chartDate = "\(startDate) - \(endDate)"
    }
    
    private func getMaxStepNumberOf(steps:[Step]) -> Int {
        let max = steps.max { $0.count < $1.count }?.count ?? 0
        if max == 0{
            return 1
        }else{
            return max
        }
    }
}

@available(iOS 15.0, *)
struct StepStatsContentView_Previews: PreviewProvider {
    static var previews: some View {
        StepStatsContentView()
    }
}

protocol StepsTabDelegate{
    func stepSelected(step: Step)
}
