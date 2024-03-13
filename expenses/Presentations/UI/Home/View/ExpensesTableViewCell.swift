//
//  ExpensesTableViewCell.swift
//  expenses
//
//  Created by vcampus on 3/13/24.
//

import UIKit

class ExpensesTableViewCell: UITableViewCell {
    
    // MARK: DEFINITION
    static let IDENTIFIER = "expenses_cell"
    static let XIB_NAME = "ExpensesTableViewCell"
    static let DEFAULT_HEIGHT: CGFloat = 160.0
    
    // MARK: OUTLET
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = Font(.installed(.RowdiesRegular), size: .standard(.s12)).instance
        dateLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s12)).instance
        amountLabel.font = Font(.installed(.RowdiesBold), size: .standard(.s15)).instance
        categoryLabel.font = Font(.system, size: .standard(.s12)).instance
        locationLabel.font = Font(.system, size: .standard(.s12)).instance
        notesLabel.font = Font(.systemItatic, size: .standard(.s12)).instance
        
        titleLabel.textColor = Palette.color0D47A1
        notesLabel.textColor = Palette.colorFF0000
        locationLabel.textColor = Palette.colorFCD303
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupExpensesRow(_ withData: ExpensesListResponse) {
        titleLabel.text = withData.title
        dateLabel.text = withData.date
        amountLabel.text = "\(withData.amount ?? 0) \(NSLocalizedString(Localized.home_view_controller_money_unit.rawValue, comment: ""))"
        categoryLabel.text = withData.category
        locationLabel.text = withData.location
        notesLabel.text = "Notes: \(withData.notes ?? "")"
    }
}
