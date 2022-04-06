//
//  AlertIfLocationServiceDisabled.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 23.01.2022.
//

import UIKit

class AlertIfLocationServiceDisabled: Alert {
	static func getAlert() -> UIAlertController {
		let alert = UIAlertController(
			title: "Location service is disabled",
			message: "do you want to turn it on?",
			preferredStyle: .alert)
		
		let settingAction = UIAlertAction(
			title: "Setting",
			style: .default) { alert in
			if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			}
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alert.addAction(settingAction)
		alert.addAction(cancelAction)
		return alert
	}
}
