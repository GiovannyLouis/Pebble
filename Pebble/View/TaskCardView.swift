//
//  TaskCardView.swift
//  Pebble
//
//  Created by maria belen on 08/04/26.
//
import Foundation
import SwiftUI
import SwiftData

struct TaskCardView: View {
    let task: TaskModel
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                .fill(Color.lightBlue)
                .stroke(Color.darkBlue,lineWidth: 3)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .padding(10)
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    Text("\(task.taskName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.darkBlue)
                    HStack {
                    Image(systemName: "calendar")
                            .foregroundStyle(Color.darkBlue)
                            
                        Text(task.dueDate, style: .date)                             .foregroundStyle(Color.darkBlue)
                    }
                }
                .padding(.leading, 20)
//                .frame(maxHeight: .infinity) //
                Spacer()//pushes circle to the right
                ZStack {
                    Circle()
                        .stroke(Color.darkBlue.opacity(0.2), lineWidth: 8)
                    
                    Circle()
                        .trim(from: 0, to: task.progress)
                        .stroke(
                            Color.darkBlue,
                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90)) // start from top
                        .animation(.easeInOut, value: task.progress)
                    
                    Text("\(task.progressPercentage)%")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.darkBlue)
                }
                .frame(width: 100, height: 100)
                .padding(.trailing,40)
                
            }
        }
    }
}

#Preview {
//    TaskCardView()
}

