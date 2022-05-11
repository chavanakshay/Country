//
//  PullToRefresh.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import SwiftUI

struct PullToRefresh: View {
    private var coordinateSpaceName: String
    private var onRefresh: (()->Void)?
    private var onPull: (()->Void)?
    @State private var needRefresh: Bool = false {
        didSet {
            onPull?()
        }
    }
    @Binding var showLoader:Bool
    private var tintColor: Color
    init(coordinateSpaceName:String, showLoader:Binding<Bool> = .constant(true), tint:Color = .white, onRefresh: (()->Void)? = nil, onPull: (()->Void)? = nil) {
        self._showLoader = showLoader
        self.coordinateSpaceName = coordinateSpaceName
        self.onRefresh = onRefresh
        self.onPull = onPull
        self.tintColor = tint
    }
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            onRefresh?()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    if(showLoader) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
                    }
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
