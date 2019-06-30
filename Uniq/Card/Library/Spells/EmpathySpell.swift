//
//  EmpathySpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class EmpathySpell: SpellCard {
    
    init() {
        super.init(
            name: "Empathy",
            requiresTarget: false
        )
        description = "Get a card for each damaged allied creature."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let spots = battle.spots.filter {
                $0.owner.isActive && ($0.creature?.isDamaged ?? false)
            }
            for _ in spots {
                _ = battle.draw(for: battle.activePlayer)
            }
            return true
        }
    }
}
