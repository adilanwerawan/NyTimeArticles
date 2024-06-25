//
//  ArticleDataSource.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

struct ArticleApiDataSourceImpl: ArticleRepository{
    
    let apiClient = APIClient()
    
    func getArticles(completion: @escaping APIClientCompletion){
        let request = ArticlesRequest()
        
        return apiClient.sendRequest(apiRequest: request, completion: completion)
    }
}
