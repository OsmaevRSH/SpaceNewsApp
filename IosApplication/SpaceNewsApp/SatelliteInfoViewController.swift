//
//  SatelliteInfoViewController.swift
//  ARProject
//
//  Created by Руслан Осмаев on 01.04.2022.
//

import UIKit

protocol SatelliteInfoDelegate {
    func swipeHandler()
}

class SatelliteInfoViewController: UIViewController {
    
    var delegate: SatelliteInfoDelegate?
    
    var parentController: UIViewController!
    
    lazy var swipeLine: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var flightLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var versionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var altitudeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var velocityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var launchDateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackViewInfo: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            flightLabel,
            versionLabel,
            altitudeLabel,
            velocityLabel,
            launchDateLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.layer.cornerRadius = 22
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.addSubview(swipeLine)
        self.view.addSubview(stackViewInfo)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        NSLayoutConstraint.activate([
            swipeLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            swipeLine.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 12),
            swipeLine.widthAnchor.constraint(equalToConstant: 100),
            swipeLine.heightAnchor.constraint(equalToConstant: 6),
            
            stackViewInfo.topAnchor.constraint(equalTo: swipeLine.bottomAnchor, constant: 16),
            stackViewInfo.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            stackViewInfo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
            stackViewInfo.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        ])
    }
    
    func presentController(parent: UIViewController) {
        if parentController == nil {
            self.parentController = parent
        }
        else {
            return
        }
        self.view.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: 0)
        parent.view.addSubview(self.view)
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: parent.view.frame.height - parent.view.frame.height / 3, width: parent.view.frame.width, height: parent.view.frame.height / 3)
        }
    }
    
    func removeController() {
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: self.parentController.view.frame.height, width: self.parentController.view.frame.width, height: 0)
        } completion: { _ in
            self.view.removeFromSuperview()
            self.parentController = nil
        }
    }
    
    @objc func swipeHandler() {
        delegate?.swipeHandler()
    }
    
    func setupData(flight: String?, version: String?, altitude: String?, velocity: String?, launch: String?) {
        let undefined = "undefined"
        flightLabel.text = "Flight: \(flight ?? undefined)"
        versionLabel.text = "Version: \(version ?? undefined)"
        altitudeLabel.text = "Altitude: \(altitude ?? undefined)"
        velocityLabel.text = "Velocity: \(velocity ?? undefined)"
        launchDateLabel.text = "Launch date: \(launch ?? undefined)"
    }
}
