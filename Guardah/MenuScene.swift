//
//  MenuScene.swift
//  SuperSpaceMan
//
//  Created by Apptist Inc on 2019-03-11.
//  Copyright © 2019 Mark Meritt. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameplayKit

class MenuScene: SKScene {
    
    //TODO: - Use this to create a menu scene
    var startButton: SKSpriteNode?
   
    
    
    //TODO: - Add a main menu and play button
    override init(size: CGSize) {
        super.init(size: size)
        startButton = SKSpriteNode(texture: SKTexture(imageNamed: "start"))
        startButton?.name = "startBtn"
        
        startButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
               
        addChild(startButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            scene?.view?.presentScene(GameScene(size: self.frame.size))
            func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                for t in touches {
                    //TODO: - Create a transition
                    enumerateChildNodes(withName: "//*", using: { ( node, stop) in
                        if node.name == "startBtn" {
                            if node.contains(t.location(in:self))// do whatever here
                            {
                                let reveal = SKTransition.reveal(with: .up,
                                                                 duration: 1)
                                let newScene = GameScene(size:self.size)
                                self.view?.presentScene(newScene, transition: reveal)
                                print("Button Pressed")
                            }
                        }
                    })
                    
                }
            }
        }
    }
}
