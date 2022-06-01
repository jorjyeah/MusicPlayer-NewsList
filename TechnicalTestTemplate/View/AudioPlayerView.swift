//
//  AudioPlayerView.swift
//  TechnicalTestTemplate
//
//  Created by jorjyeah  on 01/06/22.
//

import Foundation
import UIKit
import AVFoundation

enum AudioState {
    case play
    case pause
}

protocol AudioPlayerDelegate: AnyObject {
    func updateState(audioState: AudioState)
}

protocol AudioPlayerProtocol {
    func play()
    
    func pause()
}

class AudioPlayerView: UIViewController, AudioPlayerProtocol, AVAudioPlayerDelegate {
    // MARK: Properties
    var audioState: AudioState = .pause
    
    var audioPlayerDelegate: AudioPlayerDelegate?
    
    // MARK: Default Functions
    lazy var playButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "play-button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = audioState == .play ? UIColor.systemGray : UIColor.systemBlue
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "pause-button")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = audioState == .pause ? UIColor.systemGray : UIColor.systemBlue
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        return button
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = thickMargin
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let bgView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()

    // MARK: Default Functions
    override func viewDidLoad() {
        setupViews()
        setupLayouts()
    }
    
    private func setupViews(){
        self.view.addSubview(bgView)
        bgView.addSubview(hStackView)
        hStackView.addArrangedSubview(playButton)
        hStackView.addArrangedSubview(pauseButton)
        checkStatusPlayer()
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bgView.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            hStackView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            hStackView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            
            bgView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    @objc func play() {
        if let player = player{
            if !player.isPlaying {
                player.play()
                audioState = .play
                updateButton()
            }
        }
    }
    
    @objc func pause() {
        if let player = player{
            if player.isPlaying {
                player.pause()
                audioState = .pause
                updateButton()
            }
        }
    }
    
    func updateButton() {
        switch audioState {
        case .play:
            audioState = .play
            playButton.tintColor = .systemGray
            pauseButton.tintColor = .systemBlue
        case .pause:
            audioState = .pause
            playButton.tintColor = .systemBlue
            pauseButton.tintColor = .systemGray
        }
        audioPlayerDelegate?.updateState(audioState: audioState)
        debugPrint(audioState)
    }
    
    func initiatePlayer(){
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func checkStatusPlayer(){
        guard let player = player else {
            initiatePlayer()
            return
        }
        
        if player.isPlaying {
            audioState = .play
            updateButton()
        } else {
            audioState = .pause
            updateButton()
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        debugPrint(flag)
        if flag {
            audioState = .pause
            debugPrint(audioState)
            updateButton()
        }
    }
}
