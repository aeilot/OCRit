//
//  ContentView.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("ai_api_key") var aiAPIKey: String = ""
    @AppStorage("api_key_set") var apiKeyUnset: Bool = true
    
    var body: some View {
        VStack {
            Text("OCR it!")
                .font(.system(size: 42))
                .fontDesign(.rounded)
                .bold()
            ImagePasteBox()
        }
        .padding().frame(width: 500, height: 400)
        .sheet(isPresented: $apiKeyUnset) {
            VStack{
                Text("Set your API Key for Silicon Flow Here").font(.title)
                TextField("API Key", text: $aiAPIKey)
                Text("Get your key at https://siliconflow.cn/").font(.footnote).foregroundStyle(.secondary)
            }.padding()
        }.onAppear {
            if aiAPIKey.isEmpty {
                apiKeyUnset = true
            }
        }
    }
}

#Preview {
    ContentView()
}
