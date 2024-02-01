
import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct RenderTable<T: Identifiable>: View {
    @State var workflows: [T] = []
    var wflow: WorkflowManager = WorkflowManager(workflows: [])
    @ObservedObject var data: SampleData
    @State var myStyle: TableListStyle = TableListStyle.plain
    var backgroundColor: Color = Color.blue.opacity(0.1)

    var sectionSeperator: Visibility
   
   
   public var body: some View {
        NavigationStack {
            List($workflows.wrappedValue) { flow in
                Section(
                    content: {
                        VStack {
                      
                             if let flow = flow as? Workflow {
                                render(flow: flow)
                             }
                            
                            if let flow = flow as? ShopWorkFlow {
                                render(flow: flow)
                            }
                          
                            if let flow = flow as? ModuleWorkFlow {
                                flow.view(for: flow.component, data: data)
                                    .background(.clear)
                                    .accessibility(label: Text(""))
                            }
                        
                           
                        
                        
                        }
                    })
                .listRowSeparator(sectionSeperator)
            //   .listRowBackground(Config().background.opacity(0.2))
            }
            .listStyle(myStyle.style)
            .anyView
        }
        .backButton()
    }
}

@available(iOS 16.0, *)
protocol FlowProtocol{
    var workflows: Array<Workflow> { get set }
  //  func render<T: Equatable & Hashable>(flow: T) -> any View
}
@available(iOS 16.0, *)
class WorkflowManager: FlowProtocol {
 
    var workflows: Array<Workflow>
   // var components: Generic<Components>
    init(workflows: Array<Workflow> ) {
        self.workflows = workflows
    }
    
}
enum Generic<T> {
    case T
}
@available(iOS 16.0, *)
extension RenderTable {
 
    func render(flow: Workflow) -> some View {
        flow.view(for: flow.component, data: data)
    }
    
    func render(flow: ModuleWorkFlow) -> some View {
        flow.view(for: flow.component, data: data)
    }
    
     
       /* if let flow = flow as? Workflow  {
            flow.view(for: flow.component, data: data)
        }
        else if let flow = flow as? ModuleWorkFlow {
            flow.view(for: flow.component, data: data)
                .background(.clear)
                .accessibility(label: Text(""))
        }
        else if let flow = flow as? ShopWorkFlow {
            flow.view(for: flow.component, data: data)
        }*/
    
    
}

 
extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



