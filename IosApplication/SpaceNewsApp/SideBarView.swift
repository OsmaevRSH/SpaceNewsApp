//
//  SideBarView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.04.2022.
//

import UIKit

protocol ARSideBarViewDelegate {
    func swipeHandler()
}

class SideBarView: UIView {
    var delegate: ARSideBarViewDelegate?
    
    lazy var viewTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AR settings"
        label.sizeToFit()
        return label
    }()
    
    lazy var earthModeLbl: UILabel = {
        var label = UILabel()
        label.text = "Earth day/night mode"
        return label
    }()
    
    lazy var enableEarthLbl: UILabel = {
        var label = UILabel()
        label.text = "Enable/Disable earth"
        return label
    }()
    
    lazy var enableSatelliteLbl: UILabel = {
        var label = UILabel()
        label.text = "Enable/Disable satellite"
        return label
    }()
    
    lazy var earthModeSwich: UISwitch = {
        var swich = UISwitch()
        return swich
    }()
    
    lazy var enableEarthSwich: UISwitch = {
        var swich = UISwitch()
        return swich
    }()
    
    lazy var enableSatelliteSwich: UISwitch = {
        var swich = UISwitch()
        return swich
    }()
    
    lazy var stackContainer: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            earthModeStack, enableEarthStack, enableSatelliteStack
        ])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        return stack
    }()
    
    lazy var earthModeStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            earthModeLbl, earthModeSwich
        ])
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var enableEarthStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            enableEarthLbl, enableEarthSwich
        ])
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var enableSatelliteStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            enableSatelliteLbl, enableSatelliteSwich
        ])
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(viewTitle)
        self.addSubview(stackContainer)
        addConstraints()
        
        self.backgroundColor = .systemBackground
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipe.direction = .left
        self.addGestureRecognizer(swipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func swipeHandler() {
        delegate?.swipeHandler()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            viewTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            viewTitle.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackContainer.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 16),
            stackContainer.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            stackContainer.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            earthModeSwich.rightAnchor.constraint(equalTo: stackContainer.rightAnchor),
            enableEarthSwich.rightAnchor.constraint(equalTo: stackContainer.rightAnchor),
            enableSatelliteSwich.rightAnchor.constraint(equalTo: stackContainer.rightAnchor)
        ])
    }
}
