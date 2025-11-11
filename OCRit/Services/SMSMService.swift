//
//  SMSMService.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import Foundation
import AppKit

struct SMSMUploadResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: SMSMImageData?
    let RequestId: String?
    
    struct SMSMImageData: Codable {
        let file_id: Int?
        let width: Int
        let height: Int
        let filename: String
        let storename: String
        let size: Int
        let path: String
        let hash: String
        let url: String
        let delete: String
        let page: String
    }
}

class SMSMService {
    static let shared = SMSMService()
    
    private let apiURL = "https://sm.ms/api/v2/upload"
    
    private init() {}
    
    func uploadImage(image: NSImage, apiKey: String? = nil) async throws -> String {
        guard let tiffData = image.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffData),
              let imageData = bitmapImage.representation(using: .png, properties: [:]) else {
            throw NSError(domain: "SMSMService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to PNG format"])
        }
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if let apiKey = apiKey {
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        }
        
        var body = Data()
        
        // Add image file
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"smfile\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "SMSMService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NSError(domain: "SMSMService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Upload failed with status code \(httpResponse.statusCode)"])
        }
        
        let uploadResponse = try JSONDecoder().decode(SMSMUploadResponse.self, from: data)
        
        guard uploadResponse.success, let imageUrl = uploadResponse.data?.url else {
            throw NSError(domain: "SMSMService", code: -1, userInfo: [NSLocalizedDescriptionKey: uploadResponse.message])
        }
        
        return imageUrl
    }
}
