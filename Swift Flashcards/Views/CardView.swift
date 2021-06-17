//
//  CardView.swift
//  Swift Flashcards
//
//  Created by Kyle Musco on 6/5/21.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    @State private var viewAnswer = false
    @State private var animate3d = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black)
                .background(Color.white)
                .frame(width: 330, height: 500)
                
                
            if (!viewAnswer) {
                Text(card.question)
                    .frame(width: 300, height: 400, alignment: .center)
                    .padding()
            } else {
                AnswerView(text: card.answer)
                    .frame(width: 300, height: 475, alignment: .leading)
                    .onChange(of: card.answer, perform: { _ in
                        viewAnswer = false
                        animate3d = false
                    })
            }
        }
        .modifier(FlipEffect(flipped: $viewAnswer, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.2)) {
                self.animate3d.toggle()
            }
        }
    }
}

struct FlipEffect: GeometryEffect {

      var animatableData: Double {
            get { angle }
            set { angle = newValue }
      }

      @Binding var flipped: Bool
      var angle: Double
      let axis: (x: CGFloat, y: CGFloat)

      func effectValue(size: CGSize) -> ProjectionTransform {

            DispatchQueue.main.async {
                  self.flipped = self.angle >= 90 && self.angle < 270
            }

            let tweakedAngle = flipped ? -180 + angle : angle
            let a = CGFloat(Angle(degrees: tweakedAngle).radians)

            var transform3d = CATransform3DIdentity;
            transform3d.m34 = -1/max(size.width, size.height)

            transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
            transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)

            let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))

            return ProjectionTransform(transform3d).concatenating(affineTransform)
      }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.init(question: "Question 1", answer: "Answer 1", category: Card.Category.General))
    }
}
