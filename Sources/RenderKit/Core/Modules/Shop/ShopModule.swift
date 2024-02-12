import Foundation
import SwiftUI


//Replacement for RenderTable Generic Table View
protocol FlowContext {
    associatedtype T
    var component: T? { get set}
    func view(for component: T?, data: SampleData) -> any View
}

@available(iOS 16.0, *)
public enum ShopComponents: StringLiteralType {
    public var id: Self {
        return self
    }
    case none = "none"
    case search = "Search Products"
    case results = "Results"
}

@available(iOS 16.0, *)
public enum AmazonPosterComponents: StringLiteralType {
    public var id: Self {
        return self
    }
    case none = "none"
    case cart = "Shopping Cart"
    case payment = "Payment Selection"
}

@available(iOS 16, *)
public struct ShopWorkFlow: Identifiable, FlowContext {
    
    public var id: UUID = UUID()
    var component: ShopComponents?
    
    public var featureName: String = "Search Product Feature"
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
            SearchResults(data: data).frame(idealHeight:400).padding(.bottom, 150)
        default:
            EmptyView()
        }
    }
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
        case .some(.cart):
            ImageSlider(data: data)
                .background(Color.black)
                .frame(idealHeight:800)
                .padding(-25)
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
        let moduleWorkflow = [//AmazonPosterFlow(.cart)
                              ShopWorkFlow(.search)
                              ,ShopWorkFlow(.results)
                              ]
        VStack {
            RenderTableWithView( workflows: moduleWorkflow, data: SampleData(),  myStyle: TableListStyle.plain, sectionSeperator: Visibility.hidden)
                .ignoresSafeArea()
        
                
        }
    }
}


