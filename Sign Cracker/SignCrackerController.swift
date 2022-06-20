//
//  SignCrackerController.swift
//  Sign Cracker
//
//  Created by Corey Edh on 1/18/22.
//

import Foundation
import SwiftUI

class SignCrackerController: ObservableObject{
    
    @Published var currentSequence : [String] = []
    @Published var predictedIndicator : String = "N/A"
    @Published var predictedOutcome : String = "N/A"
    
    var predictingSteal : [String] = []
    var predictingBunt : [String] = []
    var predictingHitrun : [String] = []
    
    @Published var sequenceOutcome : [String:String] = [:]
    
    
    func getSequence() -> [String]{
        return currentSequence
    }
    
    func updateSequence(_ char: String){
        self.currentSequence.append(char)
    }
    
    func addEventToSequence(_ event: String){
        sequenceOutcome[currentSequence.joined(separator: "")] = event
        currentSequence.removeAll()
        print(sequenceOutcome)
    }
    
    func getOutcome(){
        var steal = 0
        var bunt = 0
        var hitrun = 0

        print(predictingSteal)
        if predictingSteal.count == 2{
            for i in predictingSteal{
                if(currentSequence.contains(i)){
                    steal+=1
                }
            }
        }
        
        if predictingBunt.count == 2{
            for i in predictingBunt{
                if(currentSequence.contains(i)){
                    bunt+=1
                }
            }
        }
        
        if predictingHitrun.count == 2{
            for i in predictingHitrun{
                if(currentSequence.contains(i)){
                    hitrun+=1
                }
            }
        }
        
        if steal == 2{
            self.predictedOutcome = "Steal"
        }else if bunt == 2{
            self.predictedOutcome = "Bunt"
        }else if hitrun == 2{
            self.predictedOutcome = "Hit & Run"
        }
        
        
        
    }
    
