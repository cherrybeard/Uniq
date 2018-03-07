//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class Battle {
    let player = Player()
    let desk = Desk()
    let animationPipeline = AnimationPipeline()
    
    func summon(_ creature: CreatureSprite) {
        desk.summon(creature)
    }
    
    func playCard(cardSprite: CardSprite, target: CreatureSprite? = nil) {
        let cost = cardSprite.card.cost
        if player.manaCounter.use(amount: cost) {
            cardSprite.card.play(battle: self, for: .player, target: target)
            cardSprite.card.state = .discarded
            player.hand.clean()
            player.toggleCardsHighlight(playable: true)
        }
    }
    
    func attack(attacking: CreatureSprite, defending: CreatureSprite) {
        defending.applyDamage(attacking.creature.attack)
        attacking.applyDamage(defending.creature.attack)
        attacking.canAttack = false
        
        let animation = AttackAnimation(attacking: attacking, defending: defending)
        animationPipeline.add(animation: animation)
    }
    
}
