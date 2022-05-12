//
//  ContentView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//
import SwiftUI

struct CovidStatsContentView: View {
   
    @StateObject var covidStatsViewModel = CovidStatsViewModel()
    
    var body: some View {
        
        ZStack{
            // Background color
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            NavigationView{
                // Show list of countries
                List($covidStatsViewModel.countriesInfo){ covidInfo in
                    
                    NavigationLink{
                        // Country covid info detail
                        CovidDetailView(covidDetailInfo: covidInfo)
                    } label: {
                        // Country cell
                        CovidCardView(covidInfo: covidInfo)
                    }
                    .padding(.trailing, 20)
                    .background(Color(red:0.12, green:0.15, blue:0.27))
                    .cornerRadius(20)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                }
                .navigationBarTitle(Text("Covid-19 Stats"))
                
            }.navigationViewStyle(StackNavigationViewStyle())
            
            // Show loading until data is fetched
            let isHidden: Bool = !covidStatsViewModel.countriesInfo.isEmpty
            ProgressView()
                .frame(width: 100, height: 100, alignment: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .isHidden(isHidden)
           
                
            
        }.onAppear {
            
            // Get covid info from API
            if covidStatsViewModel.countriesInfo.isEmpty{
                covidStatsViewModel.getCovidStatsInfo(completion: { covidInfo in
                    print(covidInfo)
                })
            }
            
            UITableView.appearance().backgroundColor = .black
            UITableView.appearance().separatorColor = .clear
            
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().barTintColor = .black
        }
    }
}

struct CovoidStatsContentView_Previews: PreviewProvider {
    static var previews: some View {
        CovidStatsContentView()
    }
}
