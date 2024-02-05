//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-13.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
public enum ModuleComponents: StringLiteralType, CaseIterable, Identifiable {
    public var id: Self {
        return self
    }
    case welcome = "Welcome Text"
    case login = "Login"
    case header = "Navigation Link "
    case alert = "Alert"
    case empty = "empty"
    case jokes = "Jokes"
   
}

@available(iOS 16, *)
public struct ModuleWorkFlow: Equatable, Hashable, Identifiable {
    public var id = UUID()
    public var featureName: String = "ThisFeature"
    public var component: ModuleComponents = .welcome
    typealias type = Workflow
    
    enum endpoints: StringLiteralType {
        case chuckNorris = "https://api.chucknorris.io/jokes/random"
    }
    
    init(_ component: ModuleComponents) {
        self.component = component
    }
    
    @ViewBuilder
    public func view(for destination: ModuleComponents?, data: SampleData) -> some View {
        switch destination {
        case .some(.welcome):
            WelcomeText(data: data)
        case .some(.login):
            RenderForm(data: data).frame(idealHeight:200)
        case .some(.jokes):
            VideoView().frame(height:800).padding(-50) 
            
            //WelcomeText(data: data)
            //NSFW
            //Jokes().frame(idealHeight:300)
        case .some(.alert):
                Alert("This is just here showing a in table placement :)", okBtn: {
                    
                }, cancelBtn: {
                    
                })
        case .some(.header):
        GridDisplay(data: data)
                   
        default:
            EmptyView()
        }
    }
}

@available(iOS 16, *)
extension ModuleWorkFlow {
    //Routing by component landing
    @ViewBuilder
    public func componentLanding(view: ModuleComponents?, data: SampleData) -> some View {
        switch view {
        case .some(.login):
            RenderForm(data: data)
        case .some(.header):
            // NSFW Chuck Norris
            //Jokes()
            WelcomeText(data: data)
        case .some(.alert):
            let moduleWorkflow = [
                ModuleWorkFlow(.alert)]
         
            RenderTable( workflows: moduleWorkflow, data: data, myStyle: .grouped,  sectionSeperator: .hidden).anyView
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
struct previewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [ModuleWorkFlow(.jokes)]
        VStack {
            RenderTable( workflows: moduleWorkflow, data: SampleData(), sectionSeperator: Visibility.visible)
        }
    }
}

