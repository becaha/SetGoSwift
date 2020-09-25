//
//  DiamondShape.swift
//  SetGo (iOS)
//
//  Created by Rebecca Nybo on 9/24/20.
//

import SwiftUI

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 100, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 400))
        path.addLine(to: CGPoint(x: 0, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 0))
        
        let scale: CGFloat = rect.height / path.boundingRect.height * 2

        let transform = CGAffineTransform(scaleX: scale, y: scale)

        path = path.applying(transform)

        return path
            .offsetBy(dx: (rect.minX - path.boundingRect.minX), dy: (rect.midY - path.boundingRect.midY))
    }
}
