import AppKit



final class Elipse: FigureProtocol
{
   // MARK: - Initialisation
   private var rect: CGRect
   
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
      layer.strokeColor = .white
      layer.lineWidth = 0
      
      return layer
   }()
   
   
   
   // MARK:  -
   func select() {
      shapeLayer.lineWidth = 4
   }
   
   func deselect() {
      shapeLayer.lineWidth = 0
   }
   
   
   func translate(_ translation: CGPoint)
   {
      rect = rect
         .applying(
            .init(translationX: translation.x
            , y: translation.y))
      shapeLayer.frame = rect
   }
   
   func layer() -> Any {
      shapeLayer
   }
   
   func inspector() -> Any {
      NSView()
   }
   
   func containsPoint(_ point: CGPoint) -> Bool {
      rect.contains(point)
   }
   
   func jsonString() -> String {
      """
      """
   }
}
