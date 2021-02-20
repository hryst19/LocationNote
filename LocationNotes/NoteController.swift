//
//  NoteController.swift
//  LocationNotes
//
//  Created by hryst on 8/13/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//

import UIKit

class NoteController: UITableViewController {
    
    var note: Note?
    private let imageNote = UIImageView(image: UIImage(named: "NoteList"))
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    
    @IBOutlet weak var labelFolder: UILabel!
    @IBOutlet weak var labelFolderName: UILabel!
    
    
    @IBAction func pushShareAction(_ sender: Any) {
        
        var activities: [Any] = []
        
        if  let image = note?.imageActual  {
            activities.append(image)
        }
        
        activities.append(note?.name ?? "")
        activities.append(note?.textDescription ?? "")
        
    let activityController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      let firstText = ""
         textName.text = firstText
        self.textName.placeholder = "New name"
      if textName.text != firstText {
        
         textName.text = note?.name
      } else if textName.text == firstText {
        textName.text = navigationItem.title
        }
     textName.text = note?.name
     textDescription.text = note?.textDescription
     imageView.image = note?.imageActual
     imageView.layer.cornerRadius = imageView.frame.width / 2
     imageView.layer.masksToBounds = true
     imageView.contentMode = .scaleAspectFill
    
 //     setupUI ()
    // название как в папке
   navigationItem.title = note?.name
      
        
        
        
       // self.navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = note?.name
    }
    
    @IBAction func pushDoneAction(_ sender: Any) {
        saveNote()
    // нащелкиваю новый контролер
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let folder = note?.folder {
            labelFolderName.text = folder.name
        } else {
            labelFolderName.text = "-"
        }
    }
   

    func saveNote() {
        if textName.text == "" && textDescription.text == "" && imageView.image == nil   {
            CoreDataManager.sharedInstance.managedObjectContext.delete(note!)
            
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        
        if note?.name != textName.text || note?.textDescription != textDescription.text {
            note?.dateUpdate = Date()
        }
         
        note?.name = textName.text
        note?.textDescription = textDescription.text
        note?.imageActual = imageView.image
        
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
 

    let imagePiker : UIImagePickerController = UIImagePickerController()
    
    // выбор строки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        // отменяю выделение
        tableView.deselectRow(at: indexPath , animated: true)
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let alertController = UIAlertController(title: "Вставить картинку", message: " Выбрать кортинку из:", preferredStyle: UIAlertController.Style.actionSheet)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
            let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default) { (UIAlertAction) in
                print("фоткаем")
                }
                
                
              self.imagePiker.sourceType = .camera
              self.imagePiker.delegate = self
                self.present(self.imagePiker, animated: true, completion: nil)
              alertController.addAction(a1Camera)
            }
            
            
            
            
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    print("идем в библиотеку фото")
                self.imagePiker.sourceType = .savedPhotosAlbum
                self.imagePiker.delegate = self
                self.present(self.imagePiker, animated: true, completion: nil)
                
            }
            
            alertController.addAction(a2Photo)
            
            
            if self.imageView.image != nil {
            let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) { (UIAlertAction) in
                self.imageView.image = nil
              }
             alertController.addAction(a3Delete)
            }
            
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                
            }
     
            alertController.addAction(a4Cancel)
            
            
            present(alertController, animated: true, completion: nil)
        }
    
    }
    
//    private func setupUI () {
//        navigationController?.navigationBar.prefersLargeTitles = true
//      //  navigationItem.title = note?.name
//         navigationItem.title = "wefwefwe"
//        guard let navigationBar = self.navigationController?.navigationBar else {return}
//       navigationBar.addSubview(imageNote)
//       imageNote.layer.cornerRadius = Const.ImageSizeForLargeState / 2
//       imageNote.clipsToBounds = true
//       imageNote.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([imageNote.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: Const.ImageRightMargin),
//            imageNote.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: Const.ImageBottomMarginForLargeState),
//            imageNote.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState ),
//            imageNote.widthAnchor.constraint(equalTo: imageNote.heightAnchor)
//
//            ])
//
//
//    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSelectFolder" {
            (segue.destination as! SelectFolderController).note = note
        }
        if segue.identifier == "goToMap" {
            (segue.destination as! NoteMapController).note = note
        }
        
    }
    

}

extension NoteController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
         picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