    func makePrediction(){
        predictedOutcome = "N/A"
        if sequenceOutcome.count > 1 {
            var signsINSTEAL : String = ""
            var signsINBUNT : String = ""
            var signsINHITRUN : String = ""
            var signsINNOTHING : String = ""
            
            var lettersINSTEAL : [String : Int] = [:]
            var lettersINBUNT : [String : Int] = [:]
            var lettersINHITRUN : [String : Int] = [:]
            var lettersINNOTHING : [String : Int] = [:]
            
            var numbersINSTEAL : [Int : [String]] = [:]
            var numbersINBUNT : [Int : [String]] = [:]
            var numbersINHITRUN : [Int : [String]] = [:]
            var numbersINNOTHING : [Int : [String]] = [:]
            
            var stealCounter = 0
            var buntCounter = 0
            var hitrunCounter = 0
            var nothingCounter = 0
            
            var possibleIndicator : [String] = []
            var possibleBuntSign : [String] = []
            var possibleStealSign : [String] = []
            var possibleHitRunSign : [String] = []
            
            
            for sequence in sequenceOutcome.keys{
                if sequenceOutcome[sequence] == "Steal"{
                    signsINSTEAL += sequence
                    stealCounter += 1
                }
                else if sequenceOutcome[sequence] == "Bunt"{
                    signsINBUNT += sequence
                    buntCounter += 1
                }
                else if sequenceOutcome[sequence] == "Hit & Run"{
                    signsINHITRUN += sequence
                    hitrunCounter += 1
                }
                else if sequenceOutcome[sequence] == "Nothing" {
                    signsINNOTHING += sequence
                    nothingCounter += 1
                }
            }
            
            for letter in Array(signsINSTEAL){
                if (lettersINSTEAL[String(letter)] != nil){
                    lettersINSTEAL[String(letter)]! += 1
                    
                }else{
                    lettersINSTEAL[String(letter)] = 1
                }
            }
            
            for letter in Array(signsINBUNT){
                if (lettersINBUNT[String(letter)] != nil){
                    lettersINBUNT[String(letter)]! += 1
                    
                }else{
                    lettersINBUNT[String(letter)] = 1
                }
            }
            
            for letter in Array(signsINHITRUN){
                if (lettersINHITRUN[String(letter)] != nil){
                    lettersINHITRUN[String(letter)]! += 1
                    
                }else{
                    lettersINHITRUN[String(letter)] = 1
                }
            }
            
            for letter in lettersINSTEAL.keys{
                if numbersINSTEAL[Int(lettersINSTEAL[String(letter)]!)] != nil{
                    numbersINSTEAL[Int(lettersINSTEAL[String(letter)]!)]!.append(letter)
                }
                else{
                    numbersINSTEAL[Int(lettersINSTEAL[String(letter)]!)] = [letter]
                }
            }
            for letter in lettersINBUNT.keys{
                print(letter)
                if numbersINBUNT[Int(lettersINBUNT[String(letter)]!)] != nil{
                    numbersINBUNT[Int(lettersINBUNT[String(letter)]!)]!.append(letter)
                }
                else{
                    numbersINBUNT[Int(lettersINBUNT[String(letter)]!)] = [letter]
                }
            }
            for letter in lettersINHITRUN.keys{
                if numbersINHITRUN[Int(lettersINHITRUN[String(letter)]!)] != nil{
                    numbersINHITRUN[Int(lettersINHITRUN[String(letter)]!)]!.append(letter)
                }
                else{
                    numbersINHITRUN[Int(lettersINSTEAL[String(letter)]!)] = [letter]
                }
            }
            
            let stealsigns = numbersINSTEAL[stealCounter]
            let buntsigns = numbersINBUNT[buntCounter]
            let hitrunsigns = numbersINHITRUN[hitrunCounter]
            
            if (buntCounter != 0) && (stealCounter != 0) {
                for letter in numbersINBUNT[buntCounter]!{
//                    print(letter)
                //    print(numbersINSTEAL[stealCounter])
                    
                    if numbersINSTEAL[stealCounter]!.contains(String(letter)){
                        possibleIndicator.append(String(letter))
                        
                    }else{
                        possibleBuntSign.append(String(letter))
                    }
                }
            }
            
            if (stealCounter != 0) && (buntCounter != 0) {
                for letter in numbersINSTEAL[stealCounter]!{
                    if numbersINBUNT[buntCounter]!.contains(String(letter)){
                        possibleIndicator.append(String(letter))
                    }else{
                        possibleStealSign.append(String(letter))
                    }
                }
            }
            
            if (hitrunCounter != 0) && (stealCounter != 0) {
                for letter in numbersINHITRUN[hitrunCounter]!{
                    if numbersINSTEAL[stealCounter]!.contains(String(letter)){
                        possibleIndicator.append(String(letter))
                    }else{
                        possibleHitRunSign.append(String(letter))
                    }
                }
            }
            
            print("Possible indicator " + possibleIndicator.joined(separator: ", "))
            print("Possible Steal Sign " + possibleStealSign.joined(separator: ", "))
            print("Possible Bunt Sign " + possibleBuntSign.joined(separator: ", "))
            
            var notIT : [String:[String]] = [:]
            
            if possibleBuntSign.count > 1{
            for event in sequenceOutcome{
                if event.value == "Nothing"{
                    for letters in Array(event.value){
                        if possibleBuntSign.contains(String(letters)){
                            let test = letters
                            for letter in event.value{
                                if possibleIndicator.contains(String(letter)){
                                   
                                    if notIT[String(letter)] != nil{
                                        notIT[String(letter)]!.append(String(letters))
                                    }else{
                                        notIT[String(letter)] = [String(letters)]
                                    }
                                }
                            }
                        }
                    }
                }
            }}
                if possibleStealSign.count > 1{
                for event in sequenceOutcome{
                    if event.value == "Nothing"{
                        for letters in Array(event.value){
                            if possibleStealSign.contains(String(letters)){
                                let test = letters
                                for letter in event.value{
                                    if possibleIndicator.contains(String(letter)){
                                       
                                        if notIT[String(letter)] != nil{
                                            notIT[String(letter)]!.append(String(letters))
                                        }else{
                                            notIT[String(letter)] = [String(letters)]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    
                }
                    if possibleHitRunSign.count > 1{
                    for event in sequenceOutcome{
                        if event.value == "Nothing"{
                            for letters in Array(event.value){
                                if possibleHitRunSign.contains(String(letters)){
                                    let test = letters
                                    for letter in event.value{
                                        if possibleIndicator.contains(String(letter)){
                                           
                                            if notIT[String(letter)] != nil{
                                                notIT[String(letter)]!.append(String(letters))
                                            }else{
                                                notIT[String(letter)] = [String(letters)]
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    }
                        for j in notIT.keys{
                            if ((possibleStealSign.contains(j)) && (possibleBuntSign.contains(j)) && (possibleStealSign.contains(j))) == false {
                                notIT.removeValue(forKey: j)
                                print(j)
                            }
                        }
                                        
                                        
            print(stealsigns)
                        
                if stealsigns != nil{
                    if stealsigns!.count <= 2 {
                        self.predictingSteal = stealsigns!
                    }
                }
            
            
                if buntsigns != nil{
                    if buntsigns!.count <= 2 {
                        self.predictingBunt = buntsigns!
                    }
                }
                
            if hitrunsigns != nil{
                if buntsigns!.count <= 2{
                    self.predictingHitrun = hitrunsigns!
                }
            }
            
            if possibleIndicator.count == 1{
                self.predictedIndicator = possibleIndicator[0]
            }
            
            getOutcome()
            
            
            
        
            
            
        }
    }
    
    
    
}
