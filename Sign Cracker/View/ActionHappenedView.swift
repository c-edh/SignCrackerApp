//
//  ActionHappenedView.swift
//  Sign Cracker
//
//  Created by Corey Edh on 1/15/22.
//

import SwiftUI

struct ActionHappenedView: View {
    
    @ObservedObject var predication : SignCrackerController
    
    
    var body: some View {
        
        
        
        VStack {
            predictionView(predictIndicator: predication.predictedIndicator, predictOutcome: predication.predictedOutcome)
            actionButton(actionThatHappened: "Steal", signCracker: predication)
            actionButton(actionThatHappened: "Bunt", signCracker: predication)
            actionButton(actionThatHappened: "Nothing", signCracker: predication)
        }
    }
}

struct ActionHappenedView_Previews: PreviewProvider {
    static var previews: some View {
        ActionHappenedView(predication: SignCrackerController())
    }
}

struct actionButton: View {
    var actionThatHappened : String
    var signCracker : SignCrackerController!

    
    var body: some View {
        Button(action:{
            signCracker.addEventToSequence(actionThatHappened)
//            self.presentation.wrappedValue.dismiss()
        }){
            Text(actionThatHappened)
                .foregroundColor(.white)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding()
        }
        .frame(width: 300, height: 100, alignment: .center)
        .background(Color.blue)
        .cornerRadius(10)

    }
}

struct predictionView: View{
    @State private var viewModel = SignCrackerController()

    var predictIndicator : String?
    var predictOutcome : String?
    
    
    var body: some View{
        VStack{
            Text("Prediction")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .frame(width: 300, height: 100, alignment: .center)
                .background(Color.green)
                .cornerRadius(10)
            HStack{
//
                Text("Outcome:\n" + predictOutcome!)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .frame(width: 285, height: 100, alignment: .leading)
                    .padding(.leading)
                    .background(Color.green)
                    .cornerRadius(10)
            
            }
        
        }.padding()
            .foregroundColor(.white)
        
    }
}
