//
//  MoreButtonView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 09.03.2022.
//

import UIKit

class MoreButtonView: UIView {
    
    var delegate: MoreViewButtonDelegate?
    
    lazy var addFavoriteBtn: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addFavoriteHandler), for: .touchUpInside)
        button.setTitle("Reading list", for: .normal)
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
            addFavoriteBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 8),
            addFavoriteBtn.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            addFavoriteBtn.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            addFavoriteBtn.heightAnchor.constraint(equalTo: readTextBtn.heightAnchor),
            
            readTextBtn.topAnchor.constraint(equalTo: addFavoriteBtn.bottomAnchor, constant: 8),
            readTextBtn.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            readTextBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            readTextBtn.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8)
        ])
    }
    
    @objc private func addFavoriteHandler() {
        delegate?.addFavoriteHandler()
    }
    
    @objc private func readTextHandler() {
        delegate?.readTextHandler()
    }
}
