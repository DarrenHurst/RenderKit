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
    
    //TODO Pass Navigation Items from Interface
    
    @State var toolbar: ExampleRootContext = ExampleRootContext(selectedRoute: .home)
    @State var animate: Bool = false
    @State var showToast: Bool = false
   
    let theme = Config().currentTheme
    let iconSize = 55.0
    let iconPadding = 0.0
    let toolbarHeight = 75.0
    
    fileprivate func buildToastView() -> some View {
        return ZStack {
            Toast(message: "30% Off Sale On Now", priority: 0)
                .offset(y:animate ? toolbarHeight  : -toolbarHeight)
                .animation(.easeInOut.delay(1.0).speed(0.2), value: animate)
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    toolbar.view(for: toolbar.selectedRoute)
                        .allowsHitTesting(true)
                        .frame(height: reader.size.height - toolbarHeight,alignment: .top)
                        .onAppear() {
                            animate = true
                        }
                    buildToastView().offset(y:animate ? 100  : -toolbarHeight)

                    HStack(alignment: .center) {
                        ForEach(Routes.allCases) { route in
                            VStack {
                                VStack {
                                    switch route {
                                    case .home:
                                        RenderButton(image:  Image(systemName:"house")
                                                     , shape: theme.toolbarButtonShape, action: {
                                            toolbar = ExampleRootContext(selectedRoute: route)
                                        })
                                       
                                    case .orders:
                                        RenderButton(image:Image(systemName: "menucard"), shape: theme.toolbarButtonShape, action: {
                                            toolbar = ExampleRootContext(selectedRoute: route)
                                        })
                                      
                                    case .burgers:
                                        RenderButton(image:Image(systemName: "burst"), shape:  theme.toolbarButtonShape, action: {
                                            toolbar = ExampleRootContext(selectedRoute: route)
                                        })
                                      
                                    }
                                }
                                .background(Circle().fill(isSelected(route: route) ? theme.toolbarButtonSelectColor.opacity(0.4) : .white)
                                    .padding(-5))
                                .animation(.linear(duration: 0.8), value: isSelected(route: route))
                                .frame(width:reader.size.width / CGFloat(Routes.allCases.count))
                                .offset(y:10)
                            }
                        }
                            
                    }.frame(width: reader.size.width - 20, height: toolbarHeight, alignment: .top)
                        .foregroundColor(.black)
                        .background(theme.toolbarShape.fill(.thinMaterial.opacity(0.3)))
                        .background(theme.toolbarShape.fill(.black.opacity(0.3)))
                        .background(theme.toolbarShape.fill(theme.toolbarBackground).opacity(0.4))
                        .background(theme.toolbarShape.fill(.white.opacity(0.8)))
                        .background(theme.toolbarShape.stroke(.black))
                        .offset(y:20)
                        .anyView
                }
                .offset(y:-60)
                .background(toolbar.selectedRoute == .burgers ? .black : .white)
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
    static var view: ExampleRootContext = ExampleRootContext(selectedRoute: .home)
    static var previews: some View {
        RenderToolBar(toolbar: view)
    }
}


