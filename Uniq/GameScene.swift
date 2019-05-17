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
        
        battle.summon("Yletia Pirate", to: 7)
        battle.summon("Yletia Pirate", to: 3)
        battle.summon("Bandit", to: 5)
        battle.summon("Thug", to: 4)
    }
    
    private func cancelDelayedTask() {
        sourceNode = nil
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
                if let card = node as? CreatureCardSprite {
                    sourceNode = node
                    currentlyTapped = [card]
                    possibleTargets = battle.creatureSpots.filter({
                        ($0.owner!.type == .human) && !$0.isTaken
                    })
                    return
                }
                if let creatureSprite = node as? CreatureSprite {
                    if (creatureSprite.activeAbilityCooldown == 0) && (creatureSprite.owner!.type == .human) {
                        sourceNode = node
                        currentlyTapped = [creatureSprite]
                        possibleTargets = [creatureSprite]
                        currentTargets = [creatureSprite]
                        delayedTask = DispatchWorkItem { [ weak self ] in
                            // TODO: check if ability was really used
                            self?.possibleTargets = []
                            self?.currentTargets = []
                            if (creatureSprite.useActiveAbility(battle: self!.battle)) {
                                self?.battle.endTurn()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: delayedTask!)
                        return
                    }
                }
                if let passButton = node as? PassButton {
                    sourceNode = node
                    possibleTargets = [passButton]
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
                        target.isCurrentTarget = true
                        newTargets.append(target)
                    }
                }
            }
            if (delayedTask != nil) && !delayedTask!.isCancelled {
                var stopTask = true
                for node in touchedNodes {
                    if let target = node as? Targetable {
                        if target.isPossibleTarget {
                            stopTask = false
                        }
                    }
                }
                if stopTask {
                    cancelDelayedTask()
                    possibleTargets = []
                }
            }
            currentTargets = newTargets
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            for node in touchedNodes {
                if let target = node as? Targetable {
                    if !target.isPossibleTarget { continue }
                }
                
                if sourceNode?.name == "card" {
                    if let creatureSpot = node as? CreatureSpotSprite {
                        if creatureSpot.owner!.type != .human { continue }
                        if let creatureCard = sourceNode as? CreatureCardSprite {
                            if battle.play(creatureCard, to: creatureSpot) {
                                battle.endTurn()
                                return
                            }
                        }
                    }
                }
                
                if sourceNode?.name == "pass" {
                    if let _ = node as? PassButton {
                        battle.endTurn(passed: true)
                        return
                    }
                }
            }
        }
        
        currentTargets = []
        possibleTargets = []
        currentlyTapped = []
        cancelDelayedTask()
    }
    
    override func update(_ currentTime: TimeInterval) {
        battle.update()
    }
    
    func makeComputerMove() {   //OBSLOLETE
        /*
         let creatures = battle.desk.creatures.filter { creature in (creature.owner == .ai) && creature.canAttack }
         if creatures.count > 0 {
         let creaturesShuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: creatures)
         
         for creature in creaturesShuffled {
         let playerCreatures = battle.desk.creatures.filter { creature in (creature.owner == .human) && !creature.dead && (creature is CreatureSprite) }
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
         */
    }
}
