//
//  SubtaskModel.swift
//  Pebble
//
//  Created by Stefanie Agahari on 09/04/26.
//

import Foundation
import SwiftData

@Model
class SubtaskModel {
    var id: UUID = UUID()
    var subtaskName: String
    var isCompleted: Bool = false
    
    init(subtaskName: String) {
        self.subtaskName = subtaskName
    }
}
