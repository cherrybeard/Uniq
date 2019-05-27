//
//  WitchCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 13/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import GameplayKit

class WitchCreature: CreatureCardBlueprint {
    init() {
        super.init(attack: 3, health: 2)
        description = "Death: Summon creature from your hand"
    }
//    
//    override func deathrattle(battle: Battle, creature: CreatureSprite) {
//        /*
//        let creatureCards = battle.player.deck.hand.cards.filter({ card in (card is CreatureCardSprite) })
//        if creatureCards.count > 0 {
//            if let shuffledCards = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: creatureCards) as? [CreatureCardSprite] {
//                let cardSprite = shuffledCards[0]
//                cardSprite.card.play(battle: battle, for: .player, target: nil)
//                cardSprite.state = .discarded
//                battle.player.deck.hand.clean()
//            }
//        }
//        */
//    }
}
