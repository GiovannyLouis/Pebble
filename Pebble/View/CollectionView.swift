//
//  CollectionView.swift
//  Pebble
//
//  Created by Vrz on 08/04/26.
//

import SwiftUI
import UniformTypeIdentifiers
import QuickLook
import SwiftData

struct CollectionView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var collections: [CollectionModel]
    
    // Collection Logic Managed by ViewModel
    @State private var viewModel = CollectionViewModel()
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationStack {
            // Collections grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(collections) { collection in
                        Button {
                            viewModel.handleTap(for: collection)
                        } label: {
                            CollectionCard(collection: collection)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("My Collections")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: { viewModel.isAddingFile = true }) {
                            Label("File", systemImage: "doc.badge.plus")
                        }
                        Button(action: { viewModel.isAddingLink = true }) {
                            Label("Link", systemImage: "link")
                        }
                    } label: {
                        Image(systemName: "plus").fontWeight(.semibold)
                    }
                }
            }
            // Add File Modal
            .sheet(isPresented: $viewModel.isAddingFile) {
                fileAdditionSheet
            }
            // Add Link Modal
            .sheet(isPresented: $viewModel.isAddingLink) {
                linkAdditionSheet
            }
            // Open Files
            .fileImporter(
                isPresented: $viewModel.fileInput,
                allowedContentTypes: [.pdf, .plainText, .image, .movie],
                allowsMultipleSelection: false
            ) { result in
                if case .success(let urls) = result, let url = urls.first {
                    viewModel.addFile(from: url, modelContext: modelContext)
                }
            }
            // Preview Files
            .quickLookPreview($viewModel.selectedFileURL)
        }
    }
    
    // Add File Modal View
    var fileAdditionSheet: some View {
        VStack(spacing: 20) {
            Text("Add New File")
                .font(.headline)
                .padding(.top, 32)
            Spacer()
            ZStack { Image(systemName: "plus")
                .font(.system(size: 40)) }
                .frame(width: 120, height: 160)
                .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                .contentShape(RoundedRectangle(cornerRadius: 12))
                .onTapGesture {
                    viewModel.isAddingFile = false
                    viewModel.fileInput = true
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack {
                Text("Max. file size 10 MB")
                Text("File Type: PDF, PNG, JPEG, JPG, MP4, MOV")
            }
            .font(.caption)
            .italic()
            .opacity(0.7)
            Spacer()
        }
        .presentationDetents([.medium])
    }
    
    // Add Link Modal View
    var linkAdditionSheet: some View {
        VStack(spacing: 20) {
            Text("Add New Link").font(.headline)
                .padding(.top, 32)
            TextEditor(text: $viewModel.linkInput)
                .frame(height: 120)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1.0)
                )
                .keyboardType(.URL)
                .padding(.horizontal)
                .padding(.vertical, 32)
            HStack {
                Button("Cancel") { viewModel.isAddingLink = false }
                Spacer()
                Button("Add") { viewModel.addLink(modelContext: modelContext) }
                    .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 100)
            Spacer()
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    CollectionView()
}
