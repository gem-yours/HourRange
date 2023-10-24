//

import UIKit

class TimeRecordRow: UITableViewCell {
    @IBOutlet var startHourLabel: UILabel?
    @IBOutlet var endHourLabel: UILabel?
    @IBOutlet var hour: UILabel?
    
    var timeRecord: TimeRecord? = nil {
        didSet {
            startHourLabel?.text = "開始時刻: \(timeRecord?.start.value ?? 0)"
            endHourLabel?.text = "終了時刻: \(timeRecord?.end.value ?? 0)"
            hour?.text = "指定時刻: \(timeRecord?.hour.value ?? 0)"
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
    }
}
