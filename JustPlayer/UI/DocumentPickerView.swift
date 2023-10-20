//
//  DocumentPickerView.swift
//  JustPlayer
//
//  Created by ifknord on 20/10/2023.
//

import SwiftUI

struct DocumentPickerView: UIViewControllerRepresentable {
    //@Binding var selectedSongs: [URL]
    var playerViewModel: PlayerViewModel

    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.audio])
        controller.allowsMultipleSelection = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // Обработка выбранных файлов
        uiViewController.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPickerView
        
        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            //parent.selectedSongs = urls
            parent.playerViewModel.updatePlaylist(urls: urls)
        }
    }
}
