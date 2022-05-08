//
//  ContentView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//

import SwiftUI

struct HomeStatsView: View {
   
    @Environment(\.managedObjectContext) var managedObjectContext
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    lazy var covidStatsViewModel = CovidStatsViewModel(appDelegate: appDelegate)
    
    var body: some View {
        Text("Core Data")
    }

   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView()
    }
}
