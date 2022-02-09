//
//  PhotoViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class PhotoViewController: UIViewController {

	var photoView = PhotoView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Photo"
    }
	
	override func loadView() {
		view = photoView
	}
}
