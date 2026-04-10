//
//  Subtask.swift
//  Pebble
//
//  Created by Prayogo kosasih. W on 08/04/26.
//

import SwiftUI
import SwiftData

struct SubtaskCard: View {
    var subtask: SubtaskModel
    var bgColor: Color
    var textColor: Color
    
    var body: some View {
        HStack {
            Circle()
                .stroke(subtask.isCompleted ? Color.blue : Color.black, lineWidth: 1)
                .background(
                    Circle()
                        .fill(subtask.isCompleted ? Color.blue : Color.clear)
                )
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(subtask.isCompleted ? Color.white : Color.clear)
                    )
                .onTapGesture {
                    subtask.isCompleted.toggle()
                }
            
            Text(subtask.subtaskName)
                .foregroundColor(textColor.opacity(0.5))
                .font(.body)
            
            Spacer()
        }
        .padding()
        .frame(height: 70)
        .background(bgColor)
        .cornerRadius(25)
    }
}

struct EditSubtaskCard: View {
    @Bindable var subtask: SubtaskModel
    var bgColor: Color
    var textColor: Color
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.red)
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: "minus")
                        .foregroundColor(Color.white)
                ).onTapGesture {
                    onDelete()
                }
            Spacer()
            Circle()
                .stroke(subtask.isCompleted ? Color.blue : Color.black, lineWidth: 1)
                .background(
                    Circle()
                        .fill(subtask.isCompleted ? Color.blue : Color.clear)
                )
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(subtask.isCompleted ? Color.white : Color.clear)
                    )
                .onTapGesture {
                    subtask.isCompleted.toggle()
                }
            TextEditor(text: $subtask.subtaskName)
                .foregroundColor(textColor)
                .font(.title3)
                .scrollContentBackground(.hidden)
            
            Spacer()
        }
        .padding()
        .frame(height: 70)
        .background(bgColor)
        .cornerRadius(25)
    }
}
