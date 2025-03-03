//
//  Item.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/3/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
