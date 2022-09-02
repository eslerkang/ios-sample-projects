//
//  ViewController.swift
//  DaumSearch
//
//  Created by 강태준 on 2022/09/02.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    let searchBar = SearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        setupAttribute()
        setupLayout()
    }
}


private extension MainViewController {
    func setupBind() {
        searchBar.shouldLoadResult.subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    }
    
    func setupAttribute() {
        navigationItem.title = "다음 블로그 검색"
    }
    
    func setupLayout() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
