//
//  StepTab.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/9/22.
//

import Foundation

struct StepsTab: Identifiable, Equatable {
    
    static func == (lhs: StepsTab, rhs: StepsTab) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    var id = UUID()
    var tabType: TabType
    var startDate: Date = Date()
    var endDate: Date = Date()
    var steps: [Step] = [Step]()
}

enum TabType{
    case loading
    case chart
}
