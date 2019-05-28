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

class Spot: SKNode, Targetable {
    private static let WIDTH: Int = 86
    private static let HEIGHT: Int = 56
    private struct BORDER_COLOR {
        static let base = UIColor(rgb: 0x1D1D1C)
        //static let possibleTarget = UIColor(rgb: 0x2E2924)
        static let possibleTarget = UIColor(rgb: 0x3752A1)
        static let currentTarget = UIColor(rgb: 0x3065FF)
    }
    
    let owner: PlayerType
    let range: RangeType
    let column: ColumnType
    var creature: Creature? = nil
    var isTaken: Bool { return (creature != nil) }
    
    var isPossibleTarget: Bool = false { didSet { _redraw() } }
    var isCurrentTarget: Bool = false { didSet { _redraw() } }
    
    private let _border = SKShapeNode(rectOf: CGSize(width: Spot.WIDTH, height: Spot.HEIGHT), cornerRadius: 3)

    var index: Int {
        get {
            var shift: Int = column.rawValue + 1
            if owner == .human {
                shift += 6 + range.rawValue * 3
            } else {
                shift += (range.rawValue-1) * -3
            }
            return shift
        }
    }
    
    init(at index: Int) {
        owner = Spot._getOwner(of: index)
        range = Spot._getRange(of: index)
        column = Spot._getColumn(of: index)
        super.init()
        
        _border.lineWidth = 1
        addChild(_border)
        
        _redraw()
        name = "spot"
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func _redraw() {
        if isCurrentTarget {
            _border.strokeColor = BORDER_COLOR.currentTarget
        } else if isPossibleTarget {
            _border.strokeColor = BORDER_COLOR.possibleTarget
        } else {
            _border.strokeColor = BORDER_COLOR.base
        }
    }
    
    static private func _getColumn(of index: Int) -> ColumnType {
        let column = index % 3 - 1
        return ColumnType(rawValue: column) ?? .center
    }
    
    static private func _getOwner(of index: Int) -> PlayerType {
        return index > 5 ? .human : .ai
    }
    
    static private func _getRange(of index: Int) -> RangeType {
        if (index > 2) && (index < 9) {
            return .melee
        } else {
            return .range
        }
    }
    
}
