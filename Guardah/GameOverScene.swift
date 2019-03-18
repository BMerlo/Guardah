
import Foundation
import SpriteKit

class GameoverScene: SKScene {
    
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    var returnButton: SKSpriteNode!
    var lossNameLabel: SKLabelNode!
    
    var message1: SKLabelNode!
    var message2: SKLabelNode!
    var message3: SKLabelNode!
    
    
    var highscoreValue1: SKLabelNode!
    var highscoreValue2: SKLabelNode!
    var highscoreValue3: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetStart"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        background?.zPosition = 0
        
        returnButton = SKSpriteNode(texture: SKTexture(imageNamed: "back"))
        returnButton?.name = "returnBtn"
        returnButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-120)
        returnButton?.zPosition = 1
        
        lossNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        lossNameLabel.text = "Failed!"
        lossNameLabel.horizontalAlignmentMode = .right
        lossNameLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 70, y: UIScreen.main.bounds.height / 2+160)
        lossNameLabel.zPosition = 1
        
        message1 = SKLabelNode(fontNamed: "Chalkduster")
        message1.text = "You have failed"
        message1.horizontalAlignmentMode = .right
        message1.position = CGPoint(x: UIScreen.main.bounds.width / 2+150, y: UIScreen.main.bounds.height / 2+60)
        message1.zPosition = 1
        
        message2 = SKLabelNode(fontNamed: "Chalkduster")
        message2.text = "in your mission"
        message2.horizontalAlignmentMode = .right
        message2.position = CGPoint(x: UIScreen.main.bounds.width / 2+150, y: UIScreen.main.bounds.height / 2)
        message2.zPosition = 1
        
        message3 = SKLabelNode(fontNamed: "Chalkduster")
        message3.text = "to defeat Bohr-iz"
        message3.horizontalAlignmentMode = .right
        message3.position = CGPoint(x: UIScreen.main.bounds.width / 2+170, y: UIScreen.main.bounds.height / 2-60)
        message3.zPosition = 1
        
        
        addChild(background!)
        addChild(returnButton!)
        addChild(lossNameLabel!)
        
        addChild(message1!)
        addChild(message2!)
        addChild(message3!)
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
