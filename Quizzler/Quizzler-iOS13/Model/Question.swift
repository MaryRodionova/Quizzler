import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: String

    init(
        q: String,
        a: [String],
        correctAnswer: String
    ) {
        self.text = q
        self.answers = a
        self.correctAnswer = correctAnswer
    }
}
