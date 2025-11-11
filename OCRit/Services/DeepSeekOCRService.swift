//
//  DeepSeekOCRService.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import Foundation
import OpenAI
import AppKit

class DeepSeekOCRService {
    static let shared = DeepSeekOCRService()
    
    private init() {}
    
    func uploadImage(image: NSImage, apiKey: String) async throws -> String {
        guard let tiffData = image.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffData),
              let imageData = bitmapImage.representation(using: .png, properties: [:]) else {
            throw NSError(domain: "DeepSeekOCRService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to PNG format"])
        }
        
        let base64 = imageData.base64EncodedString()
        let payload = "<|grounding|>Convert the document to markdown."
        
#if DEBUG
        print(payload)
#endif
        
        let configuration = OpenAI.Configuration(token: apiKey, host: "api.siliconflow.cn", parsingOptions: .relaxed)
        let client = OpenAI(configuration: configuration)

        let query = ChatQuery(
            messages: [
                .user(.init(content: .contentParts(
                    [
                    .image(.init(imageUrl: .init(imageData: imageData, detail: .auto))),
                    .text(.init(text: payload))
                    ]
                )))
            ],
            model: "deepseek-ai/DeepSeek-OCR"
        )
        
        let result = try await client.chats(query: query)
        return result.choices.first?.message.content ?? "FAILURE"
    }
}
