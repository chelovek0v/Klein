import AppKit

protocol FigureProtocol
{
   func select()
   func deselect()
   
   func layer() -> Any
   func inspector() -> Any
   
   func containsPoint(_ point: CGPoint) -> Bool
   
   func jsonString() -> String
   
   //func draw(in context: Contex)
}
