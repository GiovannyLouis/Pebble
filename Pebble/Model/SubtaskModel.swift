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
    var id: UUID?
    var subtaskName: String
    var isCompleted: Bool = false
    
    init(subtaskName: String, isCompleted: Bool = false) {
        self.subtaskName = subtaskName
        self.isCompleted = isCompleted
    }
}
