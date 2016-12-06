//
//  main.swift
//  typoglycemia
//
//  Created by Chris Larsen on 2016-12-05.
//  Copyright © 2016 Larsen Tech. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension String {
    func typoglycemize() -> String {
        let punctuations = [".", ",", "?"]
        let words = self.components(separatedBy: " ")
        var outputString = ""
        
        for word in words {
            var newWord = ""
            if word.characters.count > 2 {
                var letters = Array(word.characters)
                var punctuation: String.CharacterView._Element?
                if punctuations.contains(letters.last!.description) {
                    punctuation = letters.popLast()
                }
                
                let first = letters.remove(at: 0)
                let last = letters.popLast()
                letters.shuffle()
                letters.insert(first, at: 0)
                letters.append(last!)
                if let punc = punctuation {
                    letters.append(punc)
                }
                
                for letter in letters {
                    newWord.append(letter)
                }
            } else {
                newWord = word
            }
            outputString.append(newWord + " ")
        }
        
        return outputString
    }
}

var string = "According to a research team at Cambridge University, it doesn't matter in what order the letters in a word are, the only important thing is that the first and last letter be in the right place. The rest can be a total mess and you can still read it without a problem. This is because the human mind does not read every letter by itself, but the word as a whole. Such a condition is appropriately called Typoglycemia."

print(string.typoglycemize())
