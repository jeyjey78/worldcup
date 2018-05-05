//
//  log.swift
//  worldcup-pops
//
//  Created by Jeremy gros on 05/05/2018.
//  Copyright © 2018 Jeremy gros. All rights reserved.
//

import UIKit
import Willow

public var log: Logger = {
    
    struct DebugModifier: LogModifier {
        func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
            guard logLevel == .debug else { return message }
            
            return "🌵 \(message)"
        }
    }
    
    struct InfoModifier: LogModifier {
        func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
            guard logLevel == .info else { return message }
            
            return "☀️ \(message)"
        }
    }
    
    struct ErrorModifier: LogModifier {
        func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
            guard logLevel == .error else { return message }
            
            return "😡 \(message)"
        }
    }
    
    let writers = [ConsoleWriter(modifiers: [DebugModifier(), InfoModifier(), ErrorModifier()])]
    let defaultLogger = Logger(logLevels: .all, writers: writers)
    
    #if DEBUG
    #else
        defaultLogger.enabled = false
    #endif
    
    return defaultLogger
}()
