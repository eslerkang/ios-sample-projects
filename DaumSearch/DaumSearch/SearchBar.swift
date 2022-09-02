//
//  SearchBar.swift
//  DaumSearch
//
//  Created by 강태준 on 2022/09/02.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import SwiftUI


final class SearchBar: UISearchBar {
    private let disposeBag = DisposeBag()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        return button
    }()
    
    private let tapSearchButton = PublishRelay<Void>()
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBind()
        setupLayout()
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}


private extension SearchBar {
    func setupBind() {
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                self.searchButton.rx.tap.asObservable()
            )
            .bind(to: tapSearchButton)
            .disposed(by: disposeBag)
        
        tapSearchButton
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        shouldLoadResult = tapSearchButton
            .withLatestFrom(self.rx.text) {
                $1 ?? ""
            }
            .filter {
                !$0.isEmpty
            }
            .distinctUntilChanged()
    }
    
    func setupAttribute() {
        
    }
    
    func setupLayout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
