//
//  ARSideBarViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 02.04.2022.
//

import UIKit

class ARSideBarViewController: UIViewController {
    
    private lazy var shadowView: UIView = {
        var view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.9)
        view.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeVC))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private let sideBarView = SideBarView()
    
    private var parentVC: UIViewController!
    
    func presentVC(parent: UIViewController) {
        if sideBarView.delegate == nil {
            sideBarView.delegate = self
        }
        self.parentVC = parent
        let size = parent.view.frame.width * 4 / 5
        
        let window = UIApplication.shared.connectedScenes
            .flatMap{ ($0 as? UIWindowScene)?.windows ?? [] }
            .first{ $0.isKeyWindow }

        guard let window = window else {
            return
        }
        
        sideBarView.frame = CGRect(x: -size, y: 0, width: size, height: window.frame.height)
        
        parent.addChild(self)
        window.addSubview(sideBarView)
        self.willMove(toParent: parent)

        shadowView.frame = window.frame
        parent.tabBarController?.view.addSubview(shadowView)
        
        UIView.animate(withDuration: 0.2) {
            self.sideBarView.frame.origin = CGPoint(x: 0, y: 0)
            parent.tabBarController?.view.frame.origin = CGPoint(x: size, y: 0)
            self.shadowView.alpha = 0.5
        }
    }
    
    @objc func removeVC() {
        UIView.animate(withDuration: 0.2) {
            self.sideBarView.frame.origin = CGPoint(x: -self.sideBarView.frame.width, y: 0)
            self.parentVC.tabBarController?.view.frame.origin = CGPoint(x: 0, y: 0)
            self.shadowView.alpha = 0
        } completion: { _ in
            self.sideBarView.removeFromSuperview()
            self.shadowView.removeFromSuperview()
            self.willMove(toParent: nil)
            self.removeFromParent()
        }

    }
}

extension ARSideBarViewController: ARSideBarViewDelegate {
    func swipeHandler() {
        removeVC()
    }
}
