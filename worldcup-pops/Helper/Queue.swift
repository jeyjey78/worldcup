//
//  Queue.swift
//  worldcup-pops
//
//  Created by Jérémy GROS on 12/06/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import Foundation

public struct Queue {
    static func main(_ block: @escaping ()->()) {
        DispatchQueue.main.async(execute: block)
    }
    
    static func main(after seconds: Double, block: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: block)
    }
    
    static func name(_ queue: DispatchQueue, block: @escaping ()->()) {
        queue.async(execute: block)
    }
}
