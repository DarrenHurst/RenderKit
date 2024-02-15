//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-13.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedRow: Item 
    @State var isPresenting:  Bool
    
    var body: some View {
        VStack {
            GeometryReader { r in
                VStack {
                    ZStack {
                        Image(selectedRow.image, bundle: Bundle.module)
                            .resizable()
                            .scaledToFit()
                        
                        HStack {
                            RenderButton(image:Image(systemName: "house"), shape: Circle(), width: r.size.width) {
                              isPresenting = false
                                presentationMode.wrappedValue.dismiss()
                            }
                            .frame(width: r.size.width)
                            .offset(x:50, y:-150)
                            
                            RenderButton(image:Image(systemName: "cart"), shape: Circle(), width: r.size.width) {
                            }
                            .frame(width: r.size.width)
                            .offset(x:-70, y:-150)
                        }.frame(height:100)
                    }
                    
                    
                    VStack {
                        HStack {
                            Image(selectedRow.image, bundle: Bundle.module)
                                .resizable()
                                .scaledToFit()
                                .frame(height:100)
                            VStack(alignment: .leading, spacing: 1.0) {
                                Text(selectedRow.description.uppercased() )
                                Text("$\(selectedRow.price)")
                                    .font(.Large)
                                Text(selectedRow.name ).opacity(0.5)
                            }
                        }
                        
                        RenderButton(text:"Add To Cart", image: Image(systemName: "cart"), shape: RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)), width: r.size.width - 80) {
                        }.symbolVariant(.fill)
                        
                        RenderButton(text:"Buy Now", shape: RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)), width: r.size.width - 80) {
                        }
                    }.offset(x:-8, y:30)
                }
                
            }
            .offset(x:-190)
            .padding(-20)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .ignoresSafeArea(edges: .all)
        }
    }
}
        
