//
//  SignButtons.swift
//  Sign Cracker
//
//  Created by Corey Edh on 1/14/22.
//

import SwiftUI

struct SignButtonsView: View {
    
    
    @ObservedObject var viewModel = SignCrackerController()

    
    var body: some View {
        VStack{
            HStack{
                givenSign(signShown: "Chin\n", sign: "A", viewModel: viewModel)
                givenSign(signShown: "Hat\n", sign: "B",viewModel: viewModel)
                givenSign(signShown: "Nose\n", sign: "C",viewModel: viewModel)
            }
            HStack{
                givenSign(signShown: "Left\nShoulder", sign: "D",viewModel: viewModel)
                givenSign(signShown: "Chest\n", sign: "E",viewModel: viewModel)
                givenSign(signShown: "Right\nShoulder", sign: "F",viewModel: viewModel)
            }
            HStack{
                givenSign(signShown: "Left\nForearm", sign: "G",viewModel: viewModel)
                givenSign(signShown: "Belly\n", sign: "H",viewModel: viewModel)
                givenSign(signShown: "Right\nForearm", sign: "I",viewModel: viewModel)
            }
            HStack{
                givenSign(signShown: "Left\nHand", sign: "J",viewModel: viewModel)
                givenSign(signShown: "Watch\n", sign: "K",viewModel: viewModel)
                givenSign(signShown: "Right\nHand", sign: "L",viewModel: viewModel)
            }
            HStack{
                givenSign(signShown: "Left\nKnee", sign: "M",viewModel: viewModel)
                givenSign(signShown: "Belt\n", sign: "N",viewModel: viewModel)
                givenSign(signShown: "Right\nKnee", sign: "O",viewModel: viewModel)
            }
        }
    }
}

struct givenSign: View {
    @State  var signShown : String
    @State  var sign : String
    var viewModel : SignCrackerController!
    

    
    var body: some View {
        Button(action:{
            viewModel.updateSequence(sign)
            print(viewModel.getSequence())
        }) {
            Text(sign+"\n"+signShown)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .fontWeight(.bold)
        }
        .frame(width: 100, height: 75, alignment: .center)
        .background(Color.blue)
        .cornerRadius(5)
        .shadow(color: .black, radius: 1.0)
        .padding()
    }
}


struct SignButtons_Previews: PreviewProvider {
    static var previews: some View {
        SignButtonsView()
    }
}
