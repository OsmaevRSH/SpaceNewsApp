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

protocol ARSettingsDelegate {
    func earthModeSwitchHandler(sender: UISwitch)
    func enableEarthSwitchHandler(sender: UISwitch)
    func enableSatelliteSwitchHandler(sender: UISwitch)
}

class SideBarView: UIView {
    
    var sideBarDelegate: ARSideBarViewDelegate?
    
    var arSettingsDelegate: ARSettingsDelegate?
    
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
    
    lazy var earthModeSwitch: UISwitch = {
        var swich = UISwitch()
        swich.addTarget(self, action: #selector(earthModeSwitchHandler(sender:)), for: .valueChanged)
        return swich
    }()
    
    lazy var enableEarthSwitch: UISwitch = {
        var swich = UISwitch()
        swich.addTarget(self, action: #selector(enableEarthSwitchHandler(sender:)), for: .valueChanged)
        return swich
    }()
    
    lazy var enableSatelliteSwitch: UISwitch = {
        var swich = UISwitch()
        swich.addTarget(self, action: #selector(enableSatelliteSwitchHandler(sender:)), for: .valueChanged)
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
            earthModeLbl, earthModeSwitch
        ])
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var enableEarthStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            enableEarthLbl, enableEarthSwitch
        ])
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var enableSatelliteStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            enableSatelliteLbl, enableSatelliteSwitch
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
        sideBarDelegate?.swipeHandler()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            viewTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            viewTitle.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackContainer.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 16),
            stackContainer.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            stackContainer.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            earthModeSwitch.rightAnchor.constraint(equalTo: stackContainer.rightAnchor),
            enableEarthSwitch.rightAnchor.constraint(equalTo: stackContainer.rightAnchor),
            enableSatelliteSwitch.rightAnchor.constraint(equalTo: stackContainer.rightAnchor)
        ])
    }
    
    @objc private func earthModeSwitchHandler(sender: UISwitch) {
        arSettingsDelegate?.earthModeSwitchHandler(sender: sender)
    }
    
    @objc private func enableEarthSwitchHandler(sender: UISwitch) {
        arSettingsDelegate?.enableEarthSwitchHandler(sender: sender)
    }
    
    @objc private func enableSatelliteSwitchHandler(sender: UISwitch) {
        arSettingsDelegate?.enableSatelliteSwitchHandler(sender: sender)
    }
}
