//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-31.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct NavigationBack: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    func body(content: Content) -> some View {
        content
            .offset(y:30)
            .navigationTitle(Text("Test"))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBackRoot)
            
    }
}

@available(iOS 16.0, *)
struct StartAnimation: ViewModifier {
    @State var stateAnimation: Bool
    func body(content: Content) -> some View {
        content
            .onAppear() {
                stateAnimation = true
            }
            .onDisappear() {
                stateAnimation = false
            }
    }
}

@available(iOS 16.0, *)
struct NavigationBackRoot: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 
    func body(content: Content) -> some View {
        content
            .offset(y:30)
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBackRoot)
    }
}

@available(iOS 16.0, *)
extension View {
    // install on view with .backButton()
    func backButton() -> some View {
        modifier(NavigationBack())
    }
    
    func backButtonRoot() -> some View {
        modifier(NavigationBackRoot())
    }
    
    func startAnimation(stateAnimation: Bool) -> some View {
        modifier(StartAnimation(stateAnimation: stateAnimation))
    }
}


