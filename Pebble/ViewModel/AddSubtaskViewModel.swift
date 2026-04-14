//
//  Untitled.swift
//  Pebble
//
//  Created by Deny Wahyudi Asaloei  on 09/04/26.
//
import SwiftUI
import SwiftData
import FoundationModels

@Observable
class AddSubtaskViewModel {
    var subtaskName = ""
    
    //Cek jika form sudah terisi atau belum
    var isChanged: Bool{
        subtaskName != ""
    }
    
    //if isChange True show discard alert/action sheet
    var isShowingDiscardAlert:Bool = false
    var aiPlaceholder: String = "..."
    
    
    func createSubtask() -> SubtaskModel {
        SubtaskModel(subtaskName: subtaskName)
    }
    
    // MARK: - Foundation Models
    func loadAIQuestions(taskName: String, taskDesc: String?, taskCategory: String?, existingSubtasks: [String]
    ) async {
        // 1) Instructions (Indonesia)
        let instructions = """
        Help the user break down a task into ONE actionable guiding question.
        
        The question must lead ONLY to real executable actions such as:
        reading, researching, writing, listing, comparing, collecting data, outlining, or summarizing.
        
        STRICT RULES:
        - Do NOT mention theoretical concepts (e.g. machine learning, NLP, neural networks).
        - Do NOT give conceptual examples.
        - Examples in parentheses MUST be concrete work steps (subtasks), not topics.
        - Always convert ideas into actions.
        
        The output must be exactly ONE question in a single line.
        
        Include one example subtask in parentheses.
        
        EXAMPLE OUTPUT:
        What sources should you read to understand the topic of AI? (e.g. read 3 beginner articles about AI history and applications)
        """
        
        // 2) Session
        let session = LanguageModelSession(instructions: instructions)
        
        // 3) Prompt dengan variabel dari task
        let previous = existingSubtasks.isEmpty
            ? "None"
            : existingSubtasks.enumerated()
                .map { "\($0 + 1). \($1)" }
                .joined(separator: "\n")

        let prompt = """
        Task: \(taskName)
        Description: \(taskDesc ?? "-")
        Category: \(taskCategory ?? "-")

        Already created subtasks:
        \(previous)

        Generate exactly ONE next guiding question.

        Rules:
        - Do NOT repeat ideas already covered in existing subtasks.
        - Continue the workflow logically from previous steps.
        - Move forward in sequence (research → outline → write → analyze).
        - Focus only on the NEXT missing step.
        """
        
        do {
            let response = try await session.respond(to: prompt)
            // Bersihkan output jika perlu
            let trimmed = response.content
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: "\n\n", with: "\n")
            self.aiPlaceholder = trimmed.isEmpty ? "..." : trimmed
        } catch {
            // Fallback jika gagal
            self.aiPlaceholder = """
            What is the main goal of the first subtask? (e.g. literature review)
            """
        }
    }
}
