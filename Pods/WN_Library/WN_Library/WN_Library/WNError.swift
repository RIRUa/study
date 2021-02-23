//
//  WNError.swift
//  WN_UserInterfaces
//
//  Created by RIRUa on 2021/02/20.
//

import UIKit

public enum WNError: Error {
    case sizeSmaller
    case sizeOver
    case UnKnown
}

extension WNError: LocalizedError{
    
    public var errorDescription: String? {
        
        switch self {
        case .sizeSmaller:
            return "the Size is Smaller"
            
        case .sizeOver:
            return "the Size is Over"
            
        case .UnKnown:
            return "This is Unknown Error"
        }
        
    }
    
    
}
