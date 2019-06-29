//
//  YletiaPirate.swift
//  Uniq
//
//  Created by Steven Gusev on 10/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class YletiaPirateCreature: CreatureCard {
    init() {
        super.init(name: "Yletia Pirate", attack: 1, health: 4)
        ability = ActiveAbility(
            description: "Increase attack by 3",
            cooldown: 3,
            effect: { (battle: Battle, spot: Spot?) -> Bool in
                if spot == nil { return false }
                battle.buffStat(.attack, by: 3, at: spot!)
                return true
            }
        )
    }
}
