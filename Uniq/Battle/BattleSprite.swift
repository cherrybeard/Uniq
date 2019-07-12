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
    let humanActions = ActionsPanels()
    
    override init() {
        super.init()
        
        let actionsYPos = BattleScene.screenSize.height / 2 - AbilityButton.size / 2 - BattleSprite.actionsMargin
        humanActions.position = CGPoint( x: 0, y: -actionsYPos )
        addChild(humanActions)
    }
    
    func addFormation(_ formation: FormationSprite, for player: Player) {
        let margin = BattleSprite.formationMargin + CharacterSprite.height / 2
        formation.position = CGPoint( x: 0, y: player.controlledBy.rawValue * margin )
        addChild(formation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
