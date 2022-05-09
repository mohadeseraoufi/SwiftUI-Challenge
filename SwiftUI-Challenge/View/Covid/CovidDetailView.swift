//
//  CovidDetailView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/8/22.
//

import SwiftUI

struct CovidDetailView: View {
    
    @Binding var covidDetailInfo: CountryCovidInfoViewModel
    
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
                // Background Color
                Color(red:0.12, green:0.15, blue:0.27)
                    .ignoresSafeArea()
                
                // Covid info
                VStack(alignment: .leading, spacing: 0){
                    HStack(){
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        
                        Text("Infected:")
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(String(covidDetailInfo.infected ?? 0))
                            .foregroundColor(.red)
                            .bold()
                    }
                    
                    HStack{
                        Circle()
                            .fill(.green)
                            .frame(width: 10, height: 10)
                        
                        Text("Recovered:")
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(String(covidDetailInfo.recovered ?? 0))
                            .foregroundColor(.green)
                            .bold()
                    }
                    
                    HStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 10, height: 10)
                        
                        Text("Deceased:")
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(String(covidDetailInfo.deceased ?? 0))
                            .foregroundColor(.white)
                            .bold()
                    }
                    HStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 10, height: 10)
                        
                        Text("Tested:")
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(String(covidDetailInfo.tested ?? 0))
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
        }
        .navigationBarTitle(Text(covidDetailInfo.country))
        .onAppear{
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().barTintColor = .black
        }
    }
}

struct CovidDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let covidModel = CovidInfoModel(infected: 0,
                                        tested: .null,
                                        recovered: .integer(0),
                                        deceased: .null,
                                        country: "",
                                        moreDataURL: "",
                                        historyDataURL: "",
                                        sourceURL: "",
                                        lastUpdatedApify: "",
                                        lastUpdatedSource: "")
        
        CovidDetailView(covidDetailInfo: Binding.constant(CountryCovidInfoViewModel(covidInfo: covidModel)))
    }
}
