import Foundation
import SwiftUI

enum Routes: StringLiteralType, CaseIterable {
    case home = "Home"
    case orders = "Movies"
    case posters = "Amazon Posters"
    
}

extension Routes: Identifiable {
  var id: Self { self }
}

@available(iOS 16.0, *)
struct AppRootContext: Identifiable, View {
    var id = UUID()
    @State var selectedRoute: Routes = .home
    @ObservedObject var data: SampleData = SampleData()
    
    var body: some View {
        view(for: selectedRoute)
    }
   
    @ViewBuilder
    public func view(for selectedRoute: Routes?) -> some View {
        switch selectedRoute {
        case .some(.home):
            let moduleWorkflow = [ShopWorkFlow(.search), ShopWorkFlow(.results)]
            RenderTableWithView(workflows: moduleWorkflow, data: SampleData(), sectionSeperator: Visibility.hidden).ignoresSafeArea()//.padding(-24)
             
        case .some(.orders):
            let moduleWorkflow = [ModuleWorkFlow(.header)]
            let moduleWorkflow2 = [
                ModuleWorkFlow(.jokes)
            ]
            
            SegmentedControl(data: SampleData(), shape: Config().currentTheme.toolbarShape, sections: [
                Sections(id:0, title: "Welcome", view: RenderTableWithView( workflows: moduleWorkflow2, data: data, sectionSeperator: .hidden)),
                Sections(id:1, title: "Movies", view:   RenderTableWithView( workflows: moduleWorkflow, data: data, sectionSeperator: .hidden)
                    .offset(y:-10)
                   ),
                Sections(id:2, title: "Map", view: MapView(location: Location()))
            ]).offset(y:80)
            
        case .some(.posters):
            ZStack {
                ImageSlider(data: data).offset(y:40).zIndex(1.0)
                PageControlView(data: data) .zIndex(3.0).offset(y:-300)
                // CartView().offset(y:30)
            }.padding(-20)
        default:
           EmptyView()
        }
    }
    
}
