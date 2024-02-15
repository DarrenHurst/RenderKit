import Foundation
import SwiftUI

@available(iOS 16.0, *)
public enum Components: StringLiteralType {
    case welcome = "Welcome Text"
    case welcomeButton = "Welcome Button"
    case headerView = "Lets get started"
    case menuItem = "Segment"
    case menuView = "SegmentView"
    case empty = "nil"
}
 
@available(iOS 16.0, *)
public struct Workflow : Identifiable {
    public var id = UUID()
    public var component: Components
 
    //Table View
    @ViewBuilder
    public func view(for destination: Components?, data: SampleData) -> some View {
        switch destination {
        case .some(.welcomeButton):
            RenderNavigationLink(ModuleWorkFlow(.header), data: data)
        default:
          EmptyView()
        }
    }
    
    //AnyView Passthrough
    @ViewBuilder
    public func view(for body: any View, data: SampleData) -> some View {
         AnyView(body)
    }
    
    //Routing
    @ViewBuilder
    public func componentLanding(view: Components?, data: SampleData) -> some View {
        switch view {
            default:
                EmptyView()
        }
    }
}

@available(iOS 16.0, *)
extension Workflow: Equatable {
    public static func == (lhs: Workflow, rhs: Workflow) -> Bool {
        return lhs.component == rhs.component
    }
    
    public init(_ component: Components ) {
        self.component = component
    }
}
