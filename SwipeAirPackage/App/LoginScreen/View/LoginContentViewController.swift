//
//  LoginContentViewController.swift
//  SwipeAirPackage
//
//  Created by apple on 08/07/25.
//

import UIKit
import SwiftUI

class LoginContentViewController: UIViewController {

    var screenData: LoginScreen = .mock

    private var titleSubtitleView: TitleSubtitleView!
    private let toggleInputModeLabel = UILabel()
    private var toggleInputModeLabelTopForPhone: NSLayoutConstraint!
    private var toggleInputModeLabelTopForEmail: NSLayoutConstraint!
    private var isUsingEmail = false

    private let phoneTextField = SAPPhoneInputView()
    private let emailTextField = SAPTextInputView()
    private let credentialInput = SAPTextInputView()


    private var sendOtpButton: SAPButton!
    private var sendOtpButtonHeightConstraint: NSLayoutConstraint!
    private var loginModeToggleButton: SAPSecondaryButton!
    private var loginButtonTopToSendOtpConstraint: NSLayoutConstraint!
    private var loginButtonTopToCredentialInputConstraint: NSLayoutConstraint!
    private var passwordLoginButton: SAPButton!
    private var passwordLoginButtonHeightConstraint: NSLayoutConstraint!
    private var passwordLoginButtonTopConstraint: NSLayoutConstraint!
    private var hasSentOtp = false



    private var isUsingPassword = false
    private var socialStack = SAPSocialButtons()

