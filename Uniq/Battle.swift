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
    let desk = TableSprite()
    let animationPipeline = AnimationPipeline()
    
    var state: TurnState = .playerTurn      // TODO: split it into currentPlayer: OwnerType and state
    
    func summon(_ creature: CreatureSprite) { // OBSOLETE
        desk.summon(creature)
        if creature.creature.charge {
            creature.canAttack = true
        }
        creature.battlecry(battle: self)
    }
    
    func play(cardSprite: CardSprite, target: CreatureSprite? = nil) {  // OBSOLETE
        let cost = cardSprite.card.cost
        if player.mana.use(amount: cost) {
            cardSprite.card.play(battle: self, for: .player, target: target)
            cardSprite.state = .discarded
            player.deck.hand.clean()
            player.highlightCards()
        }
    }
    
    func play(_ creatureCard: CreatureCardSprite, to creatureSpot: CreatureSpotSprite) -> Bool {
        if !creatureSpot.isTaken {
            if let creature = creatureCard.card as? CreatureCard {
                if player.mana.use(amount: creature.cost) {
                    setCardState(card: creatureCard, state: .discarded)
                    desk.summon(creature, to: creatureSpot)
                }
            }
        }
        return false
    }
    
    func attack(attacking: CharacterSprite, defending: CharacterSprite) {
        defending.applyDamage(attacking.attack, battle: self)
        attacking.applyDamage(defending.attack, battle: self)
        attacking.canAttack = false
        
        let animation = AttackAnimation(attacking: attacking, defending: defending)
        animationPipeline.add(animation: animation)
    }
    
    func setCardState(card: CardSprite, state: CardState) {
        card.state = state
        player.deck.hand.clean()
        player.highlightCards()
    }
    
}
