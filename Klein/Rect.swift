import AppKit


final class Rect: FigureProtocol
{
   private lazy var shapeLayer =
      CAShapeLayer()
   
   func select() {
      
   }
   
   func deselect() {
      
   }
   
   func layer() -> Any {
      shapeLayer
   }
   
   func inspector() -> Any {
      NSView()
   }
   
   func containsPoint(_ point: CGPoint) -> Bool {
      shapeLayer.contains(point)
   }
   
   func jsonString() -> String {
      """
      """
   }
}
