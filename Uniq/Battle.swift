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
    var spots: Spots
    var interactives: [Interactive] = []
    
    let human = Player(as: .human)  // TODO: can we make it static?
    let ai = Player(as: .ai)
    var activePlayer: Player {
        willSet {
            human.isActive = false
            ai.isActive = false
            newValue.isActive = true
        }
    }
    var state: BattleState = .battleStart
    var round: Int = 0
    
    private let _animationPipeline = AnimationPipeline()
    
    var isUnlocked: Bool {
        get { return activePlayer.isHuman && state == .actions }
    }
    
    override init() {
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
        
        summon("Yletia Pirate", to: 6)
        summon("Yletia Pirate", to: 2)
        summon("Bandit", to: 4)
        summon("Thug", to: 3)
        
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
        cleanInteractivesStatus()
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
                    attack(
                        attackerSpot: attackerSpot,
                        targetSpot: targetSpot
                    )
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
            if let card = player.deck.draw() {
                interactives.append(card)
            }
        }
        round += 1
        _announce("Round \(round)")
    }
    
    func aiTurn() {
        let aiSpots = spots.filter { $0.owner.isAi && $0.isTaken }
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
        let activePlayerSpots = spots.filter { $0.owner == activePlayer }
        for spot in activePlayerSpots {
            if let creature = spot.creature {
                if !creature.isActionTaken {
                    spot.status.insert(.interactive)
                    if creature.activeAbilityCooldown == 0 {
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
    
    func attack(attackerSpot: Spot, targetSpot: Spot) {
        _animationPipeline.add(
            animation: AttackAnimation(
                attackerSpot: attackerSpot,
                targetSpot: targetSpot
            )
        )
    }
}
