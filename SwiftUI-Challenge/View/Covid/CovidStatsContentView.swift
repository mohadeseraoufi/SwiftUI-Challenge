//
//  ContentView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/3/22.
//

import SwiftUI

struct CovidStatsContentView: View {
   

    @StateObject var covidStatsViewModel = CovidStatsViewModel()
    
    init(){
        UITableView.appearance().backgroundColor = .black

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
    }
    
    var body: some View {
        
        ZStack{
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            NavigationView{
                List($covidStatsViewModel.countriesInfo){ covidInfo in


                    NavigationLink{
                        CovidDetailView(covidDetailInfo: covidInfo)
                    } label: {
                        CovidCardView(covidInfo: covidInfo)
                    }
                    .padding(.trailing, -20.0)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))

                }
                .navigationBarTitle(Text("Covid-19 Stats"))
            }.navigationViewStyle(StackNavigationViewStyle())
            
            let isHidden: Bool = !covidStatsViewModel.countriesInfo.isEmpty
            
            ProgressView()
                .frame(width: 100, height: 100, alignment: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .isHidden(isHidden)
           
                
            
        }.onAppear {
            if covidStatsViewModel.countriesInfo.isEmpty{
                covidStatsViewModel.getCovidStatsInfo(completion: { covidInfo in
                    print(covidInfo)
                })
            }
            
        }
            
    }

   
}

struct CovoidStatsContentView_Previews: PreviewProvider {
    static var previews: some View {
        CovidStatsContentView()
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
