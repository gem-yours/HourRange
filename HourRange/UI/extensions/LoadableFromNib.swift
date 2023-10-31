//

import UIKit


protocol LoadableFromNib {
    static var nibName: String { get }
}

extension LoadableFromNib where Self: UIView {

    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        UINib(nibName: nibName, bundle: Bundle(for: Self.self))
    }

    func setupFromNib() {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load \(Self.nibName).xib")
        }
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        fitTo(view)
    }
}


extension UIView {
    func fitTo(_ view: UIView) {
        addConstraints([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
