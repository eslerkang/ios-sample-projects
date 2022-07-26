//
//  ViewController.swift
//  NoticeFirebase
//
//  Created by 강태준 on 2022/07/21.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {

    var remoteConfig: RemoteConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRemoteConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNotice()
    }
    
    private func configureRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0 // 최대한 자주 원격 구성 값 가져오기
        remoteConfig?.configSettings = setting
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }


}


extension ViewController {
    func getNotice() {
        guard let remoteConfig = remoteConfig else {return}
        
        remoteConfig.fetch { [weak self] status, error in
            if error != nil {
                print("ERROR: \(String(describing: error?.localizedDescription))")
            }
            if status == .success {
                remoteConfig.activate()
            } else {
                print("ERROR: Config not fetched")
            }
            
            guard let self = self else {return}
            
            if !self.isNoticeHidden(remoteConfig) {
                let noticeViewController = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                
                noticeViewController.modalPresentationStyle = .custom
                noticeViewController.modalTransitionStyle = .crossDissolve
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                noticeViewController.noticeContents = (title: title, detail: detail, date: date)
                self.present(noticeViewController, animated: true)
            } else {
                self.showEventAlert()
            }
        }
    }
    
    func isNoticeHidden(_ remoteConfig: RemoteConfig) -> Bool {
        return remoteConfig["isHidden"].boolValue
    }
}


extension ViewController {
    func showEventAlert() {
        guard let remoteConfig = remoteConfig else {return}
        remoteConfig.fetch { [weak self] status, error in
            if status == .success {
                remoteConfig.activate()
            } else {
                print("ERROR: Config not fetched")
            }
            
            let message = remoteConfig["message"].stringValue ?? ""
            
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) { _ in
                // Google analytics
                Analytics.logEvent("promotion_alert", parameters: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self?.present(alertController, animated: true)
        }
    }
}
