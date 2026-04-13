//
//  AddTaskViewModel.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI

@Observable //untuk sinkronisasi data di vm ke view, contohnya perubahan value variabel
class AddTaskViewModel {
    var taskName = ""
    var taskNotes = ""
    var dueDate = Date()
    var selectedCategory: TaskCategory = .none
    
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
    
    
//test model
//    func createTask() -> Task {
//        Task(name: taskName, notes: taskNotes, dueDate: dueDate, category: selectedCategory)
//    }
}
