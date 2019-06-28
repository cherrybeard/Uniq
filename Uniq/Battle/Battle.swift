//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class Battle: SKNode {
    let passButton = PassButton()
    var spots: Spots
    var interactives = Interactives()
    private let animationPipeline = AnimationPipeline()
    private let onSummon = BattleEvent()
    
    let human = Player(as: .human)  // TODO: can we make it static?
    let ai = Player(as: .ai)
    var activePlayer: Player {  // TODO: return nil if preparing ?
        willSet {
            human.isActive = false
            ai.isActive = false
            newValue.isActive = true
        }
    }
    var round: Int = 0
    var creatures: [Creature] = []
    
    var isUnlocked: Bool = false
    
    override init() {
        activePlayer = ai
        spots = Spots(human: human, ai: ai)
        super.init()
        
        addChild(spots)
        interactives.append(spots)
        // TODO: Rework addChild to custom function which adds sprite to interactives array if it is Interactive
        // spots passed tp it will be added to it. same with the hand
        for spot in spots { interactives.append(spot) }
        interactives.append(passButton)
        
        // battle init
        summon("Yletia Pirate", to: 7)
        summon("Yletia Pirate", to: 3)
        summon("Bandit", to: 5)
        summon("Thug", to: 4)
        
        for _ in 1...2 {
            _ = draw(for: human)
        }
        _ = addToHand(for: human, cardName: "Tome Of Intelligence")
        
        startTurn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let state = animationPipeline.update()
        isUnlocked = (state == .finished) || (state == .idle)
    }
    
    func startTurn() {
        activePlayer = activePlayer.isHuman ? ai : human
        let message = activePlayer.isHuman ? "Your turn" : "Enemy turn"
        animationPipeline.add(
            AnnouncerAnimation(battle: self, message: message)
        ) {
            self.giveControls()
        }
    }
    
    func giveControls() {
        if activePlayer.isAi {
            aiTurn()
        } else {
            highlightActionTargets()
        }
    }
    
    func endTurn(passed: Bool = false) {
        interactives.cleanAllStatus()
        if passed {
            activePlayer.passed = true
            if activePlayer.isAi { passButton.readyToFight = true }
            if human.passed && ai.passed {
                fight()
                return
            }
        } else {
            human.passed = false
            ai.passed = false
        }
        startTurn()
    }
    
    func fight() {
        if let attackerSpot = spots.nextAttacker(activePlayer: activePlayer.type) {
            if let attacker = attackerSpot.creature {
                setActionTakenState(of: attacker, toTaken: true)
                if let targetSpot = spots.target(for: attackerSpot) {
                    attack( from: attackerSpot, to: targetSpot )
                }
            }
            fight()
        } else {
            endRound()
        }
    }
    
    func endRound() {
        for spot in spots {
            if let creature = spot.creature {
                decreaseAbilityCooldown(of: creature)
                setActionTakenState(of: creature, toTaken: false)
            }
        }
        passButton.readyToFight = false
        for player in [human, ai] {
            player.passed = false
            _ = draw(for: player)
        }
        round += 1
        
        animationPipeline.add(
            AnnouncerAnimation(battle: self, message: "Round \(round)")
        )
        startTurn()
    }
    
    func aiTurn() {
        var pass: Bool = true
        for spot in spots.shuffledSpots(in: SpotsFilters.aiCreatures) {
            if useActiveAbility(of: spot.creature!) {
                pass = false
                break
            }
        }
        endTurn(passed: pass)
    }
    
    func draw(for player: Player) -> Card? {
        if let card = player.deck.draw() {
            interactives.append(card.sprite)
            animationPipeline.add([
                RepositionHandAnimation(hand: player.deck.hand, addCard: true),
                DrawCardAnimation(hand: player.deck.hand, card: card.sprite)
            ])
            return card
        }
        return nil
    }
    
    func addToHand(for player: Player, cardName: String) -> Card? {
        if let card = player.deck.addToHand(cardName) {
            interactives.append(card.sprite)
            
            animationPipeline.add([
                RepositionHandAnimation(hand: player.deck.hand, addCard: true),
                DrawCardAnimation(hand: player.deck.hand, card: card.sprite)
            ])
            return card
        }
        return nil
    }
    
    func play(_ card: Card, for player: Player, to spot: Spot? = nil) -> Bool {
        if card.requiresTarget && (spot == nil) { return false }
        
        card.state = .discarded
        card.sprite.isDiscarded = true
        interactives.removeAll {
            if let sprite = $0 as? CardSprite {
                return sprite.isDiscarded
            }
            return false
        }
        
        animationPipeline.add([
            DiscardCardAnimaiton(card: card.sprite),
            RepositionHandAnimation(hand: player.deck.hand)
        ])
        return card.play(battle: self, spot: spot)
    }
    
    func summon(_ creatureName: String, to index: Int) {
        if let card = CardLibrary.getCard(creatureName) as? CreatureCard {
            summon(card, to: spots[index])
        }
    }

    func summon(_ card: CreatureCard, to spot: Spot) { // TODO: Return Bool
        //place(blueprint, to: spot)
        
        let creature = Creature(of: card, at: spot)
        //spot.creature = creature
        creatures.append(creature)
        spot.creature = creature
        
        animationPipeline.add(
            SummonAnimation(creature.sprite, at: spot, battle: self)
        )
        
        if card.hasRush {
            setActionTakenState(of: creature, toTaken: false)
        }
        
//        for spot in spots {
//            if let creature = spot.creature {
//                print(creature.card.description)
//            }
//        }
//        if let _ = place(blueprint, to: spot) {
            /*
            onSummon.raise(battle: self, spot: spot)
            if let ability = creature.onSummon?.ability {
                onSummon.addHandler(ability)
            }
            _ = creature.card.whenSummoned?.ability(self, spot)*/
//        }
    }
    
    func place(_ blueprint: CreatureCard, to spot: Spot) {
        // create creature
//        let creature = Creature(of: blueprint, spot: spot)
//        spot.creature = creature
        // add animation to pipeline
        //animationPipeline.add(
        //    SummonAnimation(creature.sprite, at: spot)
        //)
        //return creature
    }
    
    func swap(_ sourceSpot: Spot, with targetSpot: Spot) {
        // Swap creatures
        let creature = sourceSpot.creature
        sourceSpot.creature = targetSpot.creature
        targetSpot.creature = creature
        
        sourceSpot.creature?.spot = sourceSpot
        targetSpot.creature?.spot = targetSpot
        
        if let primaryCreature = targetSpot.creature {
            // Disable primary creature actions for this turn
            setActionTakenState(of: primaryCreature, toTaken: true)
            
            // Animate movement
            if let secondaryCreature = sourceSpot.creature {
                animationPipeline.add(
                    SwapResponseAnimation( creature: secondaryCreature.sprite, spot: sourceSpot)
                )
            }
            
            animationPipeline.add(
                SwapAnimation( creature: primaryCreature.sprite, spot: targetSpot )
            )
        }
        
    }
    
    func setActionTakenState(of creature: Creature, toTaken: Bool) {
        creature.isActionTaken = toTaken
        animationPipeline.add(
            SetActionTakenStateAnimation(creature: creature.sprite, toTaken: toTaken)
        )
    }
    
    func attack(from attackerSpot: Spot, to targetSpot: Spot) {
        if let attacker = attackerSpot.creature {
            if let target = targetSpot.creature {
                let attackerSprite = attacker.sprite
                let targetSprite = target.sprite
                
                animationPipeline.add(
                    AttackAnimation( creature: attackerSprite, target: targetSprite )
                )
                dealDamage(attacker.attack, to: targetSpot)
                animationPipeline.add(
                    RetreatAnimation( creature: attackerSprite, spot: attackerSpot )
                )
            }
            
        }
    }
    
    func dealDamage(_ amount: Int, to spot: Spot) {
        if let creature = spot.creature {
            creature.dealDamage(amount)
            animationPipeline.add(
                DamageAnimation( creature: creature.sprite, amount: -amount )
            )
            if creature.isDead {
                kill(at: spot)
            }
        }
    }
    
    func dealDamage(_ amount: Int, to filter: SpotsFilter) {
        let targets = spots.filter(filter)
        var obituaries: [Spot] = []
        for spot in targets {
            if let creature = spot.creature {
                creature.dealDamage(amount)
                animationPipeline.add(
                    DamageAnimation( creature: creature.sprite, amount: -amount )
                )
                if creature.isDead {
                    obituaries.append(spot)
                }
            }
        }
        for spot in obituaries {
            kill(at: spot)
        }
    }
    
    func kill(at spot: Spot) {
        if let creature = spot.creature {
            spot.creature = nil
            animationPipeline.add( DeathAnimation(creature: creature.sprite) )
        }
    }
    
    func heal(_ amount: Int, to spot: Spot) {
        if let creature = spot.creature {
            let healed = creature.heal(amount)
             animationPipeline.add(
                 DamageAnimation( creature: creature.sprite, amount: healed )
             )
        }
    }
    
    func buffStat(_ stat: StatType, by amount: Int, at spot: Spot) {
        if let creature = spot.creature {
            _ = creature.increaseStat(stat: stat, by: amount)
            
            animationPipeline.add(
                BuffStatAnimation(
                    creature: creature.sprite,
                    stat: stat,
                    by: amount
                )
            )
        }
    }
    
    func replaceAbility(of creature: Creature, with ability: ActiveAbility) {
        creature.ability = ability
        animationPipeline.add(
            ReplaceAbilityAnimation(creature: creature.sprite, ability: ability)
        )
    }
    
    func useActiveAbility(of creature: Creature) -> Bool {
        if let ability = creature.ability {
            if !creature.isActionTaken && (ability.left == 0) {
                setActionTakenState(of: creature, toTaken: true)
                ability.left = ability.cooldown
                animationPipeline.add(
                    ResetCooldownAnimation(creature: creature.sprite)
                )
                return ability.effect(self, creature.spot)
            }
        }
        return false
    }
    
    func decreaseAbilityCooldown(of creature: Creature) {
        if let ability = creature.ability {
            if ability.left > 0 {
                ability.left -= 1
            }
        }
        animationPipeline.add(
            DecreaseCooldownAnimation(creature: creature.sprite)
        )
    }
    
    func wait(for delay: TimeInterval) {
        animationPipeline.add(
            WaitAnimation(battle: self, delay: delay)
        )
    }
    
    func highlightActionTargets() {
        let activePlayerSpots = spots.filter { $0.owner == activePlayer }
        for spot in activePlayerSpots {
            if let creature = spot.creature {
                if !creature.isActionTaken {
                    spot.status.insert(.interactive)
                    if creature.ability?.left == 0 {
                        spot.status.insert(.activatable)
                    }
                }
            }
        }
        if activePlayer.isHuman {
            for card in human.deck.handPile {
                let sprite = card.sprite
                if card.requiresTarget {
                    let targets = interactives.filter(sprite.targetsFilter)
                    if targets.count <= 0 { continue }
                }
                sprite.status.insert(.interactive)
            }
            passButton.status.insert(.interactive)
        }
    }
    
}
