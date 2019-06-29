//
//  DoubleDrawSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class DoubleDrawSpell: SpellCard {
    private static let amount: Int = 2
    
    init() {
        super.init(
            name: "Double Draw",
            requiresTarget: false
        )
        description = "Draws \(DoubleDrawSpell.amount) cards."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            for _ in 1...DoubleDrawSpell.amount {
                _ = battle.draw(for: battle.activePlayer)
            }
            return true
        }
    }
}
