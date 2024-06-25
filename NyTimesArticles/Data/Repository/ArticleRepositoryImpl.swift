//
//  ArticleRepositoryImpl.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

struct ArticleRepositoryImpl: ArticleRepository {
    
    var dataSource: ArticleRepository
    
    func getArticles(completion: @escaping APIClientCompletion){
        return dataSource.getArticles(completion: completion)
    }
}
