//
//  Battle.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class Battle: SKNode {
    private let SPACE_BETWEEN_COLUMNS: Int = 113
    private let SPACE_BETWEEN_ROWS: Int = 90
    private let MELEE_RANGE_DISTANCE_FROM_CENTER: Int = 78
    
    let human = Player(as: .human)
    let ai = Player(as: .ai)
    
    var creatureSpots: [CreatureSpotSprite] = []
    var creatures: [CreatureSprite] = []
    
    //let animationPipeline = AnimationPipeline() // TODO: work on it
    
    override init() {
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
    
    func summon(_ creature: CreatureCard, to creatureSpotIndex: Int) { // TODO: Move to Battle class
        let checkedIndex = CreatureSpotSprite.checkIndex(creatureSpotIndex)
        let creatureSpot = creatureSpots[checkedIndex-1]
        summon(creature, to: creatureSpot)
    }
    
    func summon(_ creature: CreatureCard, to creatureSpot: CreatureSpotSprite) {
        let creatureSprite = CreatureSprite(of: creature, owner: creatureSpot.owner!)
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
