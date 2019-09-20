//
//  ViewController.swift
//  MeuLogin
//
//  Created by Treinamento on 9/11/19.
//  Copyright © 2019 LiviaHilario. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var video : AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var cadastroButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpVideo()
        loopVideo(videoLoop: video!)
    setUpElementos()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
        loopVideo(videoLoop: video!)
    }
    
    func setUpElementos() {
        Utilities.styleFilledButton(cadastroButton)
        Utilities.styleHollowButton(loginButton)

    }

    
    func setUpVideo() {
        //Get the path to the resource in the bundle
        print("Working")
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
            
        }
        //Create a URL from it
        let url = URL (fileURLWithPath: bundlePath!)
        
        //Create the video player item
        let item = AVPlayerItem (url: url)
        
        //Create the player
        video = AVPlayer (playerItem: item)
        
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: video!)
        
        // Adjust the size and frame

        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)

        view.layer.insertSublayer(videoPlayerLayer!, at: 0)

        // Add it to the view and play it
        video?.playImmediately(atRate: 0.3)
        
        loopVideo(videoLoop: video!)
    }
    
    func loopVideo (videoLoop : AVPlayer) {
        
        NotificationCenter().addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoLoop, queue: nil) { (error) in
            print("video em loop")
        }
//        NotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: nil, queue: nil) { notification in
////
//            video?.seek(to: <#T##CMTime#>)
//        videoLoop.seek(to
//                videoLoop.play()
            }
        }
    


