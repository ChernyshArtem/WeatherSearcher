//
//  BaseCell.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 26.10.23.
//

import UIKit
import SnapKit

class WeatherForThreeDaysCell: UICollectionViewCell {
    
    static let identifier = "WeatherForThreeDaysCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 55 / 255, green: 126 / 255, blue: 191 / 255, alpha: 100)
        return cv
    }()
    
    var weatherArray: [WeatherTableData] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.layer.cornerRadius = 20
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        collectionView.register(HourCell.self, forCellWithReuseIdentifier: HourCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(weatherArray: [WeatherTableData]) {
        self.weatherArray = weatherArray
        collectionView.reloadData()
    }
}

extension WeatherForThreeDaysCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCell.identifier, for: indexPath) as? HourCell else { return UICollectionViewCell() }
        cell.configure(weatherHour: weatherArray[indexPath.row])
        if indexPath.row == 0 {
            cell.updateHourLabel(text: "Сейчас")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 90)
    }
}
