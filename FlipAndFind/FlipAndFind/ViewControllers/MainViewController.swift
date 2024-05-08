//
//  MainViewController.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 14.04.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let titleLabel = UILabel()
    
    private let startButton = UIButton()
    private let myGamesButton = UIButton()
    private let settingsButton = UIButton()
    
    private let stackView = UIStackView()
    
    private let headerView = UIView()
    
    private let textTitle = "Memory \nBoom"
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: .languageChanged, object: nil)
        updateLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLanguage()
    }
    
    @objc private func updateLanguage() {
        startButton.setTitle(Localization.newGame, for: .normal)
        myGamesButton.setTitle(Localization.myGames, for: .normal)
        settingsButton.setTitle(Localization.settings, for: .normal)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupViews() {
        view.backgroundColor = .backgroundColor
        
        headerView.backgroundColor = .customBlue
        headerView.layer.cornerRadius = 50
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        titleLabel.text = textTitle
        titleLabel.textColor = .customWhite
        titleLabel.font = .logoMain
        titleLabel.numberOfLines = .zero
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .center
        
        [startButton, myGamesButton, settingsButton].forEach(stackView.addArrangedSubview)
        
        startButton.setTitle(Localization.newGame, for: .normal)
        myGamesButton.setTitle(Localization.myGames, for: .normal)
        settingsButton.setTitle(Localization.settings, for: .normal)
        
        [startButton, myGamesButton, settingsButton].forEach {
            $0.backgroundColor = .customBiege
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .buttonFont
        }
        
        startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        myGamesButton.addTarget(self, action: #selector(tapMyGamesButton), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(tapSettingsButton), for: .touchUpInside)
        
        view.addSubview(headerView)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        myGamesButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            myGamesButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            
            startButton.widthAnchor.constraint(equalToConstant: 225),
            myGamesButton.widthAnchor.constraint(equalToConstant: 225),
            settingsButton.widthAnchor.constraint(equalToConstant: 225)
        ])
    }
    
    private func buttonOpacity(button: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            button.alpha = 1.0
        }
    }
    
    @objc private func tapStartButton() {
        startButton.alpha = 0.6
        coordinator?.startGame()
        buttonOpacity(button: startButton)
    }
    
    @objc private func tapMyGamesButton() {
        myGamesButton.alpha = 0.6
        coordinator?.showMyGames()
        buttonOpacity(button: myGamesButton)
    }
    
    @objc private func tapSettingsButton() {
        settingsButton.alpha = 0.6
        coordinator?.showSettings()
        buttonOpacity(button: settingsButton)
    }
}
