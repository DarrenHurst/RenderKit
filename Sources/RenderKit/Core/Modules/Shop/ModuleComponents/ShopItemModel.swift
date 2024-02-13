//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-13.
//

import Foundation

class Item: Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var size: String //enum
    var itemColor: String //enum
    var price: String
    var image: String
    var showItem: Bool
    
    init(name: String, description: String, size: String, itemColor: String, price: String, image: String, showItem: Bool) {
        self.name = name
        self.description = description
        self.size = size
        self.itemColor = itemColor
        self.price = price
        self.image = image
        self.showItem = showItem
    }
}
