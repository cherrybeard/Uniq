//
//  WhateverItWillBeSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class WhateverItWillBeSpell: SpellCard {
    
    init() {
        super.init(name: "Whatever It Will Be")
        description = "Add a random creature card to your hand."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let card = CardLibrary.getRandomCard(filter: { $0 is CreatureCard } ) {
                _ = battle.addToHand(for: battle.activePlayer, cardName: card.name)
            }
            return true
        }
    }
}
