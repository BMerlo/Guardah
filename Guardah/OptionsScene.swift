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
    
    var scoreGetter: Int?
    var difficultyGetter: Int?
    var PlaceHolder1: Int?
    var PlaceHolder2: Int?
    var PlaceHolder3: Int?
    
    var easyButton: SKSpriteNode!
    var mediumButton: SKSpriteNode!
    var hardButton: SKSpriteNode!
    var returnButton: SKSpriteNode!
    var optionsNameLabel: SKLabelNode!
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    
    let selectionSound = SKAudioNode(fileNamed: "/Sfx/select.wav")
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/Flying_Force_Combat.mp3")
    
    override init(size: CGSize) {
        super.init(size: size)
        selectionSound.autoplayLooped = false;
        background = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetStart"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        background?.zPosition = 0
        
        easyButton = SKSpriteNode(texture: SKTexture(imageNamed: "easy"))
        easyButton?.name = "easyBtn"
        easyButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+80)
        easyButton?.zPosition = 1
        
        mediumButton = SKSpriteNode(texture: SKTexture(imageNamed: "medium"))
        mediumButton?.name = "mediumBtn"
        mediumButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+20)
        mediumButton?.zPosition = 1
        
        hardButton = SKSpriteNode(texture: SKTexture(imageNamed: "hard"))
        hardButton?.name = "hardBtn"
        hardButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-40)
        hardButton?.zPosition = 1
        
        returnButton = SKSpriteNode(texture: SKTexture(imageNamed: "back"))
        returnButton?.name = "returnBtn"
        returnButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-120)
        returnButton?.zPosition = 1
        
        optionsNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        optionsNameLabel.text = "Options"
        optionsNameLabel.horizontalAlignmentMode = .right
        optionsNameLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 70, y: UIScreen.main.bounds.height / 2+160)
        optionsNameLabel?.zPosition = 1
        
        addChild(background!)
        addChild(easyButton!)
        addChild(mediumButton!)
        addChild(hardButton!)
        addChild(returnButton!)
        addChild(optionsNameLabel!)
        
        //audio
        addChild(selectionSound)
        addChild(backgroundMusic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            //scene?.view?.presentScene(GameScene(size: self.frame.size))
            enumerateChildNodes(withName: "//*", using: { ( node, stop) in
                if node.name == "easyBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.selectionSound.run(SKAction.play());
                        self.difficultyGetter = 1
                    }
                }
                if node.name == "mediumBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.selectionSound.run(SKAction.play());
                        self.difficultyGetter = 2
                    }
                }
                if node.name == "hardBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.selectionSound.run(SKAction.play());
                        self.difficultyGetter = 3
                    }
                }
                if node.name == "returnBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.selectionSound.run(SKAction.play());
                         self.perform(#selector(self.changeSceneMenu), with: nil, afterDelay: 0.6)
                    }
                }
            })
            
        }
        
    }
    
    @objc func changeSceneMenu(){ //change scene after 0.6 sec
        let reveal = SKTransition.reveal(with: .left, duration: 0.6)
        let newScene = MenuScene(size:self.size)
        newScene.scoreGetter = Int?(self.scoreGetter!)
        newScene.difficultyGetter = Int?(self.difficultyGetter!)
        newScene.PlaceHolder1 = Int?(self.PlaceHolder1!)
        newScene.PlaceHolder2 = Int?(self.PlaceHolder2!)
        newScene.PlaceHolder3 = Int?(self.PlaceHolder3!)
        self.view?.presentScene(newScene, transition: reveal)
    }
}
