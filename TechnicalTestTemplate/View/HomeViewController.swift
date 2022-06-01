//
//  HomeViewController.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 30/05/22.
//

import Foundation
import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    // MARK: Properties
    var musicIndicatorValue: String = "Oops.. Music stops playing."
    
    // MARK: Components
    lazy var scrollView: UIScrollView = {
        let scrollView : UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.layoutMargins = UIEdgeInsets(top: thinMargin, left: 0, bottom: thickMargin, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var greetingsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Welcome you can choose your favourite news while listening to music"
        label.textAlignment = .center
        label.font = UIFont(name: "Comic Sans MS", size: 24)
        label.textColor = UIColor.init(rgb: 0x118ee9)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var musicIndicatorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = musicIndicatorValue
        label.textAlignment = .center
        label.font = UIFont(name: "Comic Sans MS", size: 24)
        label.textColor = UIColor.init(rgb: 0xb2b7ff)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var selectNewsButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("SELECT NEWS", for: .normal)
        button.backgroundColor = UIColor.init(rgb: 0x118ee9)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        return button
    }()
    
    lazy var audioPlayerView: AudioPlayerView = {
        let audioPlayerView: AudioPlayerView = AudioPlayerView()
        audioPlayerView.view.translatesAutoresizingMaskIntoConstraints = false
        audioPlayerView.audioPlayerDelegate = self
        return audioPlayerView
    }()
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        audioPlayerView.checkStatusPlayer()
    }
    
    func setupViews(){
        self.title = "Home"
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        self.view.addSubview(audioPlayerView.view)
        stackView.addArrangedSubview(greetingsLabel)
        stackView.addArrangedSubview(musicIndicatorLabel)
        stackView.addArrangedSubview(selectNewsButton)
    }
    
    func setupLayouts(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.audioPlayerView.view.topAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            audioPlayerView.view.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            audioPlayerView.view.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            audioPlayerView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            audioPlayerView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            selectNewsButton.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: mainMargin),
            selectNewsButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -mainMargin),
            selectNewsButton.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
    }
    
    @objc func handleClick(sender: UIButton){
        let vc = NewsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: AudioPlayerDelegate{
    // MARK: Extensions
    func updateState(audioState: AudioState) {
        switch audioState {
        case .play:
            musicIndicatorValue = "Music is playing.. Enjoy!"
        case .pause:
            musicIndicatorValue = "Oops.. Music stops playing"
        }
        
        musicIndicatorLabel.text = musicIndicatorValue
    }
}
