//
//  AttackLabel.swift
//  Uniq
//
//  Created by Steven Gusev on 18/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class AttackLabel: StatLabel {
    private var _isDisabled: Bool = false
    var isDisabled: Bool {
        get { return _isDisabled }
        set(newValue) {
            _isDisabled = newValue
            redraw()
        }
    }
    
    init() {
        super.init(type: .attack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
