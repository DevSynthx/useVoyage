//
//  GravityVM.swift
//  project-z
//
//  Created by Inyene Etoedia on 13/02/2024.
//

import Foundation
import CoreMotion
import UIKit
import SpriteKit
import SwiftUI

class GameScene: SKScene {
   var selectedNodeName: SKNode?
    var selectedNode: String?
    var scaledLabelText: [String] = []
    override func didMove(to view: SKView) {
        print("bar")
        //physicsWorld.contactDelegate = self
        self.backgroundColor = .clear
    
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.setUpScene()
        print("finished")
    }
    
    override var isUserInteractionEnabled: Bool {
          get {
              return true
          }
          set {
              super.isUserInteractionEnabled = false
          }
      }
    
    func setUpScene(){
        createBox(color: .green, position: CGPoint(x: 100, y: 100), name: "boxA", labelText: "boxLabel")
        createBox(color: .red, position: CGPoint(x: 100, y: 200), name: "boxB", labelText: "boxBLabel")
        createBox(color: .yellow, position: CGPoint(x: frame.midX, y: frame.midY), name: "boxC", labelText: "boxCLabel")
        createBox(color: .systemIndigo, position: CGPoint(x: frame.midX, y: frame.midY), name: "boxD", labelText: "boxDLabel")
        createBox(color: .systemIndigo, position: CGPoint(x: 100, y: 400), name: "boxE", labelText: "boxELabel")

       }
    
    
    func createBox(color: UIColor, position: CGPoint, name: String, labelText: String) {
//         let box = SKSpriteNode(color: color, size: CGSize(width: 100, height: 100))
//         box.name = name
//         box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
//         box.position = position
        
        let box = SKShapeNode(circleOfRadius: 50 )
        box.name = name
        box.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        box.position = position
        box.strokeColor = .clear
        box.physicsBody?.isDynamic = true
        box.physicsBody?.allowsRotation = false
        box.fillColor = .blue
        box.physicsBody?.affectedByGravity = true
        
        
        let boxLabel = SKLabelNode()
        boxLabel.text = labelText
        boxLabel.name = "label"
        boxLabel.fontSize = 14
        boxLabel.fontName = "Arial-BoldMT"
        boxLabel.isUserInteractionEnabled = false
        boxLabel.position = CGPoint.zero
        boxLabel.horizontalAlignmentMode = .center
        boxLabel.verticalAlignmentMode = .center
        box.addChild(boxLabel)
        
        
        self.addChild(box)
         
        
     }
     
    
    
    func toggleScale() {
        guard let node = selectedNodeName else { return }
        
           
           if node.xScale == 1.0 && node.yScale == 1.0 {
               node.setScale(1.5)
               if let labelNode = node.childNode(withName: "label") as? SKLabelNode {
                   scaledLabelText.append(labelNode.text ?? "")
               }
           } else {
               node.setScale(1.0)
               if let labelNode = node.childNode(withName: "label") as? SKLabelNode,
                   let labelText = labelNode.text,
                   let index = scaledLabelText.firstIndex(of: labelText) {
                   scaledLabelText.remove(at: index)
               }
           }
       }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
         let location = touch.location(in: self)
         let nodeITapped = atPoint(location)
//        if let labelNode = nodeITapped.childNode(withName: "Text") as? SKLabelNode {
//           print(labelNode.text)
//              return
//          }
        if nodeITapped is SKLabelNode{
            return
        }
        
         selectedNodeName = nodeITapped
         selectedNode = nodeITapped.name
    }
    

}






