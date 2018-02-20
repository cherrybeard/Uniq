//
//  GameScene.swift
//  Uniq
//
//  Created by Steven Gusev on 17/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var creatures: [CreatureSprite] = []
    var playerHand: [CardSprite] = []
    var attackingCreature: CreatureSprite? = nil
    var castingCreatureCard: CreatureCardSprite? = nil
    let gameLayer = SKNode()
    let creaturesLayer = SKNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(gameLayer)
        
        let creaturesLayerBorder = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: 240))
        creaturesLayerBorder.fillColor = UIColor(hue: 0, saturation: 0, brightness: 11.0/100.0, alpha: 1)
        creaturesLayerBorder.lineWidth = 0
        creaturesLayer.addChild(creaturesLayerBorder)
        creaturesLayer.name = "creatures-layer"
        gameLayer.addChild(creaturesLayer)
        
        drawCard()
        drawCard()
        
        let computerCreature = Creature(attack: 2, health: 3)
        summonCreature(creature: computerCreature, owner: OwnerType.computer)
    }
    
    func drawCard() {
        let creature = Creature(attack: 1, health: 2)
        let card = CreatureCard(cost: 1, creature: creature)
        let cardSprite = CreatureCardSprite(card: card)
        
        let screenBottom = -Int(UIScreen.main.bounds.size.height/2)
        cardSprite.position = CGPoint(x: 0, y: screenBottom + 40 + 45)
        
        gameLayer.addChild(cardSprite)
        playerHand.append(cardSprite)
        
        repositionCards()
    }
    
    func repositionCards() {
        let screenBottom = -Int(UIScreen.main.bounds.size.height/2)
        let yPos = screenBottom + 20 + 45
        let width = (50 + 20) / 2
        let duration:TimeInterval = 0.2
        var multiplier = playerHand.count-1
        
        for card in playerHand {
            let position = CGPoint(x: -(multiplier * width), y: yPos)
            let move = SKAction.move(to: position, duration: duration)
            move.timingMode = .easeOut
            card.run(move)
            multiplier -= 2
        }
    }
    
    func playCard(card: CreatureCardSprite, owner: OwnerType) {
        summonCreature(creature: card.creatureCard.creature, owner: OwnerType.player)
        card.discarded = true
        cleanPlayerHand()
    }
    
    func cleanPlayerHand() {
        for (i, card) in playerHand.enumerated().reversed() {
            if card.discarded {
                card.destroy()
                playerHand.remove(at: i)
            }
        }
        
        repositionCards()
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
    
    func summonCreature(creature: Creature, owner: OwnerType) {
        let creatureSprite = CreatureSprite(creature: Creature(creature: creature), owner: owner)
        let yPosSummoning = (owner == OwnerType.player) ? -55-90 : 65+90
        
        creatureSprite.position = CGPoint( x: 0, y: yPosSummoning )
        gameLayer.addChild(creatureSprite)
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
    
    func removeDeadCreatures() {
        for (i, creature) in creatures.enumerated().reversed() {
            if creature.creature.health <= 0 {
                creature.destroy()
                creatures.remove(at: i)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation)
            
            for node in touchedNodes {
                if node.name == "player-creature" {
                    attackingCreature = node as? CreatureSprite
                    break
                }
                if node.name == "player-creature-card" {
                    castingCreatureCard = node as? CreatureCardSprite
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation)
            
            if attackingCreature != nil {
                for node in touchedNodes {
                    if node.name == "computer-creature" {
                        let defendingCreature = node as? CreatureSprite
                        attack(attacking: attackingCreature!, defending: defendingCreature!)
                    }
                }
            }
            
            if castingCreatureCard != nil {
                for node in touchedNodes {
                    if node.name == "creatures-layer" {
                        playCard(card: castingCreatureCard!, owner: OwnerType.player)
                    }
                }
            }
            
            attackingCreature = nil
            castingCreatureCard = nil
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
