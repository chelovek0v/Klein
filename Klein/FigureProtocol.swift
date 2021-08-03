import AppKit

//@dynamicMemberLookup
protocol FigureProtocol
{
   func select()
   func deselect()
   
   func layer() -> Any
   func inspector() -> Any
   
   func containsPoint(_ point: CGPoint) -> Bool
   func translate(_ translation: CGPoint)
   func changeOrigin(_ point: CGPoint)
   func changeSize(_ size: CGSize)
   
   func jsonString() -> String
   
//   subscript(dynamicMember member: String) -> Any? { get }
}
