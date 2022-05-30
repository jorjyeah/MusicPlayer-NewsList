//
//  HomeViewController.swift
//  TechnicalTestTemplate
//
//  Created by George Joseph Kristian on 30/05/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    lazy var stackView: UIStackView = {
        var stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 32
        return stackView
    }()
    
    lazy var greetingsLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "Welcome you can choose your favourite news while listening to music"
        label.textAlignment = .center
        label.font = UIFont(name: "Comic Sans MS", size: 24)
        label.textColor = UIColor.init(rgb: 0x118ee9)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var musicIndicatorLabel: UILabel = {
        var label: UILabel = UILabel()
        label.text = "oops"
        label.textAlignment = .center
        label.font = UIFont(name: "Comic Sans MS", size: 24)
        label.textColor = UIColor.init(rgb: 0xb2b7ff)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var selectNewsButton: UIButton = {
        var button: UIButton = UIButton()
        button.setTitle("SELECT NEWS", for: .normal)
        button.backgroundColor = UIColor.init(rgb: 0x118ee9)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    func setupViews(){
        self.title = "Home"
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(greetingsLabel)
        stackView.addArrangedSubview(musicIndicatorLabel)
        stackView.addArrangedSubview(selectNewsButton)
        stackView.addArrangedSubview(UIView())
    }
    
    func setupLayouts(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:  mainMargin),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -mainMargin),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: mainMargin),
            
            selectNewsButton.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            selectNewsButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        ])
    }
}
