//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-27.
//

import Foundation
import SwiftUI
import AVKit


struct ImageSlider: View {
    @StateObject var data: SampleData
    @State var tapped: Bool = false
    
    @State var isPresenting: Bool = true
    @State var isPresentingMovie: Bool = false
    @State var posterView: AnyView = EmptyView().anyView
    @State var leftView: AnyView = EmptyView().anyView
    @State var rightView: AnyView = EmptyView().anyView
    
    @State private var isDragging = false
    @State private var detailsCardEvent = false
    @State private var heartEvent = false
    @State private var xlocation: CGFloat = 0.0
    @State private var lastXlocation: CGFloat = 0.0
    @State var index: Int = 0
    
    var player: AVPlayer = AVPlayer()
    
    let paddingBottom = 20.0
    let opacityLevel = 0.3
    let dragRate = 50.0
     
    fileprivate func checkDragLeft(_ click: CGFloat) {
        detailsCardEvent = false
        if lastXlocation > xlocation {
            xlocation  += click / dragRate
        } else {
            xlocation -= click / dragRate
        }
    }
    
    fileprivate func checkDragRight(_ click: CGFloat) {
        detailsCardEvent = false
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
                    data.selectedMovieId = index
                    self.posterView = getView(index: index).anyView
                    setupViews()
               
                }
                
                if xlocation < -95 {
                   
                    index += 1
                    data.selectedMovieId = index
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
    

    
    fileprivate func detailsCard() -> some View {
        return VStack {
            
            Text(data.moviePosters[data.selectedMovieId].name)
                .font(.Heading)
                .foregroundColor(.white)
           
            if detailsCardEvent {
        
                HStack {
                    VStack(alignment: .leading) {
                        Text("Score Card").foregroundColor(.white)
                        
                        Rating(value: 3,
                               image: Image(systemName: "house.fill"),
                               image2: Image(systemName: "house"),
                               color:.white.opacity(0.9),
                               fillColor: .brown.opacity(0.6)).offset(x:-5)
                        
                        //solid
                        Rating(value: (data.moviePosters[index].score / 20.0 ),
                               image: Image(systemName: "ticket.fill"),
                               image2: Image(systemName: "ticket.fill"),
                               color:.white.opacity(0.9),
                               fillColor: .black.opacity(0.2)).offset(x:-5)
                            .padding(.top,5)
                            .foregroundColor(.pink)
                        
                        //line
                        Rating(value: 3.6,
                               image: Image(systemName: "star.fill"),
                               image2: Image(systemName: "star"),
                               color:.white.opacity(0.9),
                               fillColor: .yellow.opacity(0.7)).offset(x:-5)
                    }
              
                    ChartPathCircle(runAnimation: true, fillPercent: data.moviePosters[index].score).opacity(detailsCardEvent ? 1.0 : 0.0).offset(x:15, y:15)

                } .opacity(detailsCardEvent ? 1.0 : 0.0)
            }
            
            Image(systemName:"play.circle.fill")
                .resizable()
                .shadow(color: .white, radius: 2.0)
                .frame(width: 50, height: 50)
                .foregroundColor(.blue.opacity(0.6))
                .foregroundColor(.white.opacity(0.4))
                .background(Circle().stroke(.white, lineWidth: 4.0))
                .offset(y:30)
                .onTapGesture {
                    self.isPresentingMovie.toggle()
                }
               // .mask(Circle())
            
        }
        // you are adding the index to movie posters to get rotten score
        
        .frame(width:detailsCardEvent ? 350 : 50 , height: detailsCardEvent ?  400 : 40)
     
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).fill(.black.opacity(0.7)))
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).stroke(.white, lineWidth: 4.0))
        
        
        .offset(x: detailsCardEvent ? 0 : 155,
                y: detailsCardEvent ? -120 : 250)
        
        .opacity(detailsCardEvent ? 1.0 : 0.0)
        
        .animation(.interactiveSpring().speed(0.35), value: detailsCardEvent)
        
    }
    
    fileprivate func controlPill() -> some View {
        return ZStack {
            VStack {
                Image(systemName: heartEvent ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundColor(heartEvent ? .red.opacity(0.9) : .white)
                    .frame(width: 40, height:40)
                    .padding(20)
                    .opacity(isDragging ? 0.0 : 1.0)
                    .onTapGesture {
                        self.heartEvent.toggle()
                    }
                Image(systemName: "mail")
                    .resizable()
                    .foregroundColor(.white)
                    .opacity(isDragging ? 0.0 : 1.0)
                    .frame(width: 40, height:40)
                    .padding(20)
                    .onTapGesture {
                        self.detailsCardEvent.toggle()
                    }
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
            .opacity(isDragging ? 0.0 : 0.8)
        }
    }
    
    var body: some View {
        return GeometryReader { r in
            Color.black
            HStack {
                ZStack {
                    leftView
                        .frame(width:r.size.width, height: r.size.height)
                        .position(x: isDragging ? xlocation - 219 : -219, y:430)
                    
                    ZStack {
                           
                        posterView
                            .frame(width:r.size.width+20, height: r.size.height)
                            .position(x: isDragging ? xlocation + 218 : 221, y:430)
                            
                        controlPill().offset(x: (r.size.width / 2 - 60), y: 250)
                        
                        detailsCard()
                            
                    }.gesture(drag)
                   
                    rightView
                        .frame(width:r.size.width, height: r.size.height)
                        .position(x: isDragging ? xlocation + 650 : 650, y:430)
                    
                }
                .background(.clear)
                .fullScreenCover(isPresented: $isPresentingMovie, onDismiss: {}) {
                    GeometryReader { r in
                        ZStack {
                            VideoView(player: player).onAppear() {
                                player.play()
                            }
                         
                            Button("Close") {
                                           isPresentingMovie = false

                            }.offset(x: -(r.size.width / 2) + 50, y: -(r.size.height / 2))
                        }
                    }
                }
            }
            .onAppear() {
                posterView = getView(index: index).anyView
                setupViews()
            }
        }
    }
}


struct PreviewImageSlider: PreviewProvider {
    static var previews: some View {
        let data = SampleData()
        ZStack {
            ImageSlider(data: data)
           // PageControlView(data: data).offset(y:400)
        }
    }
}
