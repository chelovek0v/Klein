import AppKit

@dynamicMemberLookup
protocol CanvasProtocol
{
   func randomFigure() -> FigureProtocol
   func figureFromJSON(_ string: [String: Any]) -> FigureProtocol?
   
   func addFigure(_ figure: FigureProtocol)
   
   func click(at point: CGPoint)
   func deselect()
   func moveSelected(_ translation: CGPoint)
   
   subscript(dynamicMember member: String) -> Any? { get }
}
