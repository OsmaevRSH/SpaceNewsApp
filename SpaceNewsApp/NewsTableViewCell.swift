//
//  NewsTableViewCell.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
		
	@IBOutlet weak var newsImage: UIImageView!
	@IBOutlet weak var newsInfo: UILabel!
	@IBOutlet weak var newsPublishedAt: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		newsImage.layer.cornerRadius = 20
		backgroundColor = .black.withAlphaComponent(0.9)
		let bgColorView = UIView()
		bgColorView.backgroundColor = .gray.withAlphaComponent(0.2)
		selectedBackgroundView = bgColorView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
