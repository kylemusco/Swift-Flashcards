//
//  AnswerView.swift
//  Swift Flashcards
//
//  Created by Kyle Musco on 6/12/21.
//

import SwiftUI

struct AnswerView: View {
    var text: String
    
    var body: some View {
        return GeometryReader { geometry in
            ScrollView {
                Text(text)
                    .lineLimit(nil)
                    .frame(width: geometry.size.width)
            }
            .background(Color.clear)
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(text: """
            Long
            Long
            Long
            Text
            """)
    }
}
