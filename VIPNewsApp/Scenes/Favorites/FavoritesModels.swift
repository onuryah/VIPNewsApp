//
//  FavoritesModels.swift
//  NewsApp
//
//  Created by admin on 29.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

struct FavoritedNews
{
    struct FetchPost
    {
        struct Request
        {
        }
        struct Response
        {
            var data:[Article]?
        }
        struct ViewModel
        {
            var post:[Article]?
        }
    }
    
    struct FetchManagedPost
    {
        struct Request
        {
        }
        struct Response
        {
            var data:[Article]?
        }
        struct ViewModel
        {
            var post:[Article]?
        }
    }
}
