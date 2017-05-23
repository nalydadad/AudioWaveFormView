//
//  WaveFormView.swift
//  SoundCloudLikeWaveForm
//
//  Created by DADA on 2017/5/23.
//  Copyright © 2017年 DADA. All rights reserved.
//

import UIKit

class WaveFormView: UIView {

    var feqeuncyArray: Array<CGFloat>?
    
    final var upMaxHeight: CGFloat = 0
    final var downMaxHeight: CGFloat = 0
    private var offset: CGFloat = 5
    private var lineWidth: CGFloat = 2.5
    final var defaultColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        guard var dataArray = feqeuncyArray else { return }
        guard dataArray.count > 0 else { return }
        let currentFrame = self.layer.frame
        normalization(ary: &dataArray)
        let upPath = UIBezierPath()
        let downPath = UIBezierPath()
        
        downMaxHeight = currentFrame.height / 3
        upMaxHeight = downMaxHeight * 2

        upPath.lineWidth = lineWidth
        upPath.move(to: CGPoint(x:0.0 , y:currentFrame.height / 2))
        downPath.lineWidth = lineWidth
        downPath.move(to: CGPoint(x:0.0 , y:currentFrame.height / 2 + 1))
        
        for index in 0..<dataArray.count {
            upPath.move(to: CGPoint(x:upPath.currentPoint.x + offset , y: upPath.currentPoint.y))
            upPath.addLine(to: CGPoint(x:upPath.currentPoint.x, y:upPath.currentPoint.y - dataArray[index] * upMaxHeight))
            upPath.close()
        
            downPath.move(to: CGPoint(x: downPath.currentPoint.x + offset , y: downPath.currentPoint.y))
            downPath.addLine(to: CGPoint(x: downPath.currentPoint.x, y: downPath.currentPoint.y + dataArray[index] * downMaxHeight - 1))
            downPath.close()
        }
        //UIColor colorWithHue:0.535 saturation:1.0 brightness:0.686 alpha:1.0
        defaultColor.set()
        upPath.stroke()
        upPath.fill()
        downPath.stroke(with: CGBlendMode.normal, alpha: 0.5)
        downPath.fill()
        
    }
    
    func normalization( ary: inout Array<CGFloat>) {
        guard ary.count > 0 else { return }
        let maxCount = self.layer.frame.width / offset
        var skipIndex =  Int(floor(Double(CGFloat(ary.count) / maxCount))) - 1
        let maxValue = abs(Float(ary.max()!))
        skipIndex = skipIndex < 1 ? 1 : skipIndex
        var index = 0
        while index < ary.count {
            ary[index] = CGFloat(Float(ary[index]) / maxValue)
            index += 1
        }
    }
    
    func setColor(color: UIColor?) {
        guard color != nil else { return }
        defaultColor = color!
        self.setNeedsDisplay()
    }

}
