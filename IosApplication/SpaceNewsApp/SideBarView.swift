//
//  SideBarView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.04.2022.
//

import UIKit

protocol ARSideBarViewDelegate {
    func swipeHandler()
}

class SideBarView: UIView {
    var delegate: ARSideBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipe.direction = .left
        self.addGestureRecognizer(swipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func swipeHandler() {
        delegate?.swipeHandler()
    }
}
