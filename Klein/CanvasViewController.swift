import AppKit


final class CanvasViewController: NSViewController
{
  // MARK: - Initialisation
  
  // WIP: move to ctor
  private var customView: CanvasView!
    
  
  init(canvas: CanvasProtocol)
  {
    super.init(nibName: nil, bundle: nil)
    
    self.customView = CanvasView(canvas: canvas)
  }
  

  required init?(coder: NSCoder) { fatalError() }


  // MARK: - Overrides
  override func loadView()
  {
    view = customView
  }
}

