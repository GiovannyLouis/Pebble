//
//  AddTaskView.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI

struct AddTaskView: View {
    @State var vm = AddTaskViewModel() //hubungkan ke view model
    @Environment(\.dismiss) var dismiss //dipakai untuk menutup view saat ini/untuk tutup modal
    
    
    var body: some View {
        NavigationStack{
            //List untuk form isi new task
            List{
                TextField("Task Name", text: $vm.taskName)
                TextField("Notes", text: $vm.taskNotes)
                
                //======= Date picker ==========
                HStack {
                    Text("Due Date")
                    Spacer()
                    Button{
                        withAnimation{
                            vm.toggleDatePicker()
                        }
                    } label: {
                        Text(vm.dueDate, style: .date)
                            .foregroundColor(vm.isShowingDatePicker ? .blue : .black) //ganti warna font ketika dipencet
                    }
                    .buttonStyle(.bordered)
                }
                
                //kalau true show graphical date
                if vm.isShowingDatePicker {
                    DatePicker("Due Date",
                               selection: $vm.dueDate,
                               displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                }
                //=============================
                
                
                // Picker Category
                Picker("Category",selection: $vm.selectedCategory) {
                    //pakai selection untuk tambah separator antar None dan yang lain
                    Section{
                        Text(Category.none.rawValue).tag(Category.none)
                    }
                    
                    //dropFirst untuk skip first enum (.none)
                    Section{
                        ForEach(Category.allCases.dropFirst()){category in
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
                        if vm.isChanged{
                            vm.isShowingDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }.confirmationDialog("Are you sure you want to discard this new task?",isPresented: $vm.isShowingDiscardAlert, titleVisibility: .visible) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss() //tutup modal
                        }
                    }
                }
                
                //save button untuk create object task 
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        //TODO: Save Function
                        //_ = vm.createTask() //test buat task
                        dismiss()//tutup modal
                    } label: {
                        Image(systemName: "checkmark").foregroundStyle(.white)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(vm.isChanged ? .blue : .gray)
                    .disabled(!vm.isChanged)// Tombol mati jika isChanged  false

                }
                
            }
            
            
        }
    }
}

#Preview {
    AddTaskView()
}

