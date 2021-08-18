import AppKit


@dynamicMemberLookup
protocol FigureProtocol
{
   func select()
   func deselect()
   
   func containsPoint(_ point: CGPoint) -> Bool
   func move(_ translation: CGPoint)
   func changeOrigin(_ point: CGPoint)
   func changeSize(_ size: CGSize)
   
   subscript(dynamicMember member: String) -> Any? { get }
}
