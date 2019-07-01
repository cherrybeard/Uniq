//
//  OldProphetCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class OldProphetCreature: CreatureCard {
    init() {
        super.init(name: "Old Prophet", attack: 1, health: 1)
        onSummon = BlessOfTheEldersAbility()
    }
}
