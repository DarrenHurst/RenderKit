//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-31.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct BackButton: View {
    var dismissAction: () -> Void
    var navigationTitle: String?
    
    var btnBack : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               //Image(systemName: "arrow.left")
               Image(systemName: "chevron.left.circle")
               .aspectRatio(contentMode: .fit)
               .foregroundColor(.black)
               Text(navigationTitle ?? "")
           }.background(.clear)
           .border(.bar, width: 2)
           .foregroundColor(.black)
           .accessibility(label: Text("Back Button"))
        }
    }
    
    var btnBackRoot : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    var body: some View {
        VStack {
            AnyView {
                btnBackRoot
            }
        }
    }
}
