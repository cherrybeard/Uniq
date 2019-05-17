//
//  AnimationPipeline.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class AnimationPipeline {
    private var _queue: [Animation] = []
    var state: AnimationState {
        get { return (_queue.count > 0) ? .inProgress : .finished }
    }
    
    func add(animation: Animation) {
        _queue.append(animation)
    }
    
    func update() {
        if _queue.count == 0 { return }
        switch _queue[0].state {
        case .finished:
            _queue.remove(at: 0)
        case .ready:
            _queue[0].state = .inProgress
            _queue[0].play()
        default:
            return
        }
    }
    
}
