//
//  DetailButtonViewController.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 16.03.2022.
//

import UIKit
import AVFoundation

class DetailButtonViewController: UIViewController {

    let detailView = DetailButtonView()
    
    let synthesizer = AVSpeechSynthesizer()
    
    var isDetailPresent = false
    
    var isRobotOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
    }
    
    override func loadView() {
        view = detailView
    }
    
    func presentController(parent: BreakingNewsViewController!) {
        if !isDetailPresent {
            guard let parent = parent else {
                return
            }
            isDetailPresent = true
            
            if let _ = NewsReadingList.findBy(id: parent.newsId) {
                detailView.addFavoriteBtn.backgroundColor = .green
            }
            else {
                detailView.addFavoriteBtn.backgroundColor = .systemBackground
            }
            
            detailView.frame = CGRect(x: parent.view.frame.midX,
                                      y: parent.breakingNewsView.detailBtn.frame.maxY + 10,
                                      width: parent.breakingNewsView.detailBtn.frame.maxX - parent.view.frame.midX,
                                      height: 80)
            detailView.alpha = 0
            
            parent.addChild(self)
            parent.view.addSubview(self.view)
            self.didMove(toParent: parent)
            
            UIView.animate(withDuration: 0.3) {
                self.detailView.alpha = 1
            }
        }
        else {
            isDetailPresent = false
            UIView.animate(withDuration: 0.3) {
                self.detailView.alpha = 0
            } completion: { _ in
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presentController(parent: nil)
    }
}

extension DetailButtonViewController: DetailButtonViewDelegate {
    
    func addToReadingListHandler() {
        guard let parent = self.parent as? BreakingNewsViewController else {
            return
        }
        if let item = NewsReadingList.findBy(id: parent.newsId) {
            detailView.addFavoriteBtn.backgroundColor = .systemBackground
            NewsReadingList.removeFromReadingList(by: Int(item.uuid))
        }
        else {
            NewsReadingList.saveToReadingList(
                title: parent.breakingNewsView.newsTitle.text,
                text: parent.breakingNewsView.newsInfo.text,
                image: parent.breakingNewsView.newsImage.image?.pngData(),
                id: parent.newsId)
            detailView.addFavoriteBtn.backgroundColor = .green
        }
    }
    
    func readTextHandler() {
        guard let parent = self.parent as? BreakingNewsViewController else {
            return
        }
        isRobotOn = !isRobotOn
        if isRobotOn
        {
            detailView.readTextBtn.backgroundColor = .blue.withAlphaComponent(0.4)
            guard let speechText = parent.breakingNewsView.newsInfo.text else { return }
            let speech = AVSpeechUtterance(string: speechText)
            synthesizer.speak(speech)
        }
        else
        {
            detailView.readTextBtn.backgroundColor = .systemBackground
            if synthesizer.isSpeaking
            {
                synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            }
        }
    }
}
