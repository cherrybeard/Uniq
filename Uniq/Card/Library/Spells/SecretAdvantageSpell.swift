//
//  SecretAdvantageSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 30/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class SecretAdvantageSpell: SpellCard {
    private static let bonus: Int = 2
    
    init() {
        super.init(
            name: "Secret Advantage",
            requiresTarget: false
        )
        description = "Gives all minions in hand +\(SecretAdvantageSpell.bonus) attack."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            let cards = battle.activePlayer.deck.handPile.compactMap { $0 as? CreatureCard }
            for card in cards {
                battle.buffStat(.attack, by: SecretAdvantageSpell.bonus, to: card)
            }
            return true
        }
    }
}
