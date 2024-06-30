//
//  GravityView.swift
//  project-z
//
//  Created by Inyene Etoedia on 13/02/2024.
//

import SwiftUI
import CoreMotion
import SpriteKit
import UIKit

struct GravityView: View {
    
    var scene: GameScene  // Change the type to GameScene

     init() {
         let gameScene = GameScene()
         gameScene.size = CGSize(width: 300, height: 540)
         gameScene.scaleMode = .fill
    
         gameScene.isUserInteractionEnabled = false
         self.scene = gameScene
        // self.setupScene() // Call setupScene() to initialize the scene
     }

//    var scene: SKScene {
//        let scene = GameScene()
//        scene.size = CGSize(width: 300, height: 540)
//        scene.scaleMode = .fill
//        return scene
//    }
    
  
   
/*
   let scene = SKScene(

       size : CGSize(width: 300, height: 540)
 
   )
   init(){
       scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
       let boxB = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
       boxB.name = "boxB"
       scene.name = "SCENE - B"
       boxB.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
       boxB.position = CGPoint(x: 100, y: 200)
       //boxB.physicsBody?.isDynamic = false
       boxB.physicsBody?.affectedByGravity = true
       //boxB.zPosition = 2
       scene.addChild(boxB)
       
       
       scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
       let boxA = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 100))
       boxA.name = "boxA"
       scene.name = "SCENE - A"
       boxA.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
       boxA.position = CGPoint(x: 100, y: 200)
       //boxB.physicsBody?.isDynamic = false
       boxA.physicsBody?.affectedByGravity = true
       //boxB.zPosition = 2
       scene.addChild(boxA)
   }
   
   */
    
    var body: some View {
        VStack {
            Text("Gravity")
           SpriteView(scene: scene)
                .onTapGesture { gesture in
                    scene.toggleScale()
                    scene.selectedNodeName?.children.first?.isUserInteractionEnabled = false
//                    print(                    scene.scaledLabelText.count
//                    )
                    if let selected = scene.selectedNode {
                        print(selected)
                    
                    }
                    
                    
//                    for node in tappedNodes {
//                        if let nodeName = node.name {
//                            print("Tapped node: \(nodeName)")
//                        }
//                    }
                   // scene.children.first
                }
        }
    }
}

#Preview {
    GravityView()
}











