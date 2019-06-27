//
//  YletiaPirate.swift
//  Uniq
//
//  Created by Steven Gusev on 10/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class YletiaPirate: CreatureCard {
    init() {
        super.init(
            description: "Yletia Pirate",
            attack: 1,
            health: 4,
            ability: ActiveAbility(
                description: "Increase attack by 3",
                cooldown: 2,
                effect: { (battle: Battle, spot: Spot?) -> Bool in
                    if spot == nil { return false }
                    battle.buffStat(.attack, by: 3, at: spot!)
                    return true
                }
            )
        )
    }
    
//    override func useActiveAbility(battle: Battle) {
//        print("i am using ability tho")
//        summon?.increaseAttack(by: 3)
//    }
}
