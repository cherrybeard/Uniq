//
//  GameScene.swift
//  Uniq
//
//  Created by Steven Gusev on 17/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit
import GameplayKit

class BattleScene: SKScene {
    private struct SCREEN {
        static let bottom = -Int(UIScreen.main.bounds.size.height/2)
        static let left = -Int(UIScreen.main.bounds.size.width/2)
        static let right = Int(UIScreen.main.bounds.size.width/2)
    }
    
    let battle = Battle()   // TODO: Contains only links to battle objects functions to manipulate them
    var delayedTask: DispatchWorkItem? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = UIColor(rgb: 0x000000)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        //TODO: Move all this to class Battle
        battle.human.deck.hand.position = CGPoint(x: 0, y: SCREEN.bottom + 45 + 20)
        //battle.desk.playerHero.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 160)
        battle.passButton.position = CGPoint(x: SCREEN.left + 40, y: SCREEN.bottom + 160)
        
        addChild(battle.human.deck.hand)
        addChild(battle)
        addChild(battle.passButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            for node in touchedNodes {
                // TODO: rework to unified Tappable experience
                // TODO: join Tapped with sourceNode
                // TODO: Move checking interactive to the touchesNodes filter above
                if var interactiveNode = node as? Interactive {
                    if interactiveNode.status.contains(.interactive) {
                        var wasActivated = false
                        if interactiveNode.status.contains(.activatable) {
                            if let spot = interactiveNode as? Spot {
                                if let creature = spot.creature {
                                    wasActivated = true
                                    delayedTask = DispatchWorkItem {
                                        // TODO: check if ability was really used
                                        self.battle.cleanInteractivesStatus()
                                        if self.battle.useActiveAbility(of: creature) {
                                            self.battle.endTurn()
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: delayedTask!)
                                }
                            }
                        }
                        // remove interactive highlights
                        battle.cleanInteractivesStatus()
                        
                        // highlight itself
                        interactiveNode.status.insert(.interacted)
                        if wasActivated { interactiveNode.status.insert(.activated) }
                        
                        // highlight targets
                        battle.addInteractivesStatus(status: .targetable, filter: interactiveNode.targetsFilter)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            var stopTask = (delayedTask != nil) && !delayedTask!.isCancelled
            battle.removeInteractivesStatus(status: .targetted)
            for node in touchedNodes {
                if var interactiveNode = node as? Interactive {
                    if interactiveNode.status.contains(.targetable) {
                        interactiveNode.status.insert(.targetted)
                    }
                    if interactiveNode.status.contains(.activated) {
                        stopTask = false
                    }
                }
            }
            if stopTask { delayedTask?.cancel() }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        var actionCancelled = true
        
        for touch in touches {
            // TODO: Optimize these cycles by moving out type convertions
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter({ node in node.name != nil})
            
            if let source = battle.interactives.first(where: { $0.status.contains(.interacted) }) {
                for node in touchedNodes {
                    if var interactiveNode = node as? Interactive {
                        if interactiveNode.status.contains(.targetted) {
                            // find out what source node type is
                            if let sourceSpot = source as? Spot {
                                if let targetSpot = node as? Spot {
                                    // move creature
                                    battle.swap(sourceSpot, with: targetSpot)
                                    actionCancelled = false
                                    battle.endTurn()
                                    break
                                }
                            } else if let card = source as? Card {
                                if let spot = node as? Spot {
                                    if battle.play(card, to: spot) {
                                        actionCancelled = false
                                        battle.endTurn()
                                        break
                                    }
                                }
                            } else if source is PassButton {
                                if node is PassButton {
                                    // next turn
                                    actionCancelled = false
                                    battle.endTurn(passed: true)
                                    break
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        
        // reset targets highlighting
        delayedTask?.cancel()
        battle.cleanInteractivesStatus()
        if actionCancelled {
            battle.highlightActionTargets()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        battle.update()
    }
    
}
