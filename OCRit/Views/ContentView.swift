//
//  ContentView.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("OCR it!")
                .font(.system(size: 42))
                .fontDesign(.rounded)
                .bold()
            ImagePasteBox()
        }
        .padding().frame(width: 500, height: 400)
    }
}

#Preview {
    ContentView()
}
