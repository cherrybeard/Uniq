//
//  LesserDestuctionSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 29/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class LesserDestuctionSpell: SpellCard {
    private static let maxAttack: Int = 2
    
    init() {
        super.init(
            name: "Lesser Destuction",
            requiresTarget: true,
            spotsFilter: {
                !$0.owner.isActive
                    && ($0.creature != nil)
                    && ($0.creature!.attack <= LesserDestuctionSpell.maxAttack)
            }
        )
        description = "Destroy creature with \(LesserDestuctionSpell.maxAttack) attack or less."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if let creature = spot?.creature {
                battle.dealDamage(creature.health, to: spot!)
            }
            return true
        }
    }
}
