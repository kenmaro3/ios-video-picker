//
//  ContentView.swift
//  VideoPicker
//
//  Created by Kentaro Mihara on 2023/08/14.
//

import SwiftUI

struct ContentView: View {

    @State private var movieUrl: URL?
    @State private var showCameraMoviePickerView = false
    @State private var showPhotoLibraryMoviePickerView = false
    @State private var showMoviePlayerView = false

    private var canPlayVideo: Bool {
        movieUrl != nil
    }

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Button {
                showCameraMoviePickerView = true
            } label: {
                Text("Camera Movie Picker")
            }

            Button {
                showPhotoLibraryMoviePickerView = true
            } label: {
                Text("Photo Library Movie Picker")
            }

            Button {
                showMoviePlayerView = true

                guard let url = movieUrl else {
                    return
                }
                print(url)
            } label: {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: 50,
                           height:50)
                    .foregroundColor(canPlayVideo ? .accentColor : .gray)
            }
            .disabled(!canPlayVideo)

            Spacer()
        }
        .fullScreenCover(isPresented: $showCameraMoviePickerView) {
            CameraMoviePickerView(movieUrl: $movieUrl)
        }
        .fullScreenCover(isPresented: $showPhotoLibraryMoviePickerView) {
            PhotoLibraryMoviePickerView(movieUrl: $movieUrl)
        }
        .fullScreenCover(isPresented: $showMoviePlayerView) {
            MoviePlayerView(with: movieUrl)
        }
    }
}
