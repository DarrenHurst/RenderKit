//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-27.
//

import Foundation
import SwiftUI

struct ImageSlider: View {
    @StateObject var data = SampleData()
    @State var tapped: Bool = false
    
    @State var posterView: AnyView = EmptyView().anyView
    @State var leftView: AnyView = EmptyView().anyView
    @State var rightView: AnyView = EmptyView().anyView
    
    @State private var isDragging = false
    @State private var xlocation: CGFloat = 0.0
    @State private var lastXlocation: CGFloat = 0.0
    @State var index: Int = 0
    
    let paddingBottom = 20.0
    let opacityLevel = 0.3
    let dragRate = 50.0
     
    fileprivate func checkDragLeft(_ click: CGFloat) {
        if lastXlocation > xlocation {
            xlocation  += click / dragRate
        } else {
            xlocation -= click / dragRate
        }
    }
    
    fileprivate func checkDragRight(_ click: CGFloat) {
        if lastXlocation < xlocation {
            xlocation  += click / dragRate
        } else {
            xlocation -= click / dragRate
        }
    }
    
    var drag: some Gesture {
        return DragGesture()
            .onChanged { gesture in
                if gesture.startLocation.x < gesture.location.x {
                    let click = gesture.location.x
                    checkDragLeft(click)
                    lastXlocation = click
                    isDragging = true
                }
                
                if gesture.startLocation.x > gesture.location.x {
                    let click = gesture.location.x
                    checkDragRight(click)
                    lastXlocation = click
                    isDragging = true
                }
            }
            .onEnded { _ in
                if xlocation  > 95 && index != 0 {
                    index -= 1
                    self.posterView = getView(index: index).anyView
                    setupViews()
                }
                
                if xlocation < -95 {
                    index += 1
                    self.posterView = getView(index: index).anyView
                    setupViews()
                }
                xlocation = 0
                lastXlocation = 0
                isDragging = false
            }
    }
    
    func getView(index: Int) -> some View {
        let posters:[MoviePoster] = data.moviePosters
        return
            AsyncImage(url: URL(string: posters[index].poster)) {  phase in
                if let image = phase.image {
                    image.resizable()
                    // .frame(width:r.size.width, height: r.size.height)
                        .padding(.bottom,paddingBottom)
                    
                } else if phase.error != nil {
                    EmptyView()
                } else {
                    Color.gray.opacity(opacityLevel) // Acts as a placeholder.
                }
            }
    }
    
    fileprivate func setupViews() {
        if index == 0 {
            leftView = EmptyView().anyView
        } else {
            leftView =  getView(index: index - 1).anyView
        }
        
        if data.moviePosters.count - 1 >= index + 1 {
            rightView = getView(index: index + 1).anyView
        }
        else {
            rightView = EmptyView().anyView
            index -= 1
        }
    }
    
    @State var isPresenting: Bool = true
    var body: some View {
        let posters:[MoviePoster] = data.moviePosters
       
        return GeometryReader { r in
            Color.black
            HStack {
                ZStack {
                    Text("loc:\(xlocation)").foregroundColor(.black).offset(y:-430)
                    leftView
                        .frame(width:r.size.width, height: r.size.height)
                        .position(x: isDragging ? xlocation - 219 : -219, y:430)
                    ZStack {
                           
                        posterView
                            .frame(width:r.size.width+20, height: r.size.height)
                            .position(x: isDragging ? xlocation + 218 : 221, y:430)
                            
                        ZStack {
                            VStack {
                                Image(systemName: "heart")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 40, height:40)
                                    .padding(20)
                                    .opacity(isDragging ? 0.0 : 1.0)
                                Image(systemName: "mail")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .opacity(isDragging ? 0.0 : 1.0)
                                    .frame(width: 40, height:40)
                                    .padding(20)
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 30, height:40)
                                    .opacity(isDragging ? 0.0 : 1.0)
                                    .padding(20)
                            }
                           
                            .background(.blue)
                            .background(Capsule().stroke(.white, lineWidth: 4.0))
                            .mask(Capsule().fill(.white.opacity(0.95)))
                            .opacity(isDragging ? 0.0 : 0.7)
                        }.offset(x: (r.size.width / 2 - 60), y: 250)
                    }.gesture(drag)
                   
                    rightView
                        .frame(width:r.size.width, height: r.size.height)
                        .position(x: isDragging ? xlocation + 650 : 650, y:430)
                    
                }.background(.clear)
                 .animation(.easeInOut, value: isDragging)
               //  .mask(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
               
            }
            .onAppear() {
                posterView =  getView(index: index).anyView
                setupViews()
              }
        }
    }
}


struct PreviewImageSlider: PreviewProvider {
    static var previews: some View {
        ImageSlider()
    }
}
