//
//  CountryCell.swift
//  Country
//
//  Created by a.diliprao.chavan on 09/05/22.
//

import SwiftUI

struct CountryCell: View {
    var country:CountryWrapper
    
    var body: some View {
        VStack(alignment:.leading,spacing: 8){
            HStack{
                Text(country.name)
                    .bold()
                Spacer()
            }
            HStack{
                Text(country.formattedCode)
                    .fontWeight(.regular)
                Spacer()
                Text(country.formattedPhoneCode)
                    .fontWeight(.regular)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
    }
}

//struct CountryCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryCell(country: CountryWrapper(object: <#Country#>, id: 1, name: "India", code: "IND", phoneCode: "91"))
//    }
//}
