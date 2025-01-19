//
//  BoundInAnmation.swift
//  MyToDo
//
//  Created by Girish Parate on 18/01/25.
//

import SwiftUI

struct BoundInAnmation<Content: View>: View {
    
    @State private var scale = 0.0
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack {
            content
        }
        .scaleEffect(scale)
        .onAppear {
            withAnimation(.linear, {
                scale = 1.0
            })
        }
    }
}

#Preview {
    BoundInAnmation(content: {
        Text("Your View")
    })
}
