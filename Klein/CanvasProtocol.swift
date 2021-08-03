import AppKit

protocol CanvasProtocol
{
   func ellipse(in rect: CGRect) -> FigureProtocol
   func rect(_ rect: CGRect) -> FigureProtocol
   func randomFigure() -> FigureProtocol
   
   func addFigure(_ figure: FigureProtocol)
   
   var selectedFigure: FigureProtocol? { get }
   
   func click(at point: CGPoint)
   func rightClick(at poin: CGPoint)
   func select(at point: CGPoint)
   func selectFarthest(at point: CGPoint)
   func selectPrecisely(at point: CGPoint)
   func deselect()
   
   func layer() -> Any
   
   
   
   func jsonString() -> String
   
   //func draw(in context: Contex)
}
