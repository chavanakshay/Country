//
//  UI+Ext.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import Foundation
import SwiftUI

struct ShowProgressView:ViewModifier{
    @Binding var shouldShow:Bool
    func body(content: Content) -> some View {
        content
            .overlay(shouldShow ? AnyView(showProgressView()) : AnyView(Spacer()))
    }
    
    private func showProgressView()->some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
    }
}

extension View{
    func showProgressView(shouldShow:Binding<Bool>)->some View{
       return self.modifier(ShowProgressView(shouldShow: shouldShow))
    }
}
