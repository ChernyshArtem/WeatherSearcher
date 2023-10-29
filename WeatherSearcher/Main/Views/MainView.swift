//
//  ViewController.swift
//  WeatherSearcher
//
//  Created by Артём Черныш on 25.10.23.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MainView: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.headerReferenceSize = CGSize(width: 100, height: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let settingsButton: UIButton = {
        let settingsButton = UIButton(type: .system)
        let image = UIImage(systemName: "gearshape")
        settingsButton.tintColor = .white
        settingsButton.setBackgroundImage(image, for: .normal)
        return settingsButton
    }()
    
    let searchField: UITextField = {
        let searchField = UITextField()
        searchField.placeholder = "City name"
        searchField.textColor = .white
        searchField.layer.cornerRadius = 5
        searchField.font = UIFont.systemFont(ofSize: 30)
        searchField.backgroundColor = UIColor(red: 55 / 255, green: 126 / 255, blue: 191 / 255, alpha: 100)
        return searchField
    }()
    
    let bag = DisposeBag()
    
    let viewModel: MainViewModelInterface = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let firstColor = UIColor(red: 83 / 255, green: 139 / 255, blue: 196 / 255, alpha: 1.0)
        view.backgroundColor = firstColor
        view.addSubview(collectionView)
        view.addSubview(settingsButton)
        view.addSubview(searchField)
        setupSubviews()
        
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap)
        
        
    }
    
    
    private func setupSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.height.equalTo(35)
        }
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(settingsButton.snp.left).inset(-10)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        collectionView.backgroundColor = UIColor(red: 83 / 255, green: 139 / 255, blue: 196 / 255, alpha: 1.0)
        collectionView.register(WeatherForThreeDaysCell.self, forCellWithReuseIdentifier: WeatherForThreeDaysCell.identifier)
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.identifier)
        collectionView.register(ParameterCell.self, forCellWithReuseIdentifier: ParameterCell.identifier)
        setupBindings()
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.model.arrayOfTableData.bind { [weak self] model in
            self?.collectionView.reloadData()
        }.disposed(by: bag)
        searchField.rx.text.bind { [weak self] model in
            self?.viewModel.model.cityForSearch.accept(model ?? "Minsk")
            self?.viewModel.refreshModelData()
        }.disposed(by: bag)
    }
    
    @objc func openSettings() {
        let vc = SettingsView()
        vc.mainView = self
        self.present(vc, animated: true)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
