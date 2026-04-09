//
//  TaskViewModel.swift
//  Pebble
//
//  Created by Stefanie Agahari on 09/04/26.
//

import Foundation
import SwiftData
import Observation

@Observable
class TaskViewModel {
    var modelContext: ModelContext // untuk mengakses database SwiftData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addTask(taskName: String, dueDate: Date, taskNotes: String, progressBar: Int, category: TaskCategory) {
        let newTask = TaskModel(
            taskName: taskName,
            dueDate: dueDate,
            taskNotes: taskNotes,
            progressBar: progressBar,
            category: category
        )
        modelContext.insert(newTask)
    }
    
    func deleteTask(_ task: TaskModel) {
        modelContext.delete(task)
    }
    
    func updateTask(task: TaskModel, newName: String, newProgress: Int) {
        task.taskName = newName
        task.progressBar = newProgress
    }
    
    func toggleCompletion(for task: TaskModel) {
        task.isCompleted.toggle()
    }
}
