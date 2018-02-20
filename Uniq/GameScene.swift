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
    let gameLayer = SKNode()
    let battleground = Battleground()
    let deck = Deck()
    let playerHand = PlayerHand()
    let manaCounter = ManaCounter(mana: 1)
    
    var attackingCreature: CreatureSprite? = nil
    var castingCreatureCard: CreatureCardSprite? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(gameLayer)
        gameLayer.addChild(battleground)
        
        let screenBottom = -Int(UIScreen.main.bounds.size.height/2)
        let screenLeft = -Int(UIScreen.main.bounds.size.width/2)
        
        manaCounter.position = CGPoint(x: screenLeft + 40, y: screenBottom + 160)
        gameLayer.addChild(manaCounter)
        
        playerHand.position = CGPoint(x: 0, y: screenBottom + 45 + 20)
        gameLayer.addChild(playerHand)
        
        for _ in 1...5 {
            playerHand.draw(card: deck.draw())
        }
        
        let computerCreature = Creature(attack: 2, health: 3)
        battleground.summon(creature: computerCreature, owner: OwnerType.computer)
    }
    
    func playCard(card: CreatureCardSprite) {
        let cost = card.creatureCard.cost
        if manaCounter.useMana(amount: cost) {
            battleground.summon(creature: card.creatureCard.creature, owner: OwnerType.player)
            card.discarded = true
            playerHand.clean()
        }
    }
    
    func endTurn() {
        manaCounter.addMana(amount: 1)
        playerHand.draw(card: deck.draw())
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
                        battleground.attack(attacking: attackingCreature!, defending: defendingCreature!)
                    }
                }
            }
            
            if castingCreatureCard != nil {
                for node in touchedNodes {
                    if node.name == "creatures-layer" {
                        playCard(card: castingCreatureCard!)
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
