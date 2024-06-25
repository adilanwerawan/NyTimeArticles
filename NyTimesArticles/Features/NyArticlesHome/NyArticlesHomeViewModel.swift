//
//  NyArticlesHomeViewModel.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation
import Combine

class NyArticlesHomeViewModel<T:Codable> : ObservableObject {
    
    var articleUseCase = ArticleUseCase(repo: ArticleRepositoryImpl(dataSource: ArticleApiDataSourceImpl()))
    
    @Published var articles: [NyResult] = .init()
    @Published var title = ""
    @Published var description = ""
    @Published var date: Date = .init()
    @Published var error:ErrorResponse = ErrorResponse(message: "")
    
    func getArticles() {
    
        articleUseCase.getArticles { [weak self] result in
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: NyArticle.self) {
                    if let results = response.body.results {
                        self?.articles = results
                    }
                } else {
                    self?.error = ErrorResponse(message: "Failed to decode response")
                }
            case .failure:
                self?.error = ErrorResponse(message: "Error perform network request")
            }
        }
    }
}
