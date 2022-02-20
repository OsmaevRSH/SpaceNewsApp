//
//  SetupApiSettingsViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit
import MapKit

class SetupApiSettingsViewController: UIViewController {

	var setupApiSettingsView = SetupApiSettingsView()
    var resultCityPageViewController: ResultCityPageViewController!
    
    private var location: CLLocationCoordinate2D!
    
    func setupFields(location: CLLocationCoordinate2D) {
        self.location = location
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Photo"
        setupApiSettingsView.delegate = self
    }
	
	override func loadView() {
		view = setupApiSettingsView
	}
}

extension SetupApiSettingsViewController: SetupApiDelegate {
    func submitButtonHandler() {
        let first = UIViewController()
        first.view.backgroundColor = .red
        let second = UIViewController()
        second.view.backgroundColor = .yellow
        resultCityPageViewController.setupFields(latitude: "\(location.latitude)",
                                                 longitude: "\(location.longitude)",
                                                 radius: "\(setupApiSettingsView.radiusSlider.value)",
                                                 minPopulation: "\(setupApiSettingsView.minPopulationTextField.text!)",
                                                 maxPopulation: "\(setupApiSettingsView.maxPopulationTextField.text!)")
        navigationController?.show(resultCityPageViewController, sender:  nil)
    }
}
