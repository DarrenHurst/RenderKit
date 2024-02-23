//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-21.
//

import Foundation
import SwiftUI


struct TextBox: View {
    var body: some View {
        GeometryReader { r in
            Text("Today's Special ").frame(width: r.size.width - 40)
                .background(Config().currentTheme.background)
                .padding(.leading,10)
            Rectangle().fill(Config().currentTheme.background).padding(20)
        }
    }
}

struct TextWithAmount: View {
    var label: String?
    var amount: Double = 0.00
    
    var body: some View {
        GeometryReader { r in
            HStack(alignment: .top, spacing: 0.0) {
                Text(label ?? "left side label")
                    .frame(width: r.size.width * 0.70, alignment: .leading)
                    .padding(.leading)
                HStack(alignment: .top) {
                   
                    Text("$\(String(describing: amount))")
                        .padding(.top, 5)
                        .frame(width: r.size.width * 0.15, alignment: .center)
                  
                }
            }
        }.frame(height: 35.0)
    }
}

struct TextWithAmountModifier: View {
    var label: String?
    var amount: Double = 0.00
    
    var body: some View {
        GeometryReader { r in
            HStack(alignment: .top, spacing: 0.0) {
                Text(label ?? "left side label")
                    .frame(width: r.size.width * 0.60, alignment: .leading)
                    .padding(.leading)
                HStack(alignment: .top) {
                    RenderButton(image: Image(systemName: "minus"), shape: Circle(), width: 20, action: {})
                        .frame(height: 35.0)
                    Text("$\(String(describing: amount))")
                        .padding(.top, 5)
                        .frame(width: r.size.width * 0.15, alignment: .center)
                    RenderButton(image: Image(systemName: "plus"), shape: Circle(), width: 20, action: {})
                        .frame(height: 35.0)
                }
            }
        }.frame(height: 35.0)
    }
}

struct TextWithAmountPreview: PreviewProvider {
    static var previews: some View {
        TextWithAmount()
    }
}


struct TextDescriptionWithAmount: View {
    var title: String?
    var label: String?
    var amount: Double = 0.00
    
    var body: some View {
        GeometryReader { r in
            HStack(alignment: .center, spacing: 1.0) {
                VStack(alignment: .leading) {
                    Text(title ?? "Title of item").font(.title)
                        .padding(.leading,5)
                    Text(label ?? "label is the description and can have a good amount of text")
                        .font(.subheadline)
                        .padding(.leading, 15)
                        .padding(.bottom, 10)
                    
                }.frame(width: r.size.width * 0.70, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.leading, 5)
                    .zIndex(1.0)
                Text("$\(String(describing: amount))")
                    .frame(width: r.size.width * 0.20, alignment: .leading)
                    .zIndex(2.0)
                    .padding(.bottom)
            }
            .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(Config().currentTheme.background.opacity(0.3)))
            .offset(x:10)
       
            
        }
    }
}

struct OrderCard: View {
    fileprivate func items() -> some View {
        VStack {
            TextWithAmount(label: "Side of Slaw", amount: 2.99)
            TextWithAmount(label: "POP - Coke", amount: 1.99)
            TextWithAmount(label: "Side of Slaw", amount: 2.99)
            TextWithAmountModifier(label: "POP - Coke", amount: 1.99)
            TextWithAmount(label: "Side of Slaw", amount: 2.99)
        }
    }
    
    var body: some View {
        ViewThatFits {
            GeometryReader { r in
                Grid() {
                    ScrollView(.vertical) {
                        TextBox().padding(.bottom,10)
                        TextDescriptionWithAmount(title: "Catch of the Day", label:"Beer Battered Fish", amount: 15.99 ).frame(height:80)
                        
                        Text("Modifiers").font(.subheadline.smallCaps()).frame(width: r.size.width, alignment: .leading).padding(.leading,15)
                        
                        items()
                        
                        RenderButton(text: "Add to Cart", shape: Capsule(), width: 230, action:  {
                            
                        }, animate: true).frame(width: r.size.width - 80)
                        
                        RenderButton(text: "Checkout Now", shape: Capsule(), width: 230, action:  {
                            
                        }, animate: true).frame(width: r.size.width - 80)
                    }
                }
            }.padding(5)
        }
    }
}

struct TextDescriptionWithAmountPreview: PreviewProvider {
 
    static var previews: some View {
       OrderCard()
    }
}


