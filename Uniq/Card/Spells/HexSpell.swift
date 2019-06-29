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
            requiresTarget: true,
            spotsFilter: {
                !$0.owner.isActive && ($0.creature != nil)
            }
        )
        description = "Transform target creature into \(HexSpell.creatureName)."
        effect = { (battle: Battle, spot: Spot?) -> Bool in
            battle.kill(at: spot!)
            battle.summon(HexSpell.creatureName, to: spot!.index)
            return true
        }
    }
}
