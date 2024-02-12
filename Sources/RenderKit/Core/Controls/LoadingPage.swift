import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct LoadingPage : View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    var view: AppRootContext = AppRootContext(selectedRoute: .home)
    @State var pathAnimation: Bool = false
    @State var isLoading: Bool = false
    @State var ready: Bool = false
    
    let bannerOffset:CGFloat = -350.0
    
    var body: some View {
        VStack {
           
            GeometryReader { r in
                ZStack {
                    logo()
                    progressInd()
                        .opacity(isLoading ? 0 : 1)
                        .animation(.easeInOut.delay(4), value: pathAnimation)
                }
                .frame(width: r.size.width, height: r.size.height)
                VStack {
                    if isLoading {
                        
                        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
                            NavigationSplitView(sidebar: {}, detail: {
                                // Call route with no attached toolbar
                                let route = Routes.home
                                
                                VStack {
                                    AppRootContext(selectedRoute: route).view(for: route)
                                        .opacity(ready ? 1 : 0)
                                    
                                        .padding(.leading,60)
                                        .padding(.trailing, 40)
                                        .animation(.easeInOut.delay(2.0).speed(0.7), value: ready)
                                        .frame(width: r.size.width, height: r.size.height )
                                }.padding(.top,40)
                                    .offset(y:30)
                            })
                            
                        } else {
                            RenderToolBar(toolbar: view)
                                .opacity(ready ? 1 : 0)
                                .animation(.easeInOut.delay(2.0).speed(0.7), value: ready)
                            
                                .frame(width: r.size.width, height: r.size.height)
                        }
                    }
                }
            }
        }
        
        
        .ignoresSafeArea()
        .onAppear() {
            pathAnimation = true
        }
    }
    
    @MainActor
    func validate() async -> Bool {
        if !isLoading {
            return false
        }
       
        return true
    }
}

@available(iOS 16.0, *)
struct LoadingPagePreview : PreviewProvider {
    static var previews: some View {
     
            LoadingPage()
               // .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
               // .previewDisplayName("iPhone 14")
               // .environment(\.locale, .init(identifier: "fr" ) )
            
   
       
    }
}
 
@available(iOS 16.0, *)
extension LoadingPage {
    fileprivate func logo() -> some View {
        
        let logoposition1: CGSize = CGSize(width:-140, height:-268)
        let logoposition2: CGSize = CGSize(width:0, height:-20)
        let logoSize: CGSize = CGSize(width: 55, height: 55)
        let logoSize2: CGSize = CGSize(width: 0, height: 0)
        return ZStack {
            Image("logo", bundle: Bundle.main).resizable()
                .frame(width: isLoading ? logoSize.width : logoSize2.width, height: isLoading ? logoSize.height : logoSize2.height)
                .offset(isLoading ? logoposition1 : logoposition2).opacity(0.8)
                .animation(.linear.speed(0.8).delay(4), value: isLoading)
                .onAppear() {
                    isLoading = true
                    
                    Task {
                        if await validate() {
                           ready = true
                        }
                    }
                }
        }
    }
    
    fileprivate func slinky() ->  some View {
        return ForEach(0..<72) { index in
            
            Circle()
                .stroke(lineWidth: pathAnimation ? 1 : 3)
                .fill(.brown.opacity(0.5))
                .frame(width:20, height: 155)
            // HOW MUCH COIL
                .rotationEffect(pathAnimation ? Angle(degrees: Double(-5 * index)) : Angle(degrees: Double(5 * index)), anchor: .topTrailing)
                .offset(x: -10,y:60).opacity(0.4)
                .animation(.easeInOut.speed(0.2).repeatForever(autoreverses: true), value: pathAnimation)
            
        }
    }
    
    fileprivate func emitter() ->  some View {
        return ForEach(0..<72) { index in
            ZStack {
                Circle()
                // storke or fill
                    .fill(.white.opacity(0.4))
                    .shadow(radius: 1.5)
                    .foregroundColor(.gray.opacity(0.3))
                
                    .frame(width:10, height: 100)
                // HOW MUCH COIL
                    .rotationEffect(pathAnimation ? Angle(degrees: Double(-5 * index)) : Angle(degrees: Double(5 * index)), anchor: .topTrailing)
                    .offset(x: -10,y:60).opacity(0.4)
                    .animation(.easeIn.speed(0.17).repeatForever(autoreverses: false), value: pathAnimation)
                Circle()
                // storke or fill
                   .stroke(lineWidth: 5)
                   .fill(.blue.opacity(0.7))
                   // .shadow(color:.gray, radius: 1.5)
                    .foregroundColor(.gray.opacity(0.3))
                
                    .frame(width:10, height: 100)
                // HOW MUCH COIL
                    .rotationEffect(pathAnimation ? Angle(degrees: Double(-5 * index)) : Angle(degrees: Double(5 * index)), anchor: .top)
                    .offset(x: -10,y:60).opacity(0.4)
                    .animation(.easeIn.speed(0.17).repeatForever(autoreverses: false), value: pathAnimation)
            }
           
            
        }
    }
    
    fileprivate func progressInd() -> some View {
        return ZStack {
           // CircleText()
              // .offset(x:-8, y: 21)
            ZStack {
                Circle().fill(.yellow.opacity(0.2))
                    .frame(width:98, height: 98).offset(x:-10, y:10)
                emitter()
                //slinky()
            }
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.brown.opacity(1.0)).offset(y:120)
                .opacity(pathAnimation ? 0 : 1)
                .animation(.linear.repeatForever().speed(0.3), value: pathAnimation)
        }
    }
    
    
}
