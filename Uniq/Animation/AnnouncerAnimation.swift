//
//  AnnouncerAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 16/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AnnouncerAnimation: Animation {
    private weak var _announcer: TurnAnnouncerSprite?
    
    init(announcer: TurnAnnouncerSprite) {
        _announcer = announcer
    }
    
    override func play() {
        if _announcer == nil {
            self.state = .finished
            return
        }
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let wait  = SKAction.wait(forDuration: 0.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([fadeIn, wait])
        _announcer?.run(sequence) {
            self.state = .finished
            self._announcer?.run(fadeOut) {
                self._announcer?.removeFromParent()
            }
            
        }
    }
}
