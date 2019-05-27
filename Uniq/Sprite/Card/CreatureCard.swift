//
//  CreatureCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureCard: Card {
    private let _health: StatLabel
    private let _attack: StatLabel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(blueprint: CreatureCardBlueprint) {
        _health = StatLabel(type: .health, value: blueprint.health)
        _attack = StatLabel(type: .attack, value: blueprint.attack)
        super.init(blueprint: blueprint)
        
        _attack.position = CGPoint(x: -Card.WIDTH/2 + 6, y: -Card.HEIGHT/2 + 6)
        _health.position = CGPoint(x: Card.WIDTH/2 - 6, y: -Card.HEIGHT/2 + 6)
        
        addChild(_attack)
        addChild(_health)
    }
}
