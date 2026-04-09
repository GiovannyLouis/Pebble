//
//  CollectionView.swift
//  Pebble
//
//  Created by Vrz on 08/04/26.
//

import SwiftUI
import UniformTypeIdentifiers
import QuickLook

struct CollectionView: View {
    @State private var uploadedCollections: [CollectionModel] = []
    @State private var isAddingFile: Bool = false
    @State private var isAddingLink: Bool = false
    @State private var linkInput: String = ""
    @State private var fileInput: Bool = false
    @State private var selectedFileURL: URL?
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(uploadedCollections) {collection  in
                        Button {
                            handleTap(for: collection)
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
                    Menu{
                        Button(action: { isAddingFile = true }) {
                            Label("File", systemImage: "doc.badge.plus")
                        }
                        Button(action: { isAddingLink = true }) {
                            Label("Link", systemImage: "link")
                        }
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $isAddingFile) {
                VStack(spacing: 20) {
                    Text("Add New File")
                        .font(.headline)
                        .padding(.top, 32)
                    Spacer()
                    ZStack {
                        Image(systemName: "plus")
                            .font(.system(size: 40))
                    }
                    .frame(width: 120, height: 160)
                    .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                    .contentShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        isAddingFile = false
                        fileInput = true
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack {
                        Text("Max. file size 10 MB")
                        Text("File Type: PDF, PNG, JPEG, JPG, MP4, MOV")
                    }
                    .font(.caption)
                    .italic()
                    .foregroundStyle(.opacity(0.7))
                    Spacer()
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            .fileImporter(
                isPresented: $fileInput,
                allowedContentTypes: [.pdf, .plainText, .image, .movie],
                allowsMultipleSelection: false
            ) { result in
                if case .success(let urls) = result, let url = urls.first {
                    if url.startAccessingSecurityScopedResource() {
                        CollectionService.generateFileThumbnail(for: url) { thumb in
                            let newCollection = CollectionModel(name: url.lastPathComponent, date: Date(), thumbnail: thumb, type: .file, url: url)
                            uploadedCollections.append(newCollection)
                            url.stopAccessingSecurityScopedResource()
                        }
                    }
                }
            }
            .quickLookPreview($selectedFileURL)
            .sheet(isPresented: $isAddingLink) {
                VStack(spacing: 20) {
                    Text("Add New Link")
                        .font(.headline)
                        .padding(.top, 32)
                    Spacer()
                    TextField("https://example.com", text: $linkInput)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                        .padding(.horizontal)
                    HStack(spacing: 20) {
                        Button("Cancel", role: .cancel) {
                            linkInput = ""
                            isAddingLink = false
                        }
                        .buttonStyle(.bordered)
                        Button("Add") {
                            processLink(linkInput)
                            linkInput = ""
                            isAddingLink = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
    
    func processLink(_ urlString: String) {
        // Basic validation to ensure the string starts with http
        let formattedUrl = urlString.lowercased().hasPrefix("http") ? urlString : "https://\(urlString)"
        
        guard let webURL = URL(string: formattedUrl) else { return }
        
        CollectionService.fetchLinkMetadata(for: formattedUrl) { title, image in
            let newCollection = CollectionModel(name: title, date: Date(), thumbnail: image, type: .link, url: webURL)
            uploadedCollections.append(newCollection)
        }
    }
    
    func handleTap(for collection: CollectionModel) {
        guard let targetURL = collection.url else { return }
        if collection.type == .link {
            UIApplication.shared.open(targetURL)
        } else {
            self.selectedFileURL = targetURL
        }
    }
}

#Preview {
    CollectionView()
}
