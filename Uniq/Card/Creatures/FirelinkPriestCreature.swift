//
//  FirelinkPriestCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//
//
class FirelinkPriestCreature: CreatureCard {
    init() {
        super.init(name: "Firelink Priest", attack: 1, health: 2)
        //description = "Battlecry: Set health to number of cards in your hand"
        ability = ActiveAbility(
            description: "Give random allied creature +1/+1",
            cooldown: 2,
            effect: { (battle: Battle, spot: Spot?) -> Bool in
                if let randomSpot = battle.spots.randomSpot(
                    in: { ($0 != spot ) && ($0.owner == spot!.owner) && ( $0.creature != nil ) }
                ) {
                    battle.buffStat(.attack, by: 1, at: randomSpot)
                    battle.buffStat(.health, by: 1, at: randomSpot)
                    return true
                }
                return false
            }
        )
    }
    /*
    override func battlecry(battle: Battle, creature: CreatureSprite) {
        let health = battle.player.deck.handPile.count
        creature.setHealth(to: health)
    }
    */
}
