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
        
        let playLabel = SKLabelNode(text: "Touch anywhere to Play")
        playLabel.position = CGPointMake(size.width/2, size.height*0.2)
        playLabel.name = "Play"
        playLabel.fontName = "Avenir"

        self.addChild(playLabel)
        
        let a1 = SKAction.fadeInWithDuration(1)
        let a2 = SKAction.fadeOutWithDuration(1)
        playLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([a1,a2])))
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
        
            if node.name == "Purchase" {
            }
            else {
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