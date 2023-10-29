//
//  HourCell.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 27.10.23.
//

import UIKit
import SnapKit

class HourCell: UICollectionViewCell {
    static let identifier = "HourCell"
    
    var temperature = UserDefaults.standard.string(forKey: "temperature")
    
    private var imageView = UIImageView()
    private var degreeseLabel: UILabel = {
        let degreeseLabel = UILabel()
        degreeseLabel.textColor = .white
        return degreeseLabel
    }()
    private var hourLabel: UILabel = {
        let hourLabel = UILabel()
        hourLabel.textColor = .white
        return hourLabel
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(hourLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(degreeseLabel)
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel).offset(16)
            make.centerX.equalTo(contentView)
            make.height.width.equalTo(50)
        }
        degreeseLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(weatherHour: WeatherTableData) {
        guard let url = URL.init(string: "https:" + weatherHour.imageURL) else {
            print("URL_ERROR")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
        temperature   = UserDefaults.standard.string(forKey: "temperature")
        hourLabel.text = "\(weatherHour.hour)"
        degreeseLabel.text = "\(weatherHour.temperature)" + (self.temperature ?? "")
    }
    
    func updateHourLabel(text: String) {
        hourLabel.text = text
    }
}
