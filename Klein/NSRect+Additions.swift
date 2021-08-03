import Foundation

extension NSSize {
  func withHeight(_ height: CGFloat) -> NSSize {
    .init(width: width, height: height)
  }
  
  
  func withWidth(_ width: CGFloat) -> NSSize {
   .init(width: width, height: height)
  }
  
  func insetBy(dx: CGFloat, dy: CGFloat) -> NSSize {
    .init(width: width - dx, height: height - dy)
  }
  
  func min() -> CGFloat {
     Swift.min(width, height)
   }
   
   func minimalSquare() -> NSSize {
   .init(width: min(), height: min())
  }
  
  // MARK: - Rect
  func zeroOriginRect() -> NSRect {
    .init(origin: .zero, size: self)
  }
  
  func rectWithOrigin(_ origin: NSPoint) -> NSRect {
    .init(origin: origin, size: self)
  }
}



extension NSRect {
  func insetBy(dxPercentage: CGFloat, dyPercentage: CGFloat) -> NSRect {
    insetBy(dx: width * dxPercentage, dy: height * dyPercentage)
  }
  
  func minSide() -> CGFloat {
    Swift.min(width, height)
  }
  
  func minimalSquare() -> NSRect {
    .init(origin: origin, size: .init(width: minSide(), height: minSide()))
  }
  
  func centeredIn(_ rect: NSRect) -> NSRect {
    NSRect(
      x: rect.origin.x + (rect.size.width - size.width) / CGFloat(2.0)
      , y: rect.origin.y + (rect.size.height - size.height) / CGFloat(2.0)
      , width: size.width
      , height: size.height
    )
  }
  
  func withOrigin(_ origin: NSPoint) -> NSRect {
    .init(origin: origin, size: size)
  }
  
  
  func withSize(_ size: NSSize) -> NSRect {
    .init(origin: origin, size: size)
  }
  
  
  func withHeight(_ height: CGFloat) -> NSRect {
    .init(origin: origin, size: NSSize(width: width, height: height))
  }
  
  
  func withWidth(_ width: CGFloat) -> NSRect {
    .init(origin: origin, size: NSSize(width: width, height: height))
  }
  
  func withX(_ x: CGFloat) -> NSRect {
    .init(origin: origin.withX(x), size: size)
  }
  
  func withY(_ y: CGFloat) -> NSRect {
    .init(origin: origin.withY(y), size: size)
  }
  
  func pointsClockwise()
    -> [NSPoint]
  {
    [NSPoint(x: minX, y: maxY)
    , NSPoint(x: maxX, y: maxY)
    , NSPoint(x: maxX, y: minY)
    , origin]
  }
  
  func centerPoint()
    -> NSPoint
  {
      .init(x: midX, y: midY)
  }
  
  func enclosingRect(with anotherRect: NSRect)
  -> NSRect
  {
     NSRect(
      origin: origin
      , size: size.withWidth(anotherRect.maxX - minX))
  }
}
