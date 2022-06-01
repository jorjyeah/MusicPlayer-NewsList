//
//  NewsViewModel.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 31/05/22.
//

import Foundation

class NewsViewModel {
    var articles: [Articles] = []
    var articlesResult: NewsModel?
    
    private var apiCall: APICall = APICall()
    var newsModel: NewsModel!
    
    func fetchData(_ :@escaping ([Articles]) -> Void){
        self.apiCall.getNews { data, response, error in
            self.articlesResult = data
            if let data = data {
                self.articlesResult = data
                if let articles = data.articles{
                    self.articles = articles
                }
            }
        }
    }
}
