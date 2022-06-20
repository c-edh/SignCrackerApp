//
//  ContentView.swift
//  Sign Cracker
//
//  Created by Corey Edh on 1/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @ObservedObject var viewModel = SignCrackerController()
    
    var body: some View {
        NavigationView{
            ScrollView {
                Text("Sequence:\n"  + viewModel.getSequence().joined(separator: ", "))
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.3)
                    .padding(.leading)
                    .frame(width: 300, height: 100, alignment: .leading)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 1)
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
                    .padding()
                
                NavigationLink(destination: ActionHappenedView(predication: viewModel)){
                    Text("Record")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .frame(width: 300, height: 100, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 1)
                }.simultaneousGesture(TapGesture().onEnded{
                    viewModel.makePrediction()
                })
            
                
                
            }.navigationBarHidden(true)
            
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

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
    }
}





