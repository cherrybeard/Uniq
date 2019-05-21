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
    case battleStart, actions, actionsPaused, turnEnd, roundEnd
}

class Battle: SKNode {
    private let SPACE_BETWEEN_COLUMNS: Int = 113
    private let SPACE_BETWEEN_ROWS: Int = 90
    private let MELEE_RANGE_DISTANCE_FROM_CENTER: Int = 78
    
    let passButton = PassButton()
    var creatureSpots: [CreatureSpotSprite] = []
    var creatures: [CreatureSprite] = []
    
    let human = Player(as: .human)
    let ai = Player(as: .ai)
    var activePlayer: Player
    var state: BattleState = .battleStart
    var round: Int = 0
    
    private let _animationPipeline = AnimationPipeline()
    
    var isUnlocked: Bool {
        get { return (activePlayer.type == .human) && state == .actions }
    }
    
    override init() {
        activePlayer = human
        super.init()
        
        for index in 1...12 {
            let creatureSpot = CreatureSpotSprite(at: index, battle: self)
            creatureSpots.append(creatureSpot)
            let yPos = creatureSpot.owner!.type.rawValue * (MELEE_RANGE_DISTANCE_FROM_CENTER + creatureSpot.range.rawValue * SPACE_BETWEEN_ROWS)
            let xPos = creatureSpot.column.rawValue * SPACE_BETWEEN_COLUMNS
            creatureSpot.position = CGPoint(x: xPos, y: yPos)
            addChild(creatureSpot)
        }
        
        name = "desk"
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        _animationPipeline.update()
        if _animationPipeline.state == .finished {
            switch state {
            case .turnEnd:
                startTurn()
            case .battleStart:
                endRound()
            case .actions:
                state = .actions
            case .roundEnd:
                startTurn()
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
            aiTurn()
        }
    }
    
    func endTurn(passed: Bool = false) {
        state = .turnEnd
        if passed {
            activePlayer.passed = passed
            if activePlayer.type == .ai { passButton.readyToFight = true }
            if human.passed && ai.passed {
                endRound()
                return
            }
        } else {
            human.passed = false
            ai.passed = false
        }
        let message = activePlayer.type == .ai ? "Your turn" : "Enemy turn"
        _announce(message)
    }
    
    func endRound() {
        state = .roundEnd
        for creature in creatures {
            creature.decreaseAbilityCooldown()
            creature.isActionTaken = false
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
        let aiCreatures = creatures.filter { $0.owner!.type == .ai }
        let creaturesShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: aiCreatures)
        var pass: Bool = true
        for creature in creaturesShuffled {
            if let selectedCreature = creature as? CreatureSprite {
                if selectedCreature.useActiveAbility(battle: self) {
                    pass = false
                    break
                }
            }
        }
        endTurn(passed: pass)
    }
    
    func summon(_ creatureName: String, to creatureSpotIndex: Int) {    //TODO: Make all three functions make sense
        if let creature = CardLibrary.getCard(creatureName) as? CreatureCard {
            summon(creature, to: creatureSpotIndex)
        }
    }
    
    func summon(_ creature: CreatureCard, to creatureSpotIndex: Int) { // TODO: Return Bool
        let checkedIndex = CreatureSpotSprite.checkIndex(creatureSpotIndex)
        let creatureSpot = creatureSpots[checkedIndex-1]
        summon(creature, to: creatureSpot)
    }

    func summon(_ creature: CreatureCard, to creatureSpot: CreatureSpotSprite) { // TODO: Return Bool
        let creatureSprite = CreatureSprite(of: creature, spot: creatureSpot)
        creatureSprite.position = creatureSpot.position
        creatureSprite.zRotation = CGFloat.random(in: -3...3) / 180 * .pi
        creatureSpot.creature = creatureSprite
        addChild(creatureSprite)
        creatures.append(creatureSprite)
    }
    
    func play(_ creatureCard: CreatureCardSprite, to creatureSpot: CreatureSpotSprite) -> Bool {
        if !creatureSpot.isTaken {
            if let creature = creatureCard.card as? CreatureCard {
                setCardState(card: creatureCard, state: .discarded)
                summon(creature, to: creatureSpot)
                return true
            }
        }
        return false
    }
    
    func swap(_ sourceSpot: CreatureSpotSprite, with targetSpot: CreatureSpotSprite) {
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
    
    func setCardState(card: CardSprite, state: CardState) {
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
    
    func getSpot(of player: PlayerType, range: RangeType, column: ColumnType) -> CreatureSpotSprite {
        return creatureSpots.first(where: {
            ($0.owner!.type == player) && ($0.range == range) && ($0.column == column)
        })!
    }
    
    func getSpot(at index: Int) -> CreatureSpotSprite {
        let checkedIndex = CreatureSpotSprite.checkIndex(index)
        return creatureSpots.first(where: { $0.index == checkedIndex })!
    }
    
    func getNearbySpots(of spot: CreatureSpotSprite, sameOwner: Bool = true) -> [CreatureSpotSprite] {
        var nearbySpots: [CreatureSpotSprite] = []
        let index = spot.index
        var indexModifiers = [-3, 3]
        if index % 3 != 0 { indexModifiers.append(1) }
        if index % 3 != 1 { indexModifiers.append(-1) }
        for indexModifier in indexModifiers {
            let newIndex = index + indexModifier
            if (newIndex < 1) || (newIndex > 12) { continue }
            let nearbySpot = getSpot(at: newIndex)
            if !sameOwner || (nearbySpot.owner!.type == spot.owner!.type) {
                nearbySpots.append(nearbySpot)
            }
        }
        return nearbySpots
    }
    
    /*
    func attack(attacking: CharacterSprite, defending: CharacterSprite) {
        defending.applyDamage(attacking.attack, battle: self)
        attacking.applyDamage(defending.attack, battle: self)
        attacking.canAttack = false
        
        let animation = AttackAnimation(attacking: attacking, defending: defending)
        animationPipeline.add(animation: animation)
    }
 
    func setCreaturesAttack(owner: PlayerType, canAttack: Bool) {
        let ownerCreatures = creatures.filter({ creature in (creature.owner == owner) && (creature.attack > 0) })
        for creature in ownerCreatures {
            creature.canAttack = canAttack
        }
    }
    
    func markTargets(filter: CardTargetFilter = CardTargetFilters.all) {
        _ = creatures.map { creature in creature.isTarget = false }
        let filteredCreatures = creatures.filter(filter)
        _ = filteredCreatures.map { creature in
            creature.isTarget = true
        }
    }
    
    func removeDeadCreatures() {    // Change to removing certain creature
        for (i, creature) in creatures.enumerated().reversed() {
            if creature.destroyed {
                creatures.remove(at: i)
                creature.removeFromParent()
            }
        }
    }
    */
}
