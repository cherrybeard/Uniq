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
    case rest = 0, attack, card, endTurn
}

enum NodeType: String {
    case desk = "desk"
    case card = "card"
    case character = "character"
    case endTurn = "end-turn"
}

struct PlayerAction {
    var type: PlayerActionType = .rest
    var subject: Any? = nil
    var requiresTarget: Bool = false
}

class GameScene: SKScene {
    let battle = Battle()
    var state: TurnState = .playerTurn
    var playerAction = PlayerAction()
    
    struct ScreenBoundaries {
        static let bottom = -Int(UIScreen.main.bounds.size.height/2)
        static let left = -Int(UIScreen.main.bounds.size.width/2)
        static let right = Int(UIScreen.main.bounds.size.width/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        battle.player.manaCounter.position = CGPoint(x: ScreenBoundaries.right - 40, y: ScreenBoundaries.bottom + 160)
        battle.player.hand.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 45 + 20)
        battle.desk.playerHero.position = CGPoint(x: ScreenBoundaries.left + 40, y: ScreenBoundaries.bottom + 160)
        
        addChild(battle.player.hand)
        addChild(battle.player.manaCounter)
        addChild(battle.desk)
        addChild(battle.desk.playerHero)
        
        for _ in 1...5 { battle.player.drawCard() }
        
        let leftThug = CreatureSprite(creature: CardBook["Thug"] as! CreatureCard, owner: .computer)
        let bandit = CreatureSprite(creature: CardBook["Bandit"] as! CreatureCard, owner: .computer)
        let rightThug = CreatureSprite(creature: CardBook["Thug"] as! CreatureCard, owner: .computer)
        
        battle.summon(leftThug)
        battle.summon(bandit)
        battle.summon(rightThug)
        
        battle.player.toggleCardsHighlight(playable: true)
    }
    
    func makeComputerMove() {
        let creatures = battle.desk.creatures.filter { creature in (creature.owner == .computer) && creature.canAttack }
        if creatures.count > 0 {
            let creaturesShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: creatures)
            
            for creature in creaturesShuffled {
                let playerCreatures = battle.desk.creatures.filter { creature in (creature.owner == .player) && !creature.dead && (creature is CreatureSprite) }
                var target: CharacterSprite
                if playerCreatures.count != 0 {
                    let playerCreaturesShffled =  GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: playerCreatures)
                    target = playerCreaturesShffled[0] as! CharacterSprite
                } else {
                    target = battle.desk.playerHero
                }
                
                battle.attack(attacking: creature as! CharacterSprite, defending: target)
            }
        }
        state = .computerEnd
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if state == .playerTurn {
                let touchLocation = touch.location(in: self)
                let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
                
                for node in touchedNodes {
                    if let nodeType = NodeType(rawValue: node.name!) {
                        switch nodeType {
                        case .character:
                            let creature = node as? CharacterSprite
                            if (creature?.canAttack)! {
                                playerAction.type = .attack
                                playerAction.subject = creature
                            }
                            break
                            
                        case .card:
                            if let card = node as? CardSprite {
                                playerAction.type = .card
                                playerAction.subject = card
                                if card.card.requiresTarget {
                                    playerAction.requiresTarget = true
                                    if let filter = card.card.targetFilter {
                                        battle.desk.markTargets(filter: filter)
                                    } else {
                                        battle.desk.markTargets()
                                    }
                                }
                                break
                            }
                            
                        case .endTurn:
                            playerAction.type = .endTurn
                            break
                            
                        default:
                            continue
                        }
                        
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            if state == .playerTurn {
                for node in touchedNodes {
                    if let nodeType = NodeType(rawValue: node.name!) {
                        switch playerAction.type {
                        case .attack:
                            if nodeType == .character {
                                if let defendingCreature = node as? CreatureSprite {
                                    if defendingCreature.owner == .computer {
                                        if let attackingCreature = playerAction.subject as? CreatureSprite {
                                            battle.attack(
                                                attacking: attackingCreature,
                                                defending: defendingCreature
                                            )
                                        }
                                    }
                                }
                                break
                            }
                            
                        case .card:
                            if let card = playerAction.subject as? CardSprite {
                                if playerAction.requiresTarget && (nodeType == .character) {
                                    if let creature = node as? CreatureSprite {
                                        if creature.isTarget {
                                            battle.playCard(cardSprite: card, target: creature)
                                        }
                                    }
                                    break
                                }
                                if !playerAction.requiresTarget && (nodeType == .desk) {
                                    battle.playCard(cardSprite: card)
                                    break
                                }
                            }
                            
                        case .endTurn:
                            if nodeType == .endTurn {
                                state = .playerEnd
                                break
                            }
                        
                        default:
                            continue
                        }
                    }
                }
                playerAction.type = .rest
                playerAction.subject = nil
                playerAction.requiresTarget = false
                battle.desk.markTargets(filter: { (_) -> Bool in false })
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        battle.animationPipeline.update()
        if ( battle.animationPipeline.state == AnimationState.finished) {
            battle.desk.removeDeadCreatures()
            if (state == .computerEnd) {
                state = .playerTurn
                battle.player.manaCounter.increaseAndRestore()
                battle.player.drawCard()
                battle.desk.setCreaturesAttack(owner: .player, canAttack: true)
                battle.player.toggleCardsHighlight(playable: true)
            }
            if (state == .playerEnd) {
                state = .computerTurn
                battle.player.toggleCardsHighlight(playable: false)
                battle.desk.setCreaturesAttack(owner: .player, canAttack: false)
                battle.desk.setCreaturesAttack(owner: .computer, canAttack: true)
                makeComputerMove()
            }
        }
    }
}
