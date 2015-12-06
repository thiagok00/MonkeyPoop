//
//  MainMenu.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 04/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.blueColor()
        
        let size = self.frame.size
        
        let playLabel = SKLabelNode(text: "Play")
        playLabel.position = CGPointMake(size.width/2, size.height/2)
        playLabel.name = "Play"
        self.addChild(playLabel)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
        
            if node.name == "Play" {
                self.play()
            }
        
        
        }
    }
 
    
    private func play() {
        
        let transition = SKTransition.fadeWithDuration(1.5)
        
        let scene = GameScene(size:self.frame.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene, transition: transition)
        
    }
    
} //End of Class