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
    
    let firstNode = SKNode()
    let nontextured1 = SKSpriteNode()
    let nontextured2 = SKSpriteNode()
    let textured1 = SKSpriteNode(imageNamed: "doge")
    var shape: SKShapeNode!
    var label: SKLabelNode!
    
    override func didMove(to view: SKView)
    {
        nontextured2.addChild(textured1)
        nontextured1.addChild(nontextured2)
        firstNode.addChild(nontextured1)
        self.addChild(firstNode)
        
        firstNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        nontexturedSKspritenode()
        texturedSKspritendie()
        createshape()
        createlabel(170, 1)
        createlabel(-170, 2)
        

    }
    
    func nontexturedSKspritenode()
    {
        nontextured1.name = "first"
        nontextured1.color = UIColor.blue
        nontextured1.size = CGSize(width: 128, height: 128)
        nontextured1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
        nontextured2.name = "second"
        nontextured2.color = UIColor.red
        nontextured2.size = CGSize(width: 100, height: 100)
        nontextured2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nontextured2.position = CGPoint(x: 0, y: 0)
    }
    
    func texturedSKspritendie()
    {
        textured1.size = CGSize(width: 64, height: 64)
        textured1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }
    
    func createshape()
    {
        shape = SKShapeNode(rectOf: CGSize(width: 244, height: 244))
        shape.fillColor = SKColor.white
        shape.fillTexture = SKTexture(imageNamed: "doge")
        shape.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(shape)
        
    }
    
    func createlabel(_ pos: CGFloat, _ type: Int)
    {
        label = SKLabelNode()
        
        if (type == 1)
        {
            label.text = "karen you whore"
        }
        else if (type == 2)
        {
            
            label.text = "release me from this ios hell"
        }
        
        
        label.fontSize = 32.0
        label.fontColor = UIColor.red
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY + pos)
        self.addChild(label)
        
    }

}
