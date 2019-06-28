//
//  AngerSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class AngerSpell: SpellCard {
    private static let attackBuff: Int = 2
    private static let healthBuff: Int = 2
    
    init() {
        super.init(
            name: "Anger",
            requiresTarget: true,
            spotsFilter: {
                $0.owner.isActive && ($0.creature?.isDamaged ?? false)
            }
        )
        description = "Give damaged creature +\(AngerSpell.attackBuff)/\(AngerSpell.healthBuff)."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            if spot != nil {
                battle.buffStat(.attack, by: AngerSpell.attackBuff, at: spot!)
                battle.buffStat(.health, by: AngerSpell.healthBuff, at: spot!)
                return true
            }
            return false
        }
    }
}
