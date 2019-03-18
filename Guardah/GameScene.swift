import SpriteKit
import GameplayKit

let wallCategory: UInt32 = 0x1 << 0
let ballCategory: UInt32 = 0x1 << 1
let playerCategory: UInt32 = 0x1 << 2

class GameScene: SKScene {
    
    var superSpaceMan: SKSpriteNode?
    var background: SKSpriteNode!
    var backButton: SKSpriteNode!
    
    var lossButton: SKSpriteNode!
    var winButton: SKSpriteNode!
    
    var PlayerSprite: SKSpriteNode!
    
    let screenSize: CGRect = UIScreen.main.bounds
   
    override init(size: CGSize) {
        super.init(size: size)
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        background?.zPosition = 0
        
        lossButton = SKSpriteNode(texture: SKTexture(imageNamed: "youlost"))
        lossButton?.name = "lossBtn"
        lossButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 100)
        lossButton?.zPosition = 1
        
        winButton = SKSpriteNode(texture: SKTexture(imageNamed: "youwon"))
        winButton?.name = "winBtn"
        winButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 100)
        winButton?.zPosition = 1
        
        backButton = SKSpriteNode(texture: SKTexture(imageNamed: "smallerback"))
        backButton?.name = "backBtn"
        backButton?.position = CGPoint(x: 10, y: screenSize.height - 15)
        backButton?.zPosition = 1
        
        PlayerSprite = SKSpriteNode(imageNamed: "spacecraft")
        PlayerSprite?.name = "spacecraft1"
        PlayerSprite?.setScale(0.08)
        PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        PlayerSprite?.zPosition = 2
        
        //addChild(superSpaceMan!)
        addChild(background!)
        addChild(backButton!)
        addChild(PlayerSprite!)
        addChild(lossButton!)
        addChild(winButton!)
        //superSpaceMan?.run(scaleBack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            //scene?.view?.presentScene(GameScene(size: self.frame.size))
            enumerateChildNodes(withName: "//*", using: { ( node, stop) in
                if node.name == "backBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        let reveal = SKTransition.reveal(with: .up,                                                                duration: 1)
                        let newScene = MenuScene(size:self.size)
                        self.view?.presentScene(newScene, transition: reveal)
                        print("Button Pressed")
                    }
                }
                if node.name == "lossBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        let reveal = SKTransition.reveal(with: .up,                                                                duration: 1)
                        let newScene = GameoverScene(size:self.size)
                        self.view?.presentScene(newScene, transition: reveal)
                        print("Button Pressed")
                    }
                }
                if node.name == "winBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        let reveal = SKTransition.reveal(with: .up,                                                                duration: 1)
                        let newScene = WinScene(size:self.size)
                        self.view?.presentScene(newScene, transition: reveal)
                        print("Button Pressed")
                    }
                }
                
            })
            
        }
}
}
