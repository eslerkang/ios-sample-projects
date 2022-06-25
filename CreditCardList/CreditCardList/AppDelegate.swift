//
//  AppDelegate.swift
//  CreditCardList
//
//  Created by 강태준 on 2022/06/25.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        let db = Firestore.firestore()
        
        db.collection("creditCardList").getDocuments(completion: { snapshot, _ in
            guard snapshot?.isEmpty == true else {return}
            let batch = db.batch()
            
            let card0Ref = db.collection("creditCardList").document("card0")
            let card1Ref = db.collection("creditCardList").document("card1")
            let card2Ref = db.collection("creditCardList").document("card2")
            let card3Ref = db.collection("creditCardList").document("card3")
            let card4Ref = db.collection("creditCardList").document("card4")
            let card5Ref = db.collection("creditCardList").document("card5")
            let card6Ref = db.collection("creditCardList").document("card6")
            let card7Ref = db.collection("creditCardList").document("card7")
            let card8Ref = db.collection("creditCardList").document("card8")
            let card9Ref = db.collection("creditCardList").document("card9")
            
            do {
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card0)) as! [String:Any], forDocument: card0Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card1)) as! [String:Any], forDocument: card1Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card2)) as! [String:Any], forDocument: card2Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card3)) as! [String:Any], forDocument: card3Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card4)) as! [String:Any], forDocument: card4Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card5)) as! [String:Any], forDocument: card5Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card6)) as! [String:Any], forDocument: card6Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card7)) as! [String:Any], forDocument: card7Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card8)) as! [String:Any], forDocument: card8Ref)
                try batch.setData(JSONSerialization.jsonObject(with: JSONEncoder().encode(CreditCardDummy.card9)) as! [String:Any], forDocument: card9Ref)
                
                batch.commit()
            } catch {
                print("ERROR: \(error)")
            }
        })
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

