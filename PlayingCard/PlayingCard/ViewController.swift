//
//  ViewController.swift
//  PlayingCard
//
//  Created by Dias on 2/22/21.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            if let playingCardView = sender.view as? PlayingCardView {
                UIView.transition(with: playingCardView, duration: 0.8, options: [.transitionFlipFromLeft], animations: {
                    playingCardView.isFaceUp = !playingCardView.isFaceUp
                })
            }
        default:
            break
        }
    }
    
    @IBOutlet var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

