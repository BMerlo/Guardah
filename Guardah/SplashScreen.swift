
import Foundation
import SpriteKit

class SplashScreen: SKScene {
    
    //TODO: - Use this to create a menu scene
    var startButton: SKSpriteNode?
        let screenSize: CGRect = UIScreen.main.bounds
    
    //TODO: - Add a main menu and play button
    override init(size: CGSize) {
        super.init(size: size)
        startButton = SKSpriteNode(texture: SKTexture(imageNamed: "start"))
        //startButton.
        
        addChild(startButton!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            scene?.view?.presentScene(GameScene(size: self.frame.size))
        }
    }
}
