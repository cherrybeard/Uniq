//
//  BuffLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 30/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class BuffLabel: SKNode {
    
    enum Kind: String {
        case attack = "ATK"
    }
    
    var value: Int = 0 { didSet { redraw() } }
    let kind: Kind
    private let label = SKLabelNode()
    
    init(kind: Kind) {
        self.kind = kind
        super.init()
        label.fontName = "Futura-Medium"
        label.fontColor = UIColor(rgb: 0xC69F78)
        label.fontSize = 10
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        addChild(label)
    }
    
    func redraw() {
        label.text = "\(value > 0 ? "+": "-")\(value) \(kind.rawValue)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