    private let signupLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        setupUI()
        applyConstraints()
    }

    private func applyGradientBackground() {
        let gradientHeight: CGFloat = 193
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(gradientView, at: 0)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: gradientHeight)
        ])

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FDEBFF").cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: gradientHeight)

        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

    @objc private func toggleInputMode() {
        isUsingEmail.toggle()

        phoneTextField.isHidden = isUsingEmail
        emailTextField.isHidden = !isUsingEmail
        toggleInputModeLabel.text = isUsingEmail ? "Use Phone Instead" : screenData.emailToggleText

        toggleInputModeLabelTopForPhone.isActive = !isUsingEmail
        toggleInputModeLabelTopForEmail.isActive = isUsingEmail

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func handleOtpButtonTap() {
        if !hasSentOtp {
            print("sendOtp")
            showAlert("Success", "OTP sent")
            hasSentOtp = true
            sendOtpButton.setTitle("Verify and Login", for: .normal)
        } else {
            print("verifyOtp")
            showAlert("Success", "OTP verified")
            // Optionally: navigate, authenticate, or reset state here
        }
    }

    
    @objc private func toggleLoginMode() {
        isUsingPassword.toggle()

        credentialInput.placeholder = isUsingPassword ? "Enter Password" : "Enter OTP"

        // Immediately update visibility-related constraints without animating
        sendOtpButtonHeightConstraint.constant = isUsingPassword ? 0 : 50
        passwordLoginButtonHeightConstraint.constant = isUsingPassword ? 50 : 0

        loginButtonTopToSendOtpConstraint.isActive = false
        loginButtonTopToCredentialInputConstraint.isActive = false
        passwordLoginButtonTopConstraint.isActive = isUsingPassword
        loginButtonTopToSendOtpConstraint.isActive = !isUsingPassword

        loginButtonTopToCredentialInputConstraint = loginModeToggleButton.topAnchor.constraint(
            equalTo: isUsingPassword ? passwordLoginButton.bottomAnchor : sendOtpButton.bottomAnchor,
            constant: 20
        )
        loginButtonTopToCredentialInputConstraint.isActive = true

        // Immediately apply layout (no animation to avoid vertical bounce)
        self.view.layoutIfNeeded()

        if isUsingPassword {
            // Show password login button from left
            passwordLoginButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
            passwordLoginButton.alpha = 0
            passwordLoginButton.isHidden = false

            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.passwordLoginButton.transform = .identity
                self.passwordLoginButton.alpha = 1
            }

            // Hide OTP button to the right
            UIView.animate(withDuration: 0.3, animations: {
                self.sendOtpButton.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
                self.sendOtpButton.alpha = 0
            }, completion: { _ in
                self.sendOtpButton.isHidden = true
                self.sendOtpButton.transform = .identity
            })

        } else {
            // Show OTP button from left
            sendOtpButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
            sendOtpButton.alpha = 0
            sendOtpButton.isHidden = false
            hasSentOtp = false
            sendOtpButton.setTitle(screenData.otpButtonText, for: .normal)


            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.sendOtpButton.transform = .identity
                self.sendOtpButton.alpha = 1
            }

            // Hide password login button to the right
            UIView.animate(withDuration: 0.3, animations: {
                self.passwordLoginButton.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
                self.passwordLoginButton.alpha = 0
            }, completion: { _ in
                self.passwordLoginButton.isHidden = true
                self.passwordLoginButton.transform = .identity
            })
        }

        loginModeToggleButton.setTitle(isUsingPassword ? "Login with OTP" : "Login with Password", for: .normal)
    }
	

    
    @objc private func handleSignupTap() {
        let signupBridgeView = SignUpScreenBridgeView()
        let hostingVC = UIHostingController(rootView: signupBridgeView)
        hostingVC.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(hostingVC, animated: true)
    }


    private func setupUI() {
        view.backgroundColor = .white

        titleSubtitleView = TitleSubtitleView(title: screenData.titleText, subtitle: screenData.subtitleText)
        view.addSubview(titleSubtitleView)

        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter Email Address"
        emailTextField.isHidden = true
        
        // Credential Input Field (for OTP/Password)
        credentialInput.placeholder = "Enter OTP"
        view.addSubview(credentialInput)
        
        passwordLoginButton = SAPButton(title: "Login", height: 60) {
            print("Login tapped with password")
            // Perform password login action here
        }
        passwordLoginButton.isHidden = true
        passwordLoginButton.alpha = 0// initially hidden

        view.addSubview(passwordLoginButton)
        passwordLoginButton.translatesAutoresizingMaskIntoConstraints = false

        toggleInputModeLabel.text = screenData.emailToggleText
        toggleInputModeLabel.font = UIFont.jost(.medium, size: 16)
        toggleInputModeLabel.textColor = UIColor(hex: "#FF6D09")
        toggleInputModeLabel.textAlignment = .left
        toggleInputModeLabel.isUserInteractionEnabled = true
        let toggleGesture = UITapGestureRecognizer(target: self, action: #selector(toggleInputMode))
        toggleInputModeLabel.addGestureRecognizer(toggleGesture)

        sendOtpButton = SAPButton(title: screenData.otpButtonText, height: 60) { [weak self] in
            self?.handleOtpButtonTap()
        }



        loginModeToggleButton = SAPSecondaryButton(
            title: screenData.passwordButtonText,
            height: 60
        ) { [weak self] in
            self?.toggleLoginMode()
        }
        
        
        let signupPromptAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.jost(.regular, size: 16),
            .foregroundColor: UIColor(hex: "#7B7B7B")
        ]

        let signupActionAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.jost(.semiBold, size: 16),
            .foregroundColor: UIColor.black
        ]

        let signupPromptText = NSMutableAttributedString(string: "\(screenData.signupPromptText) ", attributes: signupPromptAttributes)
        let signupActionText = NSAttributedString(string: screenData.signupActionText, attributes: signupActionAttributes)

        signupPromptText.append(signupActionText)
        signupLabel.attributedText = signupPromptText
        signupLabel.textAlignment = .center
        signupLabel.isUserInteractionEnabled = true
        let signupTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignupTap))
        signupLabel.addGestureRecognizer(signupTapGesture)



        [
            titleSubtitleView, phoneTextField, emailTextField,
            toggleInputModeLabel, credentialInput,
            sendOtpButton, loginModeToggleButton,
            signupLabel, socialStack
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

    }

    private func applyConstraints() {
        toggleInputModeLabelTopForPhone = toggleInputModeLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8)
        toggleInputModeLabelTopForEmail = toggleInputModeLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8)
        sendOtpButtonHeightConstraint = sendOtpButton.heightAnchor.constraint(equalToConstant: 50)

        loginButtonTopToSendOtpConstraint = loginModeToggleButton.topAnchor.constraint(equalTo: sendOtpButton.bottomAnchor, constant: 16)
        loginButtonTopToCredentialInputConstraint = loginModeToggleButton.topAnchor.constraint(equalTo: credentialInput.bottomAnchor, constant: 20)
        
        passwordLoginButtonTopConstraint = passwordLoginButton.topAnchor.constraint(equalTo: credentialInput.bottomAnchor, constant: 20)
        passwordLoginButtonHeightConstraint = passwordLoginButton.heightAnchor.constraint(equalToConstant: 50)


        NSLayoutConstraint.activate([
            titleSubtitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleSubtitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleSubtitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            phoneTextField.topAnchor.constraint(equalTo: titleSubtitleView.bottomAnchor, constant: 30),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),

            emailTextField.topAnchor.constraint(equalTo: titleSubtitleView.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            toggleInputModeLabel.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            toggleInputModeLabelTopForPhone,
            
            credentialInput.topAnchor.constraint(equalTo: toggleInputModeLabel.bottomAnchor, constant: 10),
            credentialInput.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            credentialInput.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            credentialInput.heightAnchor.constraint(equalToConstant: 50),

            passwordLoginButtonTopConstraint,
               passwordLoginButton.leadingAnchor.constraint(equalTo: credentialInput.leadingAnchor),
               passwordLoginButton.trailingAnchor.constraint(equalTo: credentialInput.trailingAnchor),
               passwordLoginButtonHeightConstraint,
            
            sendOtpButton.topAnchor.constraint(equalTo: credentialInput.bottomAnchor, constant: 20),
            sendOtpButton.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            sendOtpButton.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            sendOtpButtonHeightConstraint,
            
            loginButtonTopToSendOtpConstraint,
            
            loginModeToggleButton.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            loginModeToggleButton.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            loginModeToggleButton.heightAnchor.constraint(equalToConstant: 50),


            signupLabel.topAnchor.constraint(equalTo: loginModeToggleButton.bottomAnchor, constant: 40),
            signupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            socialStack.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 16),
            socialStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
