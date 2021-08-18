import AppKit


final class CanvasViewController: NSViewController
{
   // MARK: - Initialisation
   init(canvas: CanvasProtocol)
   {
      super.init(nibName: nil, bundle: nil)
      
      self.customView = CanvasView(canvas: canvas)
   }
   
   
   required init?(coder: NSCoder) { fatalError() }
   
   private var customView: CanvasView!
   
   
   
   // MARK: - Overrides
   override func loadView()
   {
      view = customView
   }
}

