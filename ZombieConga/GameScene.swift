import SpriteKit


class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background1") //creating a sprite
        background.position = CGPoint(x: size.width / 2 , y: size.height / 2 ) // positioning a sprite in bottom left.
        addChild(background) // adding sprite to the scene
        backgroundColor = SKColor.black
        
    }
}
