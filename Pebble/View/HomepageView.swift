//
//  HomepageView.swift
//  Pebble
//
//  Created by Vrz on 07/04/26.
//
import Foundation
import SwiftUI
import SwiftData

struct HomepageView: View {
    
    @Query private var tasks: [TaskModel]
    
    @State private var selectedIndex = 0
    let options = ["Ongoing", "Completed"]
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State var isShowingAddTask: Bool = false
    private var filteredTasks: [TaskModel] {
        switch selectedIndex {
        case 0: // Ongoing
            return tasks.filter { !$0.isCompleted && $0.progressPercentage < 100 }
        case 1: // Completed
            return tasks.filter { $0.isCompleted || $0.progressPercentage == 100 }
        default:
            return tasks
        }
    }
    let lightColors: [Color] = [.lightBlue, .lightYellow, .lightPurple]
    let darkColors: [Color] = [.darkBlue, .darkYellow, .darkPurple]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("pebble green logo")
                        .resizable()
                        .frame(width: 100, height: 60)
                    Spacer()
                    Button {
                        isShowingAddTask = true
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 30)
                        
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.white) // 👈 changes the background color
                    .foregroundStyle(.black)
                    .sheet(isPresented: $isShowingAddTask) {
                        AddTaskView()
                    }
                }
                .padding(.horizontal, 25)
                Picker("Ongoing", selection: $selectedIndex) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(options[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Spacer()
                ScrollView() {
                    //TODO: WARNA CARD + NAVIGASI
                    ForEach(Array(filteredTasks.enumerated()), id: \.element.id) { index, task in
                        NavigationLink(destination: TaskView(task: task)) {
                            TaskCardView(task: task, lightColor: lightColors[index % lightColors.count],
                                         darkColor: darkColors[index % darkColors.count])
                        }
                    }
                    
                }
                
            }
            .searchable(text: $searchText, isPresented: $searchIsActive)
            
        }
    }
}

#Preview {
    HomepageView()
}
