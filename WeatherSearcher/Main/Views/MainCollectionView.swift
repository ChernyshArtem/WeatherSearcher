//
//  MainCollectionView.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 29.10.23.
//

import UIKit

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if viewModel.model.arrayOfTableData.value.count > 0 {
                return 1
            } else {
                return 0
            }
        case 2:
            return 8
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(indexPath.section) {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.identifier, for: indexPath) as? TitleCell else { return UICollectionViewCell() }
            cell.congigure(viewModel: viewModel)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForThreeDaysCell.identifier, for: indexPath) as? WeatherForThreeDaysCell else { return UICollectionViewCell() }
            cell.configure(weatherArray: viewModel.model.arrayOfTableData.value)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParameterCell.identifier, for: indexPath) as? ParameterCell else { return UICollectionViewCell() }
            let a: Parameters = Parameters(rawValue: indexPath.row) ?? .wind
            
            let temperature   = UserDefaults.standard.string(forKey: "temperature")
            let length        = UserDefaults.standard.string(forKey: "length")
            let pressure      = UserDefaults.standard.string(forKey: "pressure")
            let precipitation = UserDefaults.standard.string(forKey: "precipitation")
            
            switch a {
            case .wind:
                viewModel.model.wind.bind { model in
                    cell.infoLabel.text = "\(model)" + (length ?? "") + "\\h"
                }.disposed(by: bag)
                cell.nameLabel.text = "Ветренность"
            case .pressure:
                viewModel.model.pressure.bind { model in
                    cell.infoLabel.text = "\(model)" + (pressure ?? "")
                }.disposed(by: bag)
                cell.nameLabel.text = "Давление"
            case .precipitation:
                viewModel.model.precipitation.bind { model in
                    cell.infoLabel.text = "\(model)" + (precipitation ?? "")
                }.disposed(by: bag)
                cell.nameLabel.text = "Осадки"
            case .humidity:
                viewModel.model.humidity.bind { model in
                    cell.infoLabel.text = "\(model)%"
                }.disposed(by: bag)
                cell.nameLabel.text = "Влажность"
            case .cloud:
                viewModel.model.cloud.bind { model in
                    cell.infoLabel.text = "\(model)%"
                }.disposed(by: bag)
                cell.nameLabel.text = "Облачность"
            case .feelsLike:
                viewModel.model.feelsLike.bind { model in
                    cell.infoLabel.text = "\(model)" + (temperature ?? "")
                }.disposed(by: bag)
                cell.nameLabel.text = "Ощущается как"
            case .visible:
                viewModel.model.visible.bind { model in
                    cell.infoLabel.text = "\(model)" + (length ?? "")
                }.disposed(by: bag)
                cell.nameLabel.text = "Видимость"
            case .gust:
                viewModel.model.gust.bind { model in
                    cell.infoLabel.text = "\(model)" + (length ?? "") + "\\h"
                }.disposed(by: bag)
                cell.nameLabel.text = "Порывы"
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch(indexPath.section) {
        case 0:
            return CGSize(width: view.frame.width, height: 213)
        case 1:
            return CGSize(width: view.frame.width - 16, height: 100)
        case 2:
            let length = (view.frame.width / 2) - 16
            return CGSize(width: length, height: length)
        default:
            return CGSize()
        }
    }
}
