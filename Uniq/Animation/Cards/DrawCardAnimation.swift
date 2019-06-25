//
//  DrawCardAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class DrawCardAnimation: Animation {
    private static let DURATION: TimeInterval = 0.5
    
    let hand: HandSprite
    let drawnCard: CardSprite
    
    init(hand: HandSprite, card: CardSprite) {
        self.hand = hand
        drawnCard = card
    }
    
    override func play() {
        //drawnCard.alpha = 0
        let xPos = BattleScene.SCREEN_RIGHT + CardSprite.WIDTH + 20
        drawnCard.position = CGPoint(x: xPos, y: 0)
        //drawnCard.zRotation = .pi / 2
        hand.addChild(drawnCard)
        
        let total = (hand.children.filter { $0 is CardSprite }).count
        let (position, rotation) = HandSprite.cardPosition(at: total, total: total)
        
        let move = SKAction.move(to: position, duration: DrawCardAnimation.DURATION)
        let rotate = SKAction.rotate(toAngle: rotation, duration: DrawCardAnimation.DURATION)
        let action = SKAction.group([move, rotate])
        action.timingMode = .easeOut
        
        drawnCard.run(action) {
            self.state = .finished
        }
    }
}
