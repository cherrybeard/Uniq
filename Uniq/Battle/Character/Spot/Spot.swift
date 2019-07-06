//
//  CreatureSpot.swift
//  Uniq
//
//  Created by Steven Gusev on 03/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class Spot: SKNode, Interactive {
    
    enum Range: Int {
        case melee = 0
        case range = 1
    }
    
    enum Column: Int {
        case left = -1
        case center = 0
        case right = 1
    }
    
    private enum SpriteState: String, CaseIterable {
        case targetted = "targetted"
        case targetable = "targetable"
        case base = "base"
    }
    
    
    static let width: Int = 86
    static let height: Int = 56
    private static let strokeColor: [SpriteState: UIColor] = [
        .targetted: UIColor(rgb: 0x3065FF),
        .targetable: UIColor(rgb: 0x3752A1),
        .base: UIColor(rgb: 0x1D1D1C)
    ]
    
    private let border = SKShapeNode(
        rectOf: CGSize(width: Spot.width, height: Spot.height),
        cornerRadius: 3
    )
    
    var state: Set<InteractiveState> = [] {
        didSet {
            if let sprite = creature?.sprite as? CreatureSprite {
                sprite.state = state
            }
            redraw()
        }
    }
    var targetsFilter: (Interactive) -> Bool = { _ in return false }
    
    let owner: Player
    let range: Range
    let column: Column
    weak var creature: Creature? = nil
    var isFree: Bool { return (creature == nil) }

    var index: Int {
        get {
            var shift: Int = column.rawValue + 2
            if owner.isHuman {
                shift += 6 + range.rawValue * 3
            } else {
                shift += (range.rawValue-1) * -3
            }
            return shift
        }
    }
    
    init(owner: Player, range: Range, column: Column) {
        self.owner = owner
        self.range = range
        self.column = column
        super.init()
        let neighbors = Spots.neighbors(of: index)
        targetsFilter = {
            if let spot = $0 as? Spot {
                return neighbors.contains(spot.index)
            }
            return false
        }
        
        border.lineWidth = 1
        addChild(border)
        redraw()
        name = "spot"
    }
    
    private func redraw() {
        var spriteState: SpriteState = .base
        for s in SpriteState.allCases {
            if let interactiveState = InteractiveState(rawValue: s.rawValue) {
                if state.contains(interactiveState) {
                    spriteState = s
                    break
                }
            }
        }
        border.strokeColor = Spot.strokeColor[spriteState]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func == (lhs: Spot, rhs: Spot) -> Bool {
        return lhs.index == rhs.index
    }
}
