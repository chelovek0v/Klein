import AppKit


final class Rect: FigureProtocol
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
      
      layer.path = CGPath(rect: rect.withOrigin(.zero), transform: nil)
      layer.fillColor = NSColor.red.cgColor
      layer.strokeColor = .white
      layer.lineWidth = 0
      
      return layer
   }()
   
   
   // MARK: -
   func select() {
      shapeLayer.lineWidth = 4
   }
   
   func deselect() {
      shapeLayer.lineWidth = 0
   }
   
   func layer() -> Any {
      shapeLayer
   }
   
   func inspector() -> Any {
      NSView()
   }
   
   func containsPoint(_ point: CGPoint) -> Bool {
//      shapeLayer.contains(point)
      rect.contains(point)
   }
   
   func jsonString() -> String {
      """
      """
   }
}
