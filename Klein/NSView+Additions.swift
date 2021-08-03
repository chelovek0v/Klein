import AppKit


// MARK: - Layout
protocol LayoutConstraintable
{
  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var leftAnchor: NSLayoutXAxisAnchor { get }
  var rightAnchor: NSLayoutXAxisAnchor { get }
  
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }
  
  var widthAnchor: NSLayoutDimension { get }
  var heightAnchor: NSLayoutDimension { get }
  
  var centerXAnchor: NSLayoutXAxisAnchor { get }
  var centerYAnchor: NSLayoutYAxisAnchor { get }
}


extension NSView {
  func constrain(_ contraints: NSLayoutConstraint...) {
    NSLayoutConstraint.activate(contraints)
  }
  
  // WIP: create "fluent" version
  func prepareForAutolayout() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func expandHorizontally() {
    setContentHuggingPriority(.defaultLow, for: .horizontal)
  }
  
  func expandVertically() {
    setContentHuggingPriority(.defaultLow, for: .vertical)
  }
  
func shrinkHorizontally(_ priority: NSLayoutConstraint.Priority = .defaultHigh) {
    setContentHuggingPriority(priority, for: .horizontal)
  }
  
  func shrinkVertically(_ priority: NSLayoutConstraint.Priority = .defaultHigh) {
    setContentHuggingPriority(priority, for: .vertical)
  }
  
  func toughenHorizontally(_ priority: NSLayoutConstraint.Priority = .defaultHigh)
   {
    setContentCompressionResistancePriority(priority, for: .horizontal)
  }
  
  // WIP: rename to harden
  func hardenVertically(_ priority: NSLayoutConstraint.Priority = .defaultHigh) {
     setContentCompressionResistancePriority(priority, for: .vertical)
   }
   
   func softenHorizontally(_ priority: NSLayoutConstraint.Priority = .defaultLow)
   {
     setContentCompressionResistancePriority(
      priority
      , for: .horizontal)
   }
   
