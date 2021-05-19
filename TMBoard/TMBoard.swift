//
//  ViewController.swift
//  TMBoard
//
//  Created by satish bisa on 5/10/21.
//

import UIKit
import AVFoundation

class TMBoard: UIViewController, CAAnimationDelegate {

    /*
     TMG SOUNDS: 2018 highlight video
     - squat 680
     - unconvincing gay guy
     - 6:38 -> "noel miller is 5'8"
     - 9:55 -> buckle your seatbelt
     - 13:45 -> "crash it"
     - ew dude wtf
     - malone brown
     */
    
    var player: AVAudioPlayer?
    var videoPlayer: AVPlayer?
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
        return gradientLayer
    }()
    
    let buttonOne: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        //label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return label
    }()
    
    let filterBackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9647058824, blue: 0.9764705882, alpha: 1)
        v.layer.borderWidth = 2
        v.backgroundColor = .black
        v.clipsToBounds = true
        v.layer.cornerRadius = 12
        v.isHidden = false
        v.isUserInteractionEnabled = true
        return v
    }()
    
    let secondButton: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 200))
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9647058824, blue: 0.9764705882, alpha: 1)
        v.layer.borderWidth = 2
        
        
        
        
        //v.backgroundColor = .black
        let gradient = CAGradientLayer()
        
  
        
        //gradient.frame = v.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = v.bounds
        v.layer.addSublayer(gradient)
        
      
        
        
        
        
        //v.layer.insertSublayer(gradient, at: 0)
        v.clipsToBounds = true
        v.layer.cornerRadius = 12
        v.isHidden = false
        v.isUserInteractionEnabled = true
        return v
    }()
    
    @IBAction func test(_ sender: Any) {
        print("hello")
    }
    @IBAction func goToBoard(_ sender: Any) {
        print("PRESSED!")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //playBackgroundVideo()
        setupView()
        playHomeVideo()
    }
    
    func playHomeVideo(){
        //playWalkman()
        let path = Bundle.main.path(forResource: "homeScreenTMG", ofType: "mp4")
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path!))
        videoPlayer!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer!.currentItem)
        videoPlayer!.seek(to: CMTime.zero)
        videoPlayer!.play()
        self.videoPlayer?.isMuted = true
    }
    
    func playBackgroundVideo(){
        playWalkman()
        let path = Bundle.main.path(forResource: "cuttingMeat", ofType: "mp4")
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path!))
        videoPlayer!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer!.currentItem)
        videoPlayer!.seek(to: CMTime.zero)
        videoPlayer!.play()
        self.videoPlayer?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd(){
        videoPlayer!.seek(to: CMTime.zero)
    }
    
    func setupView(){
        filterBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buckleYourSeatbelt)))
        secondButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iLikeDudesALot)))
        filterBackgroundView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = filterBackgroundView.bounds
        view.addSubview(filterBackgroundView)
        view.addSubview(secondButton)
        filterBackgroundView.addSubview(buttonOne)
        buttonOne.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        buttonOne.center = view.center
        
        
        filterBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        filterBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35).isActive = true
        filterBackgroundView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        filterBackgroundView.widthAnchor.constraint(equalToConstant: 165).isActive = true
        
        
        secondButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        secondButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 230).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        secondButton.widthAnchor.constraint(equalToConstant: 165).isActive = true
        
    }
    
    
    @objc private func playWalkman(){
        if let player = player, player.isPlaying{
            // stop playback
        } else {
            // setup player and play
            let urlString = Bundle.main.path(forResource: "walkman", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                
                player.play()
            
            } catch {
                print("something went wrong")
            }
        }
        
        print("Attempting to animate stroke")
    }
    
    
    @objc private func buckleYourSeatbelt(){
        if let player = player, player.isPlaying{
            // stop playback
        } else {
            // setup player and play
            let urlString = Bundle.main.path(forResource: "buckleYourSeatbelt", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                
                player.play()
            
            } catch {
                print("something went wrong")
            }
        }
        
        print("Attempting to animate stroke")
    }
    
    @objc private func iLikeDudesALot(){
        if let player = player, player.isPlaying{
            // stop playback
        } else {
            // setup player and play
            let urlString = Bundle.main.path(forResource: "iLikeDudesAlot", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                
                player.play()
            
            } catch {
                print("something went wrong")
            }
        }
        
        print("Attempting to animate stroke")
    }
    
}

