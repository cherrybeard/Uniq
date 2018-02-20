//
//  Battleground.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class Battleground: SKNode {
    var creatures: [CreatureSprite] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        let border = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: 240))
        border.fillColor = UIColor(hue: 0, saturation: 0, brightness: 11.0/100.0, alpha: 1)
        border.lineWidth = 0
        addChild(border)
        
        name = "creatures-layer"
    }
    
    func summon(creature: Creature, owner: OwnerType) {
        let creatureSprite = CreatureSprite(creature: Creature(creature: creature), owner: owner)
        let yPosSummoning = (owner == OwnerType.player) ? -55-90 : 65+90
        
        creatureSprite.position = CGPoint( x: 0, y: yPosSummoning )
        addChild(creatureSprite)
        creatures.append(creatureSprite)
        
        repositionCreatures(owner: owner)
    }
    
    func attack(attacking: CreatureSprite, defending: CreatureSprite) {
        defending.applyDamage(damage: attacking.creature.attack)
        attacking.applyDamage(damage: defending.creature.attack)
        removeDeadCreatures()
        repositionCreatures(owner: OwnerType.player)
        repositionCreatures(owner: OwnerType.computer)
    }
    
    func repositionCreatures(owner: OwnerType) {
        let yPos = (owner == OwnerType.player) ? -55 : 65
        let ownerCreatures = creatures.filter { (creature) -> Bool in
            creature.owner == owner
        }
        
        let width = (50 + 20) / 2
        let duration:TimeInterval = 0.2
        var multiplier = ownerCreatures.count-1
        
        for ownerCreature in ownerCreatures {
            let position = CGPoint(x: -(multiplier * width), y: yPos)
            let move = SKAction.move(to: position, duration: duration)
            move.timingMode = .easeOut
            ownerCreature.run(move)
            multiplier -= 2
        }
    }
    
    func removeDeadCreatures() {
        for (i, creature) in creatures.enumerated().reversed() {
            if creature.creature.health <= 0 {
                creature.destroy()
                creatures.remove(at: i)
            }
        }
    }
    
}
