//
//  FavoritesRouter.swift
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

@objc protocol FavoritesRoutingLogic
{
    func routeToDetails(segue: UIStoryboardSegue?)
}

protocol FavoritesDataPassing
{
  var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: NSObject, FavoritesRoutingLogic, FavoritesDataPassing
{
  weak var viewController: FavoritesViewController?
  var dataStore: FavoritesDataStore?
  
    func routeToDetails(segue: UIStoryboardSegue?)
    {
      if let segue = segue {
        let destinationVC = segue.destination as! NewsDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToNewDetails(source: dataStore!, destination: &destinationDS)
      } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let destinationVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToNewDetails(source: dataStore!, destination: &destinationDS)
          navigateToDetails(source: viewController!, destination: destinationVC)
      }
    }
    
    private func navigateToDetails(source: FavoritesViewController, destination: NewsDetailsViewController)
  {
    source.show(destination, sender: nil)
  }
  
    private func passDataToNewDetails(source: FavoritesDataStore, destination: inout NewsDetailsDataStore)
  {
      let selected = viewController?.favoritesTableView.indexPathForSelectedRow?.row
      let selectedFavoritedNew = source.favoritedNews![selected!]
      let willPassingData = Article(source: Source(name: selectedFavoritedNew.source.name), title: selectedFavoritedNew.title, urlToImage: selectedFavoritedNew.urlToImage, content: selectedFavoritedNew.content)
      destination.news = willPassingData
  }

}
