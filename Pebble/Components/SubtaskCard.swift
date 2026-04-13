//
//  Subtask.swift
//  Pebble
//
//  Created by Prayogo kosasih. W on 08/04/26.
//

import SwiftUI
import SwiftData

enum SubtaskCardMode {
    case view
    case edit(onDelete: () -> Void)
}

struct SubtaskCard: View {
    @Bindable var subtask: SubtaskModel
    var bgColor: Color
    var textColor: Color
    var mode: SubtaskCardMode

    var body: some View {
        HStack(spacing: 12) {

            // Delete button (only in edit mode)
            if case let .edit(onDelete) = mode {
                DeleteCircle(action: onDelete)
            }

            // Check circle (always visible)
            CheckCircle(isCompleted: subtask.isCompleted) {
                subtask.isCompleted.toggle()
            }

            // Content (switch based on mode)
            contentView

            Spacer()
        }
        .padding()
        .frame(minHeight: 70)
        .background(bgColor)
        .cornerRadius(25)
    }

    @ViewBuilder
    private var contentView: some View {
        switch mode {
        case .view:
            Text(subtask.subtaskName)
                .foregroundColor(textColor.opacity(0.5))

        case .edit:
            TextEditor(text: $subtask.subtaskName)
                .foregroundColor(textColor.opacity(0.5))
                .scrollContentBackground(.hidden)
        }
    }
}

struct DeleteCircle: View {
    var action: () -> Void

    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 26, height: 26)
            .overlay(
                Image(systemName: "minus")
                    .foregroundColor(.white)
            )
            .onTapGesture {
                action()
            }
    }
}


struct CheckCircle: View {
    var isCompleted: Bool
    var action: () -> Void

    var body: some View {
        Circle()
            .stroke(isCompleted ? Color.blue : Color.black, lineWidth: 1)
            .background(
                Circle()
                    .fill(isCompleted ? Color.blue : Color.clear)
            )
            .frame(width: 26, height: 26)
            .overlay(
                Image(systemName: "checkmark")
                    .foregroundColor(isCompleted ? .white : .clear)
            )
            .onTapGesture {
                action()
            }
    }
}
