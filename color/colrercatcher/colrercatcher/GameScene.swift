//
//  GameScene.swift
//  colrercatcher
//
//  Created by Vaughan Webb on 30/09/19.
//  Copyright © 2019 Vaughan Webb. All rights reserved.
//

import SpriteKit


class GameScene: SKScene
{
    
    var shapemenu: SKShapeNode!
    var shapewheel: SKSpriteNode!
    var score = 0
    var label: SKLabelNode!
    var shapeball: SKShapeNode!
    var isdead = false
    var currentSelection = 0
    var rand = 0
    var check = false
    
    override func didMove(to view: SKView)
    {
        createshapemenu()
        createshapewheel()
        createScoreLabel()
        createshapeball()
    }
    func createshapeball()
    {
        shapeball = SKShapeNode(circleOfRadius: 20)
        shapeball.fillColor = UIColor.white
        shapeball.position = CGPoint(x: self.frame.width/2, y: self.frame.height + 10)
        self.addChild(shapeball)
    }
    
    func createshapemenu()
    {
        shapemenu = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
        shapemenu.fillColor = SKColor.white
        shapemenu.fillTexture = SKTexture(imageNamed: "doge")
        shapemenu.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        self.addChild(shapemenu)
        
    }
    func createshapewheel()
    {
        shapewheel = SKSpriteNode(texture: SKTexture(imageNamed: "wheel"), size: CGSize(width: 200, height: 200))
        shapewheel.position = CGPoint(x: self.frame.width/2, y: self.frame.minY + 150)
        self.addChild(shapewheel)
        
    }
    
    func createScoreLabel()
    {
        label = SKLabelNode()
        label.fontSize = 32.0
        label.fontColor = UIColor.red
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(label)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        if (shapeball.hasActions() == false && isdead == false)
        {
            check = false
            shapeball.alpha = 1
            balljazz()
        }
        
        if (shapeball.position.y <= self.frame.minY + 170 && check == false)
        {
            
            check = true
            if (currentSelection == rand)
            {
                score += 1
                label.text = String(score)
                
            }
            else
            {
                isdead = true
            }

        }
    }
    
    
    func balljazz()
    {
        shapeball.position = CGPoint(x: self.frame.width/2, y: self.frame.height + 10)
        rand = Int.random(in: 0 ... 3)
        if (rand == 0)
        {
            shapeball.fillColor = UIColor.blue
        }
        else if (rand == 1)
        {
            shapeball.fillColor = UIColor.green
        }
        else if (rand == 2)
        {
            shapeball.fillColor = UIColor.yellow
        }
        else if (rand == 3)
        {
            shapeball.fillColor = UIColor.red
        }
        
        if (score > 5)
        {
            shapeball.run(SKAction.sequence([SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.minY + 150), duration: 1.5) , SKAction.fadeOut(withDuration: 0.5)]))
        }
        else
        {
            shapeball.run(SKAction.sequence([SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.minY + 150), duration: 3) , SKAction.fadeOut(withDuration: 0.5)]))

        }
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {

 
        let location = touches.first?.location(in: self)
        if shapemenu.contains(location!)
        {
            updatescore()
            let newScene = MainMenu(size: (self.view?.bounds.size)!)
            let transistion = SKTransition.reveal(with: .up, duration: 2)
            self.view?.presentScene(newScene, transition:  transistion)
            transistion.pausesIncomingScene = false
            transistion.pausesOutgoingScene = true
            
        }
        else if location!.x < self.frame.width/2
        {
            currentSelection -= 1
            if (currentSelection <= -1)
            {
                currentSelection = 3
            }
            
            shapewheel.run(SKAction.rotate(byAngle: CGFloat((3.141592656358979 * 90) / 180), duration: 0.3))
            if (isdead == true)
            {
                updatescore()
                let newScene = MainMenu(size: (self.view?.bounds.size)!)
                let transistion = SKTransition.reveal(with: .up, duration: 2)
                self.view?.presentScene(newScene, transition:  transistion)
                transistion.pausesIncomingScene = false
                transistion.pausesOutgoingScene = true
            }
        }
        else
        {
            currentSelection += 1
            if (currentSelection >= 4)
            {
                currentSelection = 0
            }
            
            shapewheel.run(SKAction.rotate(byAngle: CGFloat (-(3.141592656358979 * 90) / 180), duration: 0.3))
            if (isdead == true)
            {
                updatescore()
                let newScene = MainMenu(size: (self.view?.bounds.size)!)
                let transistion = SKTransition.reveal(with: .up, duration: 2)
                self.view?.presentScene(newScene, transition:  transistion)
                transistion.pausesIncomingScene = false
                transistion.pausesOutgoingScene = true
            }
            
        }
    }
    
    func updatescore()
    {
        UserDefaults.standard.set(score, forKey: "Current Score")
        if (score > UserDefaults.standard.integer(forKey: "High Score"))
        {
            UserDefaults.standard.set(score, forKey: "High Score")
            
        }
    }
    
}






class MainMenu: SKScene
{
    let left = SKSpriteNode()
    let right = SKSpriteNode()
    var label: SKLabelNode!

    

    
    override func didMove(to view: SKView)
    {
        createlabel(170, 1)
        createlabel(-170, 2)
        
        self.backgroundColor = UIColor.gray
        left.color = UIColor.red
        left.size = CGSize(width: 64, height: 64)
        left.position = CGPoint(x: self.frame.width/2-64, y: self.frame.height/2)
        addChild(left)
        
        right.color = UIColor.blue
        right.size = CGSize(width: 64, height: 64)
        right.position = CGPoint(x: self.frame.width/2 + 64, y: self.frame.height/2)
        addChild(right)
    }
    
    func createlabel(_ pos: CGFloat, _ type: Int)
    {
        label = SKLabelNode()
        
        if (type == 1)
        {
            label.text = "High Score: " + String(UserDefaults.standard.integer(forKey: "High Score") ?? 0)
        }
        else if (type == 2)
        {
            
            label.text = "Current score: " + String(UserDefaults.standard.integer(forKey: "Current Score") ?? 0)
        }
        
        
        label.fontSize = 32.0
        label.fontColor = UIColor.red
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY + pos)
        self.addChild(label)
        
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first?.location(in: self)
        if left.contains(location!)
        {
            left.size = CGSize(width: left.size.width * 2, height: left.size.height * 2)
            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.reveal(with: .down, duration: 2)
            self.view?.presentScene(newScene, transition: transition)

            transition.pausesOutgoingScene = false
            transition.pausesIncomingScene = false
            
            
        }
        else if right.contains(location!)
        {
            right.size = CGSize(width: right.size.width * 2, height: right.size.height * 2)

            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition  = SKTransition.crossFade(withDuration: 2)
            self.view?.presentScene(newScene, transition: transition)



            transition.pausesOutgoingScene = false
            transition.pausesIncomingScene = false
        }
    }
    

}
