// Nested Types

struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    } //Suit 枚举用于描述扑克牌的四种花色，并用原始值 Character 来代表各自的花色。
    
    // nestedRank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
      
        struct Values {
            let first: Int, second: Int?
        } //内嵌结构体 Values
      
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    } //Rank 枚举用于描述扑克牌可能出现的十三种点数，并用原始值 Int 来代表各自的点数值（这里的 Int 并不会用于 J、Q、K、Ace 的表示）。
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")


// Referring to Nested Types
// 要在定义外部使用内嵌类型，只需在其前缀加上内嵌了它的类的类型名即可
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print("heartsSymbol is \(heartsSymbol)")

let ace = BlackjackCard.Rank.Values(first: 1, second: 11)
print(ace)
