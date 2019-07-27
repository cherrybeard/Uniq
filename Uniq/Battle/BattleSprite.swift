//
//  BattleSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 08/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class BattleSprite: SKNode {
    private static let formationCenter = 40
    private static let formationMargin = 80
    private static let actionsMargin: CGFloat = 40
    
    let humanActions = ActionsPanels()
    let abilityDescription = AbilityDescription()
    
    override init() {
        super.init()
        
        let actionsYPos = BattleScene.screenSize.height / 2 - AbilityButton.size / 2 - BattleSprite.actionsMargin
        humanActions.position = CGPoint( x: 0, y: -actionsYPos )
        addChild(humanActions)
        
        let descriptionYPos = BattleScene.screenSize.height / 2 - 126
        abilityDescription.position = CGPoint(x: 0, y: -descriptionYPos)
        abilityDescription.alpha = 0
        addChild(abilityDescription)
    }
    
    func addFormation(_ formation: FormationSprite, for player: Player) {
        let margin = BattleSprite.formationMargin + CharacterSprite.height / 2
        let yPos = BattleSprite.formationCenter + player.controlledBy.rawValue * margin
        formation.position = CGPoint( x: 0, y: yPos )
        addChild(formation)
    }
    
    func updateAbilityDescription(to ability: ActiveAbility?) {
        if ability != nil {
            abilityDescription.alpha = 1
            abilityDescription.set(to: ability!)
        } else {
            abilityDescription.alpha = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
