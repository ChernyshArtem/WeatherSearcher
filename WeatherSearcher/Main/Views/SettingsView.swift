//
//  SettingsVIew.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 29.10.23.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
//Температура hour -> По цельцию / Фаренгейт
//Температура title -> По цельцию / Фаренгейт
//Ветренность -> Мили / Километры
//Давление -> Милибары / Инчи
//Осадки -> Милиметры / Инчи
//Ощущается как -> По цельцию / Фаренгейт
//Видимость -> Мили / Километры
//Порывы ->  Мили / Километры

// (По цельцию) / Фаренгейт
// Мили / (Километры)
// (Милибары) / Инчи
// (Милиметры) / Инчи
//При заходе если nil тогда заполняем UD() иначе выводим на главном меню с настройками из UD, при заходе сюда заполняем данные из UD, при изменении отображаем сначала тут а потом переносим в UD
class SettingsView: UIViewController {
    
    let celsiumLabel: UILabel = {
        let celsiumLabel = UILabel()
        celsiumLabel.text = "°C"
        celsiumLabel.font = UIFont.systemFont(ofSize: 40)
        celsiumLabel.textAlignment = .center
        celsiumLabel.textColor = .white
        return celsiumLabel
    }()
    let kilometerLabel: UILabel = {
        let kilometerLabel = UILabel()
        kilometerLabel.text = "km"
        kilometerLabel.font = UIFont.systemFont(ofSize: 40)
        kilometerLabel.textAlignment = .center
        kilometerLabel.textColor = .white
        return kilometerLabel
    }()
    let millibarsLabel: UILabel = {
        let millibarsLabel = UILabel()
        millibarsLabel.text = "mb"
        millibarsLabel.font = UIFont.systemFont(ofSize: 40)
        millibarsLabel.textAlignment = .center
        millibarsLabel.textColor = .white
        return millibarsLabel
    }()
    let millimeteresLabel: UILabel = {
        let millimeteresLabel = UILabel()
        millimeteresLabel.text = "mm"
        millimeteresLabel.font = UIFont.systemFont(ofSize: 40)
        millimeteresLabel.textAlignment = .center
        millimeteresLabel.textColor = .white
        return millimeteresLabel
    }()
    
    let tempSwitch = UISwitch()
    let lengthSwitch = UISwitch()
    let pressureSwitch = UISwitch()
    let precipitationSwitch = UISwitch()
    
    let fahrenheitLabel: UILabel = {
        let fahrenheitLabel = UILabel()
        fahrenheitLabel.text = "°F"
        fahrenheitLabel.font = UIFont.systemFont(ofSize: 40)
        fahrenheitLabel.textAlignment = .center
        fahrenheitLabel.textColor = .white
        return fahrenheitLabel
    }()
    let milesLabel: UILabel = {
        let milesLabel = UILabel()
        milesLabel.text = "mp"
        milesLabel.font = UIFont.systemFont(ofSize: 40)
        milesLabel.textAlignment = .center
        milesLabel.textColor = .white
        return milesLabel
    }()
    let firstInchesLabel: UILabel = {
        let firstInchesLabel = UILabel()
        firstInchesLabel.text = "in"
        firstInchesLabel.font = UIFont.systemFont(ofSize: 40)
        firstInchesLabel.textAlignment = .center
        firstInchesLabel.textColor = .white
        return firstInchesLabel
    }()
    let secondInchesLabel: UILabel = {
        let secondInchesLabel = UILabel()
        secondInchesLabel.text = "in"
        secondInchesLabel.font = UIFont.systemFont(ofSize: 40)
        secondInchesLabel.textAlignment = .center
        secondInchesLabel.textColor = .white
        return secondInchesLabel
    }()
    
    let bag = DisposeBag()
    lazy var mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 83 / 255, green: 139 / 255, blue: 196 / 255, alpha: 1.0)
        setupSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.collectionView.reloadData()
        mainView.viewModel.refreshModelData()
    }
    
    func setupSubviews() {
        view.addSubview(celsiumLabel)
        view.addSubview(kilometerLabel)
        view.addSubview(millibarsLabel)
        view.addSubview(millimeteresLabel)
        view.addSubview(fahrenheitLabel)
        view.addSubview(milesLabel)
        view.addSubview(firstInchesLabel)
        view.addSubview(secondInchesLabel)
        view.addSubview(tempSwitch)
        view.addSubview(lengthSwitch)
        view.addSubview(pressureSwitch)
        view.addSubview(precipitationSwitch)
        setupLeftPartOfSettings()
        setupRightPartOfSettings()
        setupCenterPartOfSettings()
        setupUserDefaultsData()
        setupBinds()
    }
    
    func setupLeftPartOfSettings() {
        celsiumLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
        kilometerLabel.snp.makeConstraints { make in
            make.top.equalTo(celsiumLabel.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
        millibarsLabel.snp.makeConstraints { make in
            make.top.equalTo(kilometerLabel.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
        millimeteresLabel.snp.makeConstraints { make in
            make.top.equalTo(millibarsLabel.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
    }
    
    func setupRightPartOfSettings() {
        fahrenheitLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
        milesLabel.snp.makeConstraints { make in
            make.top.equalTo(fahrenheitLabel.snp.bottom).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
        firstInchesLabel.snp.makeConstraints { make in
            make.top.equalTo(milesLabel.snp.bottom).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
        secondInchesLabel.snp.makeConstraints { make in
            make.top.equalTo(firstInchesLabel.snp.bottom).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width / 3)
        }
    }
    
    func setupCenterPartOfSettings() {
        tempSwitch.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(celsiumLabel.snp.centerY)
        }
        lengthSwitch.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(kilometerLabel.snp.centerY)
        }
        pressureSwitch.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)     
            make.centerY.equalTo(millibarsLabel.snp.centerY)
        }
        precipitationSwitch.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(millimeteresLabel.snp.centerY)
        }
    }
    
    func setupUserDefaultsData() {
        let temperature   = UserDefaults.standard.string(forKey: "temperature")
        let length        = UserDefaults.standard.string(forKey: "length")
        let pressure      = UserDefaults.standard.string(forKey: "pressure")
        let precipitation = UserDefaults.standard.string(forKey: "precipitation")
         
        if temperature != "°C" {
            tempSwitch.setOn(true, animated: false)
        }
        if length != "km" {
            lengthSwitch.setOn(true, animated: false)
        }
        if pressure != "mb" {
            pressureSwitch.setOn(true, animated: false)
        }
        if precipitation != "mm" {
            precipitationSwitch.setOn(true, animated: false)
        }
    }
    
    func setupBinds() {
        bindElement(element: tempSwitch, falseValue: "°C", trueValue: "°F", userDefaultsName: "temperature")
        bindElement(element: lengthSwitch, falseValue: "km", trueValue: "mp", userDefaultsName: "length")
        bindElement(element: pressureSwitch, falseValue: "mb", trueValue: "in", userDefaultsName: "pressure")
        bindElement(element: precipitationSwitch, falseValue: "mm", trueValue: "in", userDefaultsName: "precipitation")
    }
    
    func bindElement(element: UISwitch, falseValue: String, trueValue: String, userDefaultsName: String) {
        element.rx.isOn.bind { model in
            var resultValue = ""
            if model == false {
                resultValue = falseValue
            } else {
                resultValue = trueValue
            }
            UserDefaults.standard.setValue(resultValue, forKey: userDefaultsName)
        }.disposed(by: bag)
    }
}
