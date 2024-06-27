//
//  ArticleRow.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 26/06/2024.
//

import SwiftUI

struct ArticleRow: View {
    var photoURL:String
    var title:String
    var date:String
    var byAuthor:String
    
    var body: some View {
        HStack(spacing: 5.0){
            NyAsyncImage(photoURL: photoURL)
        }
        .frame(width: 50, height: 50)
        .addBorder(Color.gray, width: 1, cornerRadius: 50)
        VStack(alignment: .leading, spacing: 8.0){
            Text(title)
                .font(.body)
                .foregroundStyle(Color.primary)
                .frame(alignment: .leading)
                .padding(.leading, 0)
            HStack(spacing:8.0){
                Text(byAuthor)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray)
                Text(date)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray)
            }
            
        }
    }
}

#Preview {
    ArticleRow(photoURL: "", title: "New One", date: "25/06/2024", byAuthor: "by Adil Anwer")
}
