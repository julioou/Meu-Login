//
//  ViewController.swift
//  MeuLogin
//
//  Created by Treinamento on 9/11/19.
//  Copyright © 2019 LiviaHilario. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class ViewController: UIViewController  {
    
    var video : AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var cadastroButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpVideo()
        setUpElementos()
        
    }
    
    func setUpElementos() {
        Utilities.styleFilledButton(cadastroButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.video!.seek(to: CMTime.zero)
    }
    
    func setUpVideo() {
        //Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        //Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //Create the video player item
        let item = AVPlayerItem(url: url)
        
        //Create the player
        video = AVPlayer(playerItem: item)
        
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: video!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        video?.playImmediately(atRate: 1)
        
        NotificationCenter.default.addObserver( forName: .AVPlayerItemDidPlayToEndTime, object: self.video!.currentItem, queue: .main ) { [weak self] _ in
            self?.video!.seek(to: CMTime.zero)
            self?.video!.play()
        }
    }
}



