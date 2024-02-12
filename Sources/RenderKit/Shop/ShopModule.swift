import Foundation
import SwiftUI

@available(iOS 16.0, *)
public enum ShopComponents: StringLiteralType {
    public var id: Self {
        return self
    }
    case none = "none"
    case search = "search"
    case results = "results"
}

@available(iOS 16, *)
public struct ShopWorkFlow: Identifiable, FlowContext {
    
    public var id: UUID = UUID()
    var component: ShopComponents?
    
    public var featureName: String = "SearchFeature"
    public var isEnabled: Bool = true
    public var data: SampleData = SampleData()
     
    init(_ component: ShopComponents) {
        self.component = component
    }
    
    //  Flow Context Block FlowContext view(for: )
    @ViewBuilder
    func view(for component: ShopComponents?, data: SampleData) -> any View {
        switch component {
        case .some(.search):
            VStack {
                SearchBar(data: data).frame(idealHeight:400).offset(y:40)
            }
        case .some(.results):
            SearchResults(data: data).frame(idealHeight:350).padding(.bottom, 150)
        default:
            EmptyView()
        }
    }
}

@available(iOS 16, *)
extension ShopWorkFlow {
    //Routing by component landing
    @ViewBuilder
    public func componentLanding(view: ShopComponents?, data: SampleData) -> some View {
        switch view {
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
struct ShopPreviewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [ShopWorkFlow(.search)
                              ,ShopWorkFlow(.results)
                              ]
        VStack {
            RenderTableWithView( workflows: moduleWorkflow, data: SampleData(),  myStyle: TableListStyle.grouped, sectionSeperator: Visibility.hidden).ignoresSafeArea()
        }
    }
}


