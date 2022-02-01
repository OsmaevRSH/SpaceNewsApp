//
//  PhotoView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class PhotoView: UIView {

	// MARK: - UI Elements
		/// ImageView для отображения фото текущего местоположения
	lazy var spaceImageView: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.backgroundColor = .purple
		return image
	}()
	
		/// Метод для добавления constraints
	private func addConstraints() {
		NSLayoutConstraint.activate([
			spaceImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			spaceImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			spaceImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			spaceImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
		])
	}
	
	// MARK: - Initialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(spaceImageView)
		addConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
