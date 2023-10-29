//
//  TitleCell.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 27.10.23.
//

import UIKit
import RxSwift
import RxCocoa

class TitleCell: UICollectionViewCell {
    
    static let identifier = "TitleCell"
    
    var temperature = UserDefaults.standard.string(forKey: "temperature")
    
    private var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.textColor = .white
        cityLabel.font = UIFont.systemFont(ofSize: 30)
        return cityLabel
    }()
    private var degreesLabel: UILabel = {
        let degreesLabel = UILabel()
        degreesLabel.textColor = .white
        degreesLabel.font = UIFont.systemFont(ofSize: 55)
        return degreesLabel
    }()
    private var weatherTitleLabel: UILabel = {
        let weatherTitleLabel = UILabel()
        weatherTitleLabel.textColor = .white
        weatherTitleLabel.font = UIFont.systemFont(ofSize: 25)
        return weatherTitleLabel
    }()
    private var diapasoneMinLabel: UILabel = {
        let diapasoneMinLabel = UILabel()
        diapasoneMinLabel.textColor = .white
        diapasoneMinLabel.font = UIFont.systemFont(ofSize: 25)
        return diapasoneMinLabel
    }()
    private var diapasoneMaxLabel: UILabel = {
        let diapasoneMaxLabel = UILabel()
        diapasoneMaxLabel.textColor = .white
        diapasoneMaxLabel.font = UIFont.systemFont(ofSize: 25)
        return diapasoneMaxLabel
    }()
    
    let bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cityLabel)
        contentView.addSubview(degreesLabel)
        contentView.addSubview(weatherTitleLabel)
        contentView.addSubview(diapasoneMinLabel)
        contentView.addSubview(diapasoneMaxLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(16)
        }
        degreesLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(cityLabel.snp.bottom).offset(8)
        }
        weatherTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(degreesLabel.snp.bottom).offset(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congigure(viewModel: MainViewModelInterface) {
        diapasoneMinLabel.textAlignment = .center
        diapasoneMinLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView)
            make.width.equalTo((contentView.frame.width / 2 ) - 8)
            make.top.equalTo(weatherTitleLabel.snp.bottom).offset(8)
        }
        diapasoneMaxLabel.textAlignment = .center
        diapasoneMaxLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.width.equalTo((contentView.frame.width / 2 ) - 8)
            make.top.equalTo(weatherTitleLabel.snp.bottom).offset(8)
        }
        
        reloadUserDefaultsData()
        
        setupBinds(viewModel: viewModel)
    }
    
    func reloadUserDefaultsData() {
        temperature   = UserDefaults.standard.string(forKey: "temperature")
    }
    
    func setupBinds(viewModel: MainViewModelInterface) {
        viewModel.model.city.bind { [weak self] model in
            self?.cityLabel.text = model
        }.disposed(by: bag)
        viewModel.model.degrees.bind { [weak self] model in
            self?.degreesLabel.text = "\(model)" + (self?.temperature ?? "")
        }.disposed(by: bag)
        viewModel.model.weatherTitleName.bind { [weak self] model in
            self?.weatherTitleLabel.text = model
        }.disposed(by: bag)
        viewModel.model.diapasoneMin.bind { [weak self] model in
            self?.diapasoneMinLabel.text = " Мин.: \(model)" + (self?.temperature ?? "")
        }.disposed(by: bag)
        viewModel.model.diapasoneMax.bind { [weak self] model in
            self?.diapasoneMaxLabel.text = "Макс.: \(model)" + (self?.temperature ?? "")
        }.disposed(by: bag)
    }
    
}
