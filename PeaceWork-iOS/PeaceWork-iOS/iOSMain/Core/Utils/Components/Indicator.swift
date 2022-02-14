//
//  Indicator.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/30/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct Indicator : UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView  {
        let view = UIActivityIndicatorView(style: .large)
        view.color = UIColor(Color(hex: Constants.DarkBlueHex))
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView:  UIActivityIndicatorView, context: Context) { }
}


struct Indicator_Previews: PreviewProvider {
    static var previews: some View {
        Indicator()
    }
}
