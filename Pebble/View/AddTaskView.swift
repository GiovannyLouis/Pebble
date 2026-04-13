//
//  AddTaskView.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI

struct AddTaskView: View {
    @State var addTaskViewModel = AddTaskViewModel() //hubungkan ke view model
    @Environment(\.dismiss) var dismiss //dipakai untuk menutup view saat ini/untuk tutup modal
    
    
    var body: some View {
        NavigationStack{
            //List untuk form isi new task
            List{
                TextField("Task Name", text: $addTaskViewModel.taskName)
                TextField("Notes", text: $addTaskViewModel.taskNotes)
                
                //======= Date picker ==========
                HStack {
                    Text("Due Date")
                    Spacer()
                    Button{
                        withAnimation{
                            addTaskViewModel.toggleDatePicker()
                        }
                    } label: {
                        Text(addTaskViewModel.dueDate, style: .date)
                            .foregroundColor(addTaskViewModel.isShowingDatePicker ? .blue : .black) //ganti warna font ketika dipencet
                    }
                    .buttonStyle(.bordered)
                }
                
                //kalau true show graphical date
                if addTaskViewModel.isShowingDatePicker {
                    DatePicker("Due Date",
                               selection: $addTaskViewModel.dueDate,
                               displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                }
                //=============================
                
                
                // Picker Category
                Picker("Category",selection: $addTaskViewModel.selectedCategory) {
                    //pakai selection untuk tambah separator antar None dan yang lain
                    Section{
                        Text(TaskCategory.none.rawValue).tag(TaskCategory.none)
                    }
                    
                    //dropFirst untuk skip first enum (.none)
                    Section{
                        ForEach(TaskCategory.allCases.dropFirst()){category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
            }
            
            //Toolbar untuk tombol dismiss dan confirm
            .toolbar{
                //discard changes button
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        if addTaskViewModel.isChanged{
                            addTaskViewModel.isShowingDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }.confirmationDialog("Are you sure you want to discard this new task?",isPresented: $addTaskViewModel.isShowingDiscardAlert, titleVisibility: .visible) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss() //tutup modal
                        }
                    }
                }
                
                //save button untuk create object task 
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        //TODO: Save Function
                        //_ = addTaskViewModel.createTask() //test buat task
                        dismiss()//tutup modal
                    } label: {
                        Image(systemName: "checkmark").foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(addTaskViewModel.isChanged ? .blue : .gray)
                    .disabled(!addTaskViewModel.isChanged)// Tombol mati jika isChanged  false

                }
                
            }
            
            
        }
    }
}

#Preview {
    AddTaskView()
}

