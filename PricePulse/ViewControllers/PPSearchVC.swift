//
//  PPSearchVC.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/8/24.
//

import UIKit

class PPSearchVC: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = PPTitleLabel()
    let assetTextField = PPTextField()
    let callToActionButton = PPButton(title: "See Asset Info")
    var isAssetEntered: Bool { return !assetTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTitleLabel()
        configureTextField()
        configureCallToActionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLogoImageView() {
        view.addSubview(imageView)
        imageView.image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "PricePulse"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureTextField() {
        view.addSubview(assetTextField)
        configureTapGesture()
        assetTextField.delegate = self
        
        assetTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            assetTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            assetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            assetTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            assetTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushAssetVC), for: .touchUpInside)
        
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: assetTextField.bottomAnchor, constant: 100),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushAssetVC() {
        guard isAssetEntered else {
            presentErrorOnMainThread(title: "No Asset Entered", message: "Please enter an asset name", buttonTitle: "Ok")
            return
        }
        
        let assetVC = AssetVC()
        assetVC.assetName = assetTextField.text
        navigationController?.pushViewController(assetVC, animated: true)
    }
}

extension PPSearchVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.borderWidth = 3
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushAssetVC()
        return true
    }
}

