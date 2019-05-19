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
        //TODO: Move all not-animation stuff to the class Battle
        
        // set souceSpot.creature.zPosition to 1
        // move souceSpot.creature from initial position to the targetSpot
        
        let targetCreature = _targetSpot.creature
        _targetSpot.creature = _sourceSpot.creature
        _sourceSpot.creature = targetCreature
        
        _targetSpot.creature?.spot = _targetSpot
        _sourceSpot.creature?.spot = _sourceSpot
        let moveToSource = SKAction.move(to: _sourceSpot.position, duration: 0.6)
        let moveToTarget = SKAction.move(to: _targetSpot.position, duration: 0.6)
        _targetSpot.creature?.isActionTaken = true
        _targetSpot.creature?.zPosition = 1
        _sourceSpot.creature?.run(moveToSource)
        _targetSpot.creature?.run(moveToTarget) {
            self._targetSpot.zPosition = 0
            self.state = .finished
        }
        // move targetSpot.creature to the sourceSpot (if exist?)
        // save targetSpot.creature to targetCreature
        // set targetSpot.creature to souceSpot.creature
        // set souceSpot.creature to targetCreature
        // check isTaken properties of spots
        // set souceSpot.creature as actionTaken = true
        // reset actionTaken in new round
    }
}
