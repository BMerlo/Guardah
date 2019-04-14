//
//  GameViewController.swift
//  Guardah
//
//  Created by Tech on 2019-03-13.
//  Copyright © 2019 PTBVGC. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class Singleton {
    let shared = Int()
    
}

class GameViewController: UIViewController {
    var scene: MenuScene!
    //var scene: GameScene!
    //var scene: WinScene!
    //var scene: GameoverScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            // Set the scale mode to scale to fit the window
            scene = MenuScene(size: self.view.frame.size)
            //scene = HighscoreScene(size: self.view.frame.size)
            //scene = GameScene(size: self.view.frame.size)
             //scene = WinScene(size: self.view.frame.size)
            //scene = GameoverScene(size: self.view.frame.size)

            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
