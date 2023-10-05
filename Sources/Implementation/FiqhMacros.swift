import Foundation

#if canImport(SwiftCompilerPlugin)
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct FiqhPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DescribeMacro.self,
    ]
}
#endif
