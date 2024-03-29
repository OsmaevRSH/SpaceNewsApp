//
//  ViewController.swift
//  ARProject
//
//  Created by Руслан Осмаев on 29.03.2022.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {
    
    private var isMoved = false
    
    private var earthMode = false
    
    private var disableEarth = false
    
    private var disableSatellite = false
    
    private let arSideBarVC = ARSideBarViewController()
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 1
        return view
    }()
    
    private lazy var sceneView: ARSCNView = {
        var view = ARSCNView()
        view.showsStatistics = false
        view.autoenablesDefaultLighting = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HandleTapGesture(sender:)));
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(HandleLongTabGesture(sender:)))
        longTapGestureRecognizer.minimumPressDuration = 2
        view.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(longTapGestureRecognizer)
        
        return view
    }()
    
    private lazy var createEarthButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.setTitle("Create Earth", for: .normal)
        button.addTarget(self, action: #selector(createEarthButtonHandler), for: .touchUpInside)
        button.layer.cornerRadius = 14
        return button
    }()
    
    private let configuration = ARWorldTrackingConfiguration()
    
    private var isCanCreateEarth = false
    
    private let satelliteInfoVC = SatelliteInfoViewController()
    
    private var earthRadius = 0.3
    
    private let scene = SCNScene()
    
    private let viewModel = ARViewModel()
    
    private var selectedNode: SCNNode!
    
    private var starlinkSatillitesInfo = [String: SpaceXSatilliteModelElement]() {
        didSet {
            if !starlinkSatillitesInfo.isEmpty {
                DispatchQueue.global(qos: .userInitiated).async { [scene, starlinkSatillitesInfo, self] in
                    let earthNode = self.createEarth(root: scene.rootNode)
                    starlinkSatillitesInfo.forEach { item in
                        self.createStarlinkSatillite(root: earthNode, lat: item.value.latitude!, lon: item.value.longitude!, name: item.key)
                    }
                }
                isCanCreateEarth = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AR"
        self.view.addSubview(containerView)
        containerView.addSubview(sceneView)
        containerView.addSubview(createEarthButton)
        addArViewConstraints()
        satelliteInfoVC.delegate = self
        bindung()
        setupBarButtonItem()
        addPinchGestureToSceneView()
    }
    
    @objc private func HandleTapGesture(sender: UITapGestureRecognizer) {
        let areaPanned = sender.view as! SCNView
        let point = sender.location(in: areaPanned)
        let hits = areaPanned.hitTest(point)
        let hit = hits.first

        if let hit = hit
        {
            if let name = hit.node.name {
                if let satellite = starlinkSatillitesInfo[name],
                    let spaceTrack = satellite.spaceTrack {
                    if selectedNode != nil {
                        selectedNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBackground
                    }
                    selectedNode = hit.node
                    selectedNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                    satelliteInfoVC.setupData(flight: spaceTrack.objectName,
                                                version: satellite.version,
                                                altitude: satellite.heightKm == nil ? nil : "\(satellite.heightKm!)",
                                                velocity: satellite.velocityKms == nil ? nil : "\(satellite.velocityKms!)",
                                                launch: spaceTrack.launchDate)
                    satelliteInfoVC.presentController(parent: self)
                }
            }
        }
    }
    
    @objc private func HandleLongTabGesture(sender: UILongPressGestureRecognizer) {
        let areaPanned = sender.view as! SCNView
        let point = sender.location(in: areaPanned)
        let hits = areaPanned.hitTest(point)
        let hit = hits.first
        
        if let _ = hit
        {
            DispatchQueue.global(qos: .default).async {
                self.sceneView.scene.rootNode.enumerateChildNodes { node, _ in
                    node.isHidden = true
                }
            }
            sceneView.scene = scene
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sceneView.session.run(self.configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    private func addArViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            
            sceneView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            sceneView.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor),
            sceneView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            sceneView.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor),
            
            createEarthButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            createEarthButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            createEarthButton.heightAnchor.constraint(equalToConstant: 40),
            createEarthButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func createEarth(root: SCNNode) -> SCNNode {
        let earthGeometry = SCNSphere(radius: earthRadius)
        if self.earthMode {
            earthGeometry.firstMaterial?.diffuse.contents = UIImage(named: "8k_earth_nightmap")
        }
        else {
            earthGeometry.firstMaterial?.diffuse.contents = UIImage(named: "8k_earth_daymap")
        }
        earthGeometry.firstMaterial?.specular.contents = UIImage(named: "8k_earth_specular_map")
        earthGeometry.firstMaterial?.normal.contents = UIImage(named: "8k_earth_normal_map")
        earthGeometry.firstMaterial?.emission.contents = UIImage(named: "8k_earth_clouds")
        let earthNode = SCNNode(geometry: earthGeometry)
        if self.disableEarth {
            earthNode.isHidden = true
        }
        else {
            earthNode.isHidden = false
        }
        earthNode.name = "Earth"
        earthNode.position = SCNVector3(0, 0, -0.8)
        root.addChildNode(earthNode)
        return earthNode
    }
    
    private func createStarlinkSatillite(root: SCNNode, lat: Double, lon: Double, name: String) {
        let starlinkGeometry = SCNSphere(radius: 0.003)
        starlinkGeometry.firstMaterial?.diffuse.contents = UIColor.systemGray6
        let starlinkNode = SCNNode(geometry: starlinkGeometry)
        starlinkNode.name = name
        let coord = CoordinateConverter.convertTo3DecatrSystem(latitude: lat, longitude: lon, radius: earthRadius + 0.05)
        starlinkNode.position = SCNVector3(coord.x, coord.y, coord.z)
        if self.disableSatellite {
            starlinkNode.isHidden = true
        }
        else {
            starlinkNode.isHidden = false
        }
        root.addChildNode(starlinkNode)
    }
    
    private func bindung() {
        viewModel
            .$starlinkSatillitesInfo
            .assign(to: \.starlinkSatillitesInfo, on: self)
            .store(in: &viewModel.cancelSet)
    }
    
    @objc private func createEarthButtonHandler() {
        if isCanCreateEarth {
            sceneView.session.run(self.configuration, options: [.resetTracking])
            sceneView.scene = scene
            DispatchQueue.global(qos: .default).async {
                self.sceneView.scene.rootNode.enumerateChildNodes { node, _ in
                    if node.name == "Earth" {
                        if self.disableEarth {
                            node.isHidden = true
                        }
                        else {
                            node.isHidden = false
                        }
                    }
                    else {
                        if self.disableSatellite {
                            node.isHidden = true
                        }
                        else {
                            node.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    /// Метод для добавдения кнопок в Navigation Bar
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                                           style: .done, target: self, action: #selector(presentSideBar))
    }
    
    @objc private func presentSideBar() {
        arSideBarVC.presentVC(parent: self)
    }
    
    func addPinchGestureToSceneView(){
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePitch(withGestureRecognizer:)))
        let leftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(withGestureRecognizer:)))
        leftGestureRecognizer.direction = .left
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(withGestureRecognizer:)))
        rightGestureRecognizer.direction = .right
        let downGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(withGestureRecognizer:)))
        downGestureRecognizer.direction = .down
        let upGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(withGestureRecognizer:)))
        upGestureRecognizer.direction = .up
        sceneView.addGestureRecognizer(pinchGestureRecognizer)
        sceneView.addGestureRecognizer(leftGestureRecognizer)
        sceneView.addGestureRecognizer(rightGestureRecognizer)
        sceneView.addGestureRecognizer(downGestureRecognizer)
        sceneView.addGestureRecognizer(upGestureRecognizer)
    }
    
    @objc func handleSwipe(withGestureRecognizer recognizer: UISwipeGestureRecognizer) {
        defer {
            isMoved = false
        }
        if isMoved {
            return
        } else {
            isMoved = true
        }
        let tapRecognizer = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapRecognizer)
        guard let _ = hitTestResults.first?.node else {
            return
        }
        
        if let earthNode = self.sceneView.scene.rootNode.childNodes.first {
            switch recognizer.direction {
            case .left:
                earthNode.localRotate(by: SCNQuaternion(x: 0, y: -0.259, z: 0, w: 0.966))
            case .right:
                earthNode.localRotate(by: SCNQuaternion(x: 0, y: 0.259, z: 0, w: 0.966))
            case .down:
                earthNode.localRotate(by: SCNQuaternion(x: 0.259, y: 0, z: 0, w: 0.966))
            case .up:
                earthNode.localRotate(by: SCNQuaternion(x: -0.259, y: 0, z: 0, w: 0.966))
            default:
                break
            }
        }
    }
    
    @objc func handlePitch(withGestureRecognizer recognizer: UIPinchGestureRecognizer) {
        guard !isMoved else {
            return
        }
        let tapRecognizer = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapRecognizer)
        guard let _ = hitTestResults.first?.node else {
            return
        }
        
        let pointA = sceneView.session.currentFrame!.camera.transform.columns.3
        let pointB = sceneView.scene.rootNode.simdTransform.columns.3
                      
        
        let currentVecDiff = simd_sub(sceneView.session.currentFrame!.camera.transform, sceneView.scene.rootNode.simdTransform)
        if abs(currentVecDiff.columns.3.x) > 0.25
            || abs(currentVecDiff.columns.3.y) > 0.25
            || abs(currentVecDiff.columns.3.z) > 0.25 {
            sceneView.session.setWorldOrigin(relativeTransform: sceneView.session.currentFrame!.camera.transform)
        }
        
        let a = pointA.x * pointB.x + pointA.y * pointB.y + pointA.z * pointB.z
        let b = sqrt(pointA.x * pointA.x + pointA.y * pointA.y + pointA.z * pointA.z) * sqrt(pointB.x * pointB.x + pointB.y * pointB.y + pointB.z * pointB.z)
        print(acos(a/b))
        
        /*
         angle = arccos ( a * b / |a| * |b| );
         where:
         a * b = ax * bx + ay * by + az * bz
         |a| = sqrt( ax * ax + ay * ay + az * az )
         |b| = sqrt( bx * bx + by * by + bz * bz )
         */
        
        if recognizer.state == .changed {
            isMoved = true
            let velocity = Float((1 - recognizer.scale) * 0.3)
            if let earthNode = self.sceneView.scene.rootNode.childNodes.first {
                earthNode.position.z = earthNode.position.z - velocity
            }
            recognizer.scale = 1
            self.isMoved = false
        }
    }
}

extension ARViewController: SatelliteInfoDelegate, ARSettingsDelegate {
    func earthModeSwitchHandler(sender: UISwitch) {
        self.earthMode = sender.isOn
        DispatchQueue.global(qos: .default).async {
            self.sceneView.scene.rootNode.enumerateChildNodes { node, _ in
                if node.name == "Earth" {
                    if self.earthMode {
                        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "8k_earth_nightmap")
                    }
                    else {
                        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "8k_earth_daymap")
                    }
                }
            }
        }
    }
    
    func enableSatelliteSwitchHandler(sender: UISwitch) {
        self.disableSatellite = sender.isOn
        DispatchQueue.global(qos: .default).async {
            self.sceneView.scene.rootNode.enumerateChildNodes { node, _ in
                if node.name != "Earth" {
                    if self.disableSatellite {
                        node.isHidden = true
                    }
                    else {
                        node.isHidden = false
                    }
                }
            }
        }
    }
    
    func swipeHandler() {
        satelliteInfoVC.removeController()
        selectedNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemGray6
    }
}
