//
//  SpellCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellCard: Card {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(blueprint: CardBlueprint) {
        super.init(blueprint: blueprint)
    }
}
