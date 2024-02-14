//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-14.
//

import Foundation
import SwiftUI

// MARK: Amazon Poster Component List
@available(iOS 16.0, *)
public enum AmazonPosterComponents: StringLiteralType {
    public var id: Self {
        return self
    }
    case none = "none"
    case main = "Movie Poster Details SPA"
    case payment = "Payment Selection"
}


@available(iOS 16, *)
public struct AmazonPosterFlow: Identifiable, FlowContext {
    
    public var id: UUID = UUID()
    var component: AmazonPosterComponents?
    
    public var featureName: String = "Cart and Payment"
    public var isEnabled: Bool = true
    public var data: SampleData = SampleData()
     
    init(_ component: AmazonPosterComponents) {
        self.component = component
    }
    
    //  Flow Context Block FlowContext view(for: )
    @ViewBuilder
    func view(for component: AmazonPosterComponents?, data: SampleData) -> any View {
        switch component {
        case .some(.main):
            ImageSlider(data: data)
                .background(Color.black)
                .frame(idealHeight:800)
                .padding(-25)
        default:
            EmptyView()
        }
    }
}


// MARK: Preview Tests
@available(iOS 16.0, *)
struct AmazonPosterPreviewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [AmazonPosterFlow(.main)]
        VStack {
            RenderTableWithView( workflows: moduleWorkflow, data: SampleData(),  myStyle: TableListStyle.plain, sectionSeperator: Visibility.hidden)
                .offset(y:-3)
                .ignoresSafeArea()
        }
     
    }
}

