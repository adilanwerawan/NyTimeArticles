//
//  ArticleRespository.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

protocol ArticleRepository{
    func getArticles() -> [NyArticle]
}
