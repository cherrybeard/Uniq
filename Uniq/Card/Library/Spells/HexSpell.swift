//
//  HexSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 28/06/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

class HexSpell: SpellCard {
    private static var creatureName = "Fairy"
    
    init() {
        super.init(
            name: "Hex",
            spotsFilter: SpotsFilters.enemyCreatures
        )
        description = "Transform target creature into \(HexSpell.creatureName)."
        /*
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            battle.kill(at: spot!, killAnimation: false)
            battle.summon(HexSpell.creatureName, to: spot!.index)
            return true
        }*/
    }
}
