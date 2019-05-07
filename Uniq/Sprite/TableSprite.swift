//
//  TableSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class TableSprite: SKNode {     // TODO: Combine with Battle class
    private let SPACE_BETWEEN_COLUMNS: Int = 113
    private let SPACE_BETWEEN_ROWS: Int = 90
    private let MELEE_RANGE_DISTANCE_FROM_CENTER: Int = 78
    
    var creatureSpots: [CreatureSpotSprite] = []
    var creatures: [CharacterSprite] = []
    var playerHero = HeroSprite(health: 30)
    
    private let creatureHalfVolume = (50 + 20) / 2          // OBSOLETE
    private let creaturesYPosition: [OwnerType: Int] = [    // OBSOLETE
        .player: -55,
        .computer: 65
    ]
    
    
    override init() {
        super.init()
        
        creatures.append(playerHero)
        
        let border = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: 240))
        //border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 11.0/100.0, alpha: 1)
        border.lineWidth = 0
        addChild(border)
        
        for index in 1...12 {
            let creatureSpot = CreatureSpotSprite(index: index)
            creatureSpots.append(creatureSpot)
            //print(creatureSpot.column, creatureSpot.range, creatureSpot.owner)
            let yPos = creatureSpot.owner.rawValue * (MELEE_RANGE_DISTANCE_FROM_CENTER + creatureSpot.range.rawValue * SPACE_BETWEEN_ROWS)
            let xPos = creatureSpot.column.rawValue * SPACE_BETWEEN_COLUMNS
            creatureSpot.position = CGPoint(x: xPos, y: yPos)
            addChild(creatureSpot)
        }
        
        name = "desk"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func summon(_ creature: CreatureSprite) {       // OBSOLETE
        let yShift = creature.owner == .computer ? 90 : -90
        let yPos = creaturesYPosition[creature.owner]! + yShift
        creature.position = CGPoint( x: 0, y: yPos )
        addChild(creature)
        creatures.append(creature)
    }
    
    func summon(_ creature: CreatureCard, to creatureSpotIndex: Int) { // TODO: Move to Battle class
        let checkedIndex = CreatureSpotSprite.checkIndex(creatureSpotIndex)
        let creatureSpot = creatureSpots[checkedIndex-1]
        summon(creature, to: creatureSpot)
    }
    
    func summon(_ creature: CreatureCard, to creatureSpot: CreatureSpotSprite) {
        let creatureSprite = CreatureSprite(creature: creature, owner: creatureSpot.owner)
        creatureSprite.position = creatureSpot.position
        addChild(creatureSprite)
        creatures.append(creatureSprite)
        creatureSpot.isTaken = true
    }
    
    func setCreaturesAttack(owner: OwnerType, canAttack: Bool) {
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
}
