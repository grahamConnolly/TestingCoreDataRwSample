/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class ReportDetailsTableViewController: UITableViewController {
  // MARK: - Properties
  var report: PandemicReport?
  var reportService: ReportService?
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var numberTestedTextField: UITextField!
  @IBOutlet weak var numberPositiveTextField: UITextField!
  @IBOutlet weak var numberNegativeTextField: UITextField!
  @IBOutlet weak var dateReportedLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    // disables cell highlighting
    tableView.allowsSelection = false

    let formatter = DateFormatter()
    formatter.dateStyle = .short

    // Display values of selected report
    if let report = report {
      locationTextField.text = report.location
      numberTestedTextField.text = "\(report.numberTested)"
      numberPositiveTextField.text = "\(report.numberPositive)"
      numberNegativeTextField.text = "\(report.numberNegative)"
      dateReportedLabel.text = formatter.string(from: report.dateReported ?? Date())
    } else {
      dateReportedLabel.text = formatter.string(from: Date())
    }
  }

  // MARK: - Actions
  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func save(_ sender: Any) {
    let location = locationTextField.text ?? ""
    let numberTested = Int32(numberTestedTextField.text ?? "") ?? 0
    let numberPositive = Int32(numberPositiveTextField.text ?? "") ?? 0
    let numberNegative = Int32(numberNegativeTextField.text ?? "") ?? 0

    if let report = report {
      report.location = location
      report.numberTested = numberTested
      report.numberPositive = numberPositive
      report.numberNegative = numberNegative
      reportService?.update(report)
      dismiss(animated: true, completion: nil)
    } else {
      reportService?.add(
        location,
        numberTested: numberTested,
        numberPositive: numberPositive,
        numberNegative: numberNegative)
      dismiss(animated: true, completion: nil)
    }
  }
}
