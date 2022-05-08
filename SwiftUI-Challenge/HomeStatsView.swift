//
//  ContentView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//

import SwiftUI

struct HomeStatsView: View {
   

    @StateObject var covidStatsViewModel = CovidStatsViewModel()
    
    var body: some View {
        Text("Core Data")
            .onAppear {
                covidStatsViewModel.getCovidStatsInfo(completion: { covidInfo in
                    print(covidInfo[0].country)
                })
            }
    }

   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView()
    }
}
