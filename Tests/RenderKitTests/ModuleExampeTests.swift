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
            ModuleWorkFlow(.login),
            ModuleWorkFlow(.jokes)
            ]
        let tableView =  RenderTableWithView(workflows: workflow, data: SampleData(), sectionSeperator: .hidden)
        XCTAssertNotNil(tableView)
        //When
        //Table Loads
        XCTAssertFalse(tableView.$workflows.isEmpty)
       
        
      
    }
}
