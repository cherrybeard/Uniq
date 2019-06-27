//
//  TurnAnnouncerSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 15/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class TurnAnnouncerSprite: SKNode {
    private let _label = SKLabelNode()
    
    private var _message: String = ""
    var message: String {
        get { return _message }
        set(newMessage) {
            _message = newMessage
            _label.attributedText = NSAttributedString(
                string: _message.uppercased(),
                attributes: [
                    .kern: 4,
                    .font: UIFont(name: "AvenirNext-Regular", size: 20)!,
                    .foregroundColor: UIColor(rgb: 0xffffff)
                ]
            )
        }
    }
    
    override init() {
        super.init()
        
        addChild(_label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
