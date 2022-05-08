//
//  CovidCardView.swift
//  SwiftUI-Challenge
//
//  Created by Mohadese Raoufi on 5/8/22.
//

import SwiftUI


struct CovidCardView: View {
    
    @Binding var covidInfo: CountryCovidInfoViewModel

    var body: some View {
        
        ZStack(alignment: .leading){
            
            Color(red:0.12, green:0.15, blue:0.27)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 0){
                Spacer()
                
                Text(covidInfo.country)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                
                HStack{
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                    
                    Text("Infected:")
                        .foregroundColor(.white)
                        .bold()
                    
                    Text(String(covidInfo.infected ?? 0))
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
                    
                    Text(String(covidInfo.recovered ?? 0))
                        .foregroundColor(.green)
                        .bold()
                }
                
                Spacer()
            }.padding()

        }
        
        
 
    }
}


struct CovidCardView_Previews: PreviewProvider {
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
        CovidCardView(covidInfo: Binding.constant( CountryCovidInfoViewModel(covidInfo: covidModel)))
        
    }
}
