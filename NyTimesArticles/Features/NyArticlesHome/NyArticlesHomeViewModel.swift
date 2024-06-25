//
//  NyArticlesHomeViewModel.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

class NyArticlesHomeViewModel: ObservableObject {
    
    var articleUseCases = ArticleUseCase(repo: ArticleRepositoryImpl(dataSource: ArticleApiDataSourceImpl()))
    
    @Published var articles: [NyArticle] = .init()
    @Published var title = ""
    @Published var description = ""
    @Published var date: Date = .init()
    
    func getArticles() {
        self.articles = articleUseCases.getArticles()
    }
}
