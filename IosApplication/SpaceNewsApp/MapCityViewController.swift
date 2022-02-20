//
//  MapCityViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 15.02.2022.
//

import UIKit
import MapKit

class MapCityViewController: UIViewController {
    
    var viewModel: ResultCityPageViewModel!
    var page: Pages
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.view.addSubview(map)
        addConstraints()
        map.isUserInteractionEnabled = false
    }
    
    init() {
        self.page = Pages.map
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            map.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}
