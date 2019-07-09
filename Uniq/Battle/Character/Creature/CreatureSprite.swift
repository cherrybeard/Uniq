//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 13/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureSprite: CharacterSprite {
    let abilitiesList = AbilitiesList()
    
    init(_ creature: Creature) {
        super.init(creature)
        
        for ability in creature.abilities {
            abilitiesList.addChild( AbilityButton(ability) )
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
