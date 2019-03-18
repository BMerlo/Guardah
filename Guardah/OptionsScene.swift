//
//  OptionsScene.swift
//  Guardah
//
//  Created by Tech on 2019-03-18.
//  Copyright © 2019 PTBVGC. All rights reserved.
//


import Foundation
import SpriteKit

class OptionsScene: SKScene {
    
    
    var easyButton: SKSpriteNode!
    var mediumButton: SKSpriteNode!
    var hardButton: SKSpriteNode!
    var returnButton: SKSpriteNode!
    var optionsNameLabel: SKLabelNode!
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetStart"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        
        easyButton = SKSpriteNode(texture: SKTexture(imageNamed: "easy"))
        easyButton?.name = "easyBtn"
        easyButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+80)
        
        mediumButton = SKSpriteNode(texture: SKTexture(imageNamed: "medium"))
        mediumButton?.name = "mediumBtn"
        mediumButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+20)
        
        hardButton = SKSpriteNode(texture: SKTexture(imageNamed: "hard"))
        hardButton?.name = "hardBtn"
        hardButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-40)
        
        returnButton = SKSpriteNode(texture: SKTexture(imageNamed: "back"))
        returnButton?.name = "returnBtn"
        returnButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-120)
        
        optionsNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        optionsNameLabel.text = "Options"
        optionsNameLabel.horizontalAlignmentMode = .right
        optionsNameLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 70, y: UIScreen.main.bounds.height / 2+160)
        
        addChild(background!)
        addChild(easyButton!)
        addChild(mediumButton!)
        addChild(hardButton!)
        addChild(returnButton!)
        addChild(optionsNameLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            //scene?.view?.presentScene(GameScene(size: self.frame.size))
            enumerateChildNodes(withName: "//*", using: { ( node, stop) in
                if node.name == "returnBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        let reveal = SKTransition.reveal(with: .up,                                                                duration: 1)
                        let newScene = MenuScene(size:self.size)
                        self.view?.presentScene(newScene, transition: reveal)
                        print("Button Pressed")
                    }
                }
            })
            
        }
        
    }
}
