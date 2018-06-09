import SpriteKit



class GameScene: SKScene {
    
    // Adding a zombie to scene
    let background = SKSpriteNode(imageNamed: "background1") //creating a sprite
    let zombie1 = SKSpriteNode(imageNamed: "zombie1")
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    var lastUpdateTime : TimeInterval = 0
    var dt : TimeInterval = 0
    
    let playableRect : CGRect
    override init(size: CGSize) {
        let maxAspectRatio:CGFloat = 16.0/9.0 // 1
        let playableHeight = size.width / maxAspectRatio // 2
        let playableMargin = (size.height-playableHeight)/2.0 // 3
        playableRect = CGRect(x: 0, y: playableMargin,
                              width: size.width,
                              height: playableHeight) // 4
        super.init(size: size) // 5
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
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
        debugDrawPlayableArea()
        
        
    }
    override func update(_ currentTime : TimeInterval){
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0 }
        lastUpdateTime = currentTime
        print("\(dt*1000) milliseconds since last update")
        //zombie1.position = CGPoint(x: zombie1.position.x + 8, y: zombie1.position.y)
        move(sprite: zombie1, velocity: velocity)
        boundsCheckZombie()
        rotate(sprite: zombie1, direction: velocity)
    }
    func move(sprite : SKSpriteNode, velocity: CGPoint){
        //1
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        print("Amount To Move = \(amountToMove)")
        //2
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    func moveZombieToward(location: CGPoint){
        let offset = CGPoint(x: location.x - zombie1.position.x, y: location.y - zombie1.position.y)
        let lenght = sqrt(CGFloat(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(lenght), y: offset.y / CGFloat(lenght))
        velocity = CGPoint(x: direction.x * zombieMovePointsPerSec, y: direction.y * zombieMovePointsPerSec)
        
    }
    
    func sceneTouched(touchLocation: CGPoint){
        moveZombieToward(location: touchLocation)
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    func boundsCheckZombie(){
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        if zombie1.position.x <= bottomLeft.x{
            zombie1.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if zombie1.position.x >= topRight.x {
            zombie1.position.x = topRight.x
            velocity.x = -velocity.x
        }
        if zombie1.position.y <= bottomLeft.y {
            zombie1.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        if zombie1.position.y >= topRight.y {
            zombie1.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRect(playableRect)
        shape.path = path
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
    func rotate(sprite: SKSpriteNode, direction: CGPoint){
        sprite.zRotation = CGFloat(
            atan2(Double(direction.y), Double(direction.x)))
    }
}






