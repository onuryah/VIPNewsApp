//
//  NewsCell.swift
//  VIPNewsApp
//
//  Created by admin on 7.11.2022.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsLabelField: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var heartImageView: UIImageView!
    
    func configureWithNew(withNew: Article) {
        newsLabelField.text = withNew.title
        guard let imageUrl = withNew.urlToImage else {return}
        guard let urlString = URL(string: imageUrl) else {return}
        newsImageView.sd_setImage(with: urlString)
    }
}
