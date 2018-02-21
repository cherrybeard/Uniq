//
//  Battleground.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import GameplayKit
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
        if !attacking.canAttack { return }
        
        let initPos = attacking.position
        let defPos = defending.position
        let targetX = Int( (defPos.x - initPos.x) / 2 + initPos.x )
        let targetY = Int( (defPos.y - initPos.y) / 2 + initPos.y )
        let targetPos = CGPoint(x: targetX, y: targetY)
        
        let duration:TimeInterval = 0.2
        
        let moveTo = SKAction.move(to: targetPos, duration: duration)
        moveTo.timingMode = .easeOut
        
        let moveBack = SKAction.move(to: initPos, duration: duration)
        moveBack.timingMode = .easeOut
        
        attacking.canAttack = false
        attacking.run(moveTo, completion: {
            defending.applyDamage(damage: attacking.creature.attack)
            attacking.applyDamage(damage: defending.creature.attack)
            
            attacking.run(moveBack, completion: {
                self.removeDeadCreatures()
                self.repositionCreatures(owner: OwnerType.player)
                self.repositionCreatures(owner: OwnerType.computer)
                
                if attacking.owner == OwnerType.computer { self.computerAttacks() }
            })
        })
    }
    
    func computerAttacks() {
        let creatures = creaturesOf(owner: OwnerType.computer, canAttack: true)
        if creatures.count == 0 { return }
        
        let playerCreatures = creaturesOf(owner: OwnerType.player)
        if playerCreatures.count == 0 { return }
        
        let creaturesShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: creatures)
        let playerCreaturesShffled =  GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: playerCreatures)
        
        let creature = creaturesShuffled[0] as! CreatureSprite
        let playerCreature = playerCreaturesShffled[0] as! CreatureSprite
        
        attack(attacking: creature, defending: playerCreature)
    }
    
    func repositionCreatures(owner: OwnerType) {
        let yPos = (owner == OwnerType.player) ? -55 : 65
        let ownerCreatures = creaturesOf(owner: owner)
        
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
    
    func creaturesOf(owner: OwnerType) -> [CreatureSprite] {
        return creatures.filter { (creature) -> Bool in
            creature.owner == owner
        }
    }
    
    func creaturesOf(owner: OwnerType, canAttack: Bool) -> [CreatureSprite] {
        return creatures.filter { (creature) -> Bool in
            (creature.owner == owner) && (creature.canAttack == canAttack)
        }
    }
    
    func allowCreaturesAttack(owner: OwnerType) {
        for creature in creaturesOf(owner: owner) {
            creature.canAttack = true
        }
    }
    
    func disableCreaturesAttack(owner: OwnerType) {
        for creature in creaturesOf(owner: owner) {
            creature.canAttack = false
        }
    }
    
}
