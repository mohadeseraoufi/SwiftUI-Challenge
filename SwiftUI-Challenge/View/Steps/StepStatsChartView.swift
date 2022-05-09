//
//  StepStatsChartView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/9/22.

import SwiftUI

struct StepStatsChartView: View {
    
    @State var tabItem: StepsTab
    @State var selectedStep = Step(count: 0, date: Date())
    var stepsMax: Int = 0
    var delegate: StepsTabDelegate? = nil
    
    var body: some View {
        
        VStack(alignment: .leading){
            Spacer()

            GeometryReader{ hstackGeo in
                HStack() {
                    
                    ForEach(tabItem.steps){ step in
                        
                        VStack(){
                            GeometryReader { zstackGeo in
                                ZStack(alignment: .center){
                                    
                                    // Set chart bar for each week days
                                    Rectangle()
                                        .foregroundColor(Color("tabColor"))
                                        .cornerRadius(hstackGeo.size.width/7)
                                        .frame(width: hstackGeo.size.width/14)
                                    
                                    let stepRect = Rectangle()
                                        .frame(width: hstackGeo.size.width/14)
                                        .cornerRadius(hstackGeo.size.width/7, corners: [.topLeft, .topRight])
                                        .padding(.top, CGFloat(zstackGeo.size.height * CGFloat(heightPercentage(stepCount: step.count))))
                                    
                                    // Set bar chart color
                                    if selectedStep == step{
                                        stepRect.foregroundColor(Color("mainColor"))
                                            .cornerRadius(hstackGeo.size.width/7)
                                    }else{
                                        stepRect.foregroundColor(Color("accentColor"))
                                            .cornerRadius(hstackGeo.size.width/7)
                                    }
                                    
                                }.frame(width : zstackGeo.size.width)
                                .onTapGesture {
                                    
                                    // Selected one day on chart
                                    selectedStep = step
                                    if let delegate = delegate{
                                        delegate.stepSelected(step: selectedStep)
                                    }
                                }
                            }
                            
                            // Week day text on chart
                            let weekDayIndex = Calendar.current.component(.weekday, from: step.date)-1
                            let weekDay = DateFormatter().shortWeekdaySymbols[weekDayIndex]
                            
                            let dayText = Text(weekDay)
                                .font(.caption2)
                            
                            if selectedStep == step{
                                dayText.foregroundColor(Color("mainColor"))
                            }else{
                                dayText.foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 40)
            }
            Spacer()
        }
        .onAppear{
            
            // Select last day as default
            if let lastStep = tabItem.steps.last{
                selectedStep = lastStep
            }
            if let delegate = delegate {
                delegate.stepSelected(step: selectedStep)
            }
        }
    }
    
    // Calculate bar chart height
    func heightPercentage(stepCount: Int) -> Float {
        if stepCount == stepsMax {
            return 0
        } else if stepCount == 0 {
            return 1
        } else {
            return 1 - (Float(stepCount) / Float(stepsMax))
        }
    }
}

struct StepStatsChartView_Previews: PreviewProvider {
    static var previews: some View {
        StepStatsChartView(tabItem: StepsTab(tabType: .loading))
        
    }
}



