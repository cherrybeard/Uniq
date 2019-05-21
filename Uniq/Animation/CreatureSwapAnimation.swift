//
//  CreatureSwapAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 19/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSwapAnimation: Animation {
    private var _sourceSpot: CreatureSpotSprite
    private var _targetSpot: CreatureSpotSprite
    
    init(sourceSpot: CreatureSpotSprite, targetSpot: CreatureSpotSprite) {
        _sourceSpot = sourceSpot
        _targetSpot = targetSpot
    }
    
    override func play() {
        // Creating actions for the first creature
        let scaleIn = SKAction.scale(to: 1.2, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.1)
        let scaleOut = SKAction.scale(to: 1, duration: 0.1)
        let scale = SKAction.sequence([scaleIn, wait, scaleOut])
        let moveToTarget = SKAction.move(to: _targetSpot.position, duration: 0.3)
        moveToTarget.timingMode = .easeIn
        let moveToTargetAndScale = SKAction.group([moveToTarget, scale])
        _targetSpot.creature?.zPosition = 1
        
        // Creating actions for the second, optional creature
        let moveToSource = SKAction.move(to: _sourceSpot.position, duration: 0.3)
        moveToSource.timingMode = .easeIn
        
        // Running animation
        _sourceSpot.creature?.run(moveToSource)
        _targetSpot.creature?.run(moveToTargetAndScale) {
            self._targetSpot.zPosition = 0
            self.state = .finished
        }
    }
}
