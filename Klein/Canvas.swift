import AppKit

final class Canvas: CanvasProtocol
{
   // MARK: - Intialisation
   private lazy var masterLayer: CALayer = {
      let layer =
      CALayer()
      
//      layer.isGeometryFlipped = true
    layer.isOpaque = true
    layer.backgroundColor = NSColor.purple.cgColor
      
      return layer
   }()
   
   private lazy var figures: [FigureProtocol] = []
   
   var selectedFigure: FigureProtocol?
   
   
   // MARK: -
   func ellipse(in rect: CGRect) -> FigureProtocol
   {
      Elipse(rect: rect)
   }
   
   
   func rect(_ rect: CGRect) -> FigureProtocol
   {
      Rect(rect: rect)
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
   
   
   func addFigure(_ figure: FigureProtocol)
   {
      guard let figureLayer = figure.layer() as? CALayer else {return }
      
      figures.append(figure)
      masterLayer.addSublayer(figureLayer)
      
      // WIP: add z index managing, add figure to master layer
   }
   
   
   func click(at point: CGPoint)
   {
      deselect()
      
      if let selectedFigure = figures.last(where: { $0.containsPoint(point)}) {
         selectedFigure.select()
         self.selectedFigure = selectedFigure
         
         if let insepctor = selectedFigure.inspector() as? NSView {
            inspectorWrapperView.subviews.forEach({ $0.removeFromSuperview() })
            inspectorWrapperView.addSubview(insepctor)
            insepctor.pin(inspectorWrapperView)
         }
      }
      else {
         let figure =
            randomFigure()
         
         addFigure(figure)
      }
   }
   
   func rightClick(at poin: CGPoint) {
      
   }
   
   func translate(_ translation: CGPoint)
   {
      if let selectedFigure = selectedFigure {
         selectedFigure.translate(translation)
      }
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
   
   
   func deselect()
   {
      figures.forEach({ $0.deselect() })
      selectedFigure = nil
   }
   
   // MARK: -
   func layer() -> Any {
      masterLayer
   }
   
   
    private lazy var inspectorWrapperView: NSView = {
      let wrapper =
         NSView()
      wrapper.prepareForAutolayout()
      wrapper.wantsLayer = true
      wrapper.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
      return wrapper
   }()
   
   func insepctorView() -> Any
   {
      inspectorWrapperView
   }
   
   
   func jsonString() -> String {
      ""
   }
}
