import XCTest
import SwiftUI
@testable import RenderKit

@available(iOS 16.0, *)
final class RenderKitTests: XCTestCase {
    func testTableView() throws {
    
        // Given
        // I request a tableView with Section config 
        let workflow: [Workflow] = [
            Workflow(.welcome),
            Workflow(.headerView),
            Workflow(.menuItem)
            ]
        let tableView =  RenderTable(workflows: workflow, data: SampleData(), sectionSeperator: .hidden)
        XCTAssertNotNil(tableView)
        //When
        //Table Loads
        XCTAssertFalse(tableView.$workflows.isEmpty)
       
        //Then
        let component: Components = tableView.$workflows[0].component.wrappedValue
        //Section 1 = Components.component1
        XCTAssertTrue(Components.welcome == component)
      
    }
}
