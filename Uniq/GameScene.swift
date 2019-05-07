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

enum PlayerActionType: Int {   // OBSOLETE
    case rest = 0, attack, card, endTurn
}

enum NodeType: String {    // OBSOLETE
    case desk = "desk"
    case card = "card"
    case character = "character"
    case endTurn = "end-turn"
}

struct PlayerAction {   // OBSOLETE
    var type: PlayerActionType = .rest
    var subject: Any? = nil
    var requiresTarget: Bool = false
}

class GameScene: SKScene {
    let battle = Battle()
    var sourceNode: SKNode? = nil
    
    var state: TurnState = .playerTurn  // OBSOLETE
    var playerAction = PlayerAction()   // OBSOLETE
    
    private var _possibleTargets: [Targetable] = [] // TODO: Rework into targetStates array... maybe
    private var possibleTargets: [Targetable] {     // problem is how to ajoin possibleTargets array
        get { return _possibleTargets }             // with currentTargest array
        set(newTargets) {
            for var target in _possibleTargets {
                target.isPossibleTarget = false
            }
            _possibleTargets = []
            for var target in newTargets {
                target.isPossibleTarget = true
                _possibleTargets.append(target)
            }
        }
    }
    
    private var _currentTargets: [Targetable] = []
    private var currentTargets: [Targetable] {
        get { return _currentTargets }
        set(newTargets) {
            for var target in _currentTargets {
                target.isCurrentTarget = false
            }
            _currentTargets = []
            for var target in newTargets {
                target.isCurrentTarget = true
                _currentTargets.append(target)
            }
        }
    }
    
    struct ScreenBoundaries {   // constant? use uppercase
        static let bottom = -Int(UIScreen.main.bounds.size.height/2)
        static let left = -Int(UIScreen.main.bounds.size.width/2)
        static let right = Int(UIScreen.main.bounds.size.width/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor(rgb: 0x000000, alpha: 1)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        battle.player.mana.position = CGPoint(x: ScreenBoundaries.right - 40, y: ScreenBoundaries.bottom + 160)
        battle.player.deck.hand.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 45 + 20)
        battle.desk.playerHero.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 160)
        
        addChild(battle.player.deck.hand)
        addChild(battle.player.mana)
        addChild(battle.desk)
        addChild(battle.desk.playerHero)
        
        for _ in 1...5 { battle.player.deck.draw() }
        
        battle.desk.summon(CardBook["Thug"] as! CreatureCard, to: 3)
        battle.desk.summon(CardBook["Bandit"] as! CreatureCard, to: 5)
        battle.desk.summon(CardBook["Thug"] as! CreatureCard, to: 4)
        
        battle.player.highlightCards()
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
    
    func endPlayerTurn() {
        startPlayerTurn()
    }
    
    func startPlayerTurn() {
        battle.player.mana.increaseAndRestore()
        battle.player.deck.draw()
        battle.player.highlightCards()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if state == .playerTurn {
                let touchLocation = touch.location(in: self)
                let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
                
                for node in touchedNodes {
                    if let card = node as? CreatureCardSprite {
                        // add inheritance from Clickable (protocol?) to CardSprite etc.
                        if card.canPlay {
                            card.isActive = true
                            sourceNode = node
                            possibleTargets = battle.desk.creatureSpots.filter({
                                ($0.owner == .player) && !$0.isTaken
                            })
                            break
                        }
                    }
                    if let endTurnButton = node as? ManaCounter {
                        sourceNode = node
                        possibleTargets = [endTurnButton]
                        break
                    }
                    /*
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
                    */
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            var newTargets: [Targetable] = []
            if state == .playerTurn {
                if sourceNode?.name == "card" {
                    for node in touchedNodes {
                        if var target = node as? Targetable {
                            if target.isPossibleTarget {
                                target.isCurrentTarget = true
                                newTargets.append(target)
                            }
                        }
                    }
                }
            }
            currentTargets = newTargets
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            if state == .playerTurn {
                for node in touchedNodes {
                    if let target = node as? Targetable {
                        if !target.isPossibleTarget { continue }
                    }
                    
                    if sourceNode?.name == "card" {
                        if let creatureSpot = node as? CreatureSpotSprite {
                            if creatureSpot.owner != .player { continue }
                            if let creatureCard = sourceNode as? CreatureCardSprite {
                                if battle.play(creatureCard, to: creatureSpot) { break }
                            }
                        }
                    }
                    
                    if sourceNode?.name == "end-turn" {
                        if let _ = node as? ManaCounter {
                            endPlayerTurn()
                        }
                    }
                }
                
                /*
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
                                            battle.play(cardSprite: card, target: creature)
                                        }
                                    }
                                    break
                                }
                                if !playerAction.requiresTarget && (nodeType == .desk) {
                                    battle.play(cardSprite: card)
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
                 */
                
                currentTargets = []
                possibleTargets = []
                
                if let card = sourceNode as? CardSprite {
                    card.isActive = false
                }
                sourceNode = nil
                
                playerAction.type = .rest
                playerAction.subject = nil
                playerAction.requiresTarget = false
                battle.desk.markTargets(filter: { (_) -> Bool in false })
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /*
        battle.animationPipeline.update()
        if ( battle.animationPipeline.state == AnimationState.finished) {
            //battle.desk.removeDeadCreatures() // Causes permamament leak
            if (state == .computerEnd) {
                state = .playerTurn
                battle.player.mana.increaseAndRestore()
                battle.player.deck.draw()
                battle.desk.setCreaturesAttack(owner: .player, canAttack: true)
                battle.player.highlightCards()
            }
            if (state == .playerEnd) {
                state = .computerTurn
                battle.player.highlightCards(removeHighlight: true)
                battle.desk.setCreaturesAttack(owner: .player, canAttack: false)
                battle.desk.setCreaturesAttack(owner: .computer, canAttack: true)
                makeComputerMove()
            }
        }
        */
    }
}
