//
//  SignupViewController.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 07/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import IBAnimatable

class SignupViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var phoneField: AnimatableTextField!
	@IBOutlet weak var sendCodeButton: AnimatableButton!

	@IBOutlet weak var pinView: AnimatableView!
	@IBOutlet weak var pinField: AnimatableTextField!

	override func viewDidLoad() {
        super.viewDidLoad()
		// Handle the background taps
//		view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

		// Add the delegates for the UITextFields
		pinField.delegate = self

		// TODO: Remove this
		phoneField.text = "+30 6931223366"
    }

	/// Dismisses the keyboard, and tries to send the authentication
	/// request if the phone number we have provided is valid
	@IBAction func onSendCodeButtonTap(_ sender: Any) {
		// Dismiss the keyboard
		dismissKeyboard()

		// Send a request to authenticate the phone we provided
		if let phoneNumber = checkPhoneNumber() {
			log.info("Sending the phone to authenticate the user")
			// Disable the sendCodeButton
			sendCodeButton.isEnabled = false

			// Set the PhoneAuthDelegate to this controller and send the request
			FirebaseAuth.auth.phoneAuthDelegate = self
			FirebaseAuth.auth.authPhone(phoneNumber)
		} else {
			// TODO: Show an alert that says the phone number is invalid
		}
	}

	/// Dismisses the keyboard regardless of which UITextField is the first responder
	@objc func dismissKeyboard() {
		// Dismiss the keyboard
		phoneField.resignFirstResponder()
		pinField.resignFirstResponder()
	}

	/// Sanitizes the phoneField text and returns the sanitized string
	/// If the phoneNumber is not valid, it returns nil
	func checkPhoneNumber() -> String? {
		if let phoneNumber = phoneField.text {
			return phoneNumber
		}
		return nil
	}

	/// Shows the pin view using a slideIn animation from the bottom up
	func showPinView() {
		pinView.isHidden = false
		pinView.animate(.slideFade(way: .in, direction: .up), duration: 0.35, damping: 0.65, velocity: 0.5)
	}
}

// MARK: - PinField selector
extension SignupViewController {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
				   replacementString string: String) -> Bool {
		if textField == pinField {
			return checkPinField(shouldChangeCharactersIn: range,
								 replacementString: string)
		}

		return true
	}

	/// Checks if the input of the pinField is correct
	func checkPinField(shouldChangeCharactersIn range: NSRange,
					   replacementString string: String) -> Bool {
		// Find the current length of the characters in the textField
		let currentCharacterCount = pinField.text?.count ?? 0
		let newLength = currentCharacterCount + string.count - range.length

		// If the text will exceed the limit (6), do add characters to the string
		if newLength > 6 {
			return false
		}

		// If the newLegth is 6, call the FirebaseAuth.checkCode()
		if newLength == 6, let prevPin = pinField.text {
			FirebaseAuth.auth.checkVerificationCode(prevPin + string)
		}

		return true
	}
}

// MARK: - PhoneAuthDelegate
extension SignupViewController: PhoneAuthDelegate {
	func verifiedPhone(withError error: Error?) {
		if let error = error {
			log.error("We got a phone authentication error: \(error.localizedDescription)")
			// If the error exists, present an error dialog to the user and re-enable the sendCodeButton
			sendCodeButton.isEnabled = true
		} else {
			// If there's no error, show the pinView
			showPinView()
		}
	}
}

// MARK: - VerificationCodeDelegate
extension SignupViewController: VerificationCodeDelegate {
	func checkedVerificationCode(userID: String?) {
		if userID != nil {
			dismiss(animated: true)
		} else {

		}
	}
}
