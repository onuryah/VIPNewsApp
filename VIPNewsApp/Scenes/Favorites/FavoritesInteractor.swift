//
//  FavoritesInteractor.swift
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

protocol FavoritesBusinessLogic
{
    func fetchFavoritedNews(request: FavoritedNews.FetchManagedPost.Request)
}

protocol FavoritesDataStore
{
    var favoritedNews: [Article]? { get }
}

class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore
{
    var coreDataWorker: NewsFetcher?
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorker?
    var favoritedNews: [Article]?
    //var name: String = ""
    
    // MARK: Do something
    
    func fetchFavoritedNews(request: FavoritedNews.FetchManagedPost.Request)
    {
        coreDataWorker = CoreDataWorker()
        var datas = [Article]()
        coreDataWorker?.retrieveValues(compilation: { data in
            datas = data
        })
        self.favoritedNews = datas
        let response = FavoritedNews.FetchPost.Response(data: datas)
        self.presenter?.presentFavoritedNews(response: response)
    }
}
