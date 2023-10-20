//
//  ContentView.swift
//  JustPlayer
//
//  Created by ifknord on 18/10/2023.
//

import SwiftUI

struct MainPlayerView: View {
    @State private var showingPicker = false
    @StateObject var viewModel: PlayerViewModel
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack {
            Text(viewModel.currentSong)
                .font(.title)
                .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    // Действие при нажатии на кнопку Stop
                    viewModel.isPlaying = false
                    viewModel.player.stopSong()
                }) {
                    Image(systemName: "stop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                }
                Spacer()
                Button(action: {
                    // Действие при нажатии на кнопку Play
                    viewModel.isPlaying.toggle()
                    viewModel.play()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                }
                Spacer()
                Button(action: {
                    // Действие при нажатии на кнопку Next Song
                    viewModel.isPlaying.toggle()
                    viewModel.isPlaying = true
                    viewModel.player.nextSong()
                }) {
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }
                Spacer()
            }
            
            Spacer()
            
            List(viewModel.playlist, id: \.self) { song in
                Text(song.lastPathComponent)
                    .onTapGesture {
                        // Воспроизводим песню при нажатии на строку
                        viewModel.isPlaying.toggle()
                        viewModel.isPlaying = true
                        viewModel.play(song)
                    }
            }
            
            Button(action: {
                showingPicker = true
            }) {
                Text("Добавить музыку")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $showingPicker) {
            DocumentPickerView(playerViewModel: viewModel)
        }
        .onAppear{
            // TODO
        }
        .onDisappear{
            viewModel.savePlaylist()
        }
        .onChange(of: scenePhase) { newPhase in
            print("newPhase - \(newPhase)")
            if newPhase == .inactive {
                viewModel.savePlaylist()
            } else if newPhase == .active {
                
            } else if newPhase == .background {
                viewModel.savePlaylist()
            }
        }
    }
    

}

struct MainPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MainPlayerView(viewModel: PlayerViewModel(player: Player(playlist: Playlist())))
    }
}
