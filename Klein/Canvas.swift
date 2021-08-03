import AppKit

final class Canvas: CanvasProtocol
{
   // MARK: - Intialisation
   private lazy var masterLayer = CALayer()
   private lazy var figures: [FigureProtocol] = []
   
   var selectedFigure: FigureProtocol?
   
   
   // MARK: -
   func ellipse(in rect: CGRect) -> FigureProtocol
   {
      Elipse()
   }
   
   
   func rect(_ rect: CGRect) -> FigureProtocol
   {
      Rect()
   }
   
   func randomFigure() -> FigureProtocol
   {
      let randomRect =
      randomRect(inside: masterLayer.bounds)
      return Bool.random() ?
         ellipse(in: randomRect) :
         rect(randomRect)
   }
   
   func randomRect(inside bounds: CGRect) -> CGRect
   {
      CGRect(origin: .zero, size: .zero)
   }
   
   func addFigure(_ figure: FigureProtocol) {
      figures.append(figure)
      // WIP: add z index managing, add figure to master layer
   }
   
   
   
   func select(at point: CGPoint) {
      // WIP: find the nearest figure, select it, udpate selectedFigure
   }
   
   func selectFarthest(at point: CGPoint) {
      // WIP: find the farthest figure, select it, udpate selectedFigure
   }
   
   func selectPrecisely(at point: CGPoint) {
      // WIP: show a menu
      // REFACTOR: selectPrecisely should return a menu(Any)
   }
   
   func deselect() {
      // WIP: deselect all figures and nil selectedFigure
   }
   
   func layer() -> Any {
      masterLayer
   }
   
   
   func jsonString() -> String {
      ""
   }
}
