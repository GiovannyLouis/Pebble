//
//  TaskModel.swift
//  Pebble
//
//  Created by Vrz on 07/04/26.
//

import Foundation
import SwiftData

@Model
class TaskModel {
    var id: UUID = UUID()
    var taskName: String
    var dueDate: Date
    var taskNotes: String
    var progressBar: Int
    var category: TaskCategory
    var isCompleted: Bool = false
    
    @Relationship(deleteRule : .cascade)
    var subtasks: [SubtaskModel] = []
    
    var progress: Double {
        guard !subtasks.isEmpty else { return 0 }
        let completed = subtasks.filter { $0.isCompleted }.count
        return Double(completed) / Double(subtasks.count)
    }
    
    var progressPercentage: Int {
        Int(progress * 100)
    }
    
    init (taskName: String, dueDate: Date, taskNotes: String, progressBar: Int, category: TaskCategory, isCompleted: Bool = false) {
        self.taskName = taskName
        self.dueDate = dueDate
        self.taskNotes = taskNotes
        self.progressBar = progressBar
        self.category = category
        self.isCompleted = isCompleted
    }
}

enum TaskCategory: String, CaseIterable, Codable, Identifiable {
    case none = "None"
    case health = "Healthcare"
    case science = "Science & Math"
    case creative = "Creative Art & Design"
    case social = "Social & Behavioural"
    case business = "Business & Finance"
    case education = "Education & Teaching"
    case law = "Law"
    case engineering = "Engineering"
        
    var id: Self { self }
}
