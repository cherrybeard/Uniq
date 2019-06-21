//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BattleState {
    case preparing, turnStart, turn, turnEnd, roundEnd
}

class Battle: SKNode {
    let passButton = PassButton()
    var spots: Spots
    var interactives: [Interactive] = []
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
    var state: BattleState = .preparing
    var round: Int = 0
    var creatures: [Creature] = []
    
    var isUnlocked: Bool {  // TODO: Rework into settable variable
        get { return activePlayer.isHuman && state == .turn }
    }
    
    override init() {
        state = .preparing
        activePlayer = human
        spots = Spots(human: human, ai: ai)
        super.init()
        addChild(spots)
        
        // TODO: Rework addChild to custom function which adds sprite to interactives array if it is Interactive
        // spots passed tp it will be added to it. same with the hand
        for spot in spots { interactives.append(spot) }
        
        for _ in 1...4 {
            if let card = human.deck.draw() {
                interactives.append(card)
            }
        }
        interactives.append(passButton)
        
        // battle init
        summon("Yletia Pirate", to: 6)
        summon("Yletia Pirate", to: 2)
        summon("Bandit", to: 4)
        summon("Thug", to: 3)
        
        startTurn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let animationState = animationPipeline.update()
        if animationState == .finished {
            switch state {
            case .preparing:
                break
            case .turnStart:
                break
            case .turn:
                break
            case .turnEnd:
                break
            case .roundEnd:
                break
            }
        }
    }
    
    func startTurn() {
        state = .turnStart
        let message = activePlayer.isHuman ? "Your turn" : "Enemy turn"
        animationPipeline.add(
            AnnouncerAnimation(battle: self, message: message)
        ) {
            self.giveControls()
        }
    }
    
    func giveControls() {
        highlightActionTargets()
        state = .turn
        if activePlayer.isAi { aiTurn() }
    }
    
    func endTurn(passed: Bool = false) {
        state = .turnEnd
        cleanInteractivesStatus()
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
        activePlayer = activePlayer.isAi ? human : ai
        startTurn()
    }
    
    func fight() {
        if let attackerSpot = spots.nextAttacker(activePlayer: activePlayer.type) {
            if let attacker = attackerSpot.creature {
                attacker.isActionTaken = true
                if let targetSpot = spots.target(for: attackerSpot) {
                    attack(
                        attackerSpot: attackerSpot,
                        targetSpot: targetSpot
                    )
                } else {
                    fight()
                    return
                }
            }
        }
        endRound()
    }
    
    func endRound() {
        state = .roundEnd
        for spot in spots {
            if let creature = spot.creature {
                decreaseAbilityCooldown(of: creature)
                creature.isActionTaken = false
            }
        }
        passButton.readyToFight = false
        for player in [human, ai] {
            player.passed = false
            if let card = player.deck.draw() {
                interactives.append(card)
            }
        }
        round += 1
        
        animationPipeline.add(
            AnnouncerAnimation(battle: self, message: "Round \(round)")
        )
        startTurn()
    }
    
    func aiTurn() {
        let aiSpots = spots.filter { $0.owner.isAi && $0.isTaken }
        let aiSpotsShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: aiSpots)
        var pass: Bool = true
        for spot in aiSpotsShuffled {
            if let selectedSpot = spot as? Spot {
                let creature = selectedSpot.creature
                /*
                if creature!.useActiveAbility(battle: self) {
                    pass = false
                    break
                }
                */
            }
        }
        endTurn(passed: pass)
    }
    
    func play(_ card: Card, to spot: Spot?) -> Bool {
        if card.blueprint.requiresTarget && (spot == nil) { return false }
        setCardState(card: card, state: .discarded)
        return card.blueprint.play(battle: self, spot: spot)
    }
    
    func summon(_ creatureName: String, to index: Int) {
        if let blueprint = CardLibrary.getCard(creatureName) as? CreatureCardBlueprint {
            summon(blueprint, to: spots[index])
        }
    }

    func summon(_ blueprint: CreatureCardBlueprint, to spot: Spot) { // TODO: Return Bool
        //place(blueprint, to: spot)
        
        let creature = Creature(of: blueprint, at: spot)
        //spot.creature = creature
        creatures.append(creature)
        spot.creature = creature
        
        animationPipeline.add(
            SummonAnimation(creature.sprite, at: spot, battle: self)
        )
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
    
    func place(_ blueprint: CreatureCardBlueprint, to spot: Spot) {
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
        
        if let primaryCreature = targetSpot.creature {
            // Disable primary creature actions for this turn
            primaryCreature.isActionTaken = true
            
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
    
    func attack(attackerSpot: Spot, targetSpot: Spot) {
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
            let sprite = creature.sprite
            creature.dealDamage(amount)
            animationPipeline.add(
                DamageAnimation( creature: sprite, amount: amount )
            )
            if creature.isDead {
                animationPipeline.add( DeathAnimation(creature: sprite) )
            }
        }
    }
    
    func heal(_ amount: Int, to spot: Spot) {
        if let creature = spot.creature {
            creature.heal(amount)
            /*
             animationPipeline.add(
                 animation: HealAnimation(
                     creature: creature.sprite,
                     amount: amount
                 )
             )
             */
        }
    }
    
    func useActiveAbility(of creature: Creature) -> Bool {
        if let ability = creature.ability {
            if ability.left == 0 {
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
            CooldownDecreaseAnimation(creature: creature.sprite)
        )
    }
    
    func setCardState(card: Card, state: CardState) {
        card.state = state
        human.deck.hand.clean()
    }
    
    func highlightActionTargets() {
        let activePlayerSpots = spots.filter { $0.owner == activePlayer }
        for spot in activePlayerSpots {
            if let creature = spot.creature {
                if !creature.isActionTaken {
                    spot.status.insert(.interactive)
                    if creature.ability?.cooldown == 0 {
                        spot.status.insert(.activatable)
                    }
                }
            }
        }
        if activePlayer.isHuman {
            for card in human.deck.cards {  // TODO: .hand  ?
                card.status.insert(.interactive)
            }
            passButton.status.insert(.interactive)
        }
    }
    
    func addInteractivesStatus(status: InteractiveStatus, filter: (Interactive) -> Bool) {
        let targets = interactives.filter(filter)
        for var target in targets {
            target.status.insert(status)
        }
    }
    
    func removeInteractivesStatus(status: InteractiveStatus) {
        for var target in interactives {
            target.status.remove(status)
        }
    }
    
    func cleanInteractivesStatus() {
        for var interactive in interactives {
            interactive.status = []
        }
    }
    
}
