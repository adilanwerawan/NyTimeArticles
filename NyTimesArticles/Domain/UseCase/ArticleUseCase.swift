//
//  ArticleUseCase.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

struct ArticleUseCase: ArticleRepository {
    var repo: ArticleRespository
    
    func getEvents() -> [NyArticle] {
        return repo.getArticles()
    }
    
}
