//
//  SettingsView.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI
import ServiceManagement

struct SettingsView: View {
    @AppStorage("startOnStartup") private var startOnStartup: Bool = false
    @AppStorage("ai_api_key") var aiAPIKey: String = ""
    @AppStorage("api_key_set") var apiKeyUnset: Bool = true
    
    var body: some View {
        List{
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Toggle("Launch at login", isOn: $startOnStartup)
                    Text("""
                    Run OCRit app in the background automatically \
                    when you log in on your Mac.
                    """)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }.onChange(of: startOnStartup) { newValue in
                if newValue{
                    try? SMAppService.mainApp.register()
                } else {
                    try? SMAppService.mainApp.unregister()
                }
            }.onAppear{
                startOnStartup = (SMAppService.mainApp.status == .enabled)
            }
            Section{
                VStack(alignment: .leading){
                    SecureField("Silicon Flow API Key", text: $aiAPIKey).textFieldStyle(.roundedBorder).textContentType(.password).onSubmit {
                        if !aiAPIKey.isEmpty {
                            apiKeyUnset = false
                        }
                    }
                    Text("Get your key at https://siliconflow.cn/").font(.footnote).foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .frame(width: 500, height: 300)
    }
}

#Preview {
    SettingsView()
}
