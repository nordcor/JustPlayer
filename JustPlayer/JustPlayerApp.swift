//
//  JustPlayerApp.swift
//  JustPlayer
//
//  Created by ifknord on 18/10/2023.
//

import SwiftUI

@main
struct JustPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            let playlist = Playlist()
            let player = Player(playlist: playlist)
            MainPlayerView(viewModel: PlayerViewModel(player: player))
        }
    }
}
