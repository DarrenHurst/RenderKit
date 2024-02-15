//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-08.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct Alert: View, Identifiable {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var id: UUID = UUID()
    var text: String
    var okBtn:() -> ()
    var cancelBtn:(() -> ())?
    @State var controls: Int = 0
    
    let minH: CGFloat = 140
    let offset: CGFloat = -20
    let theme = Config().currentTheme
    init(_ text: String, okBtn: @escaping () -> ()) {
        self.text = text
        self.okBtn = okBtn
    }
    
    // override for optional closure with optional init
    init?(_ text: String, okBtn: @escaping () -> () , cancelBtn: (() -> ())?) {
        self.text = text
        self.okBtn = okBtn
        self.cancelBtn = cancelBtn
    }
    
    var body: some View {
        VStack {
            HStack {
                
                ZStack {
                    Image(systemName:"pencil")
                        .background(Circle().stroke(style:(StrokeStyle(lineWidth: 2))).padding(-15))
                         .padding()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(minWidth: 60)
                        .fixedSize()
                        .offset(y:offset)
                }
                .padding(.leading)
                
                Text(text)
                    .foregroundColor(Color.black)
                    .accessibility(label: Text(text))
                    .padding()
                    .offset(y:-20)
            }
            .frame(minHeight: minH)
           
       
            GeometryReader { r in
                HStack {
                     
                    if let action = cancelBtn {
                         RenderButton(id: UUID(), text: "Cancel", image: nil,
                                      shape: RoundedRectangle(cornerRadius: 10.0), action: action)
                             .foregroundColor(Color.black)
                             .frame(width: r.size.width / 2 - 16)
                             .onTapGesture {
                                 presentationMode.wrappedValue.dismiss()
                             }.onAppear(){
                                 self.controls = 1
                             }
                     }
                    
                    if let okaction = okBtn {
                        RenderButton(id: UUID(), text: "OK", image: nil, shape: RoundedRectangle(cornerRadius: 10.0), action: okaction).foregroundColor(Color.black)
                            .frame(width: self.controls == 1 ? r.size.width / 2 - 16 : r.size.width)
                            .animation(.none, value: false)
                        .onTapGesture {
                           
                        }
                    }
                }
                .padding(8)
                .frame(width: r.size.width)
                .offset(y:offset-20)
            }
            .frame( height: 30)
        }
        .frame(width: 370)
        .padding(.top, 20)
        .padding(.bottom, 17)
        .background(RoundedRectangle(cornerRadius: 20.0).fill(Config( Basic()).backgroundColor.opacity(0.7)))
        .background(RoundedRectangle(cornerRadius: 20.0).stroke(theme.backgroundBorder, style: StrokeStyle(lineWidth: 2.0)))
       
    }
}

// Cancel and Ok add to Localization
//

@available(iOS 16.0, *)
struct AlertPreview : PreviewProvider {
    static var previews : some View {
        Alert("Sorry.  This is a information message. Please contact customer support.",
              okBtn: {
                // do something
              }
              // optional add cancel)
              // (()->())?
            ,cancelBtn: {}
        )
    }
}
