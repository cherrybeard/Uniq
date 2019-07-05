//
//  AnimationPipeline.swift
//  Uniq
//
//  Created by Steven Gusev on 22/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class AnimationPipeline {
    private var queue: [Animation] = []
    private var lastState: Animation.State?
    var state: Animation.State {
        get { return (queue.count > 0) ? .inProgress : .finished }
    }
    private var blocks: [() -> Void] = []
    
    func add(_ animations: [Animation]) {
        for animation in animations {
            add(animation)
        }
    }
    
    func add(_ animation: Animation) {
        queue.append(animation)
    }
    
    func add(_ animation: Animation? = nil, completion block: @escaping () -> Void) {
        blocks.append(block)
        if animation != nil {
            queue.append(animation!)
        }
    }
    
    func update() -> Animation.State {
        if queue.count == 0 {
            if blocks.count > 0 {
                let block = blocks.remove(at: 0)
                block()
                return .inProgress
            } else if (lastState == .finished) || (lastState == .idle) {
                lastState = .idle
                return .idle
            } else {
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
