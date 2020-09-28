//
//  ShapeView.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/25/20.
//

import SwiftUI

struct ShapeView<T: Shape>: View {
    let width: CGFloat
    let color: Color
    let opacity: Double
    let shape: T
    
    var body: some View {
        HStack {
            ZStack {
                shape.opacity(opacity)
                shape.stroke(lineWidth: width/50)
            }
            .foregroundColor(color)
            .aspectRatio(contentMode: .fit)
        }
        .frame(width: width/3, height: width * 2 / 3)
    }
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            HStack {
                ShapeView(width: 50.0, color: Color.red, opacity: 0, shape: SquiggleShape())
                ShapeView(width: 50.0, color: Color.red, opacity: 0, shape: SquiggleShape())
//                ShapeView(width: 100.0, color: Color.red, opacity: 0, shape: SquiggleShape())
            }
        }
        .padding()
    }
}
