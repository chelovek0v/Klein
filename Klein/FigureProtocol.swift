import AppKit



protocol FigureProtocol
{
   func select()
   func deselect()
   
   func layer() -> Any
   func inspector() -> Any
   
   func containsPoint(_ point: CGPoint) -> Bool
   func move(_ translation: CGPoint)
   func changeOrigin(_ point: CGPoint)
   func changeSize(_ size: CGSize)
   
   func jsonString() -> String
}
