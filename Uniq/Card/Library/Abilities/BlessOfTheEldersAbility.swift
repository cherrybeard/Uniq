//
//  BlessOfTheEldersAbility.swift
//  Uniq
//
//  Created by Steven Gusev on 01/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class BlessOfTheEldersAbility: OnSummonAbility {
    private static let bonus: Int = 2
    
    init() {
        super.init(
            effect: { (battle: Battle, sourceSpot: Spot, summonSpot: Spot) -> () in
                if sourceSpot.owner == summonSpot.owner {
                    battle.buffStat(.attack, by: BlessOfTheEldersAbility.bonus, at: summonSpot)
                }
            }
        )
        name = "Bless of the Elders"
        description = "Give +\(BlessOfTheEldersAbility.bonus) attack to summoned allied creature."
    }
}
