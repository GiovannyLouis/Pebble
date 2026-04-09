//
//  TaskView.swift
//  Pebble
//
//  Created by Prayogo kosasih. W on 08/04/26.
//
import SwiftUI

struct EditTaskView: View {
    @State var TaskName : String = "Task Name"
    @State var TaskDescription : String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    @State var date : Date = Date()
    @State var subtasks: [String] = [
        "Subtask1",
        "Subtask2",
        "Subtask3",
        "Subtask4",
        "Subtask5",
        "Subtask1",
        "Subtask2",
        "Subtask3",
        "Subtask4",
        "Subtask5"
    ]
    let colors: [Color] = [
        Color.color1,
        Color.color2,
        Color.color3,
    ]
    var body: some View {
        VStack{
            //Nama Task
            TextEditor(text : $TaskName)
                .font(Font.title)
                .frame(width: 370, alignment: .init(horizontal: .leading, vertical: .center))
                .foregroundColor(Color.color)
                .frame(height: 50)
            HStack{
                //Tanggal
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color.color)
                    Text(date, style: .date)
                }
                .padding(.horizontal, 20)
                Spacer()
                //Label
                Text("#Label")
                    .padding(8)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            //Deskripsi
            TextEditor(text: $TaskDescription)
                .frame(width: 370, height: 300)
                .multilineTextAlignment(.leading)
            Divider()
            //List subtask
            ScrollView{
                VStack(spacing: 20) {
                    //Card Subtask
                    ForEach(subtasks.indices , id: \.self) { index in
                        EditSubtaskCard(
                            title: subtasks[index],
                            bgColor: colors[index % colors.count],
                            textColor: .primary
                        ).padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}



#Preview {
    Group {
        EditTaskView()
    }
}
