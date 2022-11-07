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
  func doSomething(request: Favorites.Something.Request)
}

protocol FavoritesDataStore
{
  //var name: String { get set }
}

class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore
{
  var presenter: FavoritesPresentationLogic?
  var worker: FavoritesWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Favorites.Something.Request)
  {
    worker = FavoritesWorker()
    worker?.doSomeWork()
    
    let response = Favorites.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
