import AppKit

protocol FigureProtocol
{
   func select()
   func deselect()
   
   func layer() -> Any
   func inspector() -> Any
   
   func containsPoint(_ point: CGPoint) -> Bool
   
   func translate(_ translation: CGPoint)
   
   func jsonString() -> String
   
   //func draw(in context: Contex)
}
