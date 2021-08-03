import AppKit



final class Elipse: FigureProtocol
{
   // MARK: - Initialisation
   private let rect: CGRect
   
   init(rect: CGRect)
   {
      self.rect = rect
   }
   
   
   private lazy var shapeLayer: CAShapeLayer = {
      let layer =
         CAShapeLayer()
      layer.frame = rect
      
      layer.path = CGPath(ellipseIn: rect.withOrigin(.zero), transform: nil)
      layer.fillColor = NSColor.blue.cgColor
      
      return layer
   }()
   
   
   
   // MARK:  -
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
