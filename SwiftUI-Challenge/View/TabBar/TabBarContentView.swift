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
            appearance.backgroundColor = UIColor(Color("tabColor"))
            
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
