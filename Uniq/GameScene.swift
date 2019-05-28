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
    let battle = Battle()
    var sourceNode: SKNode? = nil
    var delayedTask: DispatchWorkItem? = nil
    
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
    
    private var _currentlyTapped: [Tappable] = []
    private var currentlyTapped: [Tappable] {
        get { return _currentlyTapped }
        set(newTargets) {
            for var target in _currentlyTapped {
                target.isCurrentlyTapped = false
            }
            _currentlyTapped = []
            for var target in newTargets {
                target.isCurrentlyTapped = true
                _currentlyTapped.append(target)
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

        //TODO: Move all this to class Battle
        battle.human.deck.hand.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 45 + 20)
        //battle.desk.playerHero.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 160)
        battle.passButton.position = CGPoint(x: ScreenBoundaries.left + 40, y: ScreenBoundaries.bottom + 160)
        
        addChild(battle.human.deck.hand)
        addChild(battle)
        addChild(battle.passButton)
        
        //TODO: Move to func startBattle() in class Battle
        for _ in 1...4 { battle.human.deck.draw() }
        
        battle.summon("Yletia Pirate", to: 6)
        battle.summon("Yletia Pirate", to: 2)
        battle.summon("Bandit", to: 4)
        battle.summon("Thug", to: 3)
    }
    
    private func cancelDelayedTask() {
        delayedTask?.cancel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            for node in touchedNodes {
                // TODO: rework to unified Tappable experience
                // TODO: join Tapped with sourceNode
                if let card = node as? CreatureCard {
                    sourceNode = node
                    currentlyTapped = [card]
                    possibleTargets = battle.spots.filter({ $0.owner == .human && !$0.isTaken })
                    battle.removeActionTargets()
                    return
                }
                if let creatureSprite = node as? Creature {
                    if creatureSprite.owner == .human && !creatureSprite.isActionTaken {
                        sourceNode = node
                        currentlyTapped = [creatureSprite]
                        let spots = battle.spots.neighbors(of: creatureSprite.spot!)
                        possibleTargets = spots
                        for spot in spots { // TODO: Rework this to not use creatures at all
                            if spot.creature != nil {
                                possibleTargets.append(spot.creature!)
                            }
                        }
                        if (creatureSprite.activeAbilityCooldown == 0) {
                            creatureSprite.isCurrentlyHold = true
                            
                            //creating delayed task
                            delayedTask = DispatchWorkItem { [ weak self ] in
                                // TODO: check if ability was really used
                                self?._resetTargets()
                                if (creatureSprite.useActiveAbility(battle: self!.battle)) {
                                    self?.battle.endTurn()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: delayedTask!)
                        }
                        battle.removeActionTargets()
                    }
                }
                if let passButton = node as? PassButton {
                    sourceNode = node
                    possibleTargets = [passButton]
                    battle.removeActionTargets()
                    return
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            var newTargets: [Targetable] = []
            for node in touchedNodes {
                if var target = node as? Targetable {
                    if target.isPossibleTarget {
                        newTargets.append(target)
                    }
                }
            }
            if (delayedTask != nil) && !delayedTask!.isCancelled {
                var stopTask = true
                for node in touchedNodes {
                    if let target = node as? Holdable {
                        if target.isCurrentlyHold {
                            stopTask = false
                        }
                    }
                }
                if stopTask {
                    cancelDelayedTask()
                }
            }
            currentTargets = newTargets
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        var actionCancelled = true
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            for node in touchedNodes {
                if let target = node as? Targetable {
                    if !target.isPossibleTarget { continue }
                }
                
                if sourceNode?.name == "card" {
                    if let spot = node as? Spot {
                        if spot.owner == .ai { continue }  //TODO: use isPossibleTarget
                        if let creatureCard = sourceNode as? CreatureCard {
                            if battle.play(creatureCard, to: spot) {
                                actionCancelled = false
                                battle.endTurn()
                                break
                            }
                        }
                    }
                }
                
                if sourceNode?.name == "creature" {
                    if let targetSpot = node as? Spot {
                        if let sourceSpotCreature = sourceNode as? Creature {
                            actionCancelled = false
                            battle.swap(sourceSpotCreature.spot!, with: targetSpot)
                            battle.endTurn()
                            break
                        }
                    }
                }
                
                if sourceNode?.name == "pass" {
                    if let _ = node as? PassButton {
                        actionCancelled = false
                        battle.endTurn(passed: true)
                        break
                    }
                }
            }
        }
        _resetTargets()
        if actionCancelled { battle.highlightActionTargets() }
    }
    
    override func update(_ currentTime: TimeInterval) {
        battle.update()
    }
    
    private func _resetTargets() {
        sourceNode = nil
        currentTargets = []
        possibleTargets = []
        currentlyTapped = []
        cancelDelayedTask()
    }
    
}
