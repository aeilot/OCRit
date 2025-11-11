//
//  ImagePasteBox.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI
internal import UniformTypeIdentifiers

struct ImagePasteBox: View {
    func loadProviders(){
        
    }
    
    @State var isPasting: Bool = false
    @State var color: Color = .secondary
    
    var body: some View {
        ZStack{
            Label("Paste or Drop Your Image Here", systemImage: "document.on.clipboard")
                .font(.title)
                .foregroundStyle(color)
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8])).cornerRadius(10)
                .foregroundColor(color)
                .padding()
                .onHover(perform: { hovering in
                    withAnimation {
                        if hovering {
                            color = .accentColor
                        } else {
                            color = .secondary
                        }
                    }
                }).onPasteCommand(of: [.image]) { providers in
                    if isPasting {
                        return
                    }
                    isPasting = true
            
                    isPasting = false
                }.onDrop(of: [.image], isTargeted: nil) { providers in
                    if isPasting {
                        return false
                    }
                    isPasting = true

                    
                    isPasting = false
                    return true
                }
        }
            
    }
}

#Preview {
    ImagePasteBox()
}
