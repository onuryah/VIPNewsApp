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
  func presentSomething(response: NewsList.Something.Response)
}

class NewsListPresenter: NewsListPresentationLogic
{
  weak var viewController: NewsListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: NewsList.Something.Response)
  {
    let viewModel = NewsList.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}