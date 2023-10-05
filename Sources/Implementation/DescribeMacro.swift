import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct DescribeMacro: MemberMacro {
  public enum DescribeMacroError: CustomStringConvertible, Error {
      case notCorrectType

      public var description: String {
          switch self {
          case .notCorrectType: return "@Describe can only be applied to a `class` or `struct`."
          }
      }
  }

  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {

    let identifier: TokenSyntax

    if let classDecl = declaration.as(ClassDeclSyntax.self) {
      identifier = classDecl.name
    } else if let structDecl = declaration.as(StructDeclSyntax.self) {
      identifier = structDecl.name
    } else {
      throw DescribeMacroError.notCorrectType
    }

    let memberList = declaration.memberBlock.members

    let cases = memberList.compactMap({ member -> String? in
      // is a property
      guard
        let propertyName = member.decl.as(VariableDeclSyntax.self)?.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text
      else {
        return nil
      }

      return "\(propertyName)"
    })

    let strings = cases.map { "\"\($0): \" + self.\($0) + \", \"" }
    var body = strings.joined(separator: "\n  + ")
    if let lastPlusIndex = body.lastIndex(of: "+") {
      body = String(body[..<lastPlusIndex])
    }

    let codingKeys: DeclSyntax = """

      public var description: String {
        "\(raw: identifier.text)("
        + \(raw: body)
        + ")"
      }
      
      """

    return [codingKeys]
  }
}

extension DescribeMacro: ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    [try ExtensionDeclSyntax("extension \(type): CustomStringConvertible {}")]
  }
}
