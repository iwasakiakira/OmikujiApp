//
//  ViewController.swift
//  OmikujiApp
//
//  Created by いわし on 2020/09/16.
//  Copyright © 2020 iwasi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var resultAudioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var stickView: UIView!
    
    @IBOutlet weak var stickLabel: UILabel!
    
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var OverView: UIView!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBAction func tapRetryButton(_ sender: Any) {
        OverView.isHidden = true
        stickBottomMargin.constant = 0
    }
    func setupSound(){
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3"){
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
    
    let resultTexts:[String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion != UIEvent.EventSubtype.motionShake || OverView.isHidden == false{
            // シェイクモーション以外では動作させない
            // 結果の表示中は動作させない
            return
        }
        let resultNum = Int(arc4random_uniform(UInt32(resultTexts.count)))
        stickLabel.text = resultTexts[resultNum]
        stickBottomMargin.constant = stickHeight.constant * -1
        
        UIView.animate(withDuration: 1, animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {(finished:Bool)in
            self.bigLabel.text = self.stickLabel.text
            self.OverView.isHidden = false
            
            //次の1行を追加 -> 結果表示のときに音を再生(Play)する！
            self.resultAudioPlayer.play()
        })
    }
}
