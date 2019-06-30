//
//  Animation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class Animation {
    
    enum State: Int {
        case ready, inProgress, finished, idle
    }
    
    var state: State = .ready
    
    func play() {
        
    }
}
