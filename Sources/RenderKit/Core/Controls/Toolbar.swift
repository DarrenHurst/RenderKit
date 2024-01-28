//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-25.
//

import Foundation
import SwiftUI


@available(iOS 16.0, *)
struct RenderToolBar: View {
    @State var toolbar: RenderToolBarNav = RenderToolBarNav(selectedRoute: .home)
    @State var animate: Bool = false
    @State var showToast: Bool = true
   
    let theme = Config(Basic()).currentTheme()
    let iconSize = 55.0
    let iconPadding = 0.0
    let toolbarHeight = 80.0
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                   
                    toolbar.view(for: toolbar.selectedRoute)
                        .allowsHitTesting(true)
                        .frame(height: reader.size.height - toolbarHeight,alignment: .top)
                        //.background(Config().background)
                       // .offset(x: animate ? 0 : -400)
                       // .animation(.easeIn.speed(0.55), value: animate)
                        .onAppear() {
                            animate = true
                        }
                  
                   Toast(message: "30% Off Sale On Now", priority: 0)
                      .offset(y:animate ? toolbarHeight : -toolbarHeight)
                      .animation(.easeInOut.delay(1.0).speed(0.2), value: animate)
                    
                    HStack(alignment: .center) {
                        ForEach(Routes.allCases) { route in
                  
                            VStack {
                              
                                if isSelected(route: route) {
                                    VStack {
                                        theme.background
                                    }
                                    .frame(height:3.0)
                                    //.offset(y:-5)
                            }
                          
                                
                                    VStack {
                                        switch route {
                                        case .home:
                                            RenderButton(image:  Image(systemName:"house")
                                                         , shape: theme.buttonShape, action: {
                                                toolbar = RenderToolBarNav(selectedRoute: route)
                                            })
                                           
                                        case .orders:
                                            RenderButton(image:Image(systemName: "menucard"), shape: theme.buttonShape, action: {
                                                toolbar = RenderToolBarNav(selectedRoute: route)
                                            })
                                          
                                        case .burgers:
                                            RenderButton(image:Image(systemName: "burst"), shape:  theme.buttonShape, action: {
                                                toolbar = RenderToolBarNav(selectedRoute: route)
                                            })
                                          
                                        }
                                      //  Text(route.rawValue)
                                        //    .foregroundColor(route == toolbar.selectedRoute ? .black : theme.backgroundColor)
                                    }
                                    .animation(.linear(duration: 0.8), value: isSelected(route: route))
                                    .frame(width:reader.size.width / CGFloat(Routes.allCases.count))
                                }
                            
                        }   
                            
                    }.frame(width: reader.size.width, height: 90, alignment: .top)
                        .foregroundColor(.black)
                        .background(.white)
                }  .offset(y:-25)
                
            }
          
        }
        
           
         
   
        .ignoresSafeArea()
      
    }
    
    func isSelected(route: Routes) -> Bool {
        toolbar.selectedRoute == route
    }
}



@available(iOS 16.0, *)
struct RenderToolBarPreview: PreviewProvider {
    static var view: RenderToolBarNav = RenderToolBarNav(selectedRoute: .home)
    static var previews: some View {
        RenderToolBar(toolbar: view)
    }
}


