//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-03.
//

import Foundation
import SwiftUI

@propertyWrapper
struct Trimmed {
    private var str: String = ""
    
    var wrappedValue: String {
        get { str }
        set { str = newValue.trimmingCharacters(in: .whitespacesAndNewlines)}
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
