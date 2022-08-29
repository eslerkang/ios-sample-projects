//
//  StationInfoViewController.swift
//  SubwayStation
//
//  Created by 강태준 on 2022/08/29.
//

import UIKit
import SnapKit
import Alamofire


final class StationInfoViewController: UIViewController {
    private let station: Station
    private var realTimeArrivalList = [RealTimeArrival]()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.register(StationInfoCollectionViewCell.self, forCellWithReuseIdentifier: "stationInfoCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupLayout()
        fetchData()
    }
    
    init(station: Station) {
        self.station = station
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension StationInfoViewController {
    @objc func fetchData() {
        let stationName = station.stationName == "서울역" ? "서울" : station.stationName
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
        
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalResponseModel.self) { response in
                self.refreshControl.endRefreshing()

                guard case let .success(data) = response.result
                else {
                    debugPrint(response)
                    return
                }
                
                self.realTimeArrivalList = data.realtimeArrivalList
                self.collectionView.reloadData()
            }
    }
    
    func setupNavigation() {
        navigationItem.title = station.stationName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        [
            collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension StationInfoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realTimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stationInfoCell", for: indexPath) as? StationInfoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setup(realTimeArrival: realTimeArrivalList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: 100)
    }
}
