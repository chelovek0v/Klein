import AppKit

protocol CanvasProtocol
{
   func ellipse(in rect: CGRect) -> FigureProtocol
   func rect(_ rect: CGRect) -> FigureProtocol
   func randomFigure() -> FigureProtocol
   
   func addFigure(_ figure: FigureProtocol)
   
   func click(at point: CGPoint)
   func deselect()
   
   func translate(_ translation: CGPoint)
   
   func layer() -> Any
   func insepctorView() -> Any
   
   func figureFromJSON(_ string: [String: Any]) -> FigureProtocol?
   
   func jsonString() -> String
}
