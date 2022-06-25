//
//  CardListTableViewCell.swift
//  CreditCardList
//
//  Created by 강태준 on 2022/06/25.
//

import UIKit

class CardListTableViewCell: UITableViewCell {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var rankTextLabel: UILabel!
    @IBOutlet weak var promotionTextLabel: UILabel!
    @IBOutlet weak var cardNameTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
