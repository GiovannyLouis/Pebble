//
//  AddTaskViewModel.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI

@Observable
class AddTaskViewModel {
    var taskName = ""
    var taskNotes = ""
    var dueDate = Date()
    var selectedCategory: Category = .none
    
    var isShowingDatePicker:Bool = false
    
    var initialDate = Date() //dipaki untuk cek apakah dueDate sudah berubah atau belum
    var isChanged: Bool{
        taskName != "" ||
        taskNotes != "" ||
        dueDate != initialDate ||
        selectedCategory != .none
    } //if isChange True show discard alert/action sheet
    var isShowingDiscardAlert:Bool = false

    func toggleDatePicker() {
        isShowingDatePicker.toggle()//toggle ganti value bool
    }
    
    
//test model
//    func createTask() -> Task {
//        Task(name: taskName, notes: taskNotes, dueDate: dueDate, category: selectedCategory)
//    }
}
