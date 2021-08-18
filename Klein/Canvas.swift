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
         masterLayer.bounds.random()
      let bounds =
         masterLayer.bounds
         
      return Bool.random() ?
         Ellipse(bounds: bounds, rect: randomRect) :
         Rect(bounds: bounds, rect: randomRect)
   }
   
   
   func addFigure(_ figure: FigureProtocol)
   {
      guard let layer = figure.layer as? CALayer else {return }
      
      figures.append(figure)
      
      layer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
      layer.frame = masterLayer.bounds
      masterLayer.addSublayer(layer)
   }
   
   
   func click(at point: CGPoint)
   {
      deselect()
      
      if let figure = figures.last(where: { $0.containsPoint(point)})
      , let inspector = figure.inspector as? NSView {
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
      case "inspector": return inspectorContainer
      case "layer": return masterLayer
      case "json": return json()
         
      default: return nil
      }
   }
   
   
   // MARK: -
   private lazy var inspectorContainer: NSView = {
      let wrapper =
         NSView()
      wrapper.wantsLayer = true
      wrapper.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
      
      wrapper.prepareForAutolayout()
      
      return wrapper
   }()
   
   
   private func json() -> String
   {
      "[" + figures.compactMap({ $0.json as? String}).joined(separator: ",") + "]"
   }
}
