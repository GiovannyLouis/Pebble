//
//  Untitled.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI
import SwiftData

@Observable
class AddSubtaskViewModel {
    var subtaskName = ""
    
    //Cek jika form sudah terisi atau belum
    var isChanged: Bool{
        subtaskName != ""
    }
    
    //if isChange True show discard alert/action sheet
    var isShowingDiscardAlert:Bool = false
    
    
    func createSubtask() -> SubtaskModel {
        SubtaskModel(subtaskName: subtaskName)
    }
}
