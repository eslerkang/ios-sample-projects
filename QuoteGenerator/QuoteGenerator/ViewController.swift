//
//  ViewController.swift
//  QuoteGenerator
//
//  Created by 강태준 on 2022/06/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let quotes = [
        Quote(content: "질병은 입을 쫓아 들어가고 화근은 입을 좇아 나온다.", name: "태평어람"),
        Quote(content: "탐욕은 일체를 얻고자 욕심내어서 도리어 모든 것을 잃어버린다.", name: "몽테뉴"),
        Quote(content: "100권의 책에 쓰인 말보다, 한 가지 성실한 마음이 크게 사람을 움직인다.", name: "프랭크린"),
        Quote(content: "힘으로 사람을 복종시키려 말고 덕으로써 사람을 복종시켜라.", name: "맹자"),
        Quote(content: "타인에 대한 존경은 처세법의 제일 조건이다.", name: "아미엘"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapQuoteGeneratorButton(_ sender: UIButton) {
        let randomInt = Int(arc4random_uniform(5))
        let quote = quotes[randomInt]
        self.nameLabel.text = quote.name
        self.quoteLabel.text = quote.content
    }
    
}

