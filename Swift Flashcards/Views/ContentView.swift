//
//  ContentView.swift
//  Swift Flashcards
//
//  Created by Kyle Musco on 6/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var cardViewModel = CardViewModel()

    
    var body: some View {
        VStack {
            Text("Progress: \(cardViewModel.numAnswered)/\(cardViewModel.cards.count)")
            
            CardView(card: self.cardViewModel.nextCard!)
            
            HStack {
                Button(action: {
                    cardViewModel.getNextCard()
                    cardViewModel.incrementProgress()
                }, label: {
                    Text("Incorrect")
                        .foregroundColor(Color.white)
                })
                .frame(width: 150, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.red)
                .cornerRadius(6)
                
                Button(action: {
                    cardViewModel.incrementScore()
                    cardViewModel.incrementProgress()
                    cardViewModel.getNextCard()
                }, label: {
                    Text("Correct")
                        .foregroundColor(Color.white)
                })
                .frame(width: 150, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.green)
                .cornerRadius(6)
            }
            .padding(.top, 50)
            .alert(isPresented: $cardViewModel.isOver, content: {
                Alert(title: Text("The End"),
                      message: Text("You scored \(cardViewModel.numCorrect)/\(cardViewModel.cards.count)"),
                      primaryButton: .default(Text("Reset")) {
                        cardViewModel.reset()
                      },
                      secondaryButton: .cancel() {
                        cardViewModel.reset()
                      })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
