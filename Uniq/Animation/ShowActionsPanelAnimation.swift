//
//  ShowActionsPanelAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class ShowActionsPanelAnimation: Animation {
    private let panel: ActionsPanel
    private let battle: BattleSprite
    private let character: CharacterSprite
    
    init(panel: ActionsPanel, battle: BattleSprite, character: CharacterSprite) {
        self.panel = panel
        self.battle = battle
        self.character = character
    }
    
    override func play() {
        for panel in battle.humanActions.panels {
            panel.alpha = 0
        }
        for character in battle.characters {
            character.state.removeAll()
        }
        self.panel.alpha = 1
        self.character.state.insert(.selected)
        state = .finished
    }
}
