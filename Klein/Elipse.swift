import AppKit
import Combine


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
      originSubject.send(rect.origin)
   }
   
   func layer() -> Any {
      shapeLayer
   }
   
   func inspector() -> Any {
      let view =
      InspectorView(figure: self)
      
      view.bindSizePublisher(sizeSubject.eraseToAnyPublisher())
      view.bindOriginPublisher(originSubject.eraseToAnyPublisher())
      
      
      NotificationCenter.default.publisher(
         for: NSControl.textDidChangeNotification
         , object: view.widthField)
         .compactMap { $0.object as? NSTextField }
         .compactMap { $0.stringValue }
         .compactMap { [numberFormatter] in numberFormatter.number(from: $0)?.doubleValue }
         .sink {  [weak self] width in
            guard let self = self else { return }
            
            self.rect = self.rect.withWidth(CGFloat(width))
            self.shapeLayer.frame = self.rect
            self.shapeLayer.path = CGPath(ellipseIn: self.rect.withOrigin(.zero), transform: nil)
         }
         .store(in: &subscribers)
         
      NotificationCenter.default.publisher(
         for: NSControl.textDidChangeNotification
         , object: view.heightField)
         .compactMap { $0.object as? NSTextField }
         .compactMap { $0.stringValue }
         .compactMap { [numberFormatter] in numberFormatter.number(from: $0)?.doubleValue }
         .sink {  [weak self] height in
            guard let self = self else { return }
            
            self.rect = self.rect.withHeight(CGFloat(height))
            self.shapeLayer.frame = self.rect
            self.shapeLayer.path = CGPath(ellipseIn: self.rect.withOrigin(.zero), transform: nil)
         }
         .store(in: &subscribers)
         
         
         NotificationCenter.default.publisher(
         for: NSControl.textDidChangeNotification
         , object: view.xField)
         .compactMap { $0.object as? NSTextField }
         .compactMap { $0.stringValue }
         .compactMap { [numberFormatter] in numberFormatter.number(from: $0)?.doubleValue }
         .sink {  [weak self] x in
            guard let self = self else { return }
            
            self.rect = self.rect.withOrigin(self.rect.origin.withX(CGFloat(x)))
            self.shapeLayer.frame = self.rect
         }
         .store(in: &subscribers)
         
      NotificationCenter.default.publisher(
         for: NSControl.textDidChangeNotification
         , object: view.yField)
         .compactMap { $0.object as? NSTextField }
         .compactMap { $0.stringValue }
         .compactMap { [numberFormatter] in numberFormatter.number(from: $0)?.doubleValue }
         .sink {  [weak self] y in
            guard let self = self else { return }
            
            self.rect = self.rect.withOrigin(self.rect.origin.withY(CGFloat(y)))
            self.shapeLayer.frame = self.rect
         }
         .store(in: &subscribers)
         
      
      return view
   }
   
   func changeSize(_ size: CGSize)
   {
      rect = rect.withSize(size)
      shapeLayer.frame = rect
      shapeLayer.path = CGPath(ellipseIn: rect.withOrigin(.zero), transform: nil)
      
      sizeSubject.send(size)
   }
   
   func changeOrigin(_ point: CGPoint) {
       rect =
         rect.withOrigin(point)
      shapeLayer.frame =
         rect
         
      originSubject.send(point)
   }
   
   func containsPoint(_ point: CGPoint) -> Bool {
      rect.contains(point)
   }
   
   func jsonString() -> String {
      """
      """
   }
   
   lazy var subscribers: [AnyCancellable] = []
   private lazy var numberFormatter =
      NumberFormatter()
   private lazy var sizeSubject =
      CurrentValueSubject<CGSize, Never>(rect.size)
   private lazy var originSubject =
      CurrentValueSubject<CGPoint, Never>(rect.origin)
}
