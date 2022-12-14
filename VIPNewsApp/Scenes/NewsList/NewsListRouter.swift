//
//  NewsListRouter.swift
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

@objc protocol NewsListRoutingLogic
{
    func routeToNewDetails(segue: UIStoryboardSegue?)
    func routeToFavorites(segue: UIStoryboardSegue?)
}

protocol NewsListDataPassing
{
    var dataStore: NewsListDataStore? { get }
}

class NewsListRouter: NSObject, NewsListRoutingLogic, NewsListDataPassing
{
    weak var viewController: NewsListViewController?
    var dataStore: NewsListDataStore?
    
    func routeToNewDetails(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! NewsDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToNewDetails(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var destinationVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToNewDetails(source: dataStore!, destination: &destinationDS)
            navigateToNewDetails(source: viewController!, destination: &destinationVC)
        }
    }
    
    func navigateToNewDetails( source : NewsListViewController, destination: inout NewsDetailsViewController) {
        source.show(destination, sender: nil)
    }
    
    private func passDataToNewDetails(source: NewsListDataStore, destination: inout NewsDetailsDataStore)
    {
        let selected = viewController?.tableView.indexPathForSelectedRow?.row
        destination.news = source.new?[selected!]
    }
    
    func routeToFavorites(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! NewsDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToNewDetails(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
            navigateToFavorites(source: viewController!, destination: destinationVC)
        }
    }
    
    private func navigateToFavorites(source: NewsListViewController, destination: FavoritesViewController)
    {
        source.show(destination, sender: nil)
    }
}
