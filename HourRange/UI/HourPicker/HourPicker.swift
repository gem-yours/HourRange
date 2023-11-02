//

import UIKit
import RxCocoa
import RxSwift
import RxRelay


@IBDesignable
public class HourPicker: UIView, LoadableFromNib {
    @IBInspectable public var labelText: String = "" {
        didSet {
            label?.text = labelText
        }
    }
    @IBInspectable public var defaultHour: String = "" {
        didSet {
            textField?.text = defaultHour
        }
    }
    @IBInspectable public var placeholder: String = "" {
        didSet {
            textField?.placeholder = placeholder
        }
    }
    
    public var text = BehaviorRelay<String?>(value: nil)
    
    @IBOutlet var label: UILabel?
    @IBOutlet var textField: UITextField? {
        didSet {
            guard let textField = textField else {
                return
            }
            textField.rx.text.asObservable().subscribe {
                self.text.accept($0)
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet var errorLabel: UILabel?
    
    private var errorDescription: String? = nil {
        didSet {
            errorLabel?.text = errorDescription
        }
    }
    
    private var disposeBag = DisposeBag()
    
    
    public func setText(_ text: String) {
        textField?.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
}

extension HourPicker: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let old = textField.text,
              let replaceRange = Range(range, in: old) else {
            return true
        }
        
        let text = old.replacingCharacters(in: replaceRange, with: string)
        guard let number = Int(text) else {
            errorDescription = "整数を入力してください"
            return true
        }
        guard (0...24).contains(number) else {
            errorDescription = "0以上24以下の数値を入力してください"
            return true
        }
        errorDescription = nil
        return true
    }
}
