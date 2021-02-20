//
//  NoteCell.swift
//  LocationNotes
//
//  Created by hryst on 9/14/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    var note: Note?

    @IBOutlet weak var imageNote: UIImageView!
    @IBOutlet weak var labelNameNote: UILabel!
    @IBOutlet weak var labelDateUpdate: UILabel!
    
    
    func initCell(note: Note) {
        self.note = note
        
        if note.imageSmall != nil {
            imageNote.image = UIImage(data: note.imageSmall! as Data)
        } else {
            imageNote.image = UIImage(named: "noteImege.png")
        }
        imageNote.layer.cornerRadius = imageNote.frame.size.width / 2
        imageNote.layer.masksToBounds = true
       // imageNote.clipsToBounds = true
        imageNote.contentMode = .scaleAspectFill
        
        
        labelNameNote.text = note.name
        labelDateUpdate.text = note.dateUpdate?.timeAgoDisplay()
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
