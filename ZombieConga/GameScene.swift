import SpriteKit
// Adding a zombie to scene


class GameScene: SKScene {
    let background = SKSpriteNode(imageNamed: "background1") //creating a sprite
    let zombie1 = SKSpriteNode(imageNamed: "zombie1")
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    
    var lastUpdateTime : TimeInterval = 0
    var dt : TimeInterval = 0
    
    override func didMove(to view: SKView) {
        
        background.position = CGPoint(x: size.width / 2 , y: size.height / 2 ) // positioning a sprite in bottom left.
        background.anchorPoint = CGPoint.zero // anchor point = 0.0
        background.position = CGPoint.zero // anchor points's points equal positions
        // background.zRotation = CGFloat(M_PI) / 8  ==  pi / 8 = 22.5 degree Z rotation
        //Replacing anchor point and position
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background) // adding sprite to the scene
        
        zombie1.position = CGPoint(x: 400, y: 400)
//        zombie1.xScale = 2
//        zombie1.yScale = 2
      
        addChild(zombie1)
        
    }
    override func update(_ currentTime : TimeInterval){
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0 }
        lastUpdateTime = currentTime
        print("\(dt*1000) milliseconds since last update")
        //zombie1.position = CGPoint(x: zombie1.position.x + 8, y: zombie1.position.y)
        move(sprite: zombie1, velocity: CGPoint(x : zombieMovePointsPerSec, y: 0))
    }
    func move(sprite : SKSpriteNode, velocity: CGPoint){
        //1
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        print("Amount To Move = \(amountToMove)")
        //2
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
}






