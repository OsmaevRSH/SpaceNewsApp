//
//  MapCityViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 15.02.2022.
//

import UIKit
import MapKit
import Combine

class MapCityViewController: UIViewController {
    
    var viewModel: ResultCityPageViewModel!
    var page: Pages
    var cities: ResultCitysModel = ResultCitysModel.placeholder {
        didSet {
            setPinOnMap()
        }
    }
    
    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    func binding() {
        viewModel.$dataStorage
            .assign(to: \.cities, on: self)
            .store(in: &CancellableSetService.shared.set)
    }
    
    private func setPinOnMap(){
        guard let location = cities.location else { return }
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let coordinateRegion = MKCoordinateRegion(center: center,
                                                  latitudinalMeters: CLLocationDistance(cities.radius * 2000),
                                                  longitudinalMeters: CLLocationDistance(cities.radius * 2000))
        map.setRegion(coordinateRegion, animated: true)
        cities.cities.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude,
                                                           longitude: $0.longitude)
            annotation.title = $0.name
            map.addAnnotation(annotation)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
    
        annotation.title = "Center"
        map.addAnnotation(annotation)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.view.addSubview(map)
        addConstraints()
        map.isUserInteractionEnabled = false
        binding()
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
