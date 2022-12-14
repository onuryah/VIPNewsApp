//
//  NewsDetailsViewController.swift
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

protocol NewsDetailsDisplayLogic: class
{
    func displayUI(viewModel: NewsDetails.FetchPost.ViewModel)
}

class NewsDetailsViewController: UIViewController, NewsDetailsDisplayLogic
{
    @IBOutlet weak var nameLabelField: UILabel!
    @IBOutlet weak var newsImageImageView: UIImageView!
    @IBOutlet weak var newDescriptionLabelField: UILabel!
    
    var interactor: NewsDetailsBusinessLogic?
    var router: (NSObjectProtocol & NewsDetailsRoutingLogic & NewsDetailsDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = NewsDetailsInteractor()
        let presenter = NewsDetailsPresenter()
        let router = NewsDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getNews()
    }
}


extension NewsDetailsViewController {
    private func getNews()
    {
        interactor?.getNews()
    }
    
    func displayUI(viewModel: NewsDetails.FetchPost.ViewModel)
    {
        nameLabelField.text = viewModel.post.title
        newDescriptionLabelField.text = viewModel.post.content
        guard let imageString = viewModel.post.urlToImage else {return}
        newsImageImageView.sd_setImage(with: URL(string: imageString))
    }
}
