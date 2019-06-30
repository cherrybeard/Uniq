//
//  TurnAnnouncerSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 15/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class TurnAnnouncerSprite: SKNode {
    private static let attributes: [NSAttributedString.Key : Any] = [
        .kern: 4,
        .font: UIFont(name: "AvenirNext-Regular", size: 20)!,
        .foregroundColor: UIColor(rgb: 0xffffff)
    ]
    
    var message: String = "" { didSet {
        label.attributedText = NSAttributedString(
            string: message.uppercased(),
            attributes: TurnAnnouncerSprite.attributes
        )
    } }
    private let label = SKLabelNode()
    
    override init() {
        super.init()
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
