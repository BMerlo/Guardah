import SpriteKit
import GameplayKit

let wallCategory: UInt32 = 0x1 << 0
let ballCategory: UInt32 = 0x1 << 1
let playerCategory: UInt32 = 0x1 << 2

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var superSpaceMan: SKSpriteNode?
    var background: SKSpriteNode?
    
    var atlas: [SKTextureAtlas]!
    
    var gokuSprite: SKSpriteNode?
    
    
    
    var idleAnimation: SKAction?
    var idleFrames: [SKTexture]!
    
    var punchAnimation: SKAction?
    var punchFrames: [SKTexture]!
    
    var punchAnimation1: SKAction?
    var punchFrames1: [SKTexture]!
    
    var punchAnimation2: SKAction?
    var punchFrames2: [SKTexture]!
    
    var punchAnimation3: SKAction?
    var punchFrames3: [SKTexture]!
    
    var punchAnimation4: SKAction?
    var punchFrames4: [SKTexture]!
    
    var punchAnimation5: SKAction?
    var punchFrames5: [SKTexture]!
    
    var punchAnimation6: SKAction?
    var punchFrames6: [SKTexture]!
    
    let scaleBack = SKAction.scale(by: 2/3, duration:1)
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        atlas = [SKTextureAtlas]()
        atlas.append(SKTextureAtlas(named: "attackCharge.1"))
        atlas.append(SKTextureAtlas(named: "fall.1"))
        atlas.append(SKTextureAtlas(named: "flip.1"))
        atlas.append(SKTextureAtlas(named: "fly.1"))
        atlas.append(SKTextureAtlas(named: "crouch.1"))
        atlas.append(SKTextureAtlas(named: "kick.1"))
        
        
        var punchFrames1: [SKTexture] = []
        var punchFrames2: [SKTexture] = []
        var punchFrames3: [SKTexture] = []
        var punchFrames4: [SKTexture] = []
        var punchFrames5: [SKTexture] = []
        var punchFrames6: [SKTexture] = []
        
        
        let numImages0 = atlas[0].textureNames.count - 1
        let numImages1 = atlas[1].textureNames.count - 1
        let numImages2 = atlas[2].textureNames.count - 1
        let numImages3 = atlas[3].textureNames.count - 1
        let numImages4 = atlas[4].textureNames.count - 1
        let numImages5 = atlas[5].textureNames.count - 1
        
              
        gokuSprite = SKSpriteNode(texture: SKTexture(imageNamed: "idle0"))
        gokuSprite?.name = "krilin"
        gokuSprite?.isUserInteractionEnabled = false
        superSpaceMan=SKSpriteNode(texture: SKTexture(imageNamed: "fly0"))
        
        gokuSprite?.run(SKAction.repeatForever(SKAction.animate(with: punchFrames2, timePerFrame: 0.2, resize: true, restore: true)))
        superSpaceMan?.run(SKAction.repeatForever(SKAction.animate(with: punchFrames2, timePerFrame: 0.2, resize: true, restore: true)))
        
        idleFrames = [SKTexture]()
        idleFrames.append(SKTexture(imageNamed: "idle1"))
        idleFrames.append(SKTexture(imageNamed: "idle12"))
        
        addChild(gokuSprite!)
        
        gokuSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
        gokuSprite?.physicsBody = SKPhysicsBody(rectangleOf: (gokuSprite?.frame.size)!)
        gokuSprite?.physicsBody?.affectedByGravity = true
        gokuSprite?.physicsBody?.mass = 2.0
        
        gokuSprite?.physicsBody?.categoryBitMask = playerCategory
        gokuSprite?.physicsBody?.contactTestBitMask = wallCategory
        gokuSprite?.physicsBody?.collisionBitMask = wallCategory
        
        punchAnimation1 = SKAction.animate(with: punchFrames1, timePerFrame: 0.3, resize: true, restore: true)
        punchAnimation2 = SKAction.animate(with: punchFrames2, timePerFrame: 0.3, resize: true, restore: true)
        punchAnimation3 = SKAction.animate(with: punchFrames3, timePerFrame: 0.3, resize: true, restore: true)
        punchAnimation4 = SKAction.animate(with: punchFrames4, timePerFrame: 0.3, resize: true, restore: true)
        punchAnimation5 = SKAction.animate(with: punchFrames5, timePerFrame: 0.3, resize: true, restore: true)
        punchAnimation6 = SKAction.animate(with: punchFrames6, timePerFrame: 0.3, resize: true, restore: true)
        
        superSpaceMan = SKSpriteNode(imageNamed: "Player")
        superSpaceMan?.physicsBody = SKPhysicsBody(rectangleOf: (superSpaceMan?.size)!)
        superSpaceMan?.physicsBody?.affectedByGravity = true
        superSpaceMan?.physicsBody?.isDynamic = true
        superSpaceMan?.physicsBody?.mass = 2.0
        superSpaceMan?.physicsBody?.categoryBitMask = playerCategory
        
        superSpaceMan?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.categoryBitMask = wallCategory
        self.physicsBody?.contactTestBitMask = playerCategory
        self.physicsWorld.contactDelegate = self
        
        background = SKSpriteNode(imageNamed: "Background")
        background?.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
        
        // powerUp?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + UIScreen.main.bounds.height / 4)
        
        addChild(superSpaceMan!)
        superSpaceMan?.run(scaleBack)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch=touches.first!
        //let locate=touch.location(in: self)
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "krilin"
            {
               // scene?.view?.presentScene(GameOverScene(size: self.frame.size))
            }
        }
        
        gokuSprite?.run(SKAction.move(to: (CGPoint(x: positionInScene.x, y: positionInScene.y)), duration: 1.0))
        for t in touches {
            
            if t.tapCount >= 2 {
                gokuSprite?.run(SKAction.sequence([punchAnimation6!, punchAnimation5!, punchAnimation4!, punchAnimation3!, punchAnimation2!, punchAnimation1!]))
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == wallCategory {
            print("player first")
        }
        
        if contact.bodyA.categoryBitMask == wallCategory && contact.bodyB.categoryBitMask == playerCategory {
            
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        superSpaceMan?.run(SKAction.sequence([punchAnimation4!]))
        
        let follow = SKAction.move(to: (gokuSprite?.position)!, duration: 2)
        let color = SKAction.colorize(with: UIColor.green, colorBlendFactor: 2.0, duration: 1.0)
        
        superSpaceMan?.run(follow)
        
        if(superSpaceMan?.intersects(gokuSprite!))!
        {
            superSpaceMan?.run(color)
            superSpaceMan?.run(punchAnimation6!)
        }
    }
}
