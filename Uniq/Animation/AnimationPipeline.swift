//
//  AnimationPipeline.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class AnimationPipeline {
    private var _queue: [Animation] = []
    private var _lastState: AnimationState?
    var state: AnimationState {
        get { return (_queue.count > 0) ? .inProgress : .finished }
    }
    
    func add(animation: Animation) {
        _queue.append(animation)
    }
    
    func update() -> AnimationState {
        if _queue.count == 0 {
            if (_lastState == .finished) || (_lastState == .idle) {
                _lastState = .idle
                return .idle
            } else {
                _lastState = .finished
                return .finished
            }
        }
        switch _queue[0].state {
        case .finished:
            _queue.remove(at: 0)
        case .ready:
            _queue[0].state = .inProgress
            _queue[0].play()
        default:
            break
        }
        _lastState = .inProgress
        return .inProgress
    }
    
}
