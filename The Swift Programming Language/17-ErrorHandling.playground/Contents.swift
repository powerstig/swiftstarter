import Cocoa

//: # Error Handling
//: Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime (NOTE: recoverable).
//:
//: ## Representing and Throwing Errors
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// throw VendingMachineError.InsufficientFunds(required: 5)

//: ## Handling Errors
//: ### Propagating Errors using Throwing Functions
// 明确一个函数或者方法可以抛出错误，你要在它的声明当中的形式参数后边写上 throws关键字。
func canThrowErrors() throws -> String { return "" }
func cannotThrowErrors() -> String { return "" }

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}


let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
//: Note that vend() must be marked with the try keyword. Also because the errors are not handled here the error is propagated up to buyFavoriteSnack() as noted by the throws keyword.

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//: ## Handling Errors Using Do-Catch
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    // Enjoy delicious snack
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.outOfStock {
    print("Out of Stock")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional $\(coinsNeeded).")
}
// catch分句没有处理 do分句可能抛出的所有错误。如果没有 catch分句能处理这个错误，那错误就会传递到周围的生效范围当中。总之，错误必须得在周围某个范围内得到处理。
//在不抛出错误的函数中， do-catch 分句就必须处理错误。在可抛出函数中，要么 do-catch 分句处理错误，要么调用者处理。如果错误被传递到了顶层生效范围但还是没有被处理，你就会得到一个运行时错误了。


func nourish(with item: String) throws {
  do {
    try vendingMachine.vend(itemNamed: item)
  } catch is VendingMachineError {
    print("Invalid selection, out of stock, or not enough money.")
  } //在 nourish(with:) 函数中，如果 vend(itemNamed:) 抛出 VendingMachineError 枚举中的某一错误， nourish(with:) 就会打印一个消息以处理错误。
}

do {
  try nourish(with: "Beet-Flavored Chips")
} catch {
  print("Unexpected non-vending-machine-related error: \(error)")
  //任何非 VendingMachineError 的错误就会被调用函数捕捉：
}
// Prints "Invalid selection, out of stock, or not enough money."



//: ## Converting Errors to Optional Values
// 转换错误为可选项
//: If an error is thrown while evaluating the try? expression, the value of the expression is nil
enum UnluckyError: Error { case unlucky }
func someThrowingFunction() throws -> Int {
    let success = arc4random_uniform(5)
    if success == 0 { throw UnluckyError.unlucky }
    return Int(success)
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//: Try? lets you write concise error handling code when you want to handle all errors the same way.

struct Data { }
func fetchDataFromDisk() throws -> Data {
    let success = arc4random_uniform(5)
    if success == 0 { throw UnluckyError.unlucky }
    return Data()
}
func fetchDataFromServer() throws -> Data {
    let success = arc4random_uniform(5)
    if success == 0 { throw UnluckyError.unlucky }
    return Data()
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
fetchData()


//: ## Disabling Error Propagation
//: Calling a throwing function or method with try! disables error propagation and wraps the call in a run-time assertion that no error will be thrown. If an error actually is thrown, you'll get a runtime error.

//let photo = try! loadImage("./Resources/John Appleseed.jpg")


//: ## Specifying Clean-Up Actions
//: A defer statement defers execution until the current scope is exited.
//: Deferred statements may not contain any code that would transfer control out of the statements, such as a break or return statement, or by throwing an error.
//: Deferred actions are executed in reverse order of how they are specified.

enum FileError: Error {
    case endOfFile
    case fileClosed
}

func exists(_ filename: String) -> Bool { return true }
class FakeFile {
    var isOpen = false
    var filename = ""
    var lines = 100
    func readline() throws -> String? {
        if self.isOpen {
            if lines > 0 {
                lines -= 1
                return "line number \(lines) of text\n"
            } else {
                throw FileError.endOfFile
                //return nil
            }
        } else {
            throw FileError.fileClosed
        }
    }
}

func open(fileNamed: String) -> FakeFile {
    let file = FakeFile()
    file.filename = fileNamed
    file.isOpen = true
    print("\(file.filename) has been opened")
    return file
}

func close(file: FakeFile) {
    file.isOpen = false
    print("\(file.filename) has been closed")
}

func processFile(named: String) throws {
    if exists(named) {
        let file = open(fileNamed: named)
        defer {
            close(file: file)
        } // defer语句延迟执行直到当前范围退出。
        while let line = try file.readline() {
            // Work with the file
            print(line)
        }
        // close(file) is called here, at the end of the scope.
    }
}

do {
    try processFile(named: "myFakeFile")
} catch FileError.endOfFile {
    print("Reached the end of the file")
} catch FileError.fileClosed {
    print("The file isn't open")
}






