//
//  Extensions.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/9/22.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

extension Date {
    var startOfWeek: Date! {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        guard let startOfWeek = calendar.date(from: components) else {
            return nil
        }
        return calendar.date(byAdding: .day, value: 1, to: startOfWeek)!
    }

    var endOfWeek: Date! {
        let calendar = Calendar.current
        let endOfWeekOffset = calendar.weekdaySymbols.count - 1
        let endOfWeekComponents = DateComponents(day: endOfWeekOffset, hour: 23, minute: 59, second: 59)
        guard let endOfWeek = calendar.date(byAdding: endOfWeekComponents, to: startOfWeek) else {
            return nil
        }
        return endOfWeek
            
    }
    
    static func mondayAt12() -> Date{
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}
