//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by 강태준 on 2022/06/25.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    var promotionDetail: PromotionDetail?
    
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLottieAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let promotionDetail = promotionDetail else {
            return
        }
        
        titleLabel.text = """
        \(promotionDetail.companyName)카드 쓰면
        \(promotionDetail.amount)만원 드려요
        """
        periodLabel.text = promotionDetail.period
        conditionLabel.text = promotionDetail.condition
        benefitConditionLabel.text = promotionDetail.benefitCondition
        benefitLabel.text = promotionDetail.benefitDetail
        benefitDateLabel.text = promotionDetail.benefitDate
    }
    
    private func configureLottieAnimation() {
        let animationView = AnimationView(name: "money")
        lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.frame = lottieView.bounds
        animationView.play()
    }
}
