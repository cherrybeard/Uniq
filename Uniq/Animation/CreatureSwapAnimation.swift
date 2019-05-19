//
//  CreatureSwapAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 19/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class CreatureSwapAnimation: Animation {
    init(sourceSpot: CreatureSpotSprite, targetSpot: CreatureSpotSprite) {
        
    }
    
    override func play() {
        // set souceSpot.creature.zPosition to 1
        // move souceSpot.creature from initial position to the targetSpot
        // move targetSpot.creature to the sourceSpot (if exist?)
        // save targetSpot.creature to targetCreature
        // set targetSpot.creature to souceSpot.creature
        // set souceSpot.creature to targetCreature
        // check isTaken properties of spots
        // set souceSpot.creature as actionTaken = true
        // reset actionTaken in new round
    }
}
