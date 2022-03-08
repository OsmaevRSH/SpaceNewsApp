//
//  CityCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 08.03.2022.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    static let reusebleIdenifier = "CityCell"
    
    lazy var cityNameLbl: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var distanceToCityLbl: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(displayP3Red: 138/255, green: 138/255, blue: 142/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    lazy var container: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(container)
        container.addSubview(cityNameLbl)
        container.addSubview(distanceToCityLbl)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            container.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            container.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            cityNameLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            cityNameLbl.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8),
            cityNameLbl.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8),
            
            distanceToCityLbl.topAnchor.constraint(equalTo: cityNameLbl.bottomAnchor, constant: 8),
            distanceToCityLbl.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8),
            distanceToCityLbl.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            distanceToCityLbl.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8)
        ])
    }
}
