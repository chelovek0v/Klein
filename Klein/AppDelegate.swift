import Cocoa

@main
final class AppDelegate: NSObject, NSApplicationDelegate
{
   private lazy var canvas =
      Canvas()
      
   private lazy var canvasViewController = {
   CanvasViewController(canvas: canvas)
   }()
   
    private lazy var canvasWindow: NSWindow = {
      let window =
         NSWindow()
      
      window.backgroundColor = .white
      window.contentViewController = canvasViewController
      
      
      
      window.setFrame(.init(origin: .init(x: 200, y: 200), size: .init(width: 800, height: 600)), display: true)
      
      
      return window
   }()
   
   func applicationDidFinishLaunching(_ aNotification: Notification)
   {
      canvasWindow.makeKeyAndOrderFront(self)
   }

   func applicationWillTerminate(_ aNotification: Notification)
   {
      // Insert code here to tear down your application
   }
}

