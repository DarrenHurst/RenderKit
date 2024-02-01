//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-14.
//

import Foundation
import XCTest
import SwiftUI
@testable import RenderKit

@available(iOS 16.0, *)
final class ModuleExampleTests: XCTestCase {
    func testTableviewCreationForModule() throws {
    
        // Given
        // I request a tableView with Section config
        let workflow: [ModuleWorkFlow] = [
            ModuleWorkFlow(.welcome),
            ModuleWorkFlow(.login),
            ModuleWorkFlow(.jokes)
            ]
        let tableView =  RenderTable(workflows: workflow, data: SampleData(), sectionSeperator: .hidden)
        XCTAssertNotNil(tableView)
        //When
        //Table Loads
        XCTAssertFalse(tableView.$workflows.isEmpty)
       
        //Then
        let component: ModuleComponents = tableView.$workflows[0].component.wrappedValue
        //Section 1 = Components.component1
        XCTAssertTrue(ModuleComponents.welcome == component)
        
        let component2: ModuleComponents = tableView.$workflows[1].component.wrappedValue
        //Section 2 = Components.component2
        XCTAssertTrue(ModuleComponents.login == component2)
        
        let component3: ModuleComponents = tableView.$workflows[2].component.wrappedValue
        //Section 2 = Components.component2
        XCTAssertTrue(ModuleComponents.jokes == component3)
      
    }
}
