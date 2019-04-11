import SpriteKit
import GameplayKit

let wallCategory: UInt32 = 0x1 << 0
let playerCategory: UInt32 = 0x00000001 << 1
let enemyCategory: UInt32 = 0x00000001 << 2
let attackPCategory: UInt32 = 0x00000001 << 3
let attackECategory: UInt32 = 0x00000001 << 4
let powerUpCategory: UInt32 = 0x00000001 << 5

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var scoreGetter: Int?
    
    var background: SKSpriteNode!
    var background2: SKSpriteNode!
    var backButton: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    var playerLife1: SKSpriteNode!
    var playerLife2: SKSpriteNode!
    var playerLife3: SKSpriteNode!
    
    var bossDead = false
    var playerWon = true
    
    var revived1 = true
    var revived2 = true
    var revived3 = true
    var gameOver = true
    
    var playerLives = 3
    
    //ENEMIES
    var bossHolder: SKSpriteNode!
    var bossLeftArmHolder: SKSpriteNode!
    var bossRightArmHolder: SKSpriteNode!
    var bosHeadolder: SKSpriteNode!
    
    var redBallHolder:SKSpriteNode!
    var redBallHolderR:SKSpriteNode!
    var redBallHolderL:SKSpriteNode!
    
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
    
    //timers
    var timerToShoot = Timer()
    var enemiesTimer = Timer()
    var timerAI = Timer()
    
    //MOVES
    var moveShot:SKAction!
    var moveEnemyShot:SKAction!
    var moveDiagLeftToRight:SKAction!
    var moveDiagRightToLeft:SKAction!
    var moveDiagRightToLeft3:SKAction!
    var moveDiagLeftToRightEnemy:SKAction!
    var moveDiagRightToLeftEnemy:SKAction!
    var moveDownEnemy:SKAction!
    var movePowerUpLeftToRight:SKAction!
    var movePowerUpRightToLeft:SKAction!
    
    var movePowerUp2LeftToRight:SKAction!
    var movePowerUp2RightToLeft:SKAction!
    
    var bossActive = false
    var bossHeadAlive = true
    var bossRightArmlive = true
    var bossLeftArmlive = true
    var bossRightArmLife = 3
    var bossLeftArmLife = 3
    var bossHeadLife = 5
    //MOVE BOSS
    var moveBossDiagLeftToRightDown:SKAction!
    var moveBossDiagRightToLeftDown:SKAction!
    var moveBossDiagLeftToRightUp:SKAction!
    var moveBossDiagRightToLeftUp:SKAction!
    
    var moveBossArmLeft:SKAction!
    var moveBossArmRight:SKAction!
    var moveBossArmUp:SKAction!
    var moveBossArmDown:SKAction!
    
    //MOVE ATTACK BOSS
    var moveBallDown:SKAction!
    
    //powerups
    var powerUp1exists = true
    var powerUp2exists = true
    var powerUp3exists = true
    var powerUpsCounter = 0
    var timerToSpawnPowerUps = 0.0
    var powerUpTimer = Timer()
    var powerUp3Holder:SKSpriteNode!
    
    //enemy waves
    var enemyWave1exists = true
    var enemyWave2exists = true
    var enemyWave3exists = true
    
    var enemyHolder4:SKSpriteNode!
    var enemyHolder5:SKSpriteNode!
    var enemyHolder6:SKSpriteNode!
    
    var enemyHolder7:SKSpriteNode!
    var enemyHolder8:SKSpriteNode!
    var enemyHolder9:SKSpriteNode!
    
    var RandomNumber = 100
    
    var enemy1: SKSpriteNode!
    var enemy2: SKSpriteNode!
    var enemy3: SKSpriteNode!
    var enemy4: SKSpriteNode!
    var enemy5: SKSpriteNode!
    var enemy6: SKSpriteNode!
    
    
    //highscores
    var PlaceHolder1: Int?
    var PlaceHolder2: Int?
    var PlaceHolder3: Int?
    
    var headCanAttack = true
    
    var attackHeadBossM:SKSpriteNode!
    var attackHeadBossL:SKSpriteNode!
    var attackHeadBossR:SKSpriteNode!
    
    var enemiesWaveCounter = 0
    
    //sounds
    let attackSfx = SKAction.playSoundFileNamed("/Sfx/shot2.mp3", waitForCompletion: false)
    let enemyAttackSfx = SKAction.playSoundFileNamed("/Sfx/shot3.mp3", waitForCompletion: false)
    let selectionSound = SKAction.playSoundFileNamed("/Sfx/select.wav", waitForCompletion: false)
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/win_the_game.mp3")
    let powerUpSound = SKAction.playSoundFileNamed("/Sfx/shot_g.wav", waitForCompletion: false)
    let backgroundBossMusic = SKAudioNode(fileNamed: "/Music/weak_interaction.mp3")
    let partDied = SKAction.playSoundFileNamed("/Sfx/cry2.mp3", waitForCompletion: false)
    let ballDied = SKAction.playSoundFileNamed("/Sfx/slimeball.wav", waitForCompletion: false)
    let playerDied = SKAction.playSoundFileNamed("/Sfx/damage.wav", waitForCompletion: false)
    
    override init(size: CGSize) {
        super.init(size: size)
        
        //score
        PlaceHolder1 = 1000
        PlaceHolder2 = 500
        PlaceHolder3 = 100
        
       
        
        enemy1 = SKSpriteNode(texture: SKTexture(imageNamed: "enemy1"))
        enemy1.setScale(0.5)
        enemy1.position = CGPoint(x: screenSize.width * 1.17, y:screenSize.height * 0.8)
        enemy1?.physicsBody = SKPhysicsBody(rectangleOf: (enemy1?.frame.size)!)
        enemy1?.physicsBody?.affectedByGravity = false;
        enemy1?.physicsBody?.allowsRotation = false;
        enemy1?.physicsBody?.mass = 2.0
        enemy1.name = "enemy1"
        
        enemy1?.physicsBody?.categoryBitMask = enemyCategory
        enemy1?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
        enemy1?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
        
        enemy2 = SKSpriteNode(texture: SKTexture(imageNamed: "enemy2"))
        enemy2.setScale(0.5)
        enemy2.position = CGPoint(x: screenSize.width * 1.25, y:screenSize.height * 0.9)
        enemy2?.physicsBody = SKPhysicsBody(rectangleOf: (enemy1?.frame.size)!)
        enemy2?.physicsBody?.affectedByGravity = false;
        enemy2?.physicsBody?.allowsRotation = false;
        enemy2?.physicsBody?.mass = 2.0
        enemy2.name = "enemy2"
        
        enemy2?.physicsBody?.categoryBitMask = enemyCategory
        enemy2?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
        enemy2?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
        
        enemy3 = SKSpriteNode(texture: SKTexture(imageNamed: "enemy3"))
        enemy3.setScale(0.5)
        enemy3.position = CGPoint(x: screenSize.width * 1.4, y:screenSize.height * 0.7)
        enemy3?.physicsBody = SKPhysicsBody(rectangleOf: (enemy1?.frame.size)!)
        enemy3?.physicsBody?.affectedByGravity = false;
        enemy3?.physicsBody?.allowsRotation = false;
        enemy3?.physicsBody?.mass = 2.0
        enemy3.name = "enemy3"
        
        enemy3?.physicsBody?.categoryBitMask = enemyCategory
        enemy3?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
        enemy3?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
        
        addChild(enemy1)
        addChild(enemy2)
        addChild(enemy3)
        
        enemy4 = SKSpriteNode(texture: SKTexture(imageNamed: "enemy1"))
        enemy4.setScale(0.5)
        enemy4.position = CGPoint(x: -screenSize.width * 0.62, y:screenSize.height * 1.2)
        enemy4?.physicsBody = SKPhysicsBody(rectangleOf: (enemy4?.frame.size)!)
        enemy4?.physicsBody?.affectedByGravity = false;
        enemy4?.physicsBody?.allowsRotation = false;
        enemy4?.physicsBody?.mass = 2.0
        enemy4.name = "enemy4"
        
        enemy4?.physicsBody?.categoryBitMask = enemyCategory
        enemy4?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
        enemy4?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
        
        enemy5 = SKSpriteNode(texture: SKTexture(imageNamed: "enemy2"))
        enemy5.setScale(0.5)
        enemy5.position = CGPoint(x: -screenSize.width * 0.48, y:screenSize.height * 1.1)
        enemy5?.physicsBody = SKPhysicsBody(rectangleOf: (enemy5?.frame.size)!)
        enemy5?.physicsBody?.affectedByGravity = false;
        enemy5?.physicsBody?.allowsRotation = false;
        enemy5?.physicsBody?.mass = 2.0
        enemy5.name = "enemy5"
        
        enemy5?.physicsBody?.categoryBitMask = enemyCategory
        enemy5?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
        enemy5?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
        
        enemy6 = SKSpriteNode(texture: SKTexture(imageNamed: "enemy3"))
        enemy6.setScale(0.5)
        enemy6.position = CGPoint(x: -screenSize.width * 0.75, y:screenSize.height * 1.1)
        enemy6?.physicsBody = SKPhysicsBody(rectangleOf: (enemy6?.frame.size)!)
        enemy6?.physicsBody?.affectedByGravity = false;
        enemy6?.physicsBody?.allowsRotation = false;
        enemy6?.physicsBody?.mass = 2.0
        enemy6.name = "enemy6"
        
        enemy6?.physicsBody?.categoryBitMask = enemyCategory
        enemy6?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
        enemy6?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
        
        addChild(enemy4)
        addChild(enemy5)
        addChild(enemy6)
        
        backgroundBossMusic.autoplayLooped = false;
        addChild(backgroundBossMusic)
        
         let timerToShoot = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(fire(timer:)), userInfo: nil, repeats: true)
        
        let timerToShoot2 = Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(fire2(timer:)), userInfo: nil, repeats: true)
        
        let powerUpTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(updatePowerUp(timer:)), userInfo: nil, repeats: true)
        
         let enemiesTimer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(updateEnemiesSpawn(timer:)), userInfo: nil, repeats: true)
        
        let timerAI = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(BossRandomAI(timer:)), userInfo: nil, repeats: true)
        
        //moves
        moveShot = SKAction.moveBy(x: 0, y: screenSize.height, duration: 1.6)
        moveEnemyShot = SKAction.moveBy(x: 0, y: -screenSize.height * 2, duration: 13.0)
        moveDiagLeftToRight = SKAction.moveBy(x: -screenSize.width * 2.0, y: -screenSize.height * 0.5, duration: 10.0)
        moveDiagRightToLeft = SKAction.moveBy(x: screenSize.width * 0.5 * 2, y: -screenSize.height * 0.5, duration: 5.0)
        //[pwerUp3 movenent
        moveDiagRightToLeft3 = SKAction.moveBy(x: screenSize.width * 3, y: -screenSize.height * 3, duration: 28.0)
        
        moveDiagLeftToRightEnemy = SKAction.moveBy(x: -screenSize.width * 2.0, y: -screenSize.height * 0.5, duration: 20.0)
        
        moveDiagRightToLeftEnemy = SKAction.moveBy(x: screenSize.width * 2.0, y: -screenSize.height * 0.5, duration: 20.0)
        
        movePowerUpLeftToRight = SKAction.moveBy(x: -screenSize.width, y: -screenSize.height * 0.5, duration: 20.0)
        movePowerUpRightToLeft =  SKAction.moveBy(x: screenSize.width, y: screenSize.height * 0.5, duration: 20.0)
        movePowerUp2LeftToRight = SKAction.moveBy(x: screenSize.width, y: -screenSize.height * 0.5, duration: 20.0)
        movePowerUp2RightToLeft =  SKAction.moveBy(x: -screenSize.width, y: screenSize.height * 0.5, duration: 20.0)
        
        //MOVES BOSS
        moveDownEnemy = SKAction.moveBy(x: 0.0, y: -screenSize.height * 0.08, duration: 2.0)
        moveBossDiagLeftToRightDown = SKAction.moveBy(x: screenSize.width * 0.1, y: -screenSize.height * 0.1, duration: 2.0)
        moveBossDiagLeftToRightUp = SKAction.moveBy(x: screenSize.width * 0.1, y: screenSize.height * 0.1, duration: 2.0)
        moveBossDiagRightToLeftUp = SKAction.moveBy(x: -screenSize.width * 0.1, y: screenSize.height * 0.1, duration: 2.0)
        moveBossDiagRightToLeftDown = SKAction.moveBy(x: -screenSize.width * 0.1, y: -screenSize.height * 0.1, duration: 2.0)
        
        moveBossArmLeft = SKAction.moveBy(x: -screenSize.width * 0.13, y: 0.0, duration: 2.0)
        moveBossArmRight = SKAction.moveBy(x: screenSize.width * 0.13, y: 0.0, duration: 2.0)
        moveBossArmUp = SKAction.moveBy(x: 0.0, y: screenSize.height * 0.1, duration: 2.0)
        moveBossArmDown = SKAction.moveBy(x: 0.0, y: -screenSize.height * 0.1, duration: 2.0)
        
        //MOVE ATTACK BOSS
        moveBallDown = SKAction.moveBy(x: 0, y: -screenSize.height * 2, duration: 30.6)
        
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background.position = CGPoint(x: screenSize.width/2, y:0)
        background.size.width = frame.size.width
        background.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        background?.zPosition = -1
        
        background2 = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background2.position = CGPoint(x: screenSize.width/2, y:screenSize.height)
        background2.size.width = frame.size.width
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
        
        backButton = SKSpriteNode(texture: SKTexture(imageNamed: "smallerback"))
        backButton?.name = "backBtn"
        backButton?.position = CGPoint(x: screenSize.width * 0.90, y:screenSize.height * 0.97)
        backButton?.zPosition = 1
        
        playerLife1 = SKSpriteNode(imageNamed: "spacecraft")
        playerLife1?.setScale(0.3)
        playerLife1?.position = CGPoint(x: screenSize.width * 0.02, y:screenSize.height * 0.96)
        playerLife1?.zPosition = 3
        
        playerLife2 = SKSpriteNode(imageNamed: "spacecraft")
        playerLife2?.setScale(0.3)
        playerLife2?.position = CGPoint(x: screenSize.width * 0.02, y:screenSize.height * 0.92)
        playerLife2?.zPosition = 3
        
        playerLife3 = SKSpriteNode(imageNamed: "spacecraft")
        playerLife3?.setScale(0.3)
        playerLife3?.position = CGPoint(x: screenSize.width * 0.02, y:screenSize.height * 0.88)
        playerLife3?.zPosition = 3
        
        PlayerSprite = SKSpriteNode(imageNamed: "spacecraft")
        PlayerSprite?.name = "spacecraft1"
        
        PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height * 0.2)
        PlayerSprite?.zPosition = 1
        PlayerSprite?.setScale(0.6)
        PlayerSprite?.physicsBody = SKPhysicsBody(rectangleOf: (PlayerSprite?.frame.size)!)
        PlayerSprite?.physicsBody?.affectedByGravity = false;
        PlayerSprite?.physicsBody?.allowsRotation = false;
        PlayerSprite?.physicsBody?.mass = 0.5
        
        PlayerSprite?.physicsBody?.categoryBitMask = playerCategory
        PlayerSprite?.physicsBody?.contactTestBitMask = wallCategory / attackECategory
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
        addChild(playerLife1)
        addChild(playerLife2)
        addChild(playerLife3)
        addChild(backButton!)
        addChild(PlayerSprite!)
        
        addChild(moveJoystick)
        addChild(fireButton)
        
        addChild(backgroundMusic)
        
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
            run(powerUpSound)
            playerPower = playerPower + 1
            score = score + 500
            contact.bodyB.node?.removeFromParent()
            print("player power", playerPower)
        }
        
        if contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == enemyCategory {
            print("enemy with player")
            run(playerDied)
            PlayerSprite.run(SKAction.repeat(explosion1, count: 1), completion: {
                //contact.bodyA.node?.removeFromParent()
                
                self.PlayerSprite.isHidden = true
                self.playerLives = self.playerLives - 1
                self.playerPower = 0
                contact.bodyB.node?.removeFromParent()
            })
            
            if(contact.bodyA.node?.name == "redBall")
            {
                //score = score + 1000
                run(ballDied)
                redBallHolderL.removeFromParent()
                redBallHolderR.removeFromParent()
                redBallHolder.run(SKAction.repeat(explosion2, count: 1), completion: {
                    contact.bodyA.node?.removeFromParent()
                })
            }
            
            if(contact.bodyA.node?.name == "redBallL")
            {
                //score = score + 1000
                redBallHolder.removeFromParent()
                redBallHolderR.removeFromParent()
                redBallHolderL.run(SKAction.repeat(explosion2, count: 1), completion: {
                    contact.bodyA.node?.removeFromParent()
                })
            }
            
            if(contact.bodyA.node?.name == "redBallR")
            {
                //score = score + 1000
                redBallHolderL.removeFromParent()
                redBallHolder.removeFromParent()
                redBallHolderR.run(SKAction.repeat(explosion2, count: 1), completion: {
                    contact.bodyA.node?.removeFromParent()
                })
            }
            
        }
        
        if contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == attackECategory {
            print("player with enemyAttack")
          run(playerDied)
            PlayerSprite.run(SKAction.repeat(explosion1, count: 1), completion: {
                //contact.bodyA.node?.removeFromParent()
                self.PlayerSprite.isHidden = true
                self.playerLives = self.playerLives - 1
                self.playerPower = 0
            })
            
            contact.bodyB.node?.removeFromParent()
        }
        
        if contact.bodyA.categoryBitMask == enemyCategory && contact.bodyB.categoryBitMask == attackPCategory {
           // print("attack working")
            if(contact.bodyA.node?.name == "boss")
            {
                print("boss")
                //score = score + 1000
                //bossDead = true
                
            }
            if(contact.bodyA.node?.name == "enemy1")
            {
                print("enemy1")
                if playerPower == 0 {
                score = score + 100
                }
                if playerPower == 1 {
                    score = score + 300
                }
                if playerPower == 2 {
                    score = score + 500
                }
                if playerPower == 3 {
                    score = score + 1000
                }
                
                
                enemy1.run(SKAction.repeat(explosion2, count: 1), completion: {
                   self.enemy1.isHidden = true
                   self.enemy1.position.x = -10
                })
            }
            if(contact.bodyA.node?.name == "enemy2")
            {
                print("enemy2")
                score = score + 200
                //contact.bodyA.node?.removeFromParent()
                enemy2.run(SKAction.repeat(explosion2, count: 1), completion: {
                    self.enemy2.isHidden = true
                    self.enemy2.position.x = -10
                })
            }
            if(contact.bodyA.node?.name == "enemy3")
            {
                print("enemy3")
                score = score + 400
                //contact.bodyA.node?.removeFromParent()
                enemy3.run(SKAction.repeat(explosion2, count: 1), completion: {
                    self.enemy3.isHidden = true
                    self.enemy3.position.x = -10
                })
            }
            if(contact.bodyA.node?.name == "enemy4")
            {
                print("enemy4")//hidden bonus points
                if playerPower == 0 {
                    score = score + 100
                }
                if playerPower == 1 {
                    score = score + 300
                }
                if playerPower == 2 {
                    score = score + 500
                }
                if playerPower == 3 {
                    score = score + 1000
                }
                //contact.bodyA.node?.removeFromParent()
                enemy4.run(SKAction.repeat(explosion2, count: 1), completion: {
                    self.enemy4.isHidden = true
                    self.enemy4.position.x = self.screenSize.width + 100
                })
            }
            if(contact.bodyA.node?.name == "enemy5")
            {
                print("enemy5")
                score = score + 200
                
                enemy5.run(SKAction.repeat(explosion2, count: 1), completion: {
                    self.enemy5.isHidden = true
                    self.enemy5.position.x = self.screenSize.width + 100
                })
            }
            if(contact.bodyA.node?.name == "enemy6")
            {
                print("enemy6")
                score = score + 400
                
                enemy6.run(SKAction.repeat(explosion2, count: 1), completion: {
                    self.enemy6.isHidden = true
                    self.enemy6.position.x = self.screenSize.width + 100
                })
            }
            if(contact.bodyA.node?.name == "bossLeftArm")
            {
                run(partDied)
                bossLeftArmLife = bossLeftArmLife - 1
                print("bossLeftArm hp: ", bossLeftArmLife)
                score = score + 500
                
                if(bossLeftArmLife == -1){
                    self.bossLeftArmlive = false
                    score = score + 2000
                    bossLeftArmHolder.run(SKAction.repeat(explosion2, count: 1), completion: {
                        contact.bodyA.node?.removeFromParent()
                    })
                }
            }
            
            if(contact.bodyA.node?.name == "bossRightArm")
            {
                bossRightArmLife = bossRightArmLife - 1
                print("bossRightArm hp: ", bossRightArmLife)
                
                score = score + 500
                run(partDied)
                
                 if(bossRightArmLife == -1){
                bossRightArmlive = false
                    score = score + 2000
                bossRightArmHolder.run(SKAction.repeat(explosion2, count: 1), completion: {
                    contact.bodyA.node?.removeFromParent()
                    
                })
                }
            }
            
            if(contact.bodyA.node?.name == "bossHead")
            {
                run(partDied)
                bossHeadLife = bossHeadLife - 1
                print("bossHead hp: ", bossHeadLife)
                score = score + 1000
                
                if bossRightArmlive && bossLeftArmlive {
                    bossHeadLife = 0
                }
                
                if(bossHeadLife == -1){
                    score = score + 5000
                    bossHeadAlive = false
                    bosHeadolder.run(SKAction.repeat(explosion2, count: 1), completion: {
                    contact.bodyA.node?.removeFromParent()
                    })
                }
            }
            
            if(contact.bodyA.node?.name == "redBall")
            {
                score = score + 1000
                redBallHolderL.removeFromParent()
                redBallHolderR.removeFromParent()
                    redBallHolder.run(SKAction.repeat(explosion2, count: 1), completion: {
                        contact.bodyA.node?.removeFromParent()
                    })
            }
            contact.bodyB.node?.removeFromParent()
            
        }
    }
    
    @objc func fire(timer: Timer)
    {
        // print("I got called")
        if !enemyWave1exists {
           // print("I got called 1st wave called")
        if enemy1.position.x > 0 {
        var enemyAttack1:SKSpriteNode!
        enemyAttack1 = SKSpriteNode(imageNamed: "enemyShot")
        run(enemyAttackSfx)
        enemyAttack1.setScale(0.5)
        enemyAttack1.position = CGPoint(x: enemy1.position.x, y: enemy1.position.y - 10)
        
        enemyAttack1?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack1?.frame.size)!)
        enemyAttack1?.physicsBody?.affectedByGravity = false;
        enemyAttack1?.physicsBody?.allowsRotation = false;
        enemyAttack1?.physicsBody?.mass = 2.0
        enemyAttack1?.physicsBody?.categoryBitMask = attackECategory
        enemyAttack1?.physicsBody?.contactTestBitMask = playerCategory
        enemyAttack1?.physicsBody?.collisionBitMask = playerCategory
                self.addChild(enemyAttack1)
                enemyAttack1.run(moveEnemyShot)
        }
            
        if enemy2.position.x > 0 {
        var enemyAttack2:SKSpriteNode!
        enemyAttack2 = SKSpriteNode(imageNamed: "enemyShot")
        run(enemyAttackSfx)
        enemyAttack2.setScale(0.5)
        enemyAttack2.position = CGPoint(x: enemy2.position.x, y: enemy2.position.y - 10)
        
        enemyAttack2?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack2?.frame.size)!)
        enemyAttack2?.physicsBody?.affectedByGravity = false;
        enemyAttack2?.physicsBody?.allowsRotation = false;
        enemyAttack2?.physicsBody?.mass = 2.0
        enemyAttack2?.physicsBody?.categoryBitMask = attackECategory
        enemyAttack2?.physicsBody?.contactTestBitMask = playerCategory
        enemyAttack2?.physicsBody?.collisionBitMask = playerCategory
            self.addChild(enemyAttack2)
            enemyAttack2.run(moveEnemyShot)
        }
           
        if enemy3.position.x > 0 {
            var enemyAttack3:SKSpriteNode!
            enemyAttack3 = SKSpriteNode(imageNamed: "enemyShot")
            run(enemyAttackSfx)
            enemyAttack3.setScale(0.5)
            enemyAttack3.position = CGPoint(x: enemy3.position.x, y: enemy3.position.y - 10)
            
            enemyAttack3?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack3?.frame.size)!)
            enemyAttack3?.physicsBody?.affectedByGravity = false;
            enemyAttack3?.physicsBody?.allowsRotation = false;
            enemyAttack3?.physicsBody?.mass = 2.0
            enemyAttack3?.physicsBody?.categoryBitMask = attackECategory
            enemyAttack3?.physicsBody?.contactTestBitMask = playerCategory
            enemyAttack3?.physicsBody?.collisionBitMask = playerCategory
            var shootAtPlayer:SKAction!
            var distanceOnX:Float
            var distanceOnY:Float
            if(enemy3.position.x > PlayerSprite.position.x){
                distanceOnX = Float(PlayerSprite.position.x - enemy3.position.x)
            }
            else {
                distanceOnX = Float(enemy3.position.x - PlayerSprite.position.x)
            }
            distanceOnY = Float(enemy3.position.y - PlayerSprite.position.y)
            
            shootAtPlayer = SKAction.moveBy(x: CGFloat(distanceOnX) * 2, y: CGFloat(distanceOnY * -2), duration: 10.0)
            
            self.addChild(enemyAttack3)
            enemyAttack3.run(shootAtPlayer)
        }
            
        }
        
        if !enemyWave2exists {
            if enemy5.position.x < screenSize.width + 10 {
            var enemyAttack5:SKSpriteNode!
            enemyAttack5 = SKSpriteNode(imageNamed: "enemyShot")
            run(enemyAttackSfx)
            enemyAttack5.setScale(0.5)
            enemyAttack5.position = CGPoint(x: enemy5.position.x - 5, y: enemy5.position.y - 10)
            
            enemyAttack5?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack5?.frame.size)!)
            enemyAttack5?.physicsBody?.affectedByGravity = false;
            enemyAttack5?.physicsBody?.allowsRotation = false;
            enemyAttack5?.physicsBody?.mass = 2.0
            enemyAttack5?.physicsBody?.categoryBitMask = attackECategory
            enemyAttack5?.physicsBody?.contactTestBitMask = playerCategory
            enemyAttack5?.physicsBody?.collisionBitMask = playerCategory
                
                var enemyAttack7:SKSpriteNode!
                enemyAttack7 = SKSpriteNode(imageNamed: "enemyShot")
               // run(enemyAttackSfx)
                enemyAttack7.setScale(0.5)
                enemyAttack7.position = CGPoint(x: enemy5.position.x + 5, y: enemy5.position.y - 10)
                
                enemyAttack7?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack7?.frame.size)!)
                enemyAttack7?.physicsBody?.affectedByGravity = false;
                enemyAttack7?.physicsBody?.allowsRotation = false;
                enemyAttack7?.physicsBody?.mass = 2.0
                enemyAttack7?.physicsBody?.categoryBitMask = attackECategory
                enemyAttack7?.physicsBody?.contactTestBitMask = playerCategory
                enemyAttack7?.physicsBody?.collisionBitMask = playerCategory
            
            self.addChild(enemyAttack5)
            enemyAttack5.run(moveEnemyShot)
                self.addChild(enemyAttack7)
                enemyAttack7.run(moveEnemyShot)
            }
        }
    }
    
    
    
    @objc func BossRandomAI(timer: Timer)
    {
        // print("I got called")
        RandomNumber = Int(arc4random_uniform(UInt32(100)))
    }
    
    @objc func BossRandomAI(){
        RandomNumber = Int(arc4random_uniform(UInt32(100)))
        //RandomNumber = Int.random(in: 0 ..< 100)
    }
    
    @objc func fire2(timer: Timer)
    {
        // print("I got called")
        if !enemyWave2exists{
            if enemy4.position.x < screenSize.width + 10 {
            var enemyAttack4:SKSpriteNode!
            enemyAttack4 = SKSpriteNode(imageNamed: "enemyShot")
            run(enemyAttackSfx)
            enemyAttack4.setScale(0.5)
            enemyAttack4.position = CGPoint(x: enemy4.position.x, y: enemy4.position.y - 10)
            
            enemyAttack4?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack4?.frame.size)!)
            enemyAttack4?.physicsBody?.affectedByGravity = false;
            enemyAttack4?.physicsBody?.allowsRotation = false;
            enemyAttack4?.physicsBody?.mass = 2.0
            enemyAttack4?.physicsBody?.categoryBitMask = attackECategory
            enemyAttack4?.physicsBody?.contactTestBitMask = playerCategory
            enemyAttack4?.physicsBody?.collisionBitMask = playerCategory
            self.addChild(enemyAttack4)
            enemyAttack4.run(moveEnemyShot)
            // vegetaBall.name = "ballV"
            }
           
            if enemy6.position.x < screenSize.width + 10 {
            var enemyAttack6:SKSpriteNode!
            enemyAttack6 = SKSpriteNode(imageNamed: "enemyShot")
            run(enemyAttackSfx)
            enemyAttack6.setScale(0.5)
            enemyAttack6.position = CGPoint(x: enemy6.position.x, y: enemy6.position.y - 10)
            
            enemyAttack6?.physicsBody = SKPhysicsBody(rectangleOf: (enemyAttack6?.frame.size)!)
            enemyAttack6?.physicsBody?.affectedByGravity = false;
            enemyAttack6?.physicsBody?.allowsRotation = false;
            enemyAttack6?.physicsBody?.mass = 2.0
            enemyAttack6?.physicsBody?.categoryBitMask = attackECategory
            enemyAttack6?.physicsBody?.contactTestBitMask = playerCategory
            enemyAttack6?.physicsBody?.collisionBitMask = playerCategory
            
            var shootAtPlayer:SKAction!
            var distanceOnX:Float
            var distanceOnY:Float
            if(enemy6.position.x > PlayerSprite.position.x){
                distanceOnX = Float(PlayerSprite.position.x - enemy6.position.x)
            }
            else {
                distanceOnX = Float(enemy6.position.x - PlayerSprite.position.x)
            }
            distanceOnY = Float(enemy6.position.y - PlayerSprite.position.y)
            
            shootAtPlayer = SKAction.moveBy(x: CGFloat(distanceOnX) * 2, y: CGFloat(distanceOnY * -2), duration: 10.0)
            self.addChild(enemyAttack6)
            enemyAttack6.run(shootAtPlayer)
            }
        }
    }
    
    
    @objc func updateEnemiesSpawn(timer: Timer)
    {
        //print("im being updated", enemiesWaveCounter)
        enemiesWaveCounter += 1
    }
    
    
    @objc func updatePowerUp(timer: Timer)
    {
      powerUpsCounter += 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //TODO: - Create a transition
            //scene?.view?.presentScene(GameScene(size: self.frame.size))
            enumerateChildNodes(withName: "//*", using: { ( node, stop) in
                if node.name == "backBtn" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.run(self.selectionSound);
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
                        print("pressing win", self.score)
                        newScene.scoreGetter = Int(self.score);
                        newScene.PlaceHolder1 = Int?(self.PlaceHolder1!)
                        newScene.PlaceHolder2 = Int?(self.PlaceHolder2!)
                        newScene.PlaceHolder3 = Int?(self.PlaceHolder3!)   
                        self.view?.presentScene(newScene, transition: reveal)
                        print("Button Pressed")
                    }
                  }
                if node.name == "fire" {
                    if node.contains(t.location(in:self))// do whatever here
                    {
                        self.run(self.attackSfx)
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
                            playerShoot?.setScale(0.9)
                        }
                        playerShoot.zPosition = 3
                        playerShoot?.physicsBody = SKPhysicsBody(rectangleOf: (playerShoot?.frame.size)!)
                        playerShoot?.physicsBody?.affectedByGravity = false;
                        playerShoot?.physicsBody?.allowsRotation = false;
                        playerShoot?.physicsBody?.mass = 0.2
                        
                        playerShoot?.physicsBody?.categoryBitMask = attackPCategory
                        playerShoot?.physicsBody?.contactTestBitMask = enemyCategory
                        playerShoot?.physicsBody?.collisionBitMask = enemyCategory
                        
                        
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
        ScoreLabel.text = "\(score)"
        
        if !bossLeftArmlive && !bossRightArmlive && !bossHeadAlive {
           // bossali
            if bossActive {
            bossHolder.run(SKAction.repeat(explosion2, count: 1), completion: {
                self.bossDead = true
            })
            
            }
        }
        
        
        if(powerUpsCounter == 1){
            if powerUp1exists {
            var powerUp1: SKSpriteNode!
            powerUp1 = SKSpriteNode(texture: SKTexture(imageNamed: "PowerUp"))
            powerUp1.position = CGPoint(x: screenSize.width, y:screenSize.height/2)
            powerUp1?.physicsBody = SKPhysicsBody(rectangleOf: (powerUp1?.frame.size)!)
            powerUp1?.physicsBody?.affectedByGravity = false;
            powerUp1?.physicsBody?.allowsRotation = false;
            powerUp1?.physicsBody?.mass = 2.0
            
            powerUp1?.physicsBody?.categoryBitMask = powerUpCategory
            powerUp1?.physicsBody?.contactTestBitMask = playerCategory
            powerUp1?.physicsBody?.collisionBitMask = playerCategory
                
            addChild(powerUp1)
            let sequencePowerUp = SKAction.sequence([movePowerUpLeftToRight, movePowerUpRightToLeft])
                powerUp1.run(sequencePowerUp)
            powerUp1exists = false
            }
        }
        
        if(powerUpsCounter == 2){
            if powerUp2exists {
                var powerUp2: SKSpriteNode!
                powerUp2 = SKSpriteNode(texture: SKTexture(imageNamed: "PowerUp"))
                powerUp2.position = CGPoint(x: 0, y:screenSize.height/2)
                powerUp2?.physicsBody = SKPhysicsBody(rectangleOf: (powerUp2?.frame.size)!)
                powerUp2?.physicsBody?.affectedByGravity = false;
                powerUp2?.physicsBody?.allowsRotation = false;
                powerUp2?.physicsBody?.mass = 2.0
                
                powerUp2?.physicsBody?.categoryBitMask = powerUpCategory
                powerUp2?.physicsBody?.contactTestBitMask = playerCategory
                powerUp2?.physicsBody?.collisionBitMask = playerCategory
                
                let sequencePowerUp2 = SKAction.sequence([movePowerUp2LeftToRight, movePowerUp2RightToLeft, movePowerUp2LeftToRight])
                addChild(powerUp2)
                powerUp2.run(sequencePowerUp2)
                powerUp2exists = false
            }
        }
        
        if(powerUpsCounter == 3){
            if powerUp3exists {
                var powerUp3: SKSpriteNode!
                powerUp3 = SKSpriteNode(texture: SKTexture(imageNamed: "PowerUp"))
                powerUp3.position = CGPoint(x: screenSize.width/2, y:screenSize.height)
                powerUp3?.physicsBody = SKPhysicsBody(rectangleOf: (powerUp3?.frame.size)!)
                powerUp3?.physicsBody?.affectedByGravity = false;
                powerUp3?.physicsBody?.allowsRotation = false;
                powerUp3?.physicsBody?.mass = 2.0
                
                powerUp3?.physicsBody?.categoryBitMask = powerUpCategory
                powerUp3?.physicsBody?.contactTestBitMask = playerCategory
                powerUp3?.physicsBody?.collisionBitMask = playerCategory
                powerUp3Holder = powerUp3
                addChild(powerUp3)
                powerUp3.run(moveDiagRightToLeft3)
                powerUp3exists = false
            }
        }
      
        if(enemiesWaveCounter == 1){
            if enemyWave1exists {
                enemy1.run(moveDiagLeftToRightEnemy)
                enemy2.run(moveDiagLeftToRightEnemy)
                enemy3.run(moveDiagLeftToRightEnemy)
                enemyWave1exists = false
            }
        }
       
        if(enemiesWaveCounter == 2){
            if enemyWave2exists {
                enemy4.run(moveDiagRightToLeftEnemy)
                enemy5.run(moveDiagRightToLeftEnemy)
                enemy6.run(moveDiagRightToLeftEnemy)
                
                enemyWave2exists = false
            }
        }
        
        if bossActive{
            switch RandomNumber { // 0 to 99
            case 0..<85:
                //print("test")
                if bossHeadAlive && headCanAttack {
                    headCanAttack = false
                    attackHeadBossM = SKSpriteNode(imageNamed: "redBall")
                    run(enemyAttackSfx)
                    attackHeadBossM.setScale(1.3)
                    attackHeadBossM.zPosition = 3
                    attackHeadBossM.position = CGPoint(x: bosHeadolder.position.x, y: bosHeadolder.position.y - 18 )
                    attackHeadBossM.name = "redBall"
                    attackHeadBossM?.physicsBody = SKPhysicsBody(rectangleOf: (attackHeadBossM?.frame.size)!)
                    attackHeadBossM?.physicsBody?.affectedByGravity = false;
                    attackHeadBossM?.physicsBody?.allowsRotation = false;
                    attackHeadBossM?.physicsBody?.mass = 50.0
                    attackHeadBossM?.physicsBody?.categoryBitMask = enemyCategory
                    attackHeadBossM?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
                    attackHeadBossM?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
                    redBallHolder = attackHeadBossM
                    addChild(attackHeadBossM)
                    attackHeadBossM.run(moveBallDown)
                    
                    attackHeadBossL = SKSpriteNode(imageNamed: "redBeam")
                    //run(enemyAttackSfx)
                    attackHeadBossL.setScale(1.3)
                    attackHeadBossL.zPosition = 3
                    attackHeadBossL.position = CGPoint(x: bosHeadolder.position.x - 50, y: bosHeadolder.position.y - 15 )
                    attackHeadBossL.name = "redBallL"
                    attackHeadBossL?.physicsBody = SKPhysicsBody(rectangleOf: (attackHeadBossL?.frame.size)!)
                    attackHeadBossL?.physicsBody?.affectedByGravity = false;
                    attackHeadBossL?.physicsBody?.allowsRotation = false;
                    attackHeadBossL?.physicsBody?.mass = 50.0
                    attackHeadBossL?.physicsBody?.categoryBitMask = enemyCategory
                    attackHeadBossL?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
                    attackHeadBossL?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
                    redBallHolderL = attackHeadBossL
                   // addChild(attackHeadBossL)
                    attackHeadBossL.run(moveBallDown)
                    
                    attackHeadBossR = SKSpriteNode(imageNamed: "redBeam")
                    //run(enemyAttackSfx)
                    attackHeadBossR.setScale(1.3)
                    attackHeadBossR.position = CGPoint(x: bosHeadolder.position.x + 50, y: bosHeadolder.position.y - 15 )
                    attackHeadBossR.zPosition = 3
                    attackHeadBossR.name = "redBallR"
                    attackHeadBossR?.physicsBody = SKPhysicsBody(rectangleOf: (attackHeadBossR?.frame.size)!)
                    attackHeadBossR?.physicsBody?.affectedByGravity = false;
                    attackHeadBossR?.physicsBody?.allowsRotation = false;
                    attackHeadBossR?.physicsBody?.mass = 50.0
                    attackHeadBossR?.physicsBody?.categoryBitMask = enemyCategory
                    attackHeadBossR?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
                    attackHeadBossR?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
                    redBallHolderR = attackHeadBossR
                   // addChild(attackHeadBossR)
                    attackHeadBossR.run(moveBallDown)
                }
                /*
            case 5..<20:
                print("test")
            case 20..<30:
                print("test")
            case 30..<70:
                print("test")
            case 70..<85:
                print("test")*/
            case 85..<100:
                //print("test")
                headCanAttack = true
            default:
            print("test")
            }
            
        }
        
        /////**/*/*/*/**/*/*////
        if(enemiesWaveCounter == 3){
            if enemyWave3exists {
                bossActive = true
                backgroundMusic.run(SKAction.stop());
                backgroundBossMusic.run(SKAction.play());
                
                var boss: SKSpriteNode!
                
                boss = SKSpriteNode(texture: SKTexture(imageNamed: "boss"))
                boss.setScale(0.2)
                boss.name = "boss"
                boss.position = CGPoint(x: screenSize.width * 0.5, y:screenSize.height * 1.2)
                boss.zPosition = 1
                boss?.physicsBody = SKPhysicsBody(rectangleOf: (boss?.frame.size)!)
                boss?.physicsBody?.affectedByGravity = false;
                boss?.physicsBody?.allowsRotation = false;
                boss?.physicsBody?.mass = 20.0
                
                boss?.physicsBody?.categoryBitMask = wallCategory
                boss?.physicsBody?.contactTestBitMask = playerCategory
                boss?.physicsBody?.collisionBitMask = playerCategory
                bossHolder = boss
                
                var bossHead: SKSpriteNode!
                
                bossHead = SKSpriteNode(texture: SKTexture(imageNamed: "headBoss"))
                bossHead.setScale(0.3)
                bossHead.name = "bossHead"
                bossHead.position = CGPoint(x: screenSize.width * 0.5, y:screenSize.height * 1.2)
                bossHead.zPosition = 3
                bossHead?.physicsBody = SKPhysicsBody(rectangleOf: (bossHead?.frame.size)!)
                bossHead?.physicsBody?.affectedByGravity = false;
                bossHead?.physicsBody?.allowsRotation = false;
                bossHead?.physicsBody?.mass = 20.0
                
                bossHead?.physicsBody?.categoryBitMask = enemyCategory
                bossHead?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
                bossHead?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
                bosHeadolder = bossHead
                
                var bossRightArm: SKSpriteNode!
                
                bossRightArm = SKSpriteNode(texture: SKTexture(imageNamed: "rightArmBoss"))
                bossRightArm.setScale(0.4)
                bossRightArm.name = "bossRightArm"
                bossRightArm.zPosition = 4
                bossRightArm.position = CGPoint(x: screenSize.width * 0.8, y:screenSize.height * 1.2)
                bossRightArm?.physicsBody = SKPhysicsBody(rectangleOf: (bossRightArm?.frame.size)!)
                bossRightArm?.physicsBody?.affectedByGravity = false;
                bossRightArm?.physicsBody?.allowsRotation = false;
                bossRightArm?.physicsBody?.mass = 2.0
                
                bossRightArm?.physicsBody?.categoryBitMask = enemyCategory
                bossRightArm?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
                bossRightArm?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
                bossRightArmHolder = bossRightArm
                
                var bossLeftArm: SKSpriteNode!
                
                bossLeftArm = SKSpriteNode(texture: SKTexture(imageNamed: "leftArmBoss"))
                bossLeftArm.setScale(0.4)
                bossLeftArm.name = "bossLeftArm"
                bossLeftArm.position = CGPoint(x: screenSize.width * 0.2, y:screenSize.height * 1.2)
                bossLeftArm.zPosition = 4
                bossLeftArm?.physicsBody = SKPhysicsBody(rectangleOf: (bossLeftArm?.frame.size)!)
                bossLeftArm?.physicsBody?.affectedByGravity = false;
                bossLeftArm?.physicsBody?.allowsRotation = false;
                bossLeftArm?.physicsBody?.mass = 2.0
                
                bossLeftArm?.physicsBody?.categoryBitMask = enemyCategory
                bossLeftArm?.physicsBody?.contactTestBitMask = playerCategory | attackPCategory
                bossLeftArm?.physicsBody?.collisionBitMask = playerCategory | attackPCategory
                bossLeftArmHolder = bossLeftArm
                
                let sequenceBoss = SKAction.sequence([moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy])
                let sequenceBossHeadDiamond = SKAction.sequence([moveBossDiagLeftToRightDown,moveBossDiagRightToLeftDown,moveBossDiagRightToLeftUp, moveBossDiagLeftToRightUp])
                let sequenceBossHeadDiamondInverted = SKAction.sequence([moveBossDiagRightToLeftDown,moveBossDiagLeftToRightDown, moveBossDiagLeftToRightUp,moveBossDiagRightToLeftUp])
                let sequenceBossHeadDiamondx4 = SKAction.sequence([sequenceBossHeadDiamondInverted, sequenceBossHeadDiamond,sequenceBossHeadDiamond,sequenceBossHeadDiamond, sequenceBossHeadDiamond])
                let sequenceBossHead = SKAction.sequence([moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy, sequenceBossHeadDiamond,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4,sequenceBossHeadDiamondx4])
                
                let sequenceLeftToRight = SKAction.sequence([moveBossArmRight, moveBossArmLeft,moveBossArmRight, moveBossArmLeft,moveBossArmRight, moveBossArmLeft,moveBossArmRight, moveBossArmLeft,moveBossArmRight, moveBossArmLeft,moveBossArmRight, moveBossArmLeft,moveBossArmRight, moveBossArmLeft])
                let sequenceLeftToRightx2 = SKAction.sequence([sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight,sequenceLeftToRight])
                
                let sequenceBossRarm = SKAction.sequence([moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy, sequenceLeftToRightx2])
                let sequenceBossLarm = SKAction.sequence([moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy,moveDownEnemy, moveBossArmLeft, sequenceLeftToRightx2])
                
                addChild(boss)
                addChild(bossHead)
                addChild(bossRightArm)
                addChild(bossLeftArm)
                
                boss.run(sequenceBoss)
                bossHead.run(sequenceBossHead)
                bossLeftArm.run(sequenceBossLarm)
                bossRightArm.run(sequenceBossRarm)
                
                enemyWave3exists = false
            }
        }
        
        if powerUp3Holder != nil{
            if powerUp3Holder.position.x > screenSize.width   {
                powerUp3Holder.position.x = 0
            }
        }
        
        if playerLives == 2
        {
            if revived1 {
                playerLife3.removeFromParent()
               /* PlayerSprite = SKSpriteNode(imageNamed: "spacecraft")
                PlayerSprite?.name = "spacecraft1"
                */
                PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height * 0.2)
                /*PlayerSprite?.zPosition = 1
                PlayerSprite?.setScale(0.6)
                PlayerSprite?.physicsBody = SKPhysicsBody(rectangleOf: (PlayerSprite?.frame.size)!)
                PlayerSprite?.physicsBody?.affectedByGravity = false;
                PlayerSprite?.physicsBody?.allowsRotation = false;
                PlayerSprite?.physicsBody?.mass = 1.0
                
                PlayerSprite?.physicsBody?.categoryBitMask = playerCategory
                PlayerSprite?.physicsBody?.contactTestBitMask = wallCategory / attackECategory
                PlayerSprite?.physicsBody?.collisionBitMask = attackECategory | enemyCategory | wallCategory | powerUpCategory
                */
                PlayerSprite.isHidden = false
                //addChild(PlayerSprite)
                revived1 = false
            }
        }
        else if playerLives == 1
        {
            if revived2 {
                playerLife2.removeFromParent()
                
                PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height * 0.2)
           
                PlayerSprite.isHidden = false
                revived2 = false
            }
        }
        else if playerLives == 0
        {
            if revived3 {
                playerLife1.removeFromParent()
                
                PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height * 0.2)
                
                PlayerSprite.isHidden = false
                revived3 = false
            }
        }
        else if playerLives == -1{
            if gameOver {
                moveJoystick.removeFromParent()
                lossButton = SKSpriteNode(texture: SKTexture(imageNamed: "youlost"))
                lossButton?.name = "lossBtn"
                lossButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 100)
                lossButton?.zPosition = 1
                addChild(lossButton)
                
                gameOver = false
            }
            
        }
        
        if bossDead {
            if playerWon{
            winButton = SKSpriteNode(texture: SKTexture(imageNamed: "youwon"))
            winButton?.name = "winBtn"
            winButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: screenSize.height / 2 - 100)
            winButton?.zPosition = 3
                addChild(winButton)
                playerWon = false
            }
        }
        
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
