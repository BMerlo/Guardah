
import Foundation
import SpriteKit

class HighscoreScene: SKScene {
    
    var showmeOnce = true
    
    var scoreGetter: Int?
    
    var background: SKSpriteNode!
    let screenSize: CGRect = UIScreen.main.bounds
    var returnButton: SKSpriteNode!
    var highscoreNameLabel: SKLabelNode!
    
    var highscoreValue1: SKLabelNode!
    var highscoreValue2: SKLabelNode!
    var highscoreValue3: SKLabelNode!
    
    let selectionSound = SKAudioNode(fileNamed: "/Sfx/select.wav")
    let backgroundMusic = SKAudioNode(fileNamed: "/Music/Flying_Force_Combat.mp3")
    
    var passedOnce = false
    var higherThan1 = false
    var higherThan2 = false
    var higherThan3 = false
    
    var difficultyGetter: Int?
    var PlaceHolder1: Int?
    var PlaceHolder2: Int?
    var PlaceHolder3: Int?
    
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
        
        highscoreNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        highscoreNameLabel.text = "HIGH SCORES"
        highscoreNameLabel.horizontalAlignmentMode = .center
        highscoreNameLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2 , y: UIScreen.main.bounds.height / 2+120)
        highscoreNameLabel.zPosition = 1
        
        highscoreValue1 = SKLabelNode(fontNamed: "Chalkduster")
        highscoreValue1.text = "10000"
        highscoreValue1.horizontalAlignmentMode = .center
        highscoreValue1.position = CGPoint(x: UIScreen.main.bounds.width / 2 , y: UIScreen.main.bounds.height / 2+60)
        highscoreValue1.zPosition = 1
        
        highscoreValue2 = SKLabelNode(fontNamed: "Chalkduster")
        highscoreValue2.text = "1000"
        print(Int(highscoreValue2.text!)!)
        highscoreValue2.horizontalAlignmentMode = .center
        highscoreValue2.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        highscoreValue2.zPosition = 1
        
        highscoreValue3 = SKLabelNode(fontNamed: "Chalkduster")
        highscoreValue3.text = "100"
        highscoreValue3.horizontalAlignmentMode = .center
        highscoreValue3.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2-60)
        highscoreValue3.zPosition = 1
        
        
        addChild(background!)
        addChild(returnButton!)
        addChild(highscoreNameLabel!)
        
        
        addChild(highscoreValue1!)
        addChild(highscoreValue2!)
        addChild(highscoreValue3!)
        
        //audio
        addChild(selectionSound)
        addChild(backgroundMusic)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        //print(scoreGetter ?? 90)
        
        if !passedOnce {
           // print("IM HERE ONCE")
            if scoreGetter ?? 90 > Int(PlaceHolder1!){
                print("IM HIGHER THAN 10000")
                highscoreValue1.text = "\(scoreGetter!)"
                PlaceHolder1 = scoreGetter
                higherThan1 = true
            }
            
            if scoreGetter ?? 90 > Int(PlaceHolder2!) && !higherThan1{
                print("IM HIGHER THAN 1000")
                highscoreValue2.text = "\(scoreGetter!)"
                
                PlaceHolder2 = scoreGetter
                
                higherThan2 = true
            }
            
            if scoreGetter ?? 90 > Int(PlaceHolder3!) && !higherThan1 && !higherThan2{
                print("IM HIGHER THAN 100")
                highscoreValue3.text = "\(scoreGetter!)"
                PlaceHolder3 = scoreGetter
                higherThan3 = true
            }
            
            highscoreValue1.text = "\(PlaceHolder1!)"
            highscoreValue2.text = "\(PlaceHolder2!)"
            highscoreValue3.text = "\(PlaceHolder3!)"
            
            passedOnce = true
        }
        
        if showmeOnce {
            print("scoreGetter =", scoreGetter!)
            print("PlaceHolder3 =", PlaceHolder3!)
            print("PlaceHolder2 =", PlaceHolder2!)
            print("PlaceHolder1 =", PlaceHolder1!)
            showmeOnce = false
        }
        
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
    
    @objc func changeSceneMenu(){ //change scene after 1 sec
        let reveal = SKTransition.reveal(with: .left, duration: 0.6)
        let newScene = MenuScene(size:self.size)
        newScene.scoreGetter = Int?(self.scoreGetter!)
        newScene.difficultyGetter = Int?(self.difficultyGetter!)
        newScene.PlaceHolder1 = Int?(self.PlaceHolder1!)
        newScene.PlaceHolder2 = Int?(self.PlaceHolder2!)
        newScene.PlaceHolder3 = Int?(self.PlaceHolder3!)
        self.view?.presentScene(newScene, transition: reveal)
    }
}
