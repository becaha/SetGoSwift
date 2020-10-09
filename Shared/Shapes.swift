//
//  Shapes.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/25/20.
//

import SwiftUI

struct OvalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 100))
        path.addArc(center: CGPoint(x: 100, y: 100), radius: 100, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: 200, y: 300))
        path.addArc(center: CGPoint(x: 100, y: 300), radius: 100, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: 100))
        
        let scale: CGFloat = rect.height / path.boundingRect.height

        let transform = CGAffineTransform(scaleX: scale, y: scale)

        path = path.applying(transform)

        return path
            .offsetBy(dx: ((rect.minX - path.boundingRect.minX + rect.width - path.boundingRect.width) / 2), dy: 0)
    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 100, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 400))
        path.addLine(to: CGPoint(x: 0, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 0))
        
        let scale: CGFloat = rect.height / path.boundingRect.height

        let transform = CGAffineTransform(scaleX: scale, y: scale)

        path = path.applying(transform)

        return path
            .offsetBy(dx: ((rect.minX - path.boundingRect.minX + rect.width - path.boundingRect.width) / 2), dy: 0)
    }
}

struct SquiggleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 81, y: 994))
        path.addCurve(to: CGPoint(x: 471, y: 584), control1: CGPoint(x: 300, y: 1078), control2: CGPoint(x: 551, y: 851))

        path.addCurve(to: CGPoint(x: 461, y: 224), control1: CGPoint(x: 444, y: 477), control2: CGPoint(x: 351, y: 376))

        path.addCurve(to: CGPoint(x: 331, y: 4), control1: CGPoint(x: 587, y: 50), control2: CGPoint(x: 514, y: 8))

        path.addCurve(to: CGPoint(x: 51, y: 314), control1: CGPoint(x: 151, y: 0), control2: CGPoint(x: 28, y: 145))

        path.addCurve(to: CGPoint(x: 71, y: 844), control1: CGPoint(x: 83, y: 546), control2: CGPoint(x: 246, y: 573))

        path.addCurve(to: CGPoint(x: 81, y: 994), control1: CGPoint(x: 31, y: 907), control2: CGPoint(x: 0, y: 963))
        
        let scale: CGFloat = rect.height / path.boundingRect.height
        
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        
        path = path.applying(transform)
        
        return path
            .offsetBy(dx: ((rect.minX - path.boundingRect.minX + rect.width - path.boundingRect.width) / 2), dy: 0)
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DiamondShape().background(Color.red)
                .aspectRatio(1/2, contentMode: .fit)

            SquiggleShape().background(Color.green)
                .aspectRatio(1/2, contentMode: .fit)

            OvalShape().background(Color.yellow)
                .aspectRatio(1/2, contentMode: .fit)
        }
    }
}
