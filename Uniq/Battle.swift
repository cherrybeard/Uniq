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
    case battleStart, actions, actionsPaused, turnEnd, roundEnd, fight, attack
}

class Battle: SKNode {
    let passButton = PassButton()
    var spots = Spots()
    
    let human = Player(as: .human)
    let ai = Player(as: .ai)
    var activePlayer: Player
    var state: BattleState = .battleStart
    var round: Int = 0
    
    private let _animationPipeline = AnimationPipeline()
    
    var isUnlocked: Bool {
        get { return activePlayer.isHuman && state == .actions }
    }
    
    override init() {
        activePlayer = human
        super.init()
        addChild(spots)
        name = "desk"
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let animationState = _animationPipeline.update()
        if animationState == .finished {
            switch state {
            case .turnEnd:
                startTurn()
            case .battleStart:
                endRound()
            case .actions:
                break
            case .roundEnd:
                startTurn()
            case .attack:
                fight()
            case .fight:
                break
            case .actionsPaused:
                state = .actions
            }
        }
    }
    
    func startTurn() {
        state = .actions
        switch activePlayer.type {
        case .ai:
            activePlayer = human
        case .human:
            activePlayer = ai
        }
        highlightActionTargets()
        if activePlayer.isAi { aiTurn() }
    }
    
    func endTurn(passed: Bool = false) {
        state = .turnEnd
        removeActionTargets()
        if passed {
            activePlayer.passed = passed
            if activePlayer.isAi { passButton.readyToFight = true }
            if human.passed && ai.passed {
                fight()
                return
            }
        } else {
            human.passed = false
            ai.passed = false
        }
        let message = activePlayer.isAi ? "Your turn" : "Enemy turn"
        _announce(message)
    }
    
    func fight() {
        state = .fight
        if let attackerSpot = spots.nextAttacker(activePlayer: activePlayer.type) {
            if let attacker = attackerSpot.creature {
                attacker.isActionTaken = true
                if let targetSpot = spots.target(for: attackerSpot) {
                    state = .attack
                    attack(attacker: attacker, target: targetSpot.creature!)
                } else {
                    fight()
                }
            }
        } else {
            endRound()
        }
    }
    
    func endRound() {
        state = .roundEnd
        for spot in spots {
            if let creature = spot.creature {
                creature.decreaseAbilityCooldown()
                creature.isActionTaken = false
            }
        }
        passButton.readyToFight = false
        for player in [human, ai] {
            player.passed = false
            player.deck.draw()
        }
        round += 1
        _announce("Round \(round)")
    }
    
    func aiTurn() {
        let aiSpots = spots.filter { $0.owner == .ai && $0.isTaken }
        let aiSpotsShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: aiSpots)
        var pass: Bool = true
        for spot in aiSpotsShuffled {
            if let selectedSpot = spot as? Spot {
                let creature = selectedSpot.creature
                if creature!.useActiveAbility(battle: self) {
                    pass = false
                    break
                }
            }
        }
        endTurn(passed: pass)
    }
    
    func summon(_ creatureName: String, to index: Int) {
        if let creature = CardLibrary.getCard(creatureName) as? CreatureCardBlueprint {
            summon(creature, to: spots[index])
        }
    }

    func summon(_ creature: CreatureCardBlueprint, to spot: Spot) { // TODO: Return Bool
        let creatureSprite = Creature(of: creature, spot: spot)
        creatureSprite.position = spot.position
        creatureSprite.zRotation = CGFloat.random(in: -3...3) / 180 * .pi
        spot.creature = creatureSprite
        addChild(creatureSprite)
    }
    
    func play(_ creatureCard: CreatureCard, to spot: Spot) -> Bool {
        if !spot.isTaken {
            if let creature = creatureCard.blueprint as? CreatureCardBlueprint {
                setCardState(card: creatureCard, state: .discarded)
                summon(creature, to: spot)
                return true
            }
        }
        return false
    }
    
    func swap(_ sourceSpot: Spot, with targetSpot: Spot) {
        state = .actionsPaused
        
        // Swapping creatures and disabling actions for this turn
        let movingCreature = sourceSpot.creature
        sourceSpot.creature = targetSpot.creature
        targetSpot.creature = movingCreature
        targetSpot.creature?.spot = targetSpot
        sourceSpot.creature?.spot = sourceSpot
        targetSpot.creature?.isActionTaken = true
        
        // Animating movement
        _animationPipeline.add(
            animation: CreatureSwapAnimation(
                sourceSpot: sourceSpot,
                targetSpot: targetSpot
            )
        )
    }
    
    func setCardState(card: Card, state: CardState) {
        card.state = state
        human.deck.hand.clean()
    }
    
    private func _announce(_ message: String) {
        let announcer = TurnAnnouncerSprite()
        announcer.message = message
        announcer.position = CGPoint(x: 0, y: -6)
        announcer.alpha = 0
        addChild(announcer)
        _animationPipeline.add(animation: AnnouncerAnimation(announcer: announcer))
    }
    
    func highlightActionTargets() {
        let activePlayerSpots = spots.filter { $0.owner == activePlayer.type }
        for spot in activePlayerSpots {
            let creature = spot.creature
            if creature != nil {
                creature!.isPosssibleToTap = !creature!.isActionTaken
            }
        }
        if activePlayer.isHuman {
            for card in human.deck.cards {  // TODO: .hand  ?
                card.isPosssibleToTap = true
            }
            passButton.isPosssibleToTap = true
        }
    }
    
    func removeActionTargets() {
        for spot in spots {
            spot.creature?.isPosssibleToTap = false
        }
        for card in human.deck.cards {  // TODO: .hand  ?
            card.isPosssibleToTap = false
        }
        passButton.isPosssibleToTap = false
    }
    
    func attack(attacker: Creature, target: Creature) {
        _animationPipeline.add( animation: AttackAnimation(attacker: attacker, target: target) )
    }
    
    private func _findTargetSpot(for spot: Spot) -> Spot? { // OBSOLETE
        let sign = spot.owner == .ai ? 1 : -1
        let attackerIndex = spot.index
        for i in [3, 6, 9] {
            let targetIndex = attackerIndex + i * sign
            if (targetIndex < 0) || (targetIndex > 11) { continue }
            let targetSpot = spots[targetIndex]
            if (targetSpot.creature != nil) && (targetSpot.owner != spot.owner) && (targetSpot.creature!.health > 0) {
                return targetSpot
            }
        }
        return nil
    }
}