   func softenVertically() {
      setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
}

#if os(macOS)
extension NSEdgeInsets {
  static let zero: NSEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
}
#endif

extension LayoutConstraintable
{
  func pinTopToTop(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        topAnchor
          .constraint(
            equalTo: layout.topAnchor
            , constant: offset
        )
      ]
    )
  }
  
  func pinTopToBottom(_ layout: LayoutConstraintable, offset: CGFloat = 0, priority: NSLayoutConstraint.Priority = .required)
  {
    let constraint =
      topAnchor
        .constraint(
          equalTo: layout.bottomAnchor
          , constant: offset
      )
    constraint.priority =
      priority
    NSLayoutConstraint.activate(
      [
        constraint
      ]
    )
  }
  
  func pinBottomToBottom(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        bottomAnchor
          .constraint(
            equalTo: layout.bottomAnchor
            , constant: -offset
        )
      ]
    )
  }
  
  func pinBottomToTop(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        bottomAnchor
          .constraint(
            equalTo: layout.topAnchor
            , constant: -offset
        )
      ]
    )
  }
  
  func pinWeaklyBottomToBottom(_ layout: LayoutConstraintable)
  {
    NSLayoutConstraint.activate(
      [
        bottomAnchor
          .constraint(lessThanOrEqualTo: layout.bottomAnchor)
        
      ]
    )
  }
  
  func pinTopAndBottom(_ layout: LayoutConstraintable, insets: NSEdgeInsets = .zero)
  {
    NSLayoutConstraint.activate(
      [
        topAnchor
          .constraint(
            equalTo: layout.topAnchor
            , constant: insets.top
        )
        , bottomAnchor
          .constraint(
            equalTo: layout.bottomAnchor
            , constant: -insets.bottom
        )
      ]
    )
  }
  
  func pinToLeftTopCorner(_ view: LayoutConstraintable, insets: NSEdgeInsets = .zero)
  {
    NSLayoutConstraint.activate(
      [
        leftAnchor
          .constraint(
            equalTo: view.leftAnchor
            , constant: insets.left
        )
        , topAnchor
          .constraint(
            equalTo: view.topAnchor
            , constant: insets.top
        )
      ]
    )
  }
  
  func pinTopAndSides(_ view: LayoutConstraintable, insets: NSEdgeInsets = .zero)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor
          .constraint(
            equalTo: view.leadingAnchor
            , constant: insets.left
        )
        , topAnchor
          .constraint(
            equalTo: view.topAnchor
            , constant: insets.top
        )
        , trailingAnchor
          .constraint(
            equalTo: view.trailingAnchor
            , constant: -insets.right
        )
      ]
    )
  }
  
  func pinSides(_ view: LayoutConstraintable, insets: NSEdgeInsets = .zero)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor
          .constraint(
            equalTo: view.leadingAnchor
            , constant: insets.left
        )
        , trailingAnchor
          .constraint(
            equalTo: view.trailingAnchor
            , constant: -insets.right
        )
      ]
    )
  }
  
  func pinSidesConstrains(_ view: LayoutConstraintable, insets: NSEdgeInsets = .zero) -> [NSLayoutConstraint]
  {
    [
      leadingAnchor
        .constraint(
          equalTo: view.leadingAnchor
          , constant: insets.left
      )
      , trailingAnchor
        .constraint(
          equalTo: view.trailingAnchor
          , constant: -insets.right
      )
    ]
  }
  
  func pinBottomAndSides(_ view: LayoutConstraintable, insets: NSEdgeInsets = .zero)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor
          .constraint(
            equalTo: view.leadingAnchor
            , constant: insets.left
        )
        , bottomAnchor
          .constraint(
            equalTo: view.bottomAnchor
            , constant: -insets.bottom
        )
        , trailingAnchor
          .constraint(
            equalTo: view.trailingAnchor
            , constant: -insets.right
        )
      ]
    )
  }
  
  
  func pinLeading(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor
          .constraint(
            equalTo: layout.leadingAnchor
            , constant: offset
        )
      ]
    )
  }
  
  
  
  func pinLeadingToTrailing(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor
          .constraint(
            equalTo: layout.trailingAnchor
            , constant: offset
        )
      ]
    )
  }
  
  
  func pinTrailing(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        trailingAnchor
          .constraint(
            equalTo: layout.trailingAnchor
            , constant: -offset
        )
      ]
    )
  }
  
  func pinTrailing(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        trailingAnchor
          .constraint(
            equalTo: anchor
            , constant: -offset
        )
      ]
    )
  }
  
  func pinTrailingToLeading(_ layout: LayoutConstraintable, offset: CGFloat = 0)
  {
    NSLayoutConstraint.activate(
      [
        trailingAnchor
          .constraint(
            equalTo: layout.leadingAnchor
            , constant: -offset
        )
      ]
    )
  }
  
 
  
  func pinLeading(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0)
   {
     NSLayoutConstraint.activate(
       [
         leadingAnchor
           .constraint(
             equalTo: anchor
             , constant: offset
         )
       ]
     )
   }
  
  
  func pin(_ view: LayoutConstraintable, with insets: NSEdgeInsets)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor
          .constraint(
            equalTo: view.leadingAnchor
            , constant: insets.left
        )
        , trailingAnchor
          .constraint(
            equalTo: view.trailingAnchor
            , constant: -insets.right
        )
        , topAnchor.constraint(
          equalTo: view.topAnchor
          , constant: insets.top
        )
        , bottomAnchor.constraint(
          equalTo: view.bottomAnchor
          , constant: -insets.bottom
        )
      ]
    )
  }
  
  func pin(_ view: LayoutConstraintable)
  {
    NSLayoutConstraint.activate(
      [
        leadingAnchor.constraint(equalTo: view.leadingAnchor)
        , trailingAnchor.constraint(equalTo: view.trailingAnchor)
        , topAnchor.constraint(equalTo: view.topAnchor)
        , bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ]
    )
  }
  
  // MARK: Align
  func centered(_ view: LayoutConstraintable)
  {
    NSLayoutConstraint.activate(
      [
        centerXAnchor.constraint(equalTo: view.centerXAnchor)
        , centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ]
    )
  }
  
  func centeredX(_ view: LayoutConstraintable)
   {
     NSLayoutConstraint.activate(
       [
         centerXAnchor.constraint(equalTo: view.centerXAnchor)
       ]
     )
   }
   
   func centeredY(_ view: LayoutConstraintable)
   {
     NSLayoutConstraint.activate(
       [
         centerYAnchor.constraint(equalTo: view.centerYAnchor)
       ]
     )
   }
  
  // MARK: Size
  func size(to size: CGSize)
  {
    NSLayoutConstraint.activate(
      [
        widthAnchor.constraint(equalToConstant: size.width)
        , heightAnchor.constraint(equalToConstant: size.height)
      ]
    )
  }
  
  func size(as view: NSView)
  {
    NSLayoutConstraint.activate(
      [
        widthAnchor.constraint(equalTo: view.widthAnchor)
        ,heightAnchor.constraint(equalTo: view.heightAnchor)
      ]
    )
  }
  
  func sizeHeight(with height: CGFloat)
  {
    heightAnchor.constraint(
      equalToConstant: height
    )
      .isActive =
    true
  }
  
  func sizeWidth(with width: CGFloat)
  {
    widthAnchor.constraint(
      equalToConstant: width
    )
      .isActive =
    true
  }
  
  func sizeWidth(as layout: LayoutConstraintable)
  {
    widthAnchor.constraint(
      equalTo: layout.widthAnchor
    )
      .isActive =
        true
  }
  
  func sizeWidth(as layout: LayoutConstraintable, multiplier: CGFloat)
  {
    widthAnchor.constraint(
      equalTo: layout.widthAnchor
      , multiplier: multiplier
    )
      .isActive =
    true
  }
}

extension NSView: LayoutConstraintable {}
extension NSLayoutGuide: LayoutConstraintable {}

#if os(iOS)
extension UILayoutGuide: LayoutConstraintable {}
#endif



extension NSView
{
   func installGradient(with colors: [NSColor]) {
      let gradient: CAGradientLayer = CAGradientLayer()
      guard colors.count >= 2 else { return }
      
      
      gradient.colors = colors.map { $0.cgColor }
      let locations = stride(from: 0, through: 1.0, by: 1.0 / Double(colors.count - 1))
      
      gradient.locations = Array(locations) as [NSNumber]
      gradient.frame = bounds
      
      gradient.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
      layer?.insertSublayer(gradient, at: 0)
   }
}
