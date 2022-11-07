//
//  NewsListViewController.swift
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
import RxCocoa
import RxSwift

protocol NewsListDisplayLogic: AnyObject
{
    func displayFetchedNews(viewModel: News.FetchPost.ViewModel)
    func displayFetchedManagedNews(viewModel: News.FetchManagedPost.ViewModel)
}

class NewsListViewController: UIViewController, NewsListDisplayLogic
{
    @IBOutlet weak var tableView: UITableView!
    var interactor: NewsListBusinessLogic?
  var router: (NSObjectProtocol & NewsListRoutingLogic & NewsListDataPassing)?
    private let disposeBag = DisposeBag()
    private var newData : [Article] = [] {
        didSet {
            setupCellConfiguration()
        }
    }
    private lazy var news : Observable<[Article]> = Observable.just(newData)
    private var savedArray = [Article]()

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
    let interactor = NewsListInteractor()
    let presenter = NewsListPresenter()
    let router = NewsListRouter()
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
      getNewsList()
      setupCellTapHandling()
  }
}

extension NewsListViewController {
    func displayFetchedNews(viewModel: News.FetchPost.ViewModel) {
        self.newData = viewModel.post ?? [Article]()
    }
    
    private func getNewsList()
    {
        let request = News.FetchPost.Request()
        interactor?.fetchNews(request: request)
    }
    
    func displayFetchedManagedNews(viewModel: News.FetchManagedPost.ViewModel) {
        savedArray.removeAll(keepingCapacity: false)
        savedArray = viewModel.post ?? []
    }
    
    private func getSavedList() {
        let savedRequest = News.FetchManagedPost.Request()
        interactor?.getFavoritedNews(request: savedRequest)
    }
}

extension NewsListViewController {
    private func setupCellConfiguration() {
        //1
        news
            .bind(to: tableView
                .rx // 2
                .items(cellIdentifier: "newCell", cellType: NewsCell.self)) { row, element, cell in // 3
                    cell.configureWithNew(withNew: element)
                    self.itemsInCell(cell: cell, row: row)
                }
                .disposed(by: disposeBag) // 5
    }
    
    private func setupCellTapHandling() {
        tableView
            .rx // 1
            .modelSelected(Article.self) // 2
            .subscribe(onNext: { [weak self] new in // 3
                self!.router?.routeToNewDetails(segue: nil)
                
                if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow { // 5
                    self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag) // 6    }
    }
}

extension NewsListViewController {
    @objc private func favoritesButtonClicked() {
        self.router?.routeToFavorites(segue: nil)
    }
    
    private func itemsInCell(cell: NewsCell, row: Int){
        cell.likeButton.tag = row
        cell.likeButton.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
        self.getSavedList()
        
        cell.heartImageView.image = UIImage(named: "unliked_img")
        self.savedArray.forEach { saved in
            if saved.title == self.newData[row].title{
                cell.heartImageView.image = UIImage(named: "liked_img")
            }
        }
    }
    
    @objc private func tapped(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! NewsCell
        self.tappedSettings(indexPath: indexPath, cell: cell)
        self.tableView.reloadData()
    }
    
    private func tappedSettings(indexPath : IndexPath, cell: NewsCell){
        let title = self.newData[indexPath.row].title
        let name = self.newData[indexPath.row].source.name
        let content = self.newData[indexPath.row].content
        let urlToImage = self.newData[indexPath.row].urlToImage
        if cell.heartImageView.image == UIImage(named: "unliked_img"){
            saveFavoritedNews(name: name, title: title, urlToImage: urlToImage, content: content)
            sendNewsTitleToFirebase(title: title)
        }else if cell.heartImageView.image == UIImage(named: "liked_img"){
            for i in self.savedArray{
                if title == i.title{
                    if let index = self.savedArray.firstIndex(where: {$0.title == title}) {
                        interactor?.deleteData(name: name, title: title, urlToImage: urlToImage, content: content)
                        self.savedArray.remove(at: index)
                    }
                }
            }
        }
    }
}

extension NewsListViewController {
    private func sendNewsTitleToFirebase(title: String) {
    }
    private func startIndicator() {
    }
    private func saveFavoritedNews(name: String, title: String, urlToImage: String?, content: String?){
        interactor?.save(name: name, title: title, urlToImage: urlToImage, content: content)
    }
}



