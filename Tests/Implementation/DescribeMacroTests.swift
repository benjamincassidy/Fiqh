import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import FiqhMacros

final class DescribeMacroTests: XCTestCase {
  let testMacros: [String: Macro.Type] = [
      "Describe": DescribeMacro.self
  ]

  func testDescribeMacro() throws {
    assertMacroExpansion(
      """
      @Describe
      class Person {
        let name: String
        let age: Int
      }
      """,
      expandedSource: """
      class Person {
        let name: String
        let age: Int

        public var description: String {
          "Person("
          + "name: " + self.name + ", "
          + "age: " + self.age
          + ")"
        }
      }

      extension Person: CustomStringConvertible {
      }
      """,
      macros: testMacros,
      indentationWidth: .spaces(2)
    )
  }
}
