
import Foundation
import SpriteKit

class HighscoreScene: SKScene {
    
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    var returnButton: SKSpriteNode!
    var highscoreNameLabel: SKLabelNode!
    
    var highscore1: SKLabelNode!
    var highscore2: SKLabelNode!
    var highscore3: SKLabelNode!
    
    
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
        
        highscoreNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        highscoreNameLabel.text = "Highscores"
        highscoreNameLabel.horizontalAlignmentMode = .right
        highscoreNameLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 70, y: UIScreen.main.bounds.height / 2+160)
        highscoreNameLabel.zPosition = 1
        
        highscore1 = SKLabelNode(fontNamed: "Chalkduster")
        highscore1.text = "Highscore: "
        highscore1.horizontalAlignmentMode = .right
        highscore1.position = CGPoint(x: UIScreen.main.bounds.width / 2-20, y: UIScreen.main.bounds.height / 2+60)
        highscore1.zPosition = 1
        
        highscore2 = SKLabelNode(fontNamed: "Chalkduster")
        highscore2.text = "Highscore: "
        highscore2.horizontalAlignmentMode = .right
        highscore2.position = CGPoint(x: UIScreen.main.bounds.width / 2-20, y: UIScreen.main.bounds.height / 2)
        highscore2.zPosition = 1
        
        highscore3 = SKLabelNode(fontNamed: "Chalkduster")
        highscore3.text = "Highscore: "
        highscore3.horizontalAlignmentMode = .right
        highscore3.position = CGPoint(x: UIScreen.main.bounds.width / 2-20, y: UIScreen.main.bounds.height / 2-60)
        highscore3.zPosition = 1
        
        highscoreValue1 = SKLabelNode(fontNamed: "Chalkduster")
        highscoreValue1.text = "10000"
        highscoreValue1.horizontalAlignmentMode = .right
        highscoreValue1.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2+60)
        highscoreValue1.zPosition = 1
        
        highscoreValue2 = SKLabelNode(fontNamed: "Chalkduster")
        highscoreValue2.text = "1000"
        highscoreValue2.horizontalAlignmentMode = .right
        highscoreValue2.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2)
        highscoreValue2.zPosition = 1
        
        highscoreValue3 = SKLabelNode(fontNamed: "Chalkduster")
        highscoreValue3.text = "100"
        highscoreValue3.horizontalAlignmentMode = .right
        highscoreValue3.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: UIScreen.main.bounds.height / 2-60)
        highscoreValue3.zPosition = 1
        
        
        addChild(background!)
        addChild(returnButton!)
        addChild(highscoreNameLabel!)
        
        addChild(highscore1!)
        addChild(highscore2!)
        addChild(highscore3!)
        
        addChild(highscoreValue1!)
        addChild(highscoreValue2!)
        addChild(highscoreValue3!)
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
