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
    
    private let imageView = UIImageView()
    private lazy var textView: UITextView = {
        let textView = UITextView()
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
            textView
        ].forEach {
            view.addSubview($0)
        }
        
        let imageViewInset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(imageViewInset)
        }
    }
    
    @objc func didTapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapAddButton() {
        navigationController?.popViewController(animated: true)
    }
}
