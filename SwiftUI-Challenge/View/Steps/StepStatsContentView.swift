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
    private var loadingTab = StepsTab(tabType: .loading)
    @State private var chartPage: Page = .first()
    @State var selectedStep = Step(count: 0, date: Date())
    @State var chartDate: String = ""

    var body: some View {
        
        NavigationView{
            GeometryReader{geo in
                ZStack(alignment: .top){
                    
                    // Background Color
                    Color
                        .black
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading, spacing: 20){
                        ZStack(alignment: .bottomLeading){
                            
                            // Chart date
                            Divider()
                                .background(Color.white.opacity(0.3))
                                .padding(.bottom, 5)
                                .padding(.trailing, 40)
                            
                            Text(chartDate)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                                .background(Color.black)
                        }
                        // Slider for show weeks
                        Pager(page: chartPage, data: stepsViewModel.tabItems+[loadingTab], id: \.id) { tab in
                            
                            if tab != loadingTab {
                                // Set chart on slider item
                                StepStatsChartView(tabItem: tab,
                                stepsMax: getMaxStepNumberOf(steps: tab.steps),
                                delegate: self)
                                
                            } else {
                                // Show loading on last page
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                        }
                        .onPageChanged { newPage in
                            if newPage == stepsViewModel.tabItems.count{
                                
                                let newWeek = Calendar.current.date(byAdding: .day, value: -2, to: stepsViewModel.tabItems[newPage-1].startDate)!
                                // Update chart date
                                changeChartDate(from: newWeek.startOfWeek, to: newWeek.endOfWeek)
                                
                                // Get steps of previous week
                                stepsViewModel.getNewStepTab(from: newWeek.startOfWeek,
                                                             to: newWeek.endOfWeek)
                            }else{
                                // Update chart Date
                                changeChartDate(
                                    from: stepsViewModel.tabItems[newPage].startDate,
                                    to: stepsViewModel.tabItems[newPage].endDate)
                            }
                        }
                        .horizontal(.rightToLeft)
                        .frame(width: geo.size.width, height: geo.size.height/2.6, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            // Selected weekday from chart
                            let weekDayIndex = Calendar.current.component(.weekday, from: selectedStep.date)-1
                            let weekDay = DateFormatter().weekdaySymbols[weekDayIndex]
                            Text(String(weekDay))
                                .foregroundColor(Color("mainColor"))
                            
                            // Steps Count of selected day
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
            
            // Get steps of first week
            if stepsViewModel.tabItems.isEmpty{
//                let endDate = Date()
//                let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
                changeChartDate(from: Date().startOfWeek, to: Date().endOfWeek)
                    stepsViewModel.getNewStepTab(from: Date().startOfWeek,
                                     to: Date().endOfWeek)
            }
            
            UINavigationBar.appearance().barTintColor = .black
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
    // Call from stepsChartView
    func stepSelected(step: Step) {
        // Update selected step
        selectedStep = step
    }
    
    func changeChartDate(from startDate: Date, to endDate: Date){
        // Update chart date
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let startDate = dateFormatterPrint.string(from: startDate)
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        let endDate = dateFormatterPrint.string(from: endDate)
        chartDate = "\(startDate) - \(endDate)"
    }
    
    private func getMaxStepNumberOf(steps:[Step]) -> Int {
        // Get max of steps count
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
