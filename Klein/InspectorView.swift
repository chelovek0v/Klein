import AppKit
import Combine

final class InspectorView: NSView
{
 // MARK: - Initialisation
   private weak var figure: (FigureProtocol & AnyObject)?
   
   init(figure: (FigureProtocol & AnyObject)?)
   {
      self.figure = figure
      
      super.init(frame: .zero)
      translatesAutoresizingMaskIntoConstraints = false
   }
   
   
   required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
   
   // MARK: -
   override func viewDidMoveToWindow()
   {
      super.viewDidMoveToWindow()
      
      let _ = setup
   }
   
   
   private lazy var setup: Void = {
      guard let figure = figure else { return }
       
      let stackView =
      NSStackView(views: [xField, yField, widthField, heightField])
      stackView.orientation = .vertical
      
      stackView.prepareForAutolayout()
      addSubview(stackView)
      stackView.pin(self, with: .init(top: 30, left: 20, bottom: 30, right: 20))
      
    
         
   }()
   
   lazy var subscribers: [AnyCancellable] = []
   
  
   
   
       // MARK: - Title
   lazy var widthField = {
      NSTextField(string: "100")
   }()
   
   lazy var heightField = {
      NSTextField(string: "100")
   }()
   
   lazy var xField = {
      NSTextField(string: "10")
   }()
   
   lazy var yField = {
      NSTextField(string: "20")
   }()
   
   // MARK: - Combine
   func bindSizePublisher(_ publisher: AnyPublisher<CGSize, Never>)
   {
            publisher.map(\.width).map({"\($0)"})
         .assign(to: \.stringValue, on: widthField)
         .store(in: &subscribers)
      publisher.map(\.height).map({"\($0)"})
         .assign(to: \.stringValue, on: heightField)
         .store(in: &subscribers)

   }
   
   func bindOriginPublisher(_ publisher: AnyPublisher<CGPoint, Never>)
   {
      publisher.map(\.x).map({"\($0)"})
         .assign(to: \.stringValue, on: xField)
         .store(in: &subscribers)
      publisher.map(\.y).map({"\($0)"})
         .assign(to: \.stringValue, on: yField)
         .store(in: &subscribers)
   }
}
