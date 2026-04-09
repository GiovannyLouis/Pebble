//
//  Subtask.swift
//  Pebble
//
//  Created by Prayogo kosasih. W on 08/04/26.
//

import SwiftUI

struct SubtaskCard: View {
    var title: String
    var bgColor: Color
    var textColor: Color
    
    @State private var isDone = false
    
    var body: some View {
        HStack {
            Circle()
                .stroke(isDone ? Color.blue : Color.black, lineWidth: 1)
                .background(
                    Circle()
                        .fill(isDone ? Color.blue : Color.clear)
                )
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(isDone ? Color.white : Color.clear)
                    )
                .onTapGesture {
                    isDone.toggle()
                }
            
            Text(title)
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
    @State var title: String
    var bgColor: Color
    var textColor: Color
    @State private var isDone = false
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.red)
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: "minus")
                        .foregroundColor(Color.white)
                )
            Spacer()
            Circle()
                .stroke(isDone ? Color.blue : Color.black, lineWidth: 1)
                .background(
                    Circle()
                        .fill(isDone ? Color.blue : Color.clear)
                )
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(isDone ? Color.white : Color.clear)
                    )
                .onTapGesture {
                    isDone.toggle()
                }
            TextEditor(text: $title)
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
