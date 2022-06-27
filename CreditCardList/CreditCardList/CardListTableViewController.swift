//
//  CardListTableViewController.swift
//  CreditCardList
//
//  Created by 강태준 on 2022/06/25.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore
import CoreAudio

class CardListTableViewController: UITableViewController {
    var creditCardList: [CreditCard] = []
//    var ref: DatabaseReference! // Firebase realtime database reference
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableView Table Register
        let nibName = UINib(nibName: "CardListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListTableViewCell")
        
        // Firestore 읽기
        db.collection("creditCardList").addSnapshotListener({ snapshot, error in
            guard let documents = snapshot?.documents else {
                print("ERROR FireStore fetching document \(String(describing: error))")
                return
            }
            self.creditCardList = documents.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data())
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch {
                    print("ERROR: \(error.localizedDescription)")
                    return nil
                }
            }.sorted {
                $0.rank < $1.rank
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        // 실시간 데이터베이스 읽기
//        self.ref = Database.database().reference()
//        self.ref.observe(.value, with: {snapShot in
//            guard let value = snapShot.value as? [String: [String: Any]] else {return}
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String:CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//
//                self.creditCardList = cardList.sorted(by: {
//                    $0.rank < $1.rank
//                })
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch let error {
//                print("ERROR: JSON Parsing - \(error.localizedDescription)")
//            }
//        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListTableViewCell", for: indexPath) as? CardListTableViewCell else {return UITableViewCell()}
        
        cell.rankTextLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionTextLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameTextLabel.text = creditCardList[indexPath.row].name
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardId = creditCardList[indexPath.row].id
        
        // Firestore 실시간 데이터 쓰기
        // Option 1
        // db.collection("creditCardList").document("card\(cardId)").updateData(["isSelected":true])
        
        // Option 2
        db.collection("creditCardList").whereField("id", isEqualTo: cardId).getDocuments(completion: { snapshot, error in
            guard let document = snapshot?.documents.first else {
                print("ERROR: Firestore fetching document")
                return
            }
            document.reference.updateData(["isSelected": true])
        })
        
        // 실시간 데이터베이스 쓰기
        // Option
        // ref.child("Item\(cardId)/isSelected").setValue(true)
    
        // Option 2
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value) { [weak self] snapshot in
//            guard let self = self, let value = snapshot.value as? [String: [String: Any]], let key = value.keys.first else {return}
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
        
        // 상세 화면 전달
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else {return}
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        show(detailViewController, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Firestore
            // Option 1
            let cardId = creditCardList[indexPath.row].id
            // db.collection("creditCardList").document("card\(cardId)").delete()
            
            // Option 2
            db.collection("creditCardList").whereField("id", isEqualTo: cardId).getDocuments(completion: { snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    print("ERROR")
                    return
                }
                document.reference.delete()
            })
            
            // 실시간 데이터베이스
            // Option 1
//            let cardId = creditCardList[indexPath.row].id
//            ref.child("Item\(cardId)").removeValue()
//
            // Option 2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value) { [weak self] snapshot in
//                guard let self = self, let value = snapshot.value as? [String:[String:Any]], let key = value.keys.first else {return}
//                ref.child(key).removeValue()
//            }
        }
    }
    
}
