//
//  SetGameView.swift
//  Shared
//
//  Created by Rebecca Nybo on 9/17/20.
//

import SwiftUI

struct SetGameView: View {
    let title = "Set Go"
    var body: some View {
        VStack {
            Text("\(title)")
                .font(.title)
                .padding()
            
            ZStack {
//                RoundedRectangle(cornerRadius: cardCornerRadius)
//                    .stroke(Color.blue, lineWidth: 5)
//                    .padding()
                
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .fill(Color.white)
                    .padding()
            }
            
            HStack {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.green)
                    .padding()
                    .aspectRatio(4/2, contentMode: .fit)
                
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.green)
                    .padding()
                    .aspectRatio(4/2, contentMode: .fit)
            }
            
            Spacer()
        }
        
    }
    
    // MARK: - Drawing constants

    private let cardCornerRadius: CGFloat = 10.0
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
