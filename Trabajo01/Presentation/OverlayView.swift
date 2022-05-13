//
//  OverlayView.swift
//  Trabajo01
//
//  Created by David Alejandro Garcia Cortes on 12/05/22.
//

import UIKit

class OverlayView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        self.collectionView.register(UINib(nibName:"CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    //MARK: Datasource & Delegate
    
    let objects = ["Redimir en Tienda Online", "Redimir en Viajes", "Redimir en Bonos", "Redimir SOAT", "Transferir Puntos", "Convertir Puntos", "Conocer Marcas", "Servicios Financieros", "Conocer Puntos"]
    
    let icon = ["tiendaCatalogo", "Plane", "Tickets", "Shield", "Arrows", "Loop", "Store", "Bag", "School"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.title.text = self.objects[indexPath.item]
        cell.iconImageView.image = UIImage(named: icon[indexPath.row])
        
        return cell
        
    }
    
}
