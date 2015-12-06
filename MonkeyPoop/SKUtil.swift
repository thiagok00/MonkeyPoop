//
//  SKUtil.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//
//                              ¯\_(ツ)_/¯
import Foundation
import SpriteKit


extension CGSize {
    static func enemySize()->CGSize { return CGSizeMake(46,68) }
    static func poopSize()->CGSize { return CGSizeMake(32,32) }
    static func bananaSize()->CGSize { return CGSizeMake(32,32) }

}

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
extension Array {
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in self.enumerate() {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
        }
    }
}

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

class SKUtil {
    
    
    
    
    
    
}