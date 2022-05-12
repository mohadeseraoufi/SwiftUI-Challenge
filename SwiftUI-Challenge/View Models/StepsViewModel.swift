//
//  StepsViewModel.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/9/22.
//

import SwiftUI

class StepsViewModel: ObservableObject{
    
    private var healthController: HealthController?
    @Published var tabItems = [StepsTab]()
    
    init(){
        healthController = HealthController()
    }
    
    public func getNewStepTab(from startDate: Date, to endDate: Date){
        
        getPreviousWeekSteps(from: startDate, to: endDate) { steps in
            // Create new tab
            
            let newTab = StepsTab(tabType: .chart,
                             startDate: startDate,
                             endDate: endDate,
                             steps: steps)
            var tabs = self.tabItems
            tabs.append(newTab)
            
            DispatchQueue.main.async {
                self.tabItems.append(newTab)
            }
        }
        
    }
    
    private func getPreviousWeekSteps(from startDate: Date, to endDate: Date, completion: @escaping ([Step])->()){
        var steps: [Step] = []
        if let healthController = healthController {
            healthController.requestAuthorisation { success in
                if success{
                    healthController.calculateSteps(startDate: startDate, endDate: endDate) { statisticCollection in
                        if let statisticCollection = statisticCollection {
                            statisticCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                                
                                // Count steps
                                let count = statistics.sumQuantity()?.doubleValue(for: .count())
                                print("+++++\(count)")
                                let step = Step(count: Int(count ?? 0), date: statistics.startDate)
                                steps.append(step)
                            }
                            completion(steps)
                        }
                    }
                }
            }
        }
    }

}
