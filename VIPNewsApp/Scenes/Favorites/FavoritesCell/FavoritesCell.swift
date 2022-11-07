//
//  FavoritesCell.swift
//  VIPNewsApp
//
//  Created by admin on 7.11.2022.
//

import UIKit

class FavoritesCell: UITableViewCell {
    @IBOutlet weak var favoritedNewsImageView: UIImageView!
    @IBOutlet weak var favoritedNewsLabelField: UILabel!
    
    func configureWithNew(withNew: Article) {
        favoritedNewsLabelField.text = withNew.title
        guard let urlString = URL(string: withNew.urlToImage!) else {return}
        favoritedNewsImageView.sd_setImage(with: urlString)
    }
}
