import AppKit
import Combine


final class Rect: FigureProtocol
{
   // MARK: - Initialisation
   private var rect: CGRect // this can be omited
   private let bounds: CGRect
   
   init(bounds: CGRect, rect: CGRect)
   {
      self.bounds = bounds
      self.rect = rect
   }
   
   
   private lazy var shapeLayer: CAShapeLayer = {
      let layer =
         CAShapeLayer()
      layer.frame = bounds
      
      layer.path = CGPath(rect: rect, transform: nil)
      layer.fillColor = NSColor.red.cgColor
      layer.strokeColor = .white
      layer.lineWidth = 0
      
      return layer
   }()
   
   
   
   // MARK:  -
   func select() { shapeLayer.lineWidth = 4 }
   
   func deselect() { shapeLayer.lineWidth = 0 }
   
   
   func move(_ translation: CGPoint)
   {
      rect = rect
         .applying(
            .init(translationX: translation.x
            , y: translation.y))
      shapeLayer.path = CGPath(rect: self.rect, transform: nil)
      
      originSubject.send(rect.origin)
   }
   
   
   func layer() -> Any { shapeLayer }
   
   
   func inspector() -> Any {
      let view =
      InspectorView(figure: self)
      
      view.bindSizePublisher(sizeSubject.eraseToAnyPublisher())
      view.bindOriginPublisher(originSubject.eraseToAnyPublisher())
      view.bindColourPublisher(colorSubject.eraseToAnyPublisher())
      
      view.colorWell.target = self
      view.colorWell.action = #selector(handleChangeColour(_:))
      
      // WIP: i feel sorry for two way binding :D
      NotificationCenter.default.publisher(
         for: NSControl.textDidChangeNotification
         , object: view.widthField)
         .compactMap { $0.object as? NSTextField }
         .compactMap { $0.stringValue }
         .compactMap { [numberFormatter] in numberFormatter.number(from: $0)?.doubleValue }
         .sink {  [weak self] width in
            guard let self = self else { return }
            
            self.rect            = self.rect.withWidth(CGFloat(width))
            self.shapeLayer.path = CGPath(rect: self.rect, transform: nil)
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
            
            self.rect            = self.rect.withHeight(CGFloat(height))
            self.shapeLayer.path = CGPath(rect: self.rect, transform: nil)
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
            
            self.rect            = self.rect.withOrigin(self.rect.origin.withX(CGFloat(x)))
            self.shapeLayer.path = CGPath(rect: self.rect, transform: nil)
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
            
            self.rect            = self.rect.withOrigin(self.rect.origin.withY(CGFloat(y)))
            self.shapeLayer.path = CGPath(rect: self.rect, transform: nil)
         }
         .store(in: &subscribers)
         
      
      return view
   }
   
   
   func changeSize(_ size: CGSize)
   {
      rect             = rect.withSize(size)
      shapeLayer.frame = rect
      shapeLayer.path  = CGPath(rect: rect.withOrigin(.zero), transform: nil)
      
      sizeSubject.send(size)
   }
   
   
   func changeOrigin(_ point: CGPoint)
   {
      rect             = rect.withOrigin(point)
      shapeLayer.frame = rect
         
      originSubject.send(point)
   }
   
   
   func containsPoint(_ point: CGPoint) -> Bool
   {
      rect.contains(point)
   }
   
   
   func jsonString() -> String {
        """
      {
         "width": \(rect.width),
         "height": \(rect.height),
         "x": \(rect.origin.x),
         "y": \(rect.origin.y),
         "type": "rect"
      }
      """
   }
   
   
   @objc private func handleChangeColour(_ colorWell: NSColorWell)
   {
      shapeLayer.fillColor = colorWell.color.cgColor
   }
   

   // MARK: - Combine
   lazy var subscribers: [AnyCancellable] = []
   private lazy var numberFormatter =
      NumberFormatter()
      
   private lazy var colorSubject =
      CurrentValueSubject<NSColor, Never>(.red)
   private lazy var sizeSubject =
      CurrentValueSubject<CGSize, Never>(rect.size)
   private lazy var originSubject =
      CurrentValueSubject<CGPoint, Never>(rect.origin)
      
      
    // MARK: - Dynamic Memer Lookup
   subscript(dynamicMember member: String) -> Any?
   {
      switch member
      {
      case "inspector": return inspector()
      case "layer": return layer()
      case "json": return jsonString()
         
      default: return nil
      }
   }
}
