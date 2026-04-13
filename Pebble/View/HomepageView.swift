//
//  HomepageView.swift
//  Pebble
//
//  Created by Vrz on 07/04/26.
//
import Foundation
import SwiftUI

struct HomepageView: View {
//    let sampleTask: TaskModel
    @State private var selectedIndex = 0
    let options = ["Ongoing", "Completed"]
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State var isShowingAddTask: Bool = false
    
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
                    
                    Button(action: {
                        // action
                    }){
                        Image(systemName: "arrow.up.arrow.down")
                            .frame(width: 20, height: 30)
                        
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.white) // 👈 changes the background color
                    .foregroundStyle(.black)
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
                    TaskCardView()
                }
                
            }
            .searchable(text: $searchText, isPresented: $searchIsActive)

        }
    }
}

#Preview {
    HomepageView()
}
