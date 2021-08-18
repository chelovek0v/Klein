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
   

   
   // MARK: -
   lazy var setup: Void = {
      guard let inspectorView = canvas.inspector as? NSView else { return }
      addSubview(inspectorView)
      inspectorView.pinTopToTop(self)
      inspectorView.pinTrailing(self)
      inspectorView.sizeWidth(with: 200)
      inspectorView.pinBottomToBottom(self)
      
      guard let canvasLayer = canvas.layer as? CALayer else { return }
      
      layer?.addSublayer(canvasLayer)
      canvasLayer.autoresizingMask = []
      canvasLayer.frame = CGRect(origin: .zero, size: .init(width: 600, height: 600))
      
      let panRecogniser =
         NSPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
      addGestureRecognizer(panRecogniser)
   }()
   
   
   override func viewDidMoveToWindow()
   {
      super.viewDidMoveToWindow()
      
      let _ = setup
   }
   
   
   
   // MARK: - Mouse
   @objc func handlePanGesture(_ recogniser: NSPanGestureRecognizer)
   {
      let translation =
         recogniser.translation(in: self)
      
      canvas.moveSelected(translation)
      recogniser.setTranslation(.zero, in: self)
   }

   
   override func mouseDown(with event: NSEvent)
   {
      let point =
         convert(event.locationInWindow, from: nil)
      
      canvas.click(at: point)
   }
   
   
   // MARK: -
   override var acceptsFirstResponder: Bool { true }
   
   override var wantsDefaultClipping: Bool { false }
   
   override var isOpaque: Bool { true }
}

