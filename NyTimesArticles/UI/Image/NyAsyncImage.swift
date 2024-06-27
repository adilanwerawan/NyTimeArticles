//
//  NyAsyncImage.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 27/06/2024.
//

import SwiftUI

struct NyAsyncImage: View {
    var photoURL:String
    var body: some View {
        AsyncImage(url: URL(string: photoURL)) { phase in
            if let image = phase.image {
                // Display the loaded image
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .addBorder(Color.gray, width: 1, cornerRadius: 50)
            } else if phase.error != nil {
                // Display a placeholder when loading failed
                Image(systemName: "questionmark.diamond")
                    .imageScale(.large)
                    .frame(width: 50, height: 50)
                    .addBorder(Color.gray, width: 1, cornerRadius: 50)
            } else {
                // Display a placeholder while loading
                ProgressView()
            }
        }
    }
}
