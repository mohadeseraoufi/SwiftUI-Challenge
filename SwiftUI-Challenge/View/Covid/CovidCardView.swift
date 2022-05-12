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
        
        VStack(alignment: .leading, spacing: 0){
            Spacer()
            
            // Country name
            Text(covidInfo.country)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
            
            // Covid infected
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
            
            Spacer()
        }.padding()

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
