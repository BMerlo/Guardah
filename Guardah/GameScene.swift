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
    var fireButton: SKSpriteNode!
    let moveJoystick = 🕹(withDiameter: 80)
    
    let screenSize: CGRect = UIScreen.main.bounds
    var score = 0
    let ScoreLabel = SKLabelNode(fontNamed:"Helvetica")
    
    let selectionSound = SKAudioNode(fileNamed: "/Sfx/select.wav")
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/win_the_game.mp3")
    let shootSound = SKAudioNode(fileNamed: "/Sfx/shot_g.wav")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        selectionSound.autoplayLooped = false;
        shootSound.autoplayLooped = false;
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        background?.zPosition = 0
        
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
        winButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 100)
        winButton?.zPosition = 1
        
        backButton = SKSpriteNode(texture: SKTexture(imageNamed: "smallerback"))
        backButton?.name = "backBtn"
        backButton?.position = CGPoint(x: screenSize.width * 0.90, y:screenSize.height * 0.97)
        backButton?.zPosition = 1
        
        PlayerSprite = SKSpriteNode(imageNamed: "spacecraft")
        PlayerSprite?.name = "spacecraft1"
        PlayerSprite?.setScale(0.08)
        PlayerSprite?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        PlayerSprite?.zPosition = 2
        
        fireButton = SKSpriteNode(imageNamed: "Big_Red_Button")
        fireButton?.name = "fire"
        fireButton?.setScale(0.3)
        fireButton?.position = CGPoint(x: screenSize.width * 0.85, y:screenSize.height * 0.2)
        fireButton?.zPosition = 2
        
        addChild(ScoreLabel)
        addChild(background!)
        addChild(backButton!)
        addChild(PlayerSprite!)
        addChild(lossButton!)
        addChild(winButton!)
        addChild(moveJoystick)
        addChild(fireButton)
        //superSpaceMan?.run(scaleBack)
        
        addChild(shootSound)
        addChild(selectionSound)
        addChild(backgroundMusic)
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
                      self.shootSound.run(SKAction.play());
                        print("Fire Button Pressed")
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
            //   print(gokuSprite.position)
            
        }
    }
    
    @objc func changeSceneMenu(){ //change scene after 0.6 sec
        let reveal = SKTransition.reveal(with: .left, duration: 0.6)
        let newScene = MenuScene(size:self.size)
        self.view?.presentScene(newScene, transition: reveal)
    }
}
