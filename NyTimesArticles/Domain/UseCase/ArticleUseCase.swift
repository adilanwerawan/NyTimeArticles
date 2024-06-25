//
//  ArticleUseCase.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

struct ArticleUseCase: ArticleRepository {
    var repo: ArticleRepository
    
    func getArticles(completion: @escaping APIClientCompletion){
        return repo.getArticles(completion: completion)
    }
    
}
