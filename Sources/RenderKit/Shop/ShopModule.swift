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
public struct ShopWorkFlow: Identifiable {
    public var id: UUID = UUID()
    
    @State var searchText: String = "What are you looking for?"

    public var featureName: String = "SearchFeature"
    public var isEnabled: Bool = true
    public var component: ShopComponents = .none
    public var data: SampleData = SampleData()
    
    init(_ component: ShopComponents) {
        self.component = component
    }
    
    @ViewBuilder
    public func view(for destination: ShopComponents?, data: SampleData) -> some View {
        switch destination {
        case .some(.search):
            VStack {
                SearchBar(data: data).frame(idealHeight:350).offset(y:20)
            }
        case .some(.results):
            SearchResults(data: data).frame(idealHeight:350).padding(.bottom, 150)
        default:
            EmptyView()
        }
    }
}


@available(iOS 16.0, *)
extension RenderTable {
    func render(flow: ShopWorkFlow) -> some View {
        flow.view(for: flow.component, data: data)
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
            RenderTable( workflows: moduleWorkflow, data: SampleData(),  myStyle: TableListStyle.grouped, sectionSeperator: Visibility.hidden).ignoresSafeArea()
        }
    }
}


