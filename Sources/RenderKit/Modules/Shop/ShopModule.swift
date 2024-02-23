import Foundation
import SwiftUI


// MARK: Shop Component List
@available(iOS 16.0, *)
public enum ShopComponents: StringLiteralType {
    public var id: Self {
        return self
    }
    case none = "none"
    case search = "Search Products"
    case results = "Results"
}

// MARK: A Workflow or Type ShopWorkFlow that conforms to FlowContext
@available(iOS 16, *)
public struct ShopWorkFlow: Identifiable, FlowContext {
    
    public var id: UUID = UUID()
    var component: ShopComponents?
    
    public let featureName: String = "Search Product Feature"
    public var isEnabled: Bool = true
    public var data: SampleData = SampleData()
    public var isDetailsPresenting = false
   
    // Create View Model etc.
    @State var selectedRow: Item = Item(name: "", description: "", size: "", itemColor: "", price: "", image: "", showItem: false)
    
    init(_ component: ShopComponents) {
        self.component = component
      
    }
    
    // MARK: Feature Flag or Version
    
    // MARK: Data Model Manager
    
    // MARK: Module endpoints
    enum endpoints: StringLiteralType {
        //not in use
        case chuckNorris = "https://api.chucknorris.io/jokes/random"
    }
    
    // MARK: Flow Context Block FlowContext view(for: )
    /// let view = view(for: ShopComponents.search, data: DATA) -> any View
    @ViewBuilder
    func view(for component: ShopComponents?, data: SampleData) -> any View {
        switch component {
        case .some(.search):
            VStack {
                SearchBar(data: data, selectedRow: selectedRow).frame(idealHeight:400).offset(y:40)
            }
        case .some(.results):
            SearchResults(data: data, isPresenting: isDetailsPresenting, selectedRow: selectedRow).frame(idealHeight:400).padding(.bottom, 150)
        default:
            EmptyView()
        }
    }
}


// used on NavigationLink but other view(for: component) will suffice
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


// MARK: Preview Tests
@available(iOS 16.0, *)
struct ShopPreviewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [//AmazonPosterFlow(.main)
                              ShopWorkFlow(.search),
                             ShopWorkFlow(.results)
                              ]
        VStack {
            RenderTableWithView( workflows: moduleWorkflow, data: SampleData(),  myStyle: TableListStyle.plain, sectionSeperator: Visibility.hidden)
                .offset(y:-4)
                .ignoresSafeArea()
        }
     
    }
}


