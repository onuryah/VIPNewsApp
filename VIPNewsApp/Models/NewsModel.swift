//
//  NewsModel.swift
//  VIPNewsApp
//
//  Created by admin on 31.10.2022.
//

import Foundation

struct UrlClass {
    let baseUrl = "https://newsapi.org/v2"
    let type = "/top-headlines"
    let country = "?country=us"
    let title = "&q="
    let name = "&source"
    let apiKey = "&apiKey=a71736c911b149e9acf84fdd00a7e98d"
    
    func getNewsUrl() -> String {
        return baseUrl+type+country+apiKey
    }
    //    You can send a request with this url to get large amount of content instead of using Core Data
    func getSelectedFavoriteNewUrl(searchName: String, searchTitle: String) -> String {
        return baseUrl+type+country+title+searchTitle+name+searchName+apiKey
    }
}

struct NewsModel: Codable {
    let status: String
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title : String
    let urlToImage: String?
    let content: String?
}

struct Source: Codable {
    let name: String
}
