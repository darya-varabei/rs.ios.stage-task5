import UIKit

class MessageDecryptor: NSObject {
    
    let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    func decryptMessage(_ message: String) -> String {
        
        var countReps: [String] = []
        var wordArray: [String] = []
        var decodedMsg = ""
        var iterator = ""
        
        for item in message {
            
            var tmp = item
            if numbers.contains(item){
                tmp = "a"
            }
            if item.isLetter{
                tmp = "b"
            }
            switch tmp{
            case "a":
                iterator = "\(iterator)\(item)"
            break
            case "[":
                if iterator.isEmpty {
                    countReps.append("1")
                } else {
                    countReps.append(iterator)
                }
                wordArray.append(decodedMsg)
                decodedMsg.removeAll()
                iterator.removeAll()
            break
            case "]":
                var buffer = ""
                if let counts = Int(countReps.popLast() ?? "1") {
                    for _ in 0..<counts {
                        buffer += decodedMsg
                    }
                }
                decodedMsg = wordArray.popLast()! + buffer
            break
            case "b":
                decodedMsg += String(item)
            break
            default:
                break
            }
        }
        return decodedMsg
    }
}
