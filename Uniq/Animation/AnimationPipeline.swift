//
//  AnimationPipeline.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class AnimationPipeline {
    private var queue: [Animation] = []
    private var lastState: AnimationState?
    var state: AnimationState {
        get { return (queue.count > 0) ? .inProgress : .finished }
    }
    private var blocks: [() -> Void] = []
    
    func add(_ animations: [Animation]) {
        for animation in animations {
            add(animation)
        }
    }
    
    func add(_ animation: Animation, completion block: @escaping () -> Void = {}) {
        queue.append(animation)
        blocks.append(block)
    }
    
    func update() -> AnimationState {
        if queue.count == 0 {
            if (lastState == .finished) || (lastState == .idle) {
                lastState = .idle
                return .idle
            } else {
                for block in blocks {
                    block()
                }
                lastState = .finished
                return .finished
            }
        }
        switch queue[0].state {
        case .finished:
            queue.remove(at: 0)
        case .ready:
            queue[0].state = .inProgress
            queue[0].play()
        default:
            break
        }
        lastState = .inProgress
        return .inProgress
    }
    
}
