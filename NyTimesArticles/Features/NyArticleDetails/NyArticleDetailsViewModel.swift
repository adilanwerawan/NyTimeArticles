//
//  NyArticleDetailsViewModel.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 26/06/2024.
//

import Foundation

class NyArticleDetailViewModel : ObservableObject {
    
    @Published var article: NyResult
    @Published var title = "NY Times Most Popular"
    
    public init(nyArticle:NyResult){
        self.article = nyArticle
    }
    
    var publishedDate:String {
        return self.article.publishedDate ?? ""
    }
    
    var articleTitle:String {
        return self.article.title ?? ""
    }
    
    var abstractField:String {
        return self.article.abstractField ?? ""
    }
    
    var byLine:String {
        return self.article.byline ?? ""
    }
    
    var url:String {
        return self.article.url ?? ""
    }
    
    func photoUrl() -> String{
        
        guard let media = article.media, media.count > 0 else {
            return ""
        }
        
        if let mediaURL = media[0].mediametadata?[0]{
            return mediaURL.url ?? ""
        }
        return ""
    }
}
