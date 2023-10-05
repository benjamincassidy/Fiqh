@attached(member, names: arbitrary)
@attached(extension, conformances: CustomStringConvertible)
public macro Describe() = #externalMacro(module: "FiqhMacros", type: "DescribeMacro")
