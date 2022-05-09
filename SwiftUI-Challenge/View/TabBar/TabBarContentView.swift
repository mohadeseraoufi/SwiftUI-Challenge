//
//  TabBarContentView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/8/22.
//

import SwiftUI

struct TabBarContentView: View {
    
    var body: some View {
        
        TabView{
            CovidStatsContentView()
                .tabItem {
                    Label("Covid-19", image: "covid")
                }
            StepStatsContentView()
                .tabItem{
                    Label("Steps", image: "step")
                }
        }.onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(red:0.06, green:0.07, blue:0.10, alpha:1.00)
            
            UITabBar.appearance().standardAppearance = appearance
            
            let healthController = HealthController()
            healthController.requestAuthorisation { _ in
                
            }
            
        }.accentColor(.white)
        
    }
}


struct TabBarContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarContentView()
        
    }
}
