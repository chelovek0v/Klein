import Foundation


extension CGRect
{
   func random() -> CGRect
   {
      let randomPoint: CGPoint = {
         let inset =
            insetBy(dx: 150, dy: 150)
         let x =
            CGFloat.random(in: inset.minX...inset.maxX)
         let y =
            CGFloat.random(in: inset.minY...inset.maxY)
         let point =
            CGPoint(x: x, y: y)
         

         return point
      }()
      
      return CGRect(origin: randomPoint, size: .init(width: 100, height: 100))
   }
   
}
