//
//  AddTaskViewModel.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI
import SwiftData

@Observable //untuk sinkronisasi data di vm ke view, contohnya perubahan value variabel
class AddTaskViewModel {
    var taskName = ""
    var taskNotes = ""
    var dueDate = Date()
    var progress: Int = 0
    var selectedCategory: TaskCategory = .none
    var status: Bool = false
    
    var isShowingDatePicker:Bool = false
    
    var initialDate = Date() //dipaki untuk cek apakah dueDate sudah berubah atau belum
    
    //if isChange True show discard alert/action sheet
    var isChanged: Bool{
        taskName != "" ||
        taskNotes != "" ||
        dueDate != initialDate ||
        selectedCategory != .none
    }
    var isShowingDiscardAlert:Bool = false
    
    func toggleDatePicker() {
        isShowingDatePicker.toggle()//toggle ganti value bool
    }
    
    func addTask(context: ModelContext) {
        let newTask = TaskModel(
            taskName: taskName,
            dueDate: dueDate,
            taskNotes: taskNotes,
            progressBar: progress,
            category: selectedCategory,
            isCompleted: status
        )
        
        context.insert(newTask)
    }
        

}
