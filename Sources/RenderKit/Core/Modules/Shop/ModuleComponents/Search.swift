//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-30.
//

import Foundation
import SwiftUI


@available(iOS 16.0, *)
struct ImageScroll: View {
    var body: some View {
        ZStack {
            GeometryReader { r in
                ZStack {
                    VStack {
                        Text("Recommendations")
                            .font(.Small).opacity(0.5)
                            .frame(width: r.size.width, alignment: .leading)
                        Text("Womens Gray Hoodie")
                            .font(.Large)
                            .frame(width: r.size.width, alignment: .leading)
                        Text("$30")
                            .font(.XLarge)
                            .foregroundColor(Color.blue.opacity(0.4))
                            .frame(width: r.size.width, alignment: .leading)
                    }
                    .padding(10)
                    .offset(x:10, y:200)
                    .frame(width: r.size.width, alignment: .leading)
                    .foregroundColor(Color.white)
                }.background(Image("shot1", bundle: Bundle.module)
                    .resizable()
                    .padding(-10)
                    .frame(idealWidth: r.size.width, idealHeight:400).offset(y:90)
                    .scaledToFill())
            }
        }
    }
}

@available(iOS 16.0, *)
struct SearchBarResults: View {
    @StateObject var data : SampleData
    @State var showItem: Bool = false

    var body: some View {
        
        HStack {
            let items = data.shopItems
            ForEach(items) { item in
                if (item.name.contains(data.searchText) || data.searchText == "") {
                    Image(item.image, bundle: Bundle.module)
                        .resizable()
                        .scaledToFit()
                        .frame(idealWidth:100, idealHeight:100)
                        .opacity(showItem ? 1.0 : 0.0)
                        .offset(y: showItem ? 0.0 : -10)
                        .animation(Animation.easeIn(duration: 1.0), value: showItem)
                        .mask(RoundedRectangle(cornerRadius: 15))
                       
                }
            }
            .onAppear() {
                showItem = true
            }
            .onDisappear() {
                showItem = false
            }
        }
    }
    
   
}

@available(iOS 16.0, *)
struct SearchResults: View {
    @StateObject var data : SampleData

    @State var showItem: Bool = false
    @State var isPresenting: Bool
    @State var selectedRow: Item
    
    let transition: AnyTransition = .move(edge: .leading)
    let theme = Config().currentTheme
 
    var body: some View {
        VStack(alignment:.leading) {
            GeometryReader { r in
                VStack(alignment:.leading) {
                    let items = data.shopItems
                    
                    ForEach(items) { item in
                        if (item.name.contains(data.searchText) || data.searchText == "") {
                            HStack {
                                
                                Image(item.image, bundle: Bundle.module)
                                    .resizable()
                                    .frame(width:100, height:100)
                                    .scaledToFit()
                                    .opacity(showItem ? 1.0 : 0.0)
                                    .offset(y: showItem ? 0.0 : -10)
                                    .animation(Animation.easeIn(duration: 1.0), value: showItem)
                                    .mask(RoundedRectangle(cornerRadius: 15))
                                 
                                VStack(alignment: .leading) {
                                    Text("\(item.name)")
                                    Text("$\(item.price)")
                                    Text("\(item.description)")
                                    
                                }
                                
                            }
                            .frame(width:r.size.width, alignment: .leading)
                            .padding(10)
                            .padding(.leading, 10)
                            .background(isPresenting ? .clear : theme.backgroundColor.opacity(0.2))
                            .onTapGesture {
                                selectedRow = item
                                isPresenting.toggle()
                            }
                        }
                    }
                    .frame(width:r.size.width)
                   
                    .onAppear() {
                        showItem = true
                    }
                    .onDisappear() {
                        showItem = false
                    }
                }.frame(width: r.size.width, height:300, alignment: .top)
                    .onAppear() {
                        data.searchText = "Hood"
                    }
            }
           
        }
        .fullScreenCover(isPresented: $isPresenting, onDismiss: {}) {
            DetailView(selectedRow: selectedRow, isPresenting: isPresenting).offset(x:-20)
        }
   
        .transaction({ transaction in transaction.disablesAnimations = true })

        .animation(.easeIn(duration: 0.5), value: isPresenting)       .transition(transition)

      //  .transition(transition)
      //  .background(.clear)
    
    }
    
   
}


@available(iOS 16.0, *)
struct SearchBarPreview: PreviewProvider {
    static var data: SampleData = SampleData()
    static var selectedRow: Item = Item(name: "", description: "nothing", size: "", itemColor: "", price: "", image: "", showItem: false)
    static var isPresenting: Bool = false
    
    static var previews : some View {
       ViewThatFits {
            GeometryReader { r in
                VStack {
                    SearchBar(data: data,  selectedRow: selectedRow)
                    //SearchBarResults(data: data)
                    SearchResults(data: data, isPresenting: isPresenting, selectedRow: selectedRow)
                .frame(idealWidth:r.size.width)
                }.padding(-12)
   
            }
        }
    }
}


