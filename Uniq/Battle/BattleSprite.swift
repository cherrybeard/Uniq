//
//  BattleSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class BattleSprite: SKNode {
    private static let formationMargin = 60
    
    var formations: [Player.Kind: Formation] = [
        .ai: Formation(),
        .human: Formation()
    ]
    
    override init() {
        super.init()
        for (player, formation) in formations {
            let margin = BattleSprite.formationMargin + CharacterSprite.height / 2
            formation.position = CGPoint( x: 0, y: player.rawValue * margin )
            addChild(formation)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
