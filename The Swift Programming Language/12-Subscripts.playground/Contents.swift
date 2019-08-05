// 下标 Subscripts
// 可以为一个类型定义多个下标，并且下标会基于传入的索引值的类型选择合适的下标重载使用。
// 下标脚本允许你通过在实例名后面的方括号内写一个或多个值对该类的实例进行查询。

// 使用关键字 subscript 来定义下标，并且指定一个或多个输入形式参数和返回类型，与实例方法一样。
/*
subscript(index: Int) -> Int {
  get {
    // return an appropriate subscript value here
  }
  set(newValue) {
    // perform a suitable setting action here
  }
}
 */

// 可以给只读下标省略 get 关键字
/*
subscript(index: Int) -> Int {
  // return an appropriate subscript value here
}
 */


struct TimesTable {
  let multiplier: Int
  
  subscript(index: Int) -> Int {
    return multiplier * index
  } //下标脚本
  
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

// Subscript Usage
// 通常下标是用来访问集合、列表或序列中元素的快捷方式。
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

// 下标选项 Subscript Options
// 类或结构体可以根据自身需要提供多个下标实现，合适被使用的下标会基于值类型或者使用下标时下标方括号里包含的值来推断。
// 这个对多下标的定义就是所谓的下标重载。
struct Matrix {
  let rows: Int, columns: Int
  var grid: [Double]
  
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array(repeating: 0.0, count: rows * columns)
    //创建了一个足够容纳 rows * columns 个数的 Double 类型数组。
  }
  
  func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  } // 检查下标的 row 和 column 是否有效。
  
  subscript(row: Int, column: Int) -> Double {
    get {
      // 断言来检查下标的 row 和 column 是否有效。
      assert(indexIsValid(row: row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set {
      // 断言
      assert(indexIsValid(row: row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
  }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
matrix

//let someValue = matrix[2, 2]
// 断言在下标越界时触发 Assertion triggered due to out of range access

// 类型下标 - Swift 5.1

//enum Planet: Int {
//  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
//  static subscript(n: Int) -> Planet {
//    return Planet(rawValue: n)!
//  }
//}
//let mars = Planet[4]
//print(mars)

/*
public enum OldSettings {
  private static var values = [String: String]()
  
  static func get(_ name: String) -> String? {
    return values[name]
  }
  
  static func set(_ name: String, to newValue: String?) {
    print("\(name) to \(newValue ?? "nil" )")
    values[name] = newValue
  }
    
}

public enum NewSettings {
  private static var values = [String: String]()
  
  public static subscript(_ name:String) -> String?{
    get {
      return values[name]
    }
    
    set {
      print("\(name) to \(newValue ?? "nil" )")
      values[name] = newValue
    }
  }
}
 */







