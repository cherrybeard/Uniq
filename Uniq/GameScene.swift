//
//  GameScene.swift
//  Uniq
//
//  Created by Steven Gusev on 17/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit
import GameplayKit

enum TurnState: Int {
    case preparing = 0, playerTurn, playerEnd, computerTurn, computerEnd
}

enum PlayerActionType: Int {
    case rest = 0, attack, summon, spell, endTurn
}

enum PlayerActionTargetType: String {
    case all = "creatures-layer"
    case creature = "computer-creature"
}

class GameScene: SKScene {
    let gameLayer = SKNode()
    let battleground = Battleground()
    let deck = Deck()
    let playerHand = PlayerHand()
    let manaCounter = ManaCounter(mana: 5)
    let animationPipeline = AnimationPipeline()
    
    var state: TurnState = .playerTurn
    var playerAction: PlayerActionType = .rest
    var playerActionSubject: Any? = nil
    var playerActionTarget: PlayerActionTargetType? = nil
    
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
        playerHand.markPlayable(mana: manaCounter.mana)
        
        for _ in 1...3 {
            battleground.summon(creature: Creature(attack: 1, health: 12), owner: OwnerType.computer)
        }
    }
    
    func playCard(card: CardSprite, target: CreatureSprite?) {
        let cost = card.card.cost
        if manaCounter.use(amount: cost) {
            if card is CreatureCardSprite {
                let creature = (card as! CreatureCardSprite).creatureCard.creature
                battleground.summon(creature: creature, owner: .player)
            } else if card is SpellCardSprite {
                let damage = (card as! SpellCardSprite).spellCard.spell.amount
                var targets: [CreatureSprite]
                if target != nil {
                    targets = [target!]
                } else {
                    targets = battleground.creaturesOf(owner: .computer, alive: true)
                }
                spellDamage(amount: damage, targets: targets)
            }
            card.card.state = .discarded
            playerHand.clean()
            playerHand.markPlayable(mana: manaCounter.mana)
        }
    }
    
    func makeComputerMove() {
        let creatures = battleground.creaturesOf(owner: OwnerType.computer, canAttack: true)
        if creatures.count > 0 {
            let creaturesShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: creatures)
            
            for creature in creaturesShuffled {
                let playerCreatures = battleground.creaturesOf(owner: OwnerType.player, alive: true)
                if playerCreatures.count == 0 { break }
                let playerCreaturesShffled =  GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: playerCreatures)
                let playerCreature = playerCreaturesShffled[0] as! CreatureSprite
                
                attack(attacking: creature as! CreatureSprite, defending: playerCreature)
            }
        }
        state = .computerEnd
    }
    
    func attack(attacking: CreatureSprite, defending: CreatureSprite) {
        defending.applyDamage(damage: attacking.creature.attack)
        attacking.applyDamage(damage: defending.creature.attack)
        attacking.canAttack = false
        
        let animation = AttackAnimation(attacking: attacking, defending: defending)
        animationPipeline.add(animation: animation)
    }
    
    func spellDamage(amount: Int, targets: [CreatureSprite]) {
        for target in targets {
            target.applyDamage(damage: amount)
            target.showDamage(damage: amount)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if state == .playerTurn {
                let touchLocation = touch.location(in: self)
                let touchedNodes = self.nodes(at: touchLocation)
                
                for node in touchedNodes {
                    if node.name == "player-creature" {
                        let creature = node as? CreatureSprite
                        if (creature?.canAttack)! {
                            playerAction = .attack
                            playerActionSubject = creature
                            break
                        }
                    }
                    if node.name == "player-creature-card" {
                        playerAction = .summon
                        playerActionSubject = node as? CreatureCardSprite
                        break
                    }
                    if node.name == "player-spell-card" {
                        playerAction = .spell
                        let card = node as? SpellCardSprite
                        playerActionSubject = card
                        let target = card?.spellCard.spell.target
                        if (target == .all) || (target == .allEnemyCreatures) {
                            playerActionTarget = .all
                        } else {
                            playerActionTarget = .creature
                        }
                        break
                    }
                    if node.name == "end-turn" {
                        playerAction = .endTurn
                        break
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation)
            
            if state == .playerTurn {
                for node in touchedNodes {
                    if (playerAction == .attack) && (node.name == "computer-creature") {
                        let defendingCreature = node as? CreatureSprite
                        attack(attacking: playerActionSubject as! CreatureSprite, defending: defendingCreature!)
                    }
                    if (playerAction == .summon) && (node.name == "creatures-layer") {
                        playCard(card: playerActionSubject as! CreatureCardSprite, target: nil)
                    }
                    if (playerAction == .spell) && (playerActionTarget?.rawValue == node.name) {
                        if (playerActionTarget == .all) {
                            playCard(card: playerActionSubject as! SpellCardSprite, target: nil)
                        } else {
                            let targetCreature = node as? CreatureSprite
                            playCard(card: playerActionSubject as! SpellCardSprite, target: targetCreature!)
                        }
                    }
                    if (playerAction == .endTurn) && (node.name == "end-turn") {
                        state = .playerEnd
                    }
                }
                playerAction = .rest
                playerActionSubject = nil
                playerActionTarget = nil
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        animationPipeline.update()
        if (animationPipeline.state == AnimationState.finished) {
            battleground.removeDeadCreatures()
            if (state == .computerEnd) {
                state = .playerTurn
                manaCounter.increaseAndRestore()
                playerHand.draw(card: deck.draw())
                battleground.allowCreaturesAttack(owner: OwnerType.player)
                playerHand.markPlayable(mana: manaCounter.mana)
            }
            if (state == .playerEnd) {
                state = .computerTurn
                playerHand.markUnplayable()
                battleground.disableCreaturesAttack(owner: OwnerType.player)
                battleground.allowCreaturesAttack(owner: OwnerType.computer)
                makeComputerMove()
            }
        }
    }
}
