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
    var scoreGetter: Int?
    
    var startButton: SKSpriteNode!
    var optionsButton: SKSpriteNode!
    var highScoreButton: SKSpriteNode!
    //var quitButton: SKSpriteNode!  //removed due to apple store restrictions
    var gameNameLabel: SKLabelNode!
    var spriteLogo: SKSpriteNode!
    var fireParticle: SKEmitterNode!
    
    var PlaceHolder1: Int?
    var PlaceHolder2: Int?
    var PlaceHolder3: Int?
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    
    let selectionSound = SKAudioNode(fileNamed: "/Sfx/select.wav")
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/Flying_Force_Combat.mp3")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        //print(scoreGetter)
        selectionSound.autoplayLooped = false;
        
        fireParticle = SKEmitterNode(fileNamed: "MyFireParticle.sks")
        fireParticle.name = "fireme"
        fireParticle.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-60)
        fireParticle?.zPosition = 1
        
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetStart"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        background.zPosition = 0
        
        startButton = SKSpriteNode(texture: SKTexture(imageNamed: "new game"))
        startButton?.name = "startBtn"
        startButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+80)
        startButton?.zPosition = 2
        
        highScoreButton = SKSpriteNode(texture: SKTexture(imageNamed: "highscore"))
        highScoreButton?.name = "highscoreBtn"
        highScoreButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+20)
        highScoreButton?.zPosition = 2
        
        optionsButton = SKSpriteNode(texture: SKTexture(imageNamed: "options"))
        optionsButton?.name = "optionsBtn"
        optionsButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-40)
        optionsButton?.zPosition = 2
        /*
        quitButton = SKSpriteNode(texture: SKTexture(imageNamed: "quit"))
        quitButton?.name = "quitBtn"
        quitButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-100)
        quitButton?.zPosition = 2
        */
        gameNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameNameLabel?.text = "Guarda"
        gameNameLabel?.horizontalAlignmentMode = .right
        gameNameLabel?.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 70, y: UIScreen.main.bounds.height / 2+160)
        gameNameLabel?.zPosition = 2
        
        spriteLogo = SKSpriteNode(imageNamed: "spacecraft")
        spriteLogo?.name = "spacecraft1"
        spriteLogo?.setScale(0.08)
        spriteLogo?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+220)
        spriteLogo?.zPosition = 2
        
        addChild(background!)
        addChild(highScoreButton!)
        addChild(startButton!)
        addChild(optionsButton!)
        //addChild(quitButton!)
        addChild(gameNameLabel!)
        addChild(spriteLogo!)
        addChild(fireParticle!)
        
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
               if node.name == "startBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                       {
                         self.selectionSound.run(SKAction.play());
                         self.perform(#selector(self.changeSceneGame), with: nil, afterDelay: 0.6)
                       }
            }
            if node.name == "optionsBtn" {
                if node.contains(t.location(in:self))// do whatever here
                {
                    self.selectionSound.run(SKAction.play());
                    self.perform(#selector(self.changeSceneOptions), with: nil, afterDelay: 0.6)
                }
            }
            if node.name == "highscoreBtn" {
                if node.contains(t.location(in:self))// do whatever here
                {
                   self.selectionSound.run(SKAction.play());
                    print("the value in main menu of scoreGetter", self.scoreGetter!)
                   self.perform(#selector(self.changeSceneHighScore), with: nil, afterDelay: 0.6)
                }
            }
           })
                    
        }
    }
    
    @objc func changeSceneGame(){ //change scene after 1 sec
        let reveal = SKTransition.reveal(with: .up, duration: 0.6)
        let newScene = GameScene(size:self.size)
        self.view?.presentScene(newScene, transition: reveal)
    }
    
    @objc func changeSceneOptions(){ //change scene after 1 sec
        let reveal = SKTransition.reveal(with: .right, duration: 0.6)
        let newScene = OptionsScene(size:self.size)
        self.view?.presentScene(newScene, transition: reveal)
    }
    
    @objc func changeSceneHighScore(){ //change scene after 1 sec
        let reveal = SKTransition.reveal(with: .right, duration: 0.6)
        let newScene = HighscoreScene(size:self.size)
        newScene.scoreGetter = Int?(self.scoreGetter!)
        newScene.PlaceHolder1 = Int?(self.PlaceHolder1!)
        newScene.PlaceHolder2 = Int?(self.PlaceHolder2!)
        newScene.PlaceHolder3 = Int?(self.PlaceHolder3!)        
        
        self.view?.presentScene(newScene, transition: reveal)
    }
}
