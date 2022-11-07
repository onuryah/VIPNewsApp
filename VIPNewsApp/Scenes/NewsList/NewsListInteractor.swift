//
//  NewsListInteractor.swift
//  VIPNewsApp
//
//  Created by admin on 7.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsListBusinessLogic
{
    func fetchNews(request: News.FetchPost.Request)
    func getFavoritedNews(request: News.FetchManagedPost.Request)
    func deleteData(name: String, title: String, urlToImage: String?, content: String?)
    func save(name: String, title: String, urlToImage: String?, content: String?)
}

protocol NewsListDataStore
{
    var new: [Article]? { get }
    var savedNews: [Article]? {get}
}

class NewsListInteractor: NewsListBusinessLogic, NewsListDataStore
{
    private var coreDataAdjusterWoker: NewsAdjuster?
    private var coreDataFetcherWorker: NewsFetcher?
    internal var new: [Article]?
    var presenter: NewsListPresentationLogic?
    var worker: NewsListWorker?
    internal var savedNews: [Article]?
  
    func fetchNews(request: News.FetchPost.Request)
  {
    worker = NewsListWorker()
      worker?.fetchNews(completionHandler: { [weak self] (data, error) in
          self?.new = data
          let response = News.FetchPost.Response(errorMessage: error?.localizedDescription, data: data)
          self?.presenter?.presentFetchedNews(response: response)
      })
  }
    
    func getFavoritedNews(request: News.FetchManagedPost.Request) {
        coreDataFetcherWorker = CoreDataWorker()
        
        coreDataFetcherWorker?.retrieveValues(compilation: { data in
            self.savedNews = data
            let response = News.FetchManagedPost.Response(data: data)
            self.presenter?.presentFetchedManagedNews(response: response)
            
        })
    }
    
    func deleteData(name: String, title: String, urlToImage: String?, content: String?) {
        coreDataAdjusterWoker = CoreDataWorker()
        coreDataAdjusterWoker?.deleteData(name: name, title: title, urlToImage: urlToImage, content: content)
    }
    
    func save(name: String, title: String, urlToImage: String?, content: String?) {
        coreDataAdjusterWoker = CoreDataWorker()
        coreDataAdjusterWoker?.save(name: name, title: title, urlToImage: urlToImage, content: content)
    }
}
