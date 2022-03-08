//
//  CityInformationView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 07.03.2022.
//

import UIKit

class CityInformationView: UIView {
    
    /// Делегат для обработки событий
    var delegate: MapViewDelegate?
    
    /// Линия вверху view для скрытия view при свайпе
    lazy var swipeLine: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 2.5
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
        return view
    }()
    
    /// CollectionView для отображения списка городов
    lazy var cityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CityCell.self, forCellWithReuseIdentifier: CityCell.reusebleIdenifier)
        return collection
    }()
    
    /// Лейбел для вывода страны, города и индекса
    lazy var cityInfoLbl: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    /// Лейбел для вывода адреса
    lazy var addressLbl: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(displayP3Red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        return label
    }()
    
    /// Лейбел для вывода кол-во жителей в выбранном городе
    lazy var cityPopulation: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(displayP3Red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        label.text = "Население Москвы: 12 655 050"
        return label
    }()
    
    /// Заголовок списка городов
    lazy var cityInAreaTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(displayP3Red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        label.text = "Города в радиусе 100 км:"
        return label
    }()
    
    /// Конструктор
    /// - Parameter frame: Размер окна
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 22
        addSubviews()
        addConstraints()
    }
    
    /// Не используемый конструктор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Метод для добавления subviews
    private func addSubviews() {
        addSubview(swipeLine)
        addSubview(cityInfoLbl)
        addSubview(addressLbl)
        addSubview(cityPopulation)
        addSubview(cityInAreaTitle)
        addSubview(cityCollectionView)
    }
    
    /// Метод для добавления констрейнтов
    private func addConstraints() {
        NSLayoutConstraint.activate([
            swipeLine.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            swipeLine.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            swipeLine.widthAnchor.constraint(equalToConstant: 60),
            swipeLine.heightAnchor.constraint(equalToConstant: 5),
            
            cityInfoLbl.topAnchor.constraint(equalTo: swipeLine.bottomAnchor, constant: 16),
            cityInfoLbl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            cityInfoLbl.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            addressLbl.topAnchor.constraint(equalTo: cityInfoLbl.bottomAnchor),
            addressLbl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            addressLbl.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            cityPopulation.topAnchor.constraint(equalTo: addressLbl.bottomAnchor, constant: 8),
            cityPopulation.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            cityPopulation.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            cityInAreaTitle.topAnchor.constraint(equalTo: cityPopulation.bottomAnchor, constant: 16),
            cityInAreaTitle.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            cityInAreaTitle.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            cityCollectionView.topAnchor.constraint(equalTo: cityInAreaTitle.bottomAnchor),
            cityCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            cityCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            cityCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    /// Обработчик свайпа закрытия view
    @objc func swipeHandler() {
        delegate?.swipeHandler()
    }
    
    /// Метод для установки полей view
    /// - Parameters:
    ///   - city: Город
    ///   - country: Страна
    ///   - ZIP: Индекс
    ///   - address: Адрес
    func setupFields(city: String?, country: String?, ZIP: String?, address: String) {
        var localCity = ""
        var localCountry = ""
        var localZIP = ""
        
        if let city = city {
            localCity = city
        }
        if let country = country {
            localCountry = ", \(country)"
        }
        
        if let ZIP = ZIP {
            localZIP = ", \(ZIP)"
        }
        
        cityInfoLbl.text = "\(localCity) \(localCountry) \(localZIP)"
        addressLbl.text = address
    }
}
