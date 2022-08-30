//
//  UploadViewController.swift
//  Instagram
//
//  Created by 강태준 on 2022/08/30.
//

import UIKit
import SnapKit


final class UploadViewController: UIViewController {
    private let image: UIImage
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    private lazy var textField: UITextView = {
        let textView = UITextView()
        textView.text = "문구를 입력하세요"
        textView.delegate = self
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        setupLayout()
    }
    
    init(image: UIImage) {
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel
        else {
            return
        }
        
        textView.text = nil
        textView.textColor = .label
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.textColor = .secondaryLabel
            textView.text = "문구를 입력하세요"
        }
    }
}


private extension UploadViewController {
    func setupNavigation() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "새 게시물"
        
        let cancelButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didTapCancelButton)
        )
        let addButton = UIBarButtonItem(
            title: "공유",
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    func setupLayout() {
        [
            imageView,
            textField
        ].forEach {
            view.addSubview($0)
        }
        
        let imageViewInset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(100)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(imageView)
            $0.bottom.equalTo(imageView)
        }
    }
    
    @objc func didTapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapAddButton() {
        navigationController?.popViewController(animated: true)
    }
}
