import SpriteKit
import GameplayKit

let wallCategory: UInt32 = 0x1 << 0
let ballCategory: UInt32 = 0x1 << 1
let playerCategory: UInt32 = 0x1 << 2

class GameScene: SKScene {
    
    var superSpaceMan: SKSpriteNode?
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
   
    override init(size: CGSize) {
        super.init(size: size)
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        
        //addChild(superSpaceMan!)
         addChild(background!)
        //superSpaceMan?.run(scaleBack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
  
}
