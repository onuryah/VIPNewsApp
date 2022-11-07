//
//  LabelTopAlignmentHelper.swift
//  NewsApp
//
//  Created by admin on 7.11.2022.
//

import Foundation
import UIKit

class TopAlignedLabel: UILabel {
  override func drawText(in rect: CGRect) {
    let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
    super.drawText(in: textRect)
  }
}
