//
//  ViewController.swift
//  SoundCloudLikeWaveForm
//
//  Created by DADA on 2017/5/23.
//  Copyright © 2017年 DADA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wf: WaveFormView?

    override func viewDidLoad() {
        super.viewDidLoad()
        wf = WaveFormView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 80))
        wf!.feqeuncyArray = generateRandomArray(count: 10000)
        wf!.backgroundColor = UIColor.clear
        self.view.addSubview(wf!)
    }
    
    func generateRandomArray(count: Int) -> Array<CGFloat> {
        var ary = Array<CGFloat>()
        for _ in 0..<count {
            ary.append(CGFloat(arc4random_uniform(100)))
        }
        return ary
    }
    
    @IBAction func moveRight(_ sender: Any) {
        guard let layerFrame = self.wf?.layer.frame else { return }
        var frame = layerFrame
        frame.origin = CGPoint(x: frame.origin.x + 10, y: frame.origin.y)
        self.wf?.layer.frame = frame
    }
    
    @IBAction func moveLeft(_ sender: Any) {
        guard let layerFrame = self.wf?.layer.frame else { return }
        var frame = layerFrame
        frame.origin = CGPoint(x: frame.origin.x - 10, y: frame.origin.y)
        self.wf?.layer.frame = frame
    }
    
    @IBAction func setColor(_ sender: Any) {
        guard let btn = sender as? UIButton else { return }
        wf?.setColor(color: btn.backgroundColor)
    }

}

