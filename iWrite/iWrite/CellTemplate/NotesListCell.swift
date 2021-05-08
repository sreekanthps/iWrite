//
//  NotesListCell.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import UIKit

class NotesListCell: UITableViewCell {
    static let reuseIdentifier = "NotesListCell"
    let noteHeader: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        return nil
    }
    
    func layoutViews() {
        self.contentView.flex.define { (flex) in
            flex.addItem(noteHeader).marginVertical(15).marginHorizontal(10)
         }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
           layout()
       }
       func layout() {
           contentView.flex.layout(mode: .adjustHeight)
       }
    
    func configureCellata(withName name: String) {
        noteHeader.text = name
    }
    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)

        // 2) Layout contentView flex container
        layout()

        // Return the flex container new size
        return contentView.frame.size
    }
}
