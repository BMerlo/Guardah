//
//  MenuScene.swift
//  SuperSpaceMan
//
//  Created by Apptist Inc on 2019-03-11.
//  Copyright © 2019 Mark Meritt. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    //TODO: - Use this to create a menu scene
    var startButton: SKSpriteNode!
    var optionsButton: SKSpriteNode!
    var highScoreButton: SKSpriteNode!
    var quitButton: SKSpriteNode!
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    //TODO: - Add a main menu and play button
    override init(size: CGSize) {
        super.init(size: size)
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetStart"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        
        startButton = SKSpriteNode(texture: SKTexture(imageNamed: "new game"))
        startButton?.name = "startBtn"
        startButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+80)
        
        highScoreButton = SKSpriteNode(texture: SKTexture(imageNamed: "highscore"))
        highScoreButton?.name = "hsBtn"
        highScoreButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+20)
        
        optionsButton = SKSpriteNode(texture: SKTexture(imageNamed: "options"))
        optionsButton?.name = "optionsBtn"
        optionsButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-40)
        
        quitButton = SKSpriteNode(texture: SKTexture(imageNamed: "quit"))
        quitButton?.name = "quitBtn"
        quitButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-90)
        
        addChild(background!)
        addChild(highScoreButton!)
        addChild(startButton!)
        addChild(optionsButton!)
        addChild(quitButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            //scene?.view?.presentScene(GameScene(size: self.frame.size))
           enumerateChildNodes(withName: "//*", using: { ( node, stop) in
               if node.name == "startBtn" {
                            if node.contains(t.location(in:self))// do whatever here
                            {
                                let reveal = SKTransition.reveal(with: .up,                                                                duration: 1)
                                let newScene = GameScene(size:self.size)
                                self.view?.presentScene(newScene, transition: reveal)
                                print("Button Pressed")
                            }
                        }
                    })
                    
              }
  
    }
}
