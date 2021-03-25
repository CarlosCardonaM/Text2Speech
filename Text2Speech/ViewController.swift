//
//  ViewController.swift
//  Text2Speech
//
//  Created by Carlos Cardona on 24/03/21.
//

import UIKit
import MicrosoftCognitiveServicesSpeech


class ViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Text2Speech"
        label.textColor = #colorLiteral(red: 0.2549260855, green: 0.2547580004, blue: 0.3820358515, alpha: 1)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private var instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Type something to make it talk"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549260855, green: 0.2547580004, blue: 0.3820358515, alpha: 1)
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Type"
        textfield.backgroundColor = .secondarySystemBackground
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.layer.cornerRadius = CGFloat(10)
        textfield.autocapitalizationType = .sentences
        textfield.returnKeyType = .done
        return textfield
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
//        indicator.isHidden = true
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = #colorLiteral(red: 0.2549260855, green: 0.2547580004, blue: 0.3820358515, alpha: 1)
        return indicator
    }()
    
    private var voiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Make it talk", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549260855, green: 0.2547580004, blue: 0.3820358515, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = CGFloat(10)
        return button
    }()
    
    var inputText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        addSubviews()
        
        
        voiceButton.addTarget(self, action: #selector(voiceButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        titleLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 50, width: view.width - 40, height: 70)
        instructionsLabel.frame = CGRect(x: 20, y: titleLabel.bottom + 40, width: view.width - 40, height: 40)
        textField.frame = CGRect(x: 20, y: instructionsLabel.bottom + 20, width: view.width - 40, height: 52)
        activityIndicator.frame = CGRect(x: 20, y: textField.bottom + 40, width: view.width - 40, height: 30)
        voiceButton.frame = CGRect(x: 45, y: view.bottom - 90, width: view.width - 90, height: 52)
    }
    
    @objc func voiceButtonTapped() {
        
        DispatchQueue.main.async {
            self.synthesisToSpeaker()
        }
        
        
        if textField.text == "" {
            
            simpleAlert(title: "Error", message: "Please enter something into the textField")
        }
        
    }
    
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(textField)
        view.addSubview(voiceButton)
        view.addSubview(activityIndicator)
    }
    
    func synthesisToSpeaker() {
        
        var speechConfig: SPXSpeechConfiguration?
        do {
            try speechConfig = SPXSpeechConfiguration(subscription: Keys.KEY, region: Keys.REGION)
        } catch {
            print("error \(error) happened")
            speechConfig = nil
        }
        let synthesizer = try! SPXSpeechSynthesizer(speechConfig!)
        if inputText.isEmpty {
            return
        }
        let result = try! synthesizer.speakText(inputText)
        
        if result.reason.rawValue == 9 {
        }
        
        if result.reason == .canceled {
            let cancellationDetails = try! SPXSpeechSynthesisCancellationDetails(fromCanceledSynthesisResult: result)
            print("cancelled, detail: \(cancellationDetails.errorDetails!) ")
        }
    }


}


extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
        let textRange = Range(range, in: text) {
            self.inputText = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
    
}
