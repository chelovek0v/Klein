import AppKit

final class Canvas: CanvasProtocol
{
   // MARK: - Intialisation
   private lazy var masterLayer: CALayer = {
      let layer =
         CALayer()
      
      layer.isOpaque = true
      layer.backgroundColor = NSColor.purple.cgColor
      
      return layer
   }()
   
   private lazy var figures: [FigureProtocol] = []
   
   private var selectedFigure: FigureProtocol?
   
   
   
   // MARK: -
   func figureFromJSON(_ json: [String: Any]) -> FigureProtocol?
   {
      if json["type"] as? String == "rect" {
         return Rect(
            bounds: masterLayer.bounds
            , rect: .init(x: json["x"] as! CGFloat
                          , y: json["y"] as! CGFloat
                          , width: json["width"] as! CGFloat
                          , height: json["height"] as! CGFloat))
      }
      else {
         return Ellipse(
            bounds: masterLayer.bounds
            , rect: .init(x: json["x"] as! CGFloat
                          , y: json["y"] as! CGFloat
                          , width: json["width"] as! CGFloat
                          , height: json["height"] as! CGFloat))
      }
   }
   
   
   func ellipse(in rect: CGRect) -> FigureProtocol
   {
      Ellipse(bounds: masterLayer.bounds, rect: rect)
   }
   
   
   func rect(_ rect: CGRect) -> FigureProtocol
   {
      Rect(bounds: masterLayer.bounds, rect: rect)
   }
   
   
   func randomFigure() -> FigureProtocol
   {
      let randomRect =
         randomRect(inside: masterLayer.bounds)
      return Bool.random() ?
         ellipse(in: randomRect) :
         rect(randomRect)
   }
   
   
   func addFigure(_ figure: FigureProtocol)
   {
      guard let figureLayer = figure.layer() as? CALayer else {return }
      
      figures.append(figure)
      
      figureLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
      figureLayer.frame = masterLayer.bounds
      masterLayer.addSublayer(figureLayer)
   }
   
   
   func click(at point: CGPoint)
   {
      deselect()
      
      if let selectedFigure = figures.last(where: { $0.containsPoint(point)})
      , let inspector = selectedFigure.inspector() as? NSView {
         selectedFigure.select()
         self.selectedFigure = selectedFigure
         
         inspectorWrapperView.subviews.forEach({ $0.removeFromSuperview() })
         inspectorWrapperView.addSubview(inspector)
         inspector.pin(inspectorWrapperView)
      }
      else {
         addFigure(randomFigure())
      }
   }
   
   func translate(_ translation: CGPoint)
   {
      if let selectedFigure = selectedFigure {
         selectedFigure.translate(translation)
      }
   }
   

   func deselect()
   {
      inspectorWrapperView.subviews.forEach({ $0.removeFromSuperview() })
      figures.forEach({ $0.deselect() })
      selectedFigure = nil
   }
   
   
   
   // MARK: -
   func layer() -> Any { masterLayer }
   
   func insepctorView() -> Any { inspectorWrapperView }
   
   private lazy var inspectorWrapperView: NSView = {
      let wrapper =
         NSView()
      wrapper.prepareForAutolayout()
      wrapper.wantsLayer = true
      wrapper.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
      return wrapper
   }()
   
   
   func jsonString() -> String
   {
      "[" + figures.map({ $0.jsonString()}).joined(separator: ",") + "]"
   }
   
   
   func randomRect(inside bounds: CGRect) -> CGRect
   {
      // WIP: add extension to rect or size
      let randomPoint: CGPoint = {
         let inset =
            masterLayer.bounds.insetBy(dx: 150, dy: 150)
         let x =
            CGFloat.random(in: inset.minX...inset.maxX)
         let y =
            CGFloat.random(in: inset.minY...inset.maxY)
         let point =
            CGPoint(x: x, y: y)
         
         print(point)
         
         return point
      }()
      
      return CGRect(origin: randomPoint, size: .init(width: 100, height: 100))
   }
}
