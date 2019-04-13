
import Foundation
import SpriteKit

class WinScene: SKScene {
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    var returnButton: SKSpriteNode!
    var congratsNameLabel: SKLabelNode!
    
    var message1: SKLabelNode!
    var message2: SKLabelNode!
    var message3: SKLabelNode!
    var scoreGetter: Int?
    var difficultyGetter: Int?
    
    var PlaceHolder1: Int?
    var PlaceHolder2: Int?
    var PlaceHolder3: Int?
    
    var highscoreValue1: SKLabelNode!
    var highscoreValue2: SKLabelNode!
    var highscoreValue3: SKLabelNode!
    
    let selectionSound = SKAudioNode(fileNamed: "/Sfx/select.wav")
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/Flying_Force_Combat.mp3")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        selectionSound.autoplayLooped = false
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "PlanetStart"))
        background.position = CGPoint(x: screenSize.width/2, y:screenSize.height/2)
        background.size = CGSize(width: screenSize.width, height: screenSize.height)
        background?.zPosition = 0
        
        returnButton = SKSpriteNode(texture: SKTexture(imageNamed: "back"))
        returnButton?.name = "returnBtn"
        returnButton?.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-120)
        returnButton?.zPosition = 1
        
        congratsNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        congratsNameLabel.text = "Congratulations!"
        congratsNameLabel.horizontalAlignmentMode = .center
        congratsNameLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+160)
        congratsNameLabel.zPosition = 1
        
        message1 = SKLabelNode(fontNamed: "Chalkduster")
        message1.text = "You have completed"
        message1.horizontalAlignmentMode = .center
        message1.fontSize = 23
        message1.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2+60)
        message1.zPosition = 1
        
        message2 = SKLabelNode(fontNamed: "Chalkduster")
        message2.text = "your mission"
        message2.fontSize = 23
        message2.horizontalAlignmentMode = .center
        message2.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        message2.zPosition = 1
        
        message3 = SKLabelNode(fontNamed: "Chalkduster")
        message3.text = "to defeat Bohr-iz"
        message3.fontSize = 23
        message3.horizontalAlignmentMode = .center
        message3.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-60)
        message3.zPosition = 1
        
        
        addChild(background!)
        addChild(returnButton!)
        addChild(congratsNameLabel!)
        
        addChild(message1!)
        addChild(message2!)
        addChild(message3!)
        
        //audio
        addChild(selectionSound)
        addChild(backgroundMusic)
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
                        self.selectionSound.run(SKAction.play());
                        self.perform(#selector(self.changeSceneMenu), with: nil, afterDelay: 0.6)
                    }
                }
            })
            
        }
    }
    
    @objc func changeSceneMenu(){ //change scene after 0.6 sec
        let reveal = SKTransition.reveal(with: .left, duration: 0.6)
        let newScene = MenuScene(size:self.size)
        print("pressing passing a ", scoreGetter!)
        newScene.scoreGetter = Int?(self.scoreGetter!)
        newScene.PlaceHolder1 = Int?(self.PlaceHolder1!)
        newScene.PlaceHolder2 = Int?(self.PlaceHolder2!)
        newScene.PlaceHolder3 = Int?(self.PlaceHolder3!)   
        self.view?.presentScene(newScene, transition: reveal)
    }
}
