//
//  NewsListPresenter.swift
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

protocol NewsListPresentationLogic
{
    func presentFetchedNews(response: News.FetchPost.Response)
    func presentFetchedManagedNews(response: News.FetchManagedPost.Response)
}

class NewsListPresenter: NewsListPresentationLogic
{
    weak var viewController: NewsListDisplayLogic?
    
    func presentFetchedNews(response: News.FetchPost.Response)
    {
        let viewModel = News.FetchPost.ViewModel(post: response.data, errorMessage: response.errorMessage)
        viewController?.displayFetchedNews(viewModel: viewModel)
    }
    
    func presentFetchedManagedNews(response: News.FetchManagedPost.Response) {
        let savedData = response.data
        let viewModel = News.FetchManagedPost.ViewModel(post: savedData)
        self.viewController?.displayFetchedManagedNews(viewModel: viewModel)
    }
}
