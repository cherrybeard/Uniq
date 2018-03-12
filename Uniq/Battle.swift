//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

struct Player {
    let deck = Deck()
    let mana = ManaCounter()
    
    func highlightCards(removeHighlight: Bool = false) {
        if removeHighlight {
            deck.hand.highlightCards()
        } else {
            deck.hand.highlightCards(mana: mana.amount)
        }
    }
}

class Battle {
    let player = Player()
    let desk = DeskSprite()
    let animationPipeline = AnimationPipeline()
    
    func summon(_ creature: CreatureSprite) {
        desk.summon(creature)
        if creature.creature.charge {
            creature.canAttack = true
        }
        creature.battlecry(battle: self)
    }
    
    func play(cardSprite: CardSprite, target: CreatureSprite? = nil) {
        let cost = cardSprite.card.cost
        if player.mana.use(amount: cost) {
            cardSprite.card.play(battle: self, for: .player, target: target)
            cardSprite.state = .discarded
            player.deck.hand.clean()
            player.highlightCards()
        }
    }
    
    func attack(attacking: CharacterSprite, defending: CharacterSprite) {
        defending.applyDamage(attacking.attack)
        attacking.applyDamage(defending.attack)
        attacking.canAttack = false
        
        let animation = AttackAnimation(attacking: attacking, defending: defending)
        animationPipeline.add(animation: animation)
    }
    
}
