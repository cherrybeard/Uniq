//
//  DiscardCardAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 25/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DiscardCardAnimaiton: Animation {
    private static let ACTION = SKAction.fadeOut(withDuration: 0.2)
    private let card: CardSprite
    
    init(card: CardSprite) {
        self.card = card
    }
    
    override func play() {
        card.run(DiscardCardAnimaiton.ACTION) {
            self.state = .finished
            self.card.removeFromParent()
        }
    }
}
