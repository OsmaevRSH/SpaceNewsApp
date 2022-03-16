//
//  CityInformationController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 08.03.2022.
//

import UIKit

class CityInformationController: UIViewController {

    let cityView = CityInformationView()
    let viewModel = CityViewModel()
    let cityInfoViewHeight: CGFloat = 200
    
    var isCityInfoPresented = false
    var data: [City] = [] {
        didSet {
            cityView.cityCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = cityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityView.cityCollectionView.delegate = self
        cityView.cityCollectionView.dataSource = self
        viewModel.getCitys(latitude: "0", longitude: "0", radius: "0", minPopulation: "0", maxPopulation: "0")
        binding()
    }
    
    private func binding() {
        viewModel
            .$dataStorage
            .assign(to: \.data, on: self)
            .store(in: &CancellableSetService.set)
    }
    
    func presentController(from parent: UIViewController) {
        if !isCityInfoPresented {
            isCityInfoPresented = true
            self.cityView.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: 0)
            parent.addChild(self)
            parent.view.addSubview(self.view)
            self.didMove(toParent: parent)
            UIView.animate(withDuration: 0.4) {
                self.cityView.frame = CGRect(x: 0, y: parent.view.frame.height - self.cityInfoViewHeight, width: parent.view.frame.width, height: self.cityInfoViewHeight)
            }
        }
    }
    
    func removeController(from parent: UIViewController) {
        if isCityInfoPresented {
            isCityInfoPresented = false
            UIView.animate(withDuration: 0.4) {
                self.cityView.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: 0)
                
            } completion: { _ in
                self.willMove(toParent: nil)
                self.removeFromParent()
                self.cityView.removeFromSuperview()
            }
        }
    }
}

extension CityInformationController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.reusebleIdenifier, for: indexPath) as? CityCell
        else {
            return CityCell()
        }
        cell.cityNameLbl.text = data[indexPath.row].name
        cell.distanceToCityLbl.text = data[indexPath.row].distance
        return cell
    }
}

extension CityInformationController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 1
        let padding = 16 * (numberOfCell + 1)
        let avaliableHeight = collectionView.frame.height - padding * 2
        let cellSize = avaliableHeight / numberOfCell
        return CGSize(width: cellSize * 2.5, height: cellSize) // 2.5 множитель ширины относительно высоты
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
}
