//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 강태준 on 2022/06/18.
//

import UIKit

class DiaryDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    var diary: Diary?
    var indexPath: IndexPath?
    var starButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentTextView.text = diary.content
        self.dateLabel.text = self.dateToString(date: diary.date)
        self.starButton = UIBarButtonItem(image: nil, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
    }
  
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        return formatter.string(from: date)
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        viewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {return}
        NotificationCenter.default.post(
            name: NSNotification.Name("deleteDiary"),
            object: indexPath
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else {return}
        self.diary = diary
        self.configureView()
    }
    
    @objc func tapStarButton() {
        guard let isStar = self.diary?.isStar else {return}
        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        guard let indexPath = self.indexPath else {return}
        NotificationCenter.default.post(
            name: NSNotification.Name("starDiary"),
            object: [
                "diary": self.diary,
                "isStar": self.diary?.isStar ?? false,
                "indexPath": indexPath
            ]
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
