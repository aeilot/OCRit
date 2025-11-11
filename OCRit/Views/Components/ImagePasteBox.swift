//
//  ImagePasteBox.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI
internal import UniformTypeIdentifiers
import AppKit

struct ImagePasteBox: View {
    @State var isPasting: Bool = false
    @State var color: Color = .secondary
    @State var isUploading: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var imageURL: String = ""
    
    var body: some View {
        ZStack{
            if isUploading {
                ProgressView("Uploading...")
                    .font(.title)
                    .foregroundStyle(color)
            } else {
                Label("Paste or Drop Your Image Here", systemImage: "document.on.clipboard")
                    .font(.title)
                    .foregroundStyle(color)
            }
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8])).cornerRadius(10)
                .foregroundColor(color)
                .padding()
                .onHover(perform: { hovering in
                    withAnimation {
                        if hovering {
                            color = .accentColor
                        } else {
                            color = .secondary
                        }
                    }
                }).onPasteCommand(of: [.image]) { providers in
                    if isPasting || isUploading {
                        return
                    }
                    handleImageProviders(providers)
                }.onDrop(of: [.image], isTargeted: nil) { providers in
                    if isPasting || isUploading {
                        return false
                    }
                    handleImageProviders(providers)
                    return true
                }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            if !imageURL.isEmpty {
                Button("Copy URL") {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(imageURL, forType: .string)
                }
                Button("OK", role: .cancel) {}
            } else {
                Button("OK", role: .cancel) {}
            }
        } message: {
            Text(alertMessage)
        }
            
    }
    
    private func handleImageProviders(_ providers: [NSItemProvider]) {
        isPasting = true
        
        guard let provider = providers.first else {
            isPasting = false
            return
        }
        
        provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, error in
            DispatchQueue.main.async {
                if let error = error {
                    showError("Failed to load image: \(error.localizedDescription)")
                    isPasting = false
                    return
                }
                
                guard let data = data, let image = NSImage(data: data) else {
                    showError("Failed to create image from data")
                    isPasting = false
                    return
                }
                
                uploadImage(image)
            }
        }
    }
    
    private func uploadImage(_ image: NSImage) {
        isUploading = true
        
        Task {
            do {
                let url = try await SMSMService.shared.uploadImage(image: image)
                
                await MainActor.run {
                    imageURL = url
                    showSuccess(url)
                    isUploading = false
                    isPasting = false
                }
            } catch {
                await MainActor.run {
                    showError("Upload failed: \(error.localizedDescription)")
                    isUploading = false
                    isPasting = false
                }
            }
        }
    }
    
    private func showSuccess(_ url: String) {
        alertTitle = "Upload Success"
        alertMessage = "Image URL: \(url)"
        showAlert = true
    }
    
    private func showError(_ message: String) {
        alertTitle = "Error"
        alertMessage = message
        imageURL = ""
        showAlert = true
    }
}

#Preview {
    ImagePasteBox()
}
