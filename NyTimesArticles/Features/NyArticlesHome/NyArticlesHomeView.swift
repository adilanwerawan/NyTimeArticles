//
//  ContentView.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import SwiftUI

struct NyArticlesHomeView: View {
    
    @StateObject public var vm:NyArticlesHomeViewModel
    
    public init(viewModel: NyArticlesHomeViewModel) {
        self._vm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    List(self.vm.articles) { row in
                        NavigationLink(destination: NyArticleDetails(viewModel: NyArticleDetailViewModel(nyArticle: row))) {
                            ArticleRow(photoURL: self.vm.photoUrl(article: row), title: self.vm.articleTitle(article: row), date: self.vm.publishedDate(article: row), byAuthor: self.vm.byLine(article: row))
                        }
                    }
                    .listStyle(.plain)
                    .padding(10)
                }
                .onAppear {
                    vm.getArticles()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .principal) {
                        Text(self.vm.title)
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
                if self.vm.showProgress{
                   ProgressView()
                }
            }
        }
    }
}
