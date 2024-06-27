//
//  NyArticlesHomeViewModel.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation
import Combine

class NyArticlesHomeViewModel : ObservableObject {
    
    var articleUseCase = ArticleUseCase(repo: ArticleRepositoryImpl(dataSource: ArticleApiDataSourceImpl()))
    
    @Published var articles: [NyResult] = []
    @Published var title = "NY Times Most Popular"
    @Published var error:ErrorResponse = ErrorResponse(message: "")
    @Published var showProgress = true
    
    func getArticles() {
    
        articleUseCase.getArticles { [weak self] result in
            DispatchQueue.main.async{
                self?.showProgress = false
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
    
    func photoUrl(article:NyResult) -> String{
        
        guard let media = article.media, media.count > 0 else {
            return ""
        }
        
        if let mediaURL = media[0].mediametadata?[0]{
            return mediaURL.url ?? ""
        }
        return ""
    }
    
    func publishedDate(article:NyResult) -> String{
        return article.publishedDate ?? ""
    }
    
    func articleTitle(article:NyResult) -> String{
        return article.title ?? ""
    }
    
    func abstractField(article:NyResult) -> String{
        return article.abstractField ?? ""
    }
    
    func byLine(article:NyResult) -> String{
        return article.byline ?? ""
    }
}
