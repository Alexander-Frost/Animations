//
//  ViewController.swift
//  Animations
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
        
        label.text = "👨‍🚀"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
        
        let rotateBtn = UIButton(type: .custom)
        rotateBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rotateBtn)
        rotateBtn.setTitle("Rotate", for: .normal)
        rotateBtn.addTarget(self, action: #selector(rotateBtnPressed), for: .touchUpInside)
        
        let keyBtn = UIButton(type: .system)
        keyBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyBtn)
        keyBtn.setTitle("Key", for: .normal)
        keyBtn.addTarget(self, action: #selector(keyBtnPressed), for: .touchUpInside)
        
        let springBtn = UIButton(type: .system)
        springBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(springBtn)
        springBtn.setTitle("Spring", for: .normal)
        springBtn.addTarget(self, action: #selector(springBtnPressed), for: .touchUpInside)
        
        let squashBtn = UIButton(type: .system)
        squashBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squashBtn)
        squashBtn.setTitle("Squash", for: .normal)
        squashBtn.addTarget(self, action: #selector(squashBtnPressed), for: .touchUpInside)
        
        let anticBtn = UIButton(type: .system)
        anticBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anticBtn) // need to add as subview to view before adding as arrangedSubview to stackview
        anticBtn.setTitle("Antic", for: .normal)
        anticBtn.addTarget(self, action: #selector(anticBtnPressed), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(rotateBtn)
        stackView.addArrangedSubview(keyBtn)
        stackView.addArrangedSubview(springBtn)
        stackView.addArrangedSubview(squashBtn)
        stackView.addArrangedSubview(anticBtn)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.center = self.view.center
    }
    
    @objc func rotateBtnPressed(){
        label.center = self.view.center
        
        UIView.animate(withDuration: 2.0, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4) // 90 degree turn 1/4pi

        }) { (_) in
            // code that runs when animation is complete
            
            UIView.animate(withDuration: 2.0, animations: {
                self.label.transform = .identity // .identity is the original state
            })
        }
    }
    
    @objc func keyBtnPressed(){
        label.center = self.view.center

        UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.label.transform = .identity
            })
            //starts halfway through (0.5), runs for 1/4 time (0.25)
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.label.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.label.center = self.view.center
            })
        }, completion: nil)
    }
    
    @objc func springBtnPressed(){
        label.center = self.view.center

        
        self.label.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.label.transform = .identity
        }, completion: nil)
        
    }
    @objc func squashBtnPressed(){
        label.center = CGPoint(x: view.center.x, y: -label.bounds.size.height)
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4, animations: {
                self.label.center = self.view.center
            })
            // overlaps with above animation
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2, animations: {
                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2, animations: {
                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15, animations: {
                self.label.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15, animations: {
                self.label.transform = .identity
            })
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [], animations: animBlock, completion: nil)
    }
    @objc func anticBtnPressed(){
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 16.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2, animations: {
                self.label.transform = CGAffineTransform(rotationAngle: -1 * CGFloat.pi / 16.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: {
                self.label.center = CGPoint(x: self.view.bounds.size.width + self.label.bounds.size.width, y: self.view.center.y)
            })
        }
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [], animations: animBlock, completion: nil)
    }
}
    

//
//    let redView = UIView()
//    redView.backgroundColor = .red
//    redView.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(redView)
    
    //Add Constraints
    //        let redLeadingContraint = NSLayoutConstraint(item: redView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 30)
    //        let redBottomContraint = NSLayoutConstraint(item: redView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
    //        let redHeightContraint = NSLayoutConstraint(item: redView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
    //        let redAspectRatioContraint = NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
    
    
    //Create Constaints using Anchors
    //        let redLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
    //        let redBottomConstraint = redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    //        let redHeightConstraint = redView.heightAnchor.constraint(equalToConstant: 150)
    //        let redAspectRatioConstraint = redView.widthAnchor.constraint(equalTo: redView.heightAnchor, multiplier: 1, constant: 0)
    //
    //        NSLayoutConstraint.activate([redLeadingConstraint,redBottomConstraint,redHeightConstraint,redAspectRatioConstraint])
    
    


