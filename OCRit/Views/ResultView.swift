//
//  ResultView.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI
import MarkdownUI

struct ResultView: View {
    var showText: String = "# Hello"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack{
                Text("Results")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button("Copy") {
                    copyToPasteboard(text: showText)
                }
                .buttonStyle(.bordered)
            }
            ScrollView {
                Markdown(showText)
                    .font(.body)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)                    .padding(5)
            }.background(Color.secondary.opacity(0.05))
            .cornerRadius(8)
        }
        .padding()
        .frame(minWidth: 250, maxWidth: 400, minHeight: 100, maxHeight: 300)
    }
    
    private func copyToPasteboard(text: String) {
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(text, forType: .string)
    }
}

#Preview {
    ResultView(showText: "# Hello World\n Hello, my name is **hello**.")
}
