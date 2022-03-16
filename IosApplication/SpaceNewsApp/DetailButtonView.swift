//
//  DetailButtonView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.03.2022.
//

import UIKit

class DetailButtonView: UIView {
    
    var delegate: DetailButtonViewDelegate?
    
    lazy var addFavoriteBtn: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToReadingListHandler), for: .touchUpInside)
        button.setTitle("Reading list", for: .normal)
        button.layer.cornerRadius = 22
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    lazy var readTextBtn: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(readTextHandler), for: .touchUpInside)
        button.setTitle("Text to speech", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addFavoriteBtn)
        addSubview(readTextBtn)
        addConstraints()
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 22
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            addFavoriteBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addFavoriteBtn.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            addFavoriteBtn.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            addFavoriteBtn.heightAnchor.constraint(equalTo: readTextBtn.heightAnchor),
            
            readTextBtn.topAnchor.constraint(equalTo: addFavoriteBtn.bottomAnchor),
            readTextBtn.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            readTextBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            readTextBtn.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    @objc private func addToReadingListHandler() {
        delegate?.addToReadingListHandler()
    }
    
    @objc private func readTextHandler() {
        delegate?.readTextHandler()
    }
}
