//
//  TaskView.swift
//  Pebble
//
//  Created by Prayogo kosasih. W on 08/04/26.
//
import SwiftUI
import SwiftData

struct EditTaskView: View {
    @Bindable var task: TaskModel
    @State private var isShowingDatePicker = false
    @State private var isShowingCategoryPicker = false
    let colors: [Color] = [
        Color.color1,
        Color.color2,
        Color.color3,
    ]
    var body: some View {
        VStack{
            //Nama Task
            TextEditor(text : $task.taskName)
                .font(Font.title)
                .frame(width: 370, alignment: .init(horizontal: .leading, vertical: .center))
                .foregroundColor(Color.color)
                .frame(height: 50)
            HStack{
                //Tanggal
                VStack {
                    Button {
                        isShowingDatePicker = true
                    } label: {
                        HStack{
                            Image(systemName: "calendar")
                                .foregroundColor(Color.color)
                            Text(task.dueDate, style: .date)
                                .foregroundColor(Color.color)
                        }
                    }
                    .padding(.horizontal, 20)
                }.sheet(isPresented: $isShowingDatePicker) {
                    VStack {
                        DatePicker(
                            "Due Date",
                            selection: $task.dueDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        .padding()
                        
                        Button("Done") {
                            isShowingDatePicker = false
                        }
                        .padding()
                    }
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                }
                //Label
                
                Text(task.category.rawValue)
                    .padding(8)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            //Deskripsi
            TextEditor(text: $task.taskNotes)
                .frame(width: 370, height: 300)
                .multilineTextAlignment(.leading)
            Divider()
            //List subtask
            ScrollView{
                VStack(spacing: 20) {
                    //Card Subtask
                    ForEach(Array(task.subtasks.enumerated()), id: \.element.id) { index, subtask in
                        EditSubtaskCard(
                            subtask: subtask,
                            bgColor: colors[index % colors.count],
                            textColor: .primary
                        ) {
                            if let index = task.subtasks.firstIndex(where: { $0.id == subtask.id }) {
                                task.subtasks.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskModel.self, SubtaskModel.self, configurations: config)
    
    let task = TaskModel(
        taskName: "Task Name",
        dueDate: .now,
        taskNotes: "Edit this task",
        progressBar: 0,
        category: .education
    )
    
    task.subtasks.append(SubtaskModel(subtaskName: "Edit Subtask 1"))
    task.subtasks.append(SubtaskModel(subtaskName: "Edit Subtask 2"))
    task.subtasks.append(SubtaskModel(subtaskName: "Edit Subtask 2"))
    task.subtasks.append(SubtaskModel(subtaskName: "Edit Subtask 2"))
    task.subtasks.append(SubtaskModel(subtaskName: "Edit Subtask 2"))
    task.subtasks.append(SubtaskModel(subtaskName: "Edit Subtask 2"))
    
    return EditTaskView(task: task)
        .modelContainer(container)
}
