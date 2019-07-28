//
//  AnnouncerAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 16/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AnnouncerAnimation: Animation {
    private let announcer = TurnAnnouncerSprite()
    private static var fadeIn: SKAction {
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let wait  = SKAction.wait(forDuration: 0.5)
        return SKAction.sequence([fadeIn, wait])
    }
    private static var fadeOut = SKAction.fadeOut(withDuration: 0.5)
    
    init(battle: BattleSprite, message: String) {
        announcer.message = message
        announcer.position = CGPoint(x: 0, y: -6)
        announcer.alpha = 0
        battle.addChild(announcer)
    }
    
    override func play() {
        announcer.run(AnnouncerAnimation.fadeIn) {
            self.state = .finished
            self.announcer.run(AnnouncerAnimation.fadeOut) {
                self.announcer.removeFromParent()
            }
        }
    }
    
}
