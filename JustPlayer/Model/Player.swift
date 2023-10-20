//
//  Player.swift
//  JustPlayer
//
//  Created by ifknord on 18/10/2023.
//

import AVFoundation

class Player {
    var isPlaying: Bool { songPlayer?.isPlaying ?? false }
    var isPause: Bool = false
    var playlist: Playlist
    var currentSong: URL?
    
    private var songPlayer: AVAudioPlayer?

    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    private func isValidIndex(_ index: Int) -> Bool {
        if index >= 0 && index < playlist.count {
            return true
        } else {
            print("Индекс песни недействителен - \(index)")
            return false
        }
    }
    
    func play(url: URL) {
        do {
            songPlayer = try AVAudioPlayer(contentsOf: url)
            currentSong = url
            songPlayer?.play()
        } catch {
            print("Ошибка при воспроизведении файла - \(url)")
            print(error.localizedDescription)
        }
    }
    
    func playSong(index: Int) {
        guard isValidIndex(index) else { return }
        
        let songURL = playlist.urls[index]
        play(url: songURL)
    }
    
    func pauseSong() {
        songPlayer?.pause()
        isPause = true
    }
    
    func resumeSong() {
        songPlayer?.play()
        isPause = false
    }
    
    func stopSong() {
        songPlayer?.stop()
        isPause = false
    }
    
    func nextSong() {
        isPause = false
        let url = playlist.urls.randomElement()
        play(url: url!)
    }
}
