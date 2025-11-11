//
//  OCRResultParsing.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import Foundation

struct OCREntry: Identifiable, Hashable {
    let id = UUID()
    let type: String
    let boundingBox: String
    let text: String
}


func parseOCRResults(from inputString: String) -> [OCREntry] {
    
    var entries: [OCREntry] = []
    
    let pattern = #"<\|ref\|>([^<]+)<\|/ref\|><\|det\|>\[\[(.*?)\]\]<\|/det\|>\s*(.*?)(?=<\|ref\|>|$)"#
    
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators])
        
        let range = NSRange(inputString.startIndex..., in: inputString)
        
        let matches = regex.matches(in: inputString, options: [], range: range)
        
        for match in matches {
            guard let typeRange = Range(match.range(at: 1), in: inputString),
                  let boxRange = Range(match.range(at: 2), in: inputString),
                  let textRange = Range(match.range(at: 3), in: inputString)
            else {
                continue
            }
            
            let type = String(inputString[typeRange])
            let boundingBox = String(inputString[boxRange])
            let text = String(inputString[textRange]).trimmingCharacters(in: .whitespacesAndNewlines)
            
            let entry = OCREntry(type: type, boundingBox: boundingBox, text: text)
            entries.append(entry)
        }
        
    } catch {
        print("Error: \(error)")
    }
    
    return entries
}

func convertEntriesToMarkdown(entries: [OCREntry]) -> String {
    var markdownComponents: [String] = []
    
    for entry in entries {
        guard !entry.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            continue
        }
        
        switch entry.type {
        case "image":
            continue
            
        case "equation":
            markdownComponents.append("$$\(entry.text)$$")
            
        default:
            markdownComponents.append(entry.text)
        }
    }
    
    return markdownComponents.joined(separator: "\n\n")
}
