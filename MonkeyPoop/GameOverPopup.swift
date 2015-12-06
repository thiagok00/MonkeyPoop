//
//  GameOverPopup.swift
//  MonkeyPoop
//
//  Created by Thiago De Angelis on 06/12/15.
//  Copyright © 2015 ThiagoMay. All rights reserved.
//

import Foundation
import SpriteKit



class GameOverPopup: SKSpriteNode {
    
    
    class func createGameOverPopup(size:CGSize)->GameOverPopup {
        
        
        let pauseMenu = GameOverPopup(color: UIColor(red: 53/255, green: 42/255, blue: 42/255, alpha: 1), size: CGSizeMake(size.width*0.8, size.height*0.8))
        pauseMenu.position = CGPointMake(size.width/2, size.height/2)
        
        let msgLabel = SKLabelNode(text: "GameOver")
        msgLabel.fontColor = UIColor.whiteColor()
        msgLabel.fontSize = 40
        msgLabel.fontName = "Arial"
        msgLabel.position = CGPointMake(0, pauseMenu.size.height/4)
        pauseMenu.addChild(msgLabel)
        
        let restartButton = SKSpriteNode(imageNamed: "RestartButton")
        restartButton.name = "Restart"
        restartButton.position = CGPointMake(-restartButton.size.width, -50)
        
        let homeButton = SKSpriteNode(imageNamed: "HomeButton")
        homeButton.name = "Home"
        homeButton.position = CGPointMake(restartButton.size.width, -50)
        
        
        
        pauseMenu.addChild(homeButton)
        pauseMenu.addChild(restartButton)
        
        return pauseMenu
    }
}