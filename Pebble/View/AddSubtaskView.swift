//
//  AddSubtaskView.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI

struct AddSubtaskView: View {
    let task: TaskModel

    @State var addSubtaskViewModel = AddSubtaskViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 12){
                // Title
                Text("Subtask")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 10)
                    .padding(.leading, 25)
                
                //Text Editor + Placeholder kalau subtask kosong
                ZStack(alignment: .topLeading){
                    TextEditor(text: $addSubtaskViewModel.subtaskName)
                        .padding(12)
                        .frame(maxHeight: 180, alignment: .init(horizontal: .leading, vertical: .top))
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    //placeholder untuk TextEditor isinya pertanyaan
                    if addSubtaskViewModel.subtaskName.isEmpty {
                        Text("PERTANYAAN DARI AI?......") //TODO: Implementasi AI untuk pertanyaannya
                            .foregroundStyle(.tertiary)
                            .padding(.top, 20)
                            .padding(.horizontal, 36)
                            .allowsHitTesting(false) //agar textEitornya bisa di klik
                    }
                }
                Spacer()
            }
            //background gray
            .background(Color(.systemGroupedBackground))
            .frame(maxWidth: .infinity, maxHeight: .infinity) // agar bg color menutupi seluruh screen
            
            
            //Toolbar untuk tombol dismiss dan confirm
            .toolbar{
                //discard changes button
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        if addSubtaskViewModel.isChanged{
                            addSubtaskViewModel.isShowingDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }.confirmationDialog("Are you sure you want to discard this new task?",isPresented: $addSubtaskViewModel.isShowingDiscardAlert, titleVisibility: .visible) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss() //tutup modal
                        }
                    }
                }
                
                //save button untuk create object task
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        //TODO: Save Function
                        let newSubtask = addSubtaskViewModel.createSubtask()
                        task.subtasks.append(newSubtask)
                        dismiss()//tutup modal
                    } label: {
                        Image(systemName: "checkmark").foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(addSubtaskViewModel.isChanged ? .blue : .gray)
                    .disabled(!addSubtaskViewModel.isChanged)// Tombol mati jika isChanged  false
                }
            }
        }
    }
}


#Preview {
//    AddSubtaskView(task:)
}
