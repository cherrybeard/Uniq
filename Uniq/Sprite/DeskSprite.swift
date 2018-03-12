//
//  Battleground.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class DeskSprite: SKNode {
    var creatures: [CharacterSprite] = []
    var playerHero = HeroSprite(health: 30)
    
    private let creatureHalfVolume = (50 + 20) / 2
    private let creaturesYPosition: [OwnerType: Int] = [
        .player: -55,
        .computer: 65
    ]
    
    override init() {
        super.init()
        
        creatures.append(playerHero)
        
        let border = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: 240))
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 11.0/100.0, alpha: 1)
        border.lineWidth = 0
        addChild(border)
        
        name = "desk"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func summon(_ creature: CreatureSprite) {
        let yShift = creature.owner == .computer ? 90 : -90
        let yPos = creaturesYPosition[creature.owner]! + yShift
        creature.position = CGPoint( x: 0, y: yPos )
        addChild(creature)
        creatures.append(creature)
        repositionCreatures(owner: creature.owner)
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
    
    private func repositionCreatures(owner: OwnerType) {
        let ownerCreatures = creatures.filter({ creature in (creature.owner == owner) && (creature is CreatureSprite) })
        
        let duration: TimeInterval = 0.2
        var multiplier = ownerCreatures.count-1
        
        for creature in ownerCreatures {
            let position = CGPoint(x: -(multiplier * creatureHalfVolume), y: creaturesYPosition[creature.owner]!)
            let move = SKAction.move(to: position, duration: duration)
            move.timingMode = .easeOut
            creature.run(move)
            multiplier -= 2
        }
    }
    
    func removeDeadCreatures() {
        for (i, creature) in creatures.enumerated().reversed() {
            if creature.destroyed {
                creatures.remove(at: i)
                creature.removeFromParent()
            }
        }
        
        repositionCreatures(owner: .computer)
        repositionCreatures(owner: .player)
    }
}
