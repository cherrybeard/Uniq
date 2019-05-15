//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit
import GameplayKit

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
    var passedPlayers: [Player] = []
    
    //let animationPipeline = AnimationPipeline() // TODO: work on it
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func endTurn(passed: Bool = false) {
        if passed {
            activePlayer.passed = passed
        } else {
            human.passed = false
            ai.passed = false
        }
        if human.passed && ai.passed {
            endRound()
            return
        }
        if activePlayer.type == .ai {
            if activePlayer.passed { passButton.readyToFight = true }
            activePlayer = human
        } else {
            activePlayer = ai
            aiTurn()
        }
        
    }
    
    func endRound() {
        for creature in creatures {
            creature.decreaseAbilityCooldown()
        }
        passButton.readyToFight = false
        for player in [human, ai] {
            player.passed = false
            player.deck.draw()
        }
        if activePlayer.type == .ai {
            activePlayer = human
        } else {
            activePlayer = ai
            aiTurn()
        }
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
        addChild(creatureSprite)
        creatures.append(creatureSprite)
        creatureSpot.isTaken = true
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
    
    func setCardState(card: CardSprite, state: CardState) {
        card.state = state
        human.deck.hand.clean()
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
