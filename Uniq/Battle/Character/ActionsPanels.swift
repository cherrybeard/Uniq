//
//  ActionsPanels.swift
//  Uniq
//
//  Created by Steven Gusev on 10/07/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//

import SpriteKit

class ActionsPanels: SKNode {
    var panels: [ActionsPanel] = []
    
    func add(_ panel: ActionsPanel) {
        panel.alpha = 0
        panels.append(panel)
        addChild(panel)
    }
}
