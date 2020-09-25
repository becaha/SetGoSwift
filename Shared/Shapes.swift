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
            .offsetBy(dx: (rect.minX - path.boundingRect.minX), dy: (rect.midY - path.boundingRect.midY))
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
            .offsetBy(dx: (rect.minX - path.boundingRect.minX), dy: (rect.midY - path.boundingRect.midY))
//        return path.offsetBy(dx: (rect.minX - path.boundingRect.minX + rect.width) / 2, dy: (rect.midY - path.boundingRect.midY))
    }
}

struct SquiggleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 1040 - 46, y: 150 - 69))
        path.addCurve(to: CGPoint(x: 630 - 46, y: 540 - 69), control1: CGPoint(x: 1124 - 46, y: 369 - 69), control2: CGPoint(x: 897 - 46, y: 608 - 69))

        path.addCurve(to: CGPoint(x: 270 - 46, y: 530 - 69), control1: CGPoint(x: 523 - 46, y: 513 - 69), control2: CGPoint(x: 422 - 46, y: 420 - 69))

        path.addCurve(to: CGPoint(x: 50 - 46, y: 400 - 69), control1: CGPoint(x: 96 - 46, y: 656 - 69), control2: CGPoint(x: 54 - 46, y: 583 - 69))

        path.addCurve(to: CGPoint(x: 360 - 46, y: 120 - 69), control1: CGPoint(x: 46 - 46, y: 220 - 69), control2: CGPoint(x: 191 - 46, y: 97 - 69))

        path.addCurve(to: CGPoint(x: 890 - 46, y: 140 - 69), control1: CGPoint(x: 59 - 46, y: 152 - 69), control2: CGPoint(x: 619 - 46, y: 315 - 69))

        path.addCurve(to: CGPoint(x: 1040 - 46, y: 150 - 69), control1: CGPoint(x: 953 - 46, y: 100 - 69), control2: CGPoint(x: 1009 - 46, y: 69 - 69))
        
        let scale: CGFloat = rect.height / path.boundingRect.height
        
        let transform = CGAffineTransform(scaleX: scale, y: scale).rotated(by: CGFloat.pi / 2)
        
        path = path.applying(transform)
        
//        return path
//            .offsetBy(dx: (rect.minX - path.boundingRect.minX), dy: (rect.midY - path.boundingRect.midY))
        return path.offsetBy(dx: (rect.minX - path.boundingRect.minX + rect.width) / 2, dy: (rect.midY - path.boundingRect.midY))
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DiamondShape()
            SquiggleShape()
            OvalShape()
        }
        .background(Color.blue)
        .aspectRatio(contentMode: .fit)
        .padding(100)
        
    }
}
