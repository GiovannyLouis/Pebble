//
//  SubtaskViewModel.swift
//  Pebble
//
//  Created by Stefanie Agahari on 09/04/26.
//

import Foundation
import SwiftData
import Observation

@Observable
class SubtaskViewModel {
    var modelContext: ModelContext // untuk mengakses database SwiftData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addSubtask(subtaskName: String) {
        let newSubtask = SubtaskModel(
            subtaskName: subtaskName
        )
        modelContext.insert(newSubtask)
    }
    
    func deleteSubtask(_ subtask: SubtaskModel) {
        modelContext.delete(subtask)
    }
    
    func updateSubtask(subtask: SubtaskModel, newSubtaskName: String) {
        subtask.subtaskName = newSubtaskName
    }
    
//    func toggleCompletion(for subtask: SubtaskModel) {
//        subtask.isCompleted.toggle()
//    }
}
