//
//  FileProvider.swift
//  JustPlayer
//
//  Created by ifknord on 20/10/2023.
//

import Foundation

class FileProvider {
    static func mp3FromDocumentDirectory() -> [URL] {
        print(#function)

        let fileManager = FileManager.default
        var urls: [URL] = []
        var documentDirectory: URL?
        do {
            documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
        } catch {
            print("Ошибка при открытия папки с файлами")
            print(error.localizedDescription)
            return []
        }

//        let folderPath = Bundle.main.resourcePath?.appending("/Files")
        let folderPath = documentDirectory?.path()
        print("folderPath = \(String(describing: folderPath))")

        do {
            let fileList = try fileManager.contentsOfDirectory(atPath: folderPath!)
            print("file list count = \(fileList.count)")
                for file in fileList {
                    if file.lowercased().hasSuffix(".mp3") {
                        print(file)
                        let songURL = URL(fileURLWithPath: folderPath!.appending("/\(file)"))
                        urls.append(songURL)
                    }
                }
            print(urls)
        } catch {
            print("Ошибка при загрузке файлов из папки - \(String(describing: folderPath))")
            print(error.localizedDescription)
        }
        
        return urls
    }
}
