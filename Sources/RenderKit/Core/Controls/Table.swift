
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
            .background(backgroundColor)
            .anyView
        }
    }
}

@available(iOS 16.0, *)
extension RenderTable {
 
    func render(flow: Workflow) -> some View {
        flow.view(for: flow.component, data: data)
    }
}




