//
//  ProvinceCell.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import SwiftUI

struct ProvinceCell: View {
    var province:ProvinceWrapper
    
    var body: some View {
        VStack(alignment:.leading,spacing: 8){
            HStack{
                Text(province.name)
                    .bold()
                Spacer()
            }
            HStack{
                Text(province.formattedCode)
                    .fontWeight(.regular)
                Spacer()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
    }
}
