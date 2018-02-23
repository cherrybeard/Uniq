//
//  Animation.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

enum AnimationState: Int {
    case ready = 0, inProgress, finished
}

class Animation {
    var state: AnimationState = AnimationState.ready
    
    func play() {
        
    }
}
