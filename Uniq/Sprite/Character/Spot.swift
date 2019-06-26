//
//  CreatureSpot.swift
//  Uniq
//
//  Created by Steven Gusev on 03/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

enum RangeType: Int {
    case melee = 0, range = 1
}

enum ColumnType: Int {
    case left = -1, center = 0, right = 1
}

class Spot: SKNode, Interactive {
    private static let WIDTH: Int = 86
    private static let HEIGHT: Int = 56
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x1D1D1C)
        static let targetted = UIColor(rgb: 0x3065FF)
        static let targetable = UIColor(rgb: 0x3752A1)
    }
    
    private let border = SKShapeNode(
        rectOf: CGSize(
            width: Spot.WIDTH,
            height: Spot.HEIGHT
        ),
        cornerRadius: 3
    )
    
    var status: Set<InteractiveStatus> = [] {
        didSet {
            creature?.sprite.status = status
            redraw()
        }
    }
    var targetsFilter: (Interactive) -> Bool = { _ in return false }
    
    let owner: Player
    let range: RangeType
    let column: ColumnType
    weak var creature: Creature? = nil
    var isTaken: Bool { return (creature != nil) }  // TODO: Is it actually being used? Try removing it

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
    
    init(owner: Player, range: RangeType, column: ColumnType) {
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
        if status.contains(.targetted) {
            border.strokeColor = BORDER_COLOR.targetted
        } else if status.contains(.targetable) {
            border.strokeColor = BORDER_COLOR.targetable
        } else {
            border.strokeColor = BORDER_COLOR.base
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func == (lhs: Spot, rhs: Spot) -> Bool {
        return lhs.index == rhs.index
    }
}
