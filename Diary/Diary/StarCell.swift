//
//  StarCell.swift
//  Diary
//
//  Created by 강태준 on 2022/06/18.
//

import UIKit

class StarCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
