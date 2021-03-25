//
//  SpeakerModel.swift
//  Text2Speech
//
//  Created by Carlos Cardona on 24/03/21.
//

import UIKit
import MicrosoftCognitiveServicesSpeech


struct SpeakerModel {
    
    public func speaker(inputText: String) {
        var speechConfig: SPXSpeechConfiguration?
        
        do {
            try speechConfig = SPXSpeechConfiguration(subscription: Keys.KEY, region: Keys.REGION)
        } catch {
            debugPrint(error.localizedDescription)
        }
        let synthesizer = try! SPXSpeechSynthesizer(speechConfig!)
        
        if inputText.isEmpty {
            return
        }
        
        let result = try! synthesizer.speakText(inputText)
        if result.reason == SPXResultReason.canceled {
            let cancellationDetails = try! SPXSpeechSynthesisCancellationDetails(fromCanceledSynthesisResult: result)
            print("cancelled, detail: \(cancellationDetails.errorDetails!) ")
        }
    }
    
}
