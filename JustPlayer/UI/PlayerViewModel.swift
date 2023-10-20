//
//  PlayerViewModel.swift
//  JustPlayer
//
//  Created by ifknord on 18/10/2023.
//

import Foundation

class PlayerViewModel: ObservableObject {
    let player: Player
    @Published var playlist: [URL] = []
    var currentSong: String { player.currentSong?.lastPathComponent ?? "Музыкальный плеер"}
    @Published var isPlaying = false

    init(player: Player) {
        self.player = player
        self.loadPlaylist()
    }
    
    func updatePlaylist(urls: [URL]) {
        player.playlist.urls.append(contentsOf: urls)
        playlist = player.playlist.urls
        savePlaylist()
    }
    
    func loadPlaylist() {
        if let defaultPlaylist = UserDefaults.standard.array(forKey: "DefaultPlaylist") as? [URL] {
            player.playlist.urls = defaultPlaylist
        } else {
            player.playlist.urls = FileProvider.mp3FromDocumentDirectory()
        }
        playlist = player.playlist.urls
    }
    
    func savePlaylist(){
        //UserDefaults.standard.set(player.playlist.urls, forKey: "DefaultPlaylist")
    }
    
    func play(_ url: URL) {
        if isPlaying {
            if player.isPause {
                player.resumeSong()
            } else {
                player.play(url: url)
            }
        } else {
            player.pauseSong()
        }
    }
    
    func play() {
        if isPlaying {
            if player.isPause {
                player.resumeSong()
            } else {
                player.playSong(index: 0)
            }
        } else {
            player.pauseSong()
        }
    }
}
