import SpriteKit
import GameplayKit

let wallCategory: UInt32 = 0x1 << 0
let playerCategory: UInt32 = 0x00000001 << 1
let enemyCategory: UInt32 = 0x00000001 << 2
let attackPCategory: UInt32 = 0x00000001 << 3
let attackECategory: UInt32 = 0x00000001 << 4
let powerUpCategory: UInt32 = 0x00000001 << 5

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var superSpaceMan: SKSpriteNode!
    var background: SKSpriteNode!
    var background2: SKSpriteNode!
    var backButton: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    
    var lossButton: SKSpriteNode!
    var winButton: SKSpriteNode!
    
    var playerPower = 0
    
    var PlayerSprite: SKSpriteNode!
    var fireButton: SKSpriteNode!
    let moveJoystick = 🕹(withDiameter: 80)
    
    //explosion1
    var explosion1Atlas: SKTextureAtlas! //Spritesheet //1
    var explosion1Frames: [SKTexture]! //frames //2
    var explosion1: SKAction! //Animation //3
    //explosion2
    var explosion2Atlas: SKTextureAtlas! //Spritesheet //1
    var explosion2Frames: [SKTexture]! //frames //2
    var explosion2: SKAction! //Animation //3
    
    var score = 0
    let ScoreLabel = SKLabelNode(fontNamed:"Helvetica")
    
    //MOVES
    var moveShot:SKAction!
    var rotation:SKAction!
    
    //sounds
    let attackSfx = SKAudioNode(fileNamed: "/Sfx/shot2.mp3")
    let selectionSound = SKAudioNode(fileNamed: "/Sfx/select.wav")
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/win_the_game.mp3")
    let shootSound = SKAudioNode(fileNamed: "/Sfx/shot_g.wav")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        attackSfx.autoplayLooped = false;
        selectionSound.autoplayLooped = false;
        shootSound.autoplayLooped = false;
        
        superSpaceMan = SKSpriteNode(texture: SKTexture(imageNamed: "PowerUp"))
        superSpaceMan.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        superSpaceMan?.physicsBody = SKPhysicsBody(rectangleOf: (superSpaceMan?.frame.size)!)
        superSpaceMan?.physicsBody?.affectedByGravity = false;
        superSpaceMan?.physicsBody?.allowsRotation = false;
        superSpaceMan?.physicsBody?.mass = 2.0
        
        superSpaceMan?.physicsBody?.categoryBitMask = powerUpCategory
        superSpaceMan?.physicsBody?.contactTestBitMask = wallCategory | playerCategory
        superSpaceMan?.physicsBody?.collisionBitMask = wallCategory | playerCategory
        
        //moves
        moveShot = SKAction.moveBy(x: 0, y: screenSize.height, duration: 1.6)
        rotation = SKAction.rotate(toAngle: 90, duration: 0.1)
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background.position = CGPoint(x: screenSize.width/2, y:0)
        background.size.width = frame.size.width
        background.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        background?.zPosition = -1
        
        background2 = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background2.position = CGPoint(x: screenSize.width/2, y:screenSize.height)
        background2.size.width = frame.size.width
        //background2.size = CGSize(width: screenSize.width, height: screenSize.height)
        background2.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        background2?.zPosition = -1
        
        //explosions
        //1
        explosion1Atlas = SKTextureAtlas(named: "explosionFire.1") //0
        explosion1Frames = [] //2. Initialize empty texture array
        let explosion1Images = explosion1Atlas.textureNames.count-1//3. count how many frames inside atlas (if this does not work do
        //2
        explosion2Atlas = SKTextureAtlas(named: "explosionLight.1") //0
        explosion2Frames = [] //2. Initialize empty texture array
        let explosion2Images = explosion2Atlas.textureNames.count-1//3. count how many frames inside atlas (if this does not work do
        
        //1
        for i in 0...explosion1Images {
            let texture = "explosion-\(i)" //grab each frame in atlas
            explosion1Frames.append(explosion1Atlas.textureNamed(texture))
        }//add frame to texture array
        explosion1 = SKAction.animate(with: explosion1Frames, timePerFrame: 0.3, resize: true, restore: true)
        //2
        for i in 0...explosion2Images {
            let texture = "explosion2-\(i)" //grab each frame in atlas
            explosion2Frames.append(explosion2Atlas.textureNamed(texture))
        }//add frame to texture array
        explosion2 = SKAction.animate(with: explosion2Frames, timePerFrame: 0.3, resize: true, restore: true)
        
        
        ScoreLabel.text = "SCORE:   \(score)"
        ScoreLabel.fontSize = 16
        ScoreLabel.position = CGPoint(x: screenSize.width * 0.20, y:screenSize.height * 0.95)
        ScoreLabel.fontColor = UIColor.yellow
        ScoreLabel.zPosition = 2
        
        moveJoystick.position = CGPoint(x: screenSize.width * 0.15, y:screenSize.height * 0.2)
        
        lossButton = SKSpriteNode(texture: SKTexture(imageNamed: "youlost"))
        lossButton?.name = "lossBtn"
        lossButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 100)
        lossButton?.zPosition = 1
        
        winButton = SKSpriteNode(texture: SKTexture(imageNamed: "youwon"))
        winButton?.name = "winBtn"
        winButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height / 2 - 100)
        winButton?.zPosition = 1
        
        backButton = SKSpriteNode(texture: SKTexture(imageNamed: "smallerback"))
        backButton?.name = "backBtn"
        backButton?.position = CGPoint(x: screenSize.width * 0.90, y:screenSize.height * 0.97)
        backButton?.zPosition = 1
        
        PlayerSprite = SKSpriteNode(imageNamed: "spacecraft")
        PlayerSprite?.name = "spacecraft1"
        PlayerSprite?.setScale(0.06)
        PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height * 0.2)
        PlayerSprite?.zPosition = 2
        PlayerSprite?.physicsBody = SKPhysicsBody(rectangleOf: (PlayerSprite?.frame.size)!)
        PlayerSprite?.physicsBody?.affectedByGravity = false;
        PlayerSprite?.physicsBody?.allowsRotation = false;
        PlayerSprite?.physicsBody?.mass = 2.0
        
        PlayerSprite?.physicsBody?.categoryBitMask = playerCategory
        PlayerSprite?.physicsBody?.contactTestBitMask = 00011111
        PlayerSprite?.physicsBody?.collisionBitMask = attackECategory | enemyCategory | wallCategory | powerUpCategory
        
        fireButton = SKSpriteNode(imageNamed: "Big_Red_Button")
        fireButton?.name = "fire"
        fireButton?.setScale(0.3)
        fireButton?.position = CGPoint(x: screenSize.width * 0.85, y:screenSize.height * 0.2)
        fireButton?.zPosition = 2
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.categoryBitMask = wallCategory
        self.physicsBody?.contactTestBitMask = playerCategory
        self.physicsBody?.contactTestBitMask = enemyCategory
        self.physicsWorld.contactDelegate = self
        
        addChild(ScoreLabel)
        addChild(background!)
        addChild(background2!)
        addChild(backButton!)
        addChild(PlayerSprite!)
        addChild(superSpaceMan)
        //addChild(lossButton!)
        //addChild(winButton!)
        addChild(moveJoystick)
        addChild(fireButton)
        //superSpaceMan?.run(scaleBack)
        
        addChild(shootSound)
        addChild(selectionSound)
        addChild(attackSfx)
        //addChild(backgroundMusic)
        
        //superSpaceMan.run(SKAction.repeatForever(explosion1))
        //superSpaceMan.run(SKAction.repeatForever(explosion2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == wallCategory {
            print("player first")
        }
        
        if contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == powerUpCategory {
            playerPower = playerPower + 1
            print("player power", playerPower)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            //scene?.view?.presentScene(GameScene(size: self.frame.size))
            enumerateChildNodes(withName: "//*", using: { ( node, stop) in
                if node.name == "backBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.selectionSound.run(SKAction.play());
                         self.perform(#selector(self.changeSceneMenu), with: nil, afterDelay: 0.6)
                    }
                }
                if node.name == "lossBtn" {//not necessary to add delay before changing scene, this isn't on the game
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
                if node.name == "fire" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                      self.attackSfx.run(SKAction.play());
                        var playerShoot:SKSpriteNode!
                        if(self.playerPower == 0){
                        playerShoot = SKSpriteNode(imageNamed: "shot1")
                            playerShoot?.setScale(0.7)
                        }
                        else if(self.playerPower == 1){
                            playerShoot = SKSpriteNode(imageNamed: "shot2")
                            playerShoot?.setScale(0.7)
                        }
                        else if(self.playerPower == 2){
                            playerShoot = SKSpriteNode(imageNamed: "shot3")
                            playerShoot?.setScale(0.7)
                        }
                        else if(self.playerPower >= 3){
                            playerShoot = SKSpriteNode(imageNamed: "shot4")
                            playerShoot?.setScale(0.7)
                        }
                        playerShoot.position = CGPoint(x: self.PlayerSprite.position.x, y: self.PlayerSprite.position.y + 10)
                        playerShoot.run(self.moveShot)
                        
                        self.addChild(playerShoot)
                    }
                }
                
                })
            }
        }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        moveJoystick.on(.move) { [unowned self] joystick in
            guard let PlayerSprite = self.PlayerSprite else {
                return
            }
            
            let pVelocity = joystick.velocity;
            let speed = CGFloat(0.09)
            
            PlayerSprite.position = CGPoint(x: PlayerSprite.position.x + (pVelocity.x * speed), y: PlayerSprite.position.y + (pVelocity.y * speed))
            
            
        }
        
        background.run(SKAction.moveBy(x:0, y:-5, duration: 1))
        background2.run(SKAction.moveBy(x:0, y:-5, duration: 1))
        //   print(gokuSprite.position)
        if(background2.position.y <= 0.0){
            background.position = CGPoint(x:size.width/2.0, y:0)
            background2.position = CGPoint(x:size.width/2.0, y:size.height)
        }
        
    }
    
    @objc func changeSceneMenu(){ //change scene after 0.6 sec
        let reveal = SKTransition.reveal(with: .left, duration: 0.6)
        let newScene = MenuScene(size:self.size)
        self.view?.presentScene(newScene, transition: reveal)
    }
}
