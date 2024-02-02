import Foundation
import SwiftUI

enum Routes: StringLiteralType, CaseIterable {
    case home = "Home"
    case orders = "Movies"
    case burgers = "Burgers"
    
}

extension Routes: Identifiable {
  var id: Self { self }
}

@available(iOS 16.0, *)
struct ExampleRootContext: Identifiable, View {
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
            let moduleWorkflow = [ShopWorkFlow(.search)
                                  ,ShopWorkFlow(.results)]
             
            RenderTable<ShopWorkFlow>(   workflows: moduleWorkflow, data: SampleData(), sectionSeperator: Visibility.hidden).ignoresSafeArea().padding(-24)
             
        case .some(.orders):
            let moduleWorkflow = [
                ModuleWorkFlow(.header)
       
            ]
            let moduleWorkflow2 = [
                ModuleWorkFlow(.jokes)
            ]
            
            SegmentedControl(data: SampleData(), shape: Config().currentTheme.toolbarShape, sections: [
                Sections(id:0, title: "Welcome", view: RenderTable( workflows: moduleWorkflow2, data: data, sectionSeperator: .hidden)
                 
                        ),
                Sections(id:1, title: "Movies", view:   RenderTable( workflows: moduleWorkflow, data: data, sectionSeperator: .hidden).navigationBarBackButtonHidden().offset(y:-40)
                   ),
                Sections(id:2, title: "Map", view: MapView(location: Location()))
            ]).offset(y:80)
            
          
        case .some(.burgers):
            VStack {
                ImageSlider(data: data).offset(y:40)
                PageControlView(data: data).offset(y:-740)
                // CartView().offset(y:30)
            }
        default:
           EmptyView()
        }
    }
    
}