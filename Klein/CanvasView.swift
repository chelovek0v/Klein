import AppKit



final class CanvasView: NSView
{
   // MARK: - Initialisation
   private let canvas: CanvasProtocol
   
   init(canvas: CanvasProtocol)
   {
      self.canvas = canvas
      
      super.init(frame: .zero)
      
      wantsLayer                = true
      layerContentsRedrawPolicy = .onSetNeedsDisplay
   }
   
   required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
   

   
   // MARK: - Setup
   lazy var setup: Void = {
      guard let canvasLayer = canvas.layer() as? CALayer else { return }
      
      layer?.addSublayer(canvasLayer)
      canvasLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
      canvasLayer.frame = bounds
   }()
   
   
   override func viewDidMoveToWindow()
   {
      super.viewDidMoveToWindow()
      
      let _ = setup
   }
   


   // MARK: - Mouse
   
   // MARK: Mouse Down -> Mouse Up
   override func mouseDown(with event: NSEvent)
   {
      // WIP:  check layer and view coordinates
      let point =
         convert(event.locationInWindow, from: nil)
      
      // WIP: check for alt click
//      canvas.select(at: point)
      canvas.click(at: point)
   }
   

   
  /*
   override func menu(for event: NSEvent)
   -> NSMenu?
   {
      let point =
         convert(event.locationInWindow, from: nil)

      if let menu = super.menu(for: event)?.copy() as? NSMenu
      {
         // WIP: return precise menu?
      }
      else {
         return super.menu(for: event)
      }
   }
   */
   
   
   // MARK: -
   override var acceptsFirstResponder: Bool {
      true
   }
   
   override var wantsDefaultClipping: Bool {
      false
   }
   
   override var isOpaque: Bool {
      true
   }
}

