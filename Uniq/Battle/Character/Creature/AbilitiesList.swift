//
//  AbilitiesList.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AbilitiesList: SKNode {
    //var abilities: [AbilityButton] = []
    /*
    func append(ability: AbilityButton) {
        abilities.append(ability)
        addChild(ability)
    }*/
    
    static func abilityPosition(at index: Int, total: Int) -> (CGPoint, CGFloat)  {
        let center = CGFloat(total + 1) / 2
        let shift = CGFloat(index) - center
        let xPos = shift * CGFloat(AbilityButton.width  + 10)
        //let yPos = -10 * abs(shift)
        let yPos: CGFloat = 0
        let position = CGPoint(x: xPos, y: yPos)
        //let rotation = -HandSprite.ANGLE * shift
        let rotation: CGFloat = 0
        return (position, rotation)
    }
}
