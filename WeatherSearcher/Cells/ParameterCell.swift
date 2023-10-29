//
//  ParameterCell.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 28.10.23.
//

import UIKit
import SnapKit

class ParameterCell: UICollectionViewCell {
    static let identifier = "ParameterCell"
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return nameLabel
    }()
    let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.textColor = .white
        infoLabel.font = UIFont.systemFont(ofSize: 35, weight: .light)
        return infoLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 55 / 255, green: 126 / 255, blue: 191 / 255, alpha: 100)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(16)
        }
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
