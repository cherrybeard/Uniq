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
    private static let actionsMargin: CGFloat = 30
    
    // TODO: Combine this in the single class
    var formations: [Player.Kind: Formation] = [
        .ai: Formation(),
        .human: Formation()
    ]
    var characters: [CharacterSprite] {
        var characters: [CharacterSprite] = []
        for player in Player.Kind.allCases {
            if let c = formations[player]?.characters {
                characters += c
            }
        }
        return characters
    }
    let humanActions = ActionsPanels()
    
    override init() {
        super.init()
        
        for (player, formation) in formations {
            let margin = BattleSprite.formationMargin + CharacterSprite.height / 2
            formation.position = CGPoint( x: 0, y: player.rawValue * margin )
            addChild(formation)
        }
        
        let actionsYPos = BattleScene.screenSize.height / 2 - AbilityButton.size / 2 - BattleSprite.actionsMargin
        humanActions.position = CGPoint( x: 0, y: -actionsYPos )
        addChild(humanActions)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
