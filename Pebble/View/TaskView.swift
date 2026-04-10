//
//  TaskView.swift
//  Pebble
//
//  Created by Prayogo kosasih. W on 08/04/26.
//
import SwiftUI
import SwiftData

struct TaskView: View {
    @Bindable var task : TaskModel
    let colors: [Color] = [
        Color.color1,
        Color.color2,
        Color.color3,
    ]
    var body: some View {
        VStack{
            //Nama Task
            Text(task.taskName)
                .font(Font.title)
                .frame(width: 370, alignment: .init(horizontal: .leading, vertical: .center))
                .foregroundColor(Color.color)
            HStack{
                //Tanggal
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color.color)
                    Text(task.dueDate, style: .date)
                }
                .padding(.horizontal, 20)
                Spacer()
                //Label
                Text(task.category.rawValue)
                    .padding(8)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            //Deskripsi
            Text(task.taskNotes)
                .frame(width: 370, height: 300)
                .multilineTextAlignment(.leading)
            Divider()
            //List subtask
            ScrollView{
                VStack(spacing: 20) {
                    //Card Subtask
                    ForEach(Array(task.subtasks.enumerated()), id: \.element.id) { index, subtask in
                        SubtaskCard(
                            subtask: subtask,
                            bgColor: colors[index % colors.count],
                            textColor: .primary
                        )
                    }
                    //Button addsubtask
                    Button {
                        let newSubtask = SubtaskModel(subtaskName: "New Subtask")
                        task.subtasks.append(newSubtask)
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Subtask")
                        }
                        .foregroundColor(Color.primary)
                    }
                    .frame(width: 335, alignment: .init(horizontal: .leading, vertical: .center))
                }
            }
        }
    }
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskModel.self, SubtaskModel.self, configurations: config)
    
    let task = TaskModel(
        taskName: "Test Task",
        dueDate: .now,
        taskNotes: "This is a test description",
        progressBar: 0,
        category: .education
    )
    
    task.subtasks.append(SubtaskModel(subtaskName: "Subtask 1"))
    task.subtasks.append(SubtaskModel(subtaskName: "Subtask 2"))
    task.subtasks.append(SubtaskModel(subtaskName: "Subtask 3"))
    
    return TaskView(task: task)
        .modelContainer(container)
}
