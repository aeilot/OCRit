//
//  SMSMService.swift
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
              let imageData = bitmapImage.representation(using: .png, properties: [:]),
              let imageStringData = String(data: imageData, encoding: .utf8) else {
            throw NSError(domain: "DeepSeekOCRService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to PNG format"])
        }
        
        let configuration = OpenAI.Configuration(token: apiKey, host: "api.siliconflow.cn", parsingOptions: .relaxed)
        let client = OpenAI(configuration: configuration)

        let suffix = "\n<|grounding|>Convert the document to markdown."
        let query = ChatQuery(
            messages: [
                 .user(.init(content: .string(imageStringData + suffix)))],
            model: "deepseek-ai/DeepSeek-OCR")
        
        let result = try await client.chats(query: query)
        
        return result.choices.first?.message.content ?? "FAILURE"
    }
}
