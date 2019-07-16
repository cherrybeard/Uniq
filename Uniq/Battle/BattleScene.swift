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
    
    static let screenSize = CGSize(
        width: UIScreen.main.bounds.size.width,
        height: UIScreen.main.bounds.size.height
    )
    
    let battle = Battle()
    
    private var selectedCharacter: CharacterSprite? { willSet(justSelected) {
        if selectedCharacter === justSelected { return }
        
        selectedCharacter?.state.remove(.selected)
        selectedCharacter?.character.actionsPanel?.alpha = 0
        selectedAbility = nil
        
        justSelected?.state.insert(.selected)
        justSelected?.character.actionsPanel?.alpha = 1
    } }
    
    private var selectedAbility: AbilityButton? { willSet(justSelected) {
        selectedAbility?.state.remove(.selected)
        justSelected?.state.insert(.selected)
    } }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = UIColor(rgb: 0x000000)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        battle.sprite.position = CGPoint(x: 0, y: 0)
        addChild(battle.sprite)
        //TODO: Move all this to class Battle
        //let handYPos = SCREEN.bottom + (CardSprite.height / 2) + 10
        //battle.human.deck.hand.position = CGPoint(x: 0, y: handYPos)
        //battle.desk.playerHero.position = CGPoint(x: 0, y: ScreenBoundaries.bottom + 160)
        //battle.passButton.position = CGPoint(x: SCREEN.left + 40, y: SCREEN.bottom + 160)
        
        //addChild(battle.human.deck.hand)
        //addChild(battle.passButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation)//.filter({ node in node.name != nil})
            for node in touchedNodes {
                if let character = node as? CharacterSprite {
                    if character.character.owner?.isHuman ?? false {
                        selectedCharacter = character
                    }
                }
                if let ability = node as? AbilityButton {
                    selectedAbility = ability
                }
                /*
                // TODO: rework to unified Tappable experience
                // TODO: join Tapped with sourceNode
                // TODO: Move checking interactive to the touchesNodes filter above
                if var interactiveNode = node as? Interactive {
                    if interactiveNode.state.contains(.interactive) {
                        // remove interactive highlights
                        battle.interactives.clean()
                        
                        // highlight itself
                        interactiveNode.state.insert(.interacted)
                        
                        // highlight targets, and apply active targeting to itself
                        battle.interactives.addState(
                            .targetable,
                            filter: interactiveNode.targetsFilter
                        )
                        if interactiveNode.state.contains(.targetable) {
                            interactiveNode.state.insert(.targetted)
                        }
                    }
                }
                */
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter { node in node.name != nil}
            /*
            var stopTask = (delayedTask != nil) && !delayedTask!.isCancelled
            battle.interactives.removeState(.targetted)
            for node in touchedNodes {
                if var interactiveNode = node as? Interactive {
                    if interactiveNode.state.contains(.targetable) {
                        interactiveNode.state.insert(.targetted)
                    }
                    if interactiveNode.state.contains(.activated) {
                        stopTask = false
                    }
                }
            }
            if stopTask { delayedTask?.cancel() }
            */
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !battle.isUnlocked { return }
        
        for touch in touches {
            // TODO: Optimize these cycles by moving out type convertions
            let touchLocation = touch.location(in: self)
            let touchedNodes = self.nodes(at: touchLocation).filter { node in node.name != nil}
            /*
            if let source = battle.interactives.first(where: { $0.state.contains(.interacted) }) {
                for node in touchedNodes {
                    if var interactiveNode = node as? Interactive {
                        if interactiveNode.state.contains(.targetted) {
                            // find out what source node type is
                            if let sourceSpot = source as? Spot {
                                if let targetSpot = node as? Spot {
                                    // move creature
                                    battle.swap(sourceSpot, with: targetSpot)
                                    break
                                }
                            } else if let card = source as? CardSprite {
                                if let spot = node as? Spot {
                                    _ = battle.play(card.card!, for: battle.human, to: spot)
                                    break
                                } else if node is Spots {
                                    _ = battle.play(card.card!, for: battle.human)
                                    break
                                }
                            } else if source is PassButton {
                                if node is PassButton {
                                    // next turn
                                    battle.endTurn()
                                    break
                                }
                            }
                            
                        }
                    }
                }
            }*/
        }
        
        // reset targets highlighting
        //battle.interactives.clean()
        battle.actionDone()
    }
    
    override func update(_ currentTime: TimeInterval) {
        battle.update()
    }
    
}
