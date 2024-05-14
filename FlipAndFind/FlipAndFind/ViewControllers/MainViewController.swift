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
    private let scrollView = UIScrollView()
    
    private let textTitleLandscape = "Memory Boom"
    private let textTitlePortrait = "Memory \nBoom"
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateTitleLabel(for: view.bounds.size)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: .languageChanged, object: nil)
        updateLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLanguage()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.updateTitleLabel(for: size)
        }, completion: nil)
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
        
        titleLabel.textColor = .customWhite
        titleLabel.font = .logoMain
        titleLabel.numberOfLines = .zero
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .center
        
        startButton.setTitle(Localization.newGame, for: .normal)
        myGamesButton.setTitle(Localization.myGames, for: .normal)
        settingsButton.setTitle(Localization.settings, for: .normal)
        
        [startButton, myGamesButton, settingsButton].forEach {
            $0.backgroundColor = .customBiege
            $0.setTitleColor(.customBlack, for: .normal)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .buttonFont
            stackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(stackView)
        
        [headerView, titleLabel, scrollView].forEach {
            view.addSubview($0)
        }
        
        setupButtonsAction()
    }
    
    private func setupConstraints() {
        [headerView, titleLabel, stackView, scrollView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [startButton, myGamesButton, settingsButton].forEach {
            $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            $0.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 48).isActive = true
            $0.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -48).isActive = true
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func updateTitleLabel(for size: CGSize) {
        if size.width > size.height {
            titleLabel.text = textTitleLandscape
        } else {
            titleLabel.text = textTitlePortrait
        }
    }
    
    private func setupButtonsAction() {
        startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        myGamesButton.addTarget(self, action: #selector(tapMyGamesButton), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(tapSettingsButton), for: .touchUpInside)
    }
    
    private func buttonOpacity(button: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
