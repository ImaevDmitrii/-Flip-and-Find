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
        startAnimation()
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
        titleLabel.alpha = 0
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .center
        
        setupButton(startButton, title: Localization.newGame)
        setupButton(myGamesButton, title: Localization.myGames)
        setupButton(settingsButton, title: Localization.settings)
        
        scrollView.addSubview(stackView)
        
        [headerView, titleLabel, scrollView].forEach {
            view.addSubview($0)
        }
        setupButtonsAction()
    }
    
    private func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .customBiege
        button.setTitleColor(.customBlack, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .buttonFont
        button.alpha = 0
        stackView.addArrangedSubview(button)
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
        titleLabel.text = size.width > size.height ? textTitleLandscape : textTitlePortrait
    }
    
    private func setupButtonsAction() {
        startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        myGamesButton.addTarget(self, action: #selector(tapMyGamesButton), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(tapSettingsButton), for: .touchUpInside)
    }
    
    private func changeOpacity(view: UIView, delay: TimeInterval) {
        UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseInOut, animations: {
            view.alpha = 1.0
        })
    }
    
    private func animateButtonTap(button: UIButton) {
        button.alpha = 0.6
        changeOpacity(view: button, delay: 0)
    }
    
    private func startAnimation() {
        changeOpacity(view: titleLabel, delay: 0.1)
        changeOpacity(view: startButton, delay: 0.3)
        changeOpacity(view: myGamesButton, delay: 0.6)
        changeOpacity(view: settingsButton, delay: 0.9)
    }
    
    @objc private func tapStartButton() {
        animateButtonTap(button: startButton)
        coordinator?.startGame()
    }
    
    @objc private func tapMyGamesButton() {
        animateButtonTap(button: myGamesButton)
        coordinator?.showMyGames()
    }
    
    @objc private func tapSettingsButton() {
        animateButtonTap(button: settingsButton)
        coordinator?.showSettings()
    }
}
