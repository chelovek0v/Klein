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

   
   func randomFigure() -> FigureProtocol
   {
      let randomRect =
         randomRect(inside: masterLayer.bounds)
      let bounds =
         masterLayer.bounds
         
      return Bool.random() ?
         Ellipse(bounds: bounds, rect: randomRect) :
         Rect(bounds: bounds, rect: randomRect)
   }
   
   
   func addFigure(_ figure: FigureProtocol)
   {
      guard let layer = figure.layer() as? CALayer else {return }
      
      figures.append(figure)
      
      layer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
      layer.frame = masterLayer.bounds
      masterLayer.addSublayer(layer)
   }
   
   
   func click(at point: CGPoint)
   {
      deselect()
      
      if let figure = figures.last(where: { $0.containsPoint(point)})
      , let inspector = figure.inspector() as? NSView {
         figure.select()
         self.selectedFigure = figure
         
         inspectorContainer.subviews.forEach({ $0.removeFromSuperview() })
         inspectorContainer.addSubview(inspector)
         inspector.pin(inspectorContainer)
      }
      else {
         addFigure(randomFigure())
      }
   }
   
   func moveSelected(_ translation: CGPoint)
   {
      if let selectedFigure = selectedFigure {
         selectedFigure.move(translation)
      }
   }
   

   func deselect()
   {
      inspectorContainer.subviews.forEach({ $0.removeFromSuperview() })
      figures.forEach({ $0.deselect() })
      selectedFigure = nil
   }
   
   
   // MARK: - Dynamic Memer Lookup
   subscript(dynamicMember member: String) -> Any?
   {
      switch member
      {
      case "inspectorView": return insepctorView()
      case "layer": return masterLayer
      case "json": return jsonString()
         
      default: return nil
      }
   }
   
   
   // MARK: -
   func layer() -> Any { masterLayer }
   
   func insepctorView() -> Any { inspectorContainer }
   
   private lazy var inspectorContainer: NSView = {
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
