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
