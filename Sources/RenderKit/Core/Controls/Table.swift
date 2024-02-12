
import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct RenderTable<T: Identifiable> : View {
    @State var workflows: [T] = []
    @StateObject var data: SampleData
    
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
                            
                            if let flow = flow as? ModuleWorkFlow {
                                flow.view(for: flow.component, data: data)
                                    .background(.clear)
                                    .accessibility(label: Text(""))
                            }
                        }
                    })
                .listRowSeparator(sectionSeperator)
            }
            .listStyle(myStyle.style)
            .anyView
        }
        //.backButton()
    }
}

//Replacement for RenderTableWithView  Generic Table View
protocol FlowContext {
    associatedtype T
    var component: T? { get set}
    func view(for component: T?, data: SampleData) -> any View
}

@available(iOS 16.0, *)

struct RenderTableWithView<T: Identifiable & FlowContext> : View  {
    @State var workflows: [T]
    @StateObject var data: SampleData
    
    @State var myStyle: TableListStyle = TableListStyle.plain
    var backgroundColor: Color = Color.blue.opacity(0.1)
    var sectionSeperator: Visibility
   
   public var body: some View {
        NavigationStack {
            List($workflows.wrappedValue) { flow in
                Section(
                    content: {
                        VStack {
                            flow.view(for: flow.component, data: data).anyView
                        }
                    })
                .listRowSeparator(sectionSeperator)
            }
            .listStyle(myStyle.style)
            .anyView
        }
       // .backButton()
    }
}

@available(iOS 16.0, *)
extension RenderTable {
 
    func render(flow: Workflow) -> some View {
        flow.view(for: flow.component, data: data)
    }
    
    func render(flow: ModuleWorkFlow) -> some View {
        flow.view(for: flow.component, data: data)
    }
}

 
extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



