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
    private let SPACE_BETWEEN_COLUMNS: Int = 113
    private let SPACE_BETWEEN_ROWS: Int = 90
    private let MELEE_RANGE_DISTANCE_FROM_CENTER: Int = 78
    
    let passButton = PassButton()
    var spots: [Spot] = []
    
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
        
        for index in 0...11 {
            let spot = Spot(at: index, battle: self)
            spots.append(spot)
            let yPos = spot.owner!.type.rawValue * (MELEE_RANGE_DISTANCE_FROM_CENTER + spot.range.rawValue * SPACE_BETWEEN_ROWS)
            let xPos = spot.column.rawValue * SPACE_BETWEEN_COLUMNS
            spot.position = CGPoint(x: xPos, y: yPos)
            addChild(spot)
        }
        
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
        // get next attacker
        let attackerSpot = _getNextAttackerSpot()
        if attackerSpot == nil {
            endRound()
            return
        }
        let attacker = attackerSpot?.creature
        attacker!.isActionTaken = true
        let targetSpot = _findTargetSpot(for: attackerSpot!)
        if targetSpot == nil {
            fight()
            return
        } else {
            state = .attack
            attack(attacker: attacker!, target: targetSpot!.creature!)
        }
    }
    
    func endRound() {
        state = .roundEnd
        for spot in spots {
            let creature = spot.creature
            if creature != nil {    // TODO: rework into creature?
                creature!.decreaseAbilityCooldown()
                creature!.isActionTaken = false
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
        let aiSpots = spots.filter { $0.owner!.isAi && $0.isTaken }
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
    
    func summon(_ creatureName: String, to index: Int) {    //TODO: Make all three functions make sense
        if let creature = CardLibrary.getCard(creatureName) as? CreatureCardBlueprint {
            let spot = spots[index]
            summon(creature, to: spot)        }
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
    
    func getSpot(of player: PlayerType, range: RangeType, column: ColumnType) -> Spot { // OBSOLETE
        return spots.first(where: {
            ($0.owner!.type == player) && ($0.range == range) && ($0.column == column)
        })!
    }
    
    func getNearbySpots(of spot: Spot, sameOwner: Bool = true) -> [Spot] {
        var nearbySpots: [Spot] = []
        let index = spot.index
        var indexModifiers = [-3, 3]
        if index % 3 != 2 { indexModifiers.append(1) }
        if index % 3 != 0 { indexModifiers.append(-1) }
        for indexModifier in indexModifiers {
            let newIndex = index + indexModifier
            if (newIndex < 0) || (newIndex > 11) { continue }
            let nearbySpot = spots[newIndex]
            if !sameOwner || (nearbySpot.owner == spot.owner) {
                nearbySpots.append(nearbySpot)
            }
        }
        return nearbySpots
    }
    
    func highlightActionTargets() {
        let activePlayerSpots = spots.filter { $0.owner == activePlayer }
        for spot in activePlayerSpots {
            let creature = spot.creature
            if creature != nil {
                creature!.isPosssibleToTap = !creature!.isActionTaken
            }
        }
        if activePlayer.isHuman {
            for card in human.deck.cards {
                card.isPosssibleToTap = true
            }
            passButton.isPosssibleToTap = true
        }
    }
    
    func removeActionTargets() {
        for spot in spots {
            spot.creature?.isPosssibleToTap = false
        }
        for card in human.deck.cards {
            card.isPosssibleToTap = false
        }
        passButton.isPosssibleToTap = false
    }
    
    func attack(attacker: Creature, target: Creature) {
        _animationPipeline.add( animation: AttackAnimation(attacker: attacker, target: target) )
    }
    
    private func _getNextAttackerSpot() -> Spot? {
        let aiOrder = [3, 0, 4, 1, 5, 2]
        let humanOrder = [6, 9, 7, 10, 8, 11]
        let attackOrder: [Int] = activePlayer.isHuman ? aiOrder + humanOrder : humanOrder + aiOrder
        for index in attackOrder {
            let attackerSpot = spots[index]
            let attacker = attackerSpot.creature
            if (attacker != nil) && !attacker!.isActionTaken && (attacker!.attack > 0) {
                return attackerSpot
            }
        }
        return nil
    }
    
    private func _findTargetSpot(for spot: Spot) -> Spot? {
        let sign = spot.owner!.isAi ? 1 : -1
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
