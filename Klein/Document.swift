import Cocoa

class Document: NSDocument
{
   // MARK: - Initialisaion
   let canvas: CanvasProtocol
   
   override init()
   {
      self.canvas = Canvas()
   }
   
   
   
   // MARK: -
   override class var autosavesInPlace: Bool { return true }
   
   
   private lazy var windowController =
      NSWindowController(window: canvasWindow)
   
   private lazy var canvasViewController = {
      CanvasViewController(canvas:canvas)
   }()
   
   private lazy var canvasWindow: NSWindow = {
      let window =
         NSWindow()
      
      window.backgroundColor = .white
      window.contentViewController = canvasViewController
      
      window.setFrame(.init(origin: .init(x: 200, y: 200), size: .init(width: 800, height: 600)), display: true)
      
      return window
   }()
   
   override func makeWindowControllers() {
      addWindowController(windowController)
   }
   
   
   override func data(ofType typeName: String) throws -> Data {
      // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
      // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
      return (canvas.json as! String).data(using: .utf8)!
   }
   
   
   
   override func read(from data: Data, ofType typeName: String) throws {
      let json =
         try! JSONSerialization.jsonObject(
            with: data
            , options: []) as! [[String: Any]]
      
      json.forEach { figureJson in
         if let figure = canvas.figureFromJSON(figureJson) {
            canvas.addFigure(figure)
         }
      }
   }
   
   
}

