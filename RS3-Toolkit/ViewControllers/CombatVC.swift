//
//  CombatVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/15/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CombatVC: UIViewController, UISearchBarDelegate {
    var interstitial: GADInterstitial!
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var combatLevelLabel: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    // Constraints
    @IBOutlet var combatLevelConst: NSLayoutConstraint!
    @IBOutlet var leftSkillsConst: NSLayoutConstraint!
    @IBOutlet var rightSkillsConst: NSLayoutConstraint!
    @IBOutlet var attackStrengthConst: NSLayoutConstraint!
    @IBOutlet var strengthDefenceConst: NSLayoutConstraint!
    @IBOutlet var defenceConstitutionConst: NSLayoutConstraint!
    @IBOutlet var rangedMagicConst: NSLayoutConstraint!
    @IBOutlet var magicPrayerConst: NSLayoutConstraint!
    @IBOutlet var prayerSummoningConst: NSLayoutConstraint!
    
    @IBOutlet var leadingAttackConst: NSLayoutConstraint!
    @IBOutlet var leadingStrengthConst: NSLayoutConstraint!
    @IBOutlet var leadingDefenceConst: NSLayoutConstraint!
    @IBOutlet var leadingConstitutionConst: NSLayoutConstraint!
    @IBOutlet var trailingRagnedConst: NSLayoutConstraint!
    @IBOutlet var trailingMagicConst: NSLayoutConstraint!
    @IBOutlet var trailingPrayerConst: NSLayoutConstraint!
    @IBOutlet var trailingSummoningConst: NSLayoutConstraint!
    
    // Level Labels
    @IBOutlet var calculatedCombatLevelLabel: UILabel!
    @IBOutlet var attackLevelLabel: UILabel!
    @IBOutlet var strengthLevelLabel: UILabel!
    @IBOutlet var defenceLevelLabel: UILabel!
    @IBOutlet var constLevelLabel: UILabel!
    @IBOutlet var rangedLevelLabel: UILabel!
    @IBOutlet var magicLevelLabel: UILabel!
    @IBOutlet var prayerLevelLabel: UILabel!
    @IBOutlet var summonLevelLabel: UILabel!
    
    // Level Buttons
    @IBAction func subAttack(sender: UIButton) {
        guard combatSkills["attack"]! > 1 else {
            return
        }
        combatSkills["attack"]! -= 1
    }
    @IBAction func addAttack(sender: UIButton) {
        guard combatSkills["attack"]! < 99 else {
            return
        }
        combatSkills["attack"]! += 1
    }
    @IBAction func subStrength(sender: UIButton) {
        guard combatSkills["strength"]! > 1 else {
            return
        }
        combatSkills["strength"]! -= 1
    }
    @IBAction func addStrength(sender: UIButton) {
        guard combatSkills["strength"]! < 99 else {
            return
        }
        combatSkills["strength"]! += 1
    }
    @IBAction func subDefence(sender: UIButton) {
        guard combatSkills["defence"]! > 1 else {
            return
        }
        combatSkills["defence"]! -= 1
    }
    @IBAction func addDefence(sender: UIButton) {
        guard combatSkills["defence"]! < 99 else {
            return
        }
        combatSkills["defence"]! += 1
    }
    @IBAction func subConst(sender: UIButton) {
        guard combatSkills["const"]! > 1 else {
            return
        }
        combatSkills["const"]! -= 1
    }
    @IBAction func addConst(sender: UIButton) {
        guard combatSkills["const"]! < 99 else {
            return
        }
        combatSkills["const"]! += 1
    }
    @IBAction func subRanged(sender: UIButton) {
        guard combatSkills["ranged"]! > 1 else {
            return
        }
        combatSkills["ranged"]! -= 1
    }
    @IBAction func addRagned(sender: UIButton) {
        guard combatSkills["ranged"]! < 99 else {
            return
        }
        combatSkills["ranged"]! += 1
    }
    @IBAction func subMagic(sender: UIButton) {
        guard combatSkills["magic"]! > 1 else {
            return
        }
        combatSkills["magic"]! -= 1
    }
    @IBAction func addMagic(sender: UIButton) {
        guard combatSkills["magic"]! < 99 else {
            return
        }
        combatSkills["magic"]! += 1
    }
    @IBAction func subPrayer(sender: UIButton) {
        guard combatSkills["prayer"]! > 1 else {
            return
        }
        combatSkills["prayer"]! -= 1
    }
    @IBAction func addPrayer(sender: UIButton) {
        guard combatSkills["prayer"]! < 99 else {
            return
        }
        combatSkills["prayer"]! += 1
    }
    @IBAction func subSummon(sender: UIButton) {
        guard combatSkills["summon"]! > 1 else {
            return
        }
        combatSkills["summon"]! -= 1
    }
    @IBAction func addSummon(sender: UIButton) {
        guard combatSkills["summon"]! < 99 else {
            return
        }
        combatSkills["summon"]! += 1
    }
    
    @IBAction func resetCombatSkills(_ sender: UIButton) {
        updateViewData()
    }
    
    var combatSkills: [String:Int] = [
        "attack" : 1,
        "strength": 1,
        "defence" : 1,
        "ranged" : 1,
        "magic" : 1,
        "const" : 1,
        "prayer" : 1,
        "summon" : 1
        ] {
        didSet {
            updateCombatLevel()
        }
    }
    
    let activityIndicator = UIActivityIndicatorView()
    var updating: Bool = false {
        didSet {
            if updating {
                startLoading()
            } else {
                stopLoading()
                updateViewData()
            }
        }
    }
    
    var store = UserDataStore()
    static var user: UserData = UserData() {
        didSet {
            Global.cachedUserData = LogVC.user
        }
    }
    var localUser: UserData {
        return StatsVC.user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-4468715439448322/3008848820")
        //interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") // Test ID
        
        if !Global.adShown {
            let request = GADRequest()
            interstitial.load(request)
        }
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Global.cachedUserData != nil {
            LogVC.user = Global.cachedUserData!
            updateViewData()
        } else {
            updateUserData()
            updating = true
        }
        
        if Global.cachedUserAvatar != nil {
            profileImage.image = Global.cachedUserAvatar!
        } else {
            updateUserAvatar()
        }
        
        if Global.displayIsCompact() {
            combatLevelConst.constant = 50
            leftSkillsConst.constant = 45
            rightSkillsConst.constant = 45
            
            attackStrengthConst.constant = 10
            strengthDefenceConst.constant = 10
            defenceConstitutionConst.constant = 10
            rangedMagicConst.constant = 10
            magicPrayerConst.constant = 10
            prayerSummoningConst.constant = 10
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            leadingAttackConst.constant = 220
            leadingDefenceConst.constant = 220
            leadingStrengthConst.constant = 220
            leadingConstitutionConst.constant = 220
            trailingMagicConst.constant = 220
            trailingPrayerConst.constant = 220
            trailingRagnedConst.constant = 220
            trailingSummoningConst.constant = 220
        }
    }
    
    func updateUserData() {
        store.fetchUserData() {
            (result) in
            
            switch result {
            case let .success(userData):
                StatsVC.user = userData
                self.updating = false
            case .failure:
                print("Failed to Fetch User Data")
                self.updating = false
                // Show Alert Here
                let errorMessage = "The user either doesn't exist, has been offline for a while, or has privacy enabled."
                let ac = UIAlertController(title: "User Not Found", message: errorMessage, preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                ac.addAction(closeAction)
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    func updateUserAvatar() {
        store.fetchUserAvatar() {
            (result) in
            
            switch result {
            case let .success(avatar):
                self.profileImage.image = avatar
                Global.cachedUserAvatar = avatar
            case .failure:
                print("Failed to Fetch User Avatar")
            }
        }
    }
    
    func updateViewData() {
        usernameLabel.text = localUser.name
        
        let combatLevelText = NSMutableAttributedString()
        combatLevelText.bold("Combat Level: ")
        combatLevelText.normal("\(localUser.combatlevel)")
        combatLevelLabel.attributedText = combatLevelText
        
        combatSkills["attack"]! = localUser.getSkill(id: 0)["level"]!
        combatSkills["strength"]! = localUser.getSkill(id: 2)["level"]!
        combatSkills["defence"]! = localUser.getSkill(id: 1)["level"]!
        combatSkills["ranged"]! = localUser.getSkill(id: 4)["level"]!
        combatSkills["magic"]! = localUser.getSkill(id: 6)["level"]!
        combatSkills["const"]! = localUser.getSkill(id: 3)["level"]!
        combatSkills["prayer"]! = localUser.getSkill(id: 5)["level"]!
        combatSkills["summon"]! = localUser.getSkill(id: 23)["level"]!
    }
    
    func startLoading() {
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        view.addSubview(activityIndicator);
        
        activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Clicked!")
        Global.username = (searchBar.text?.replacingOccurrences(of: " ", with: "_")) ?? Global.username
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
        updateUserData()
        updateUserAvatar()
        updating = true
        if interstitial.isReady && !Global.adShown {
            self.interstitial.present(fromRootViewController: self)
            Global.adShown = true
        } else {
            print("Ad wasn't ready or has already been shown")
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tapGesture.isEnabled = true
        return true
    }
    
    func updateCombatLevel() {
        let att = combatSkills["attack"]!
        let str = combatSkills["strength"]!
        let def = combatSkills["defence"]!
        let range = combatSkills["ranged"]!
        let magic = combatSkills["magic"]!
        let const = combatSkills["const"]!
        let pray = combatSkills["prayer"]!
        let summ = combatSkills["summon"]!
        
        attackLevelLabel.text = "\(att)"
        strengthLevelLabel.text = "\(str)"
        defenceLevelLabel.text = "\(def)"
        rangedLevelLabel.text = "\(range)"
        magicLevelLabel.text = "\(magic)"
        constLevelLabel.text = "\(const)"
        prayerLevelLabel.text = "\(pray)"
        summonLevelLabel.text = "\(summ)"
        
        var max = 0
        
        if (att > str && att > range && att > magic) || (str > range && str > magic) {
            // Add strength and attack
            max = att + str
        } else if range > magic {
            // Double range
            max = range * 2
        } else {
            // Double magic
            max = magic * 2
        }
        
        let product: Double = (13/10) * Double(max) + Double(def) + Double(const) + Double(pray / 2) + Double(summ / 2)
        
        let result = product / 4
        
        calculatedCombatLevelLabel.text = "\(Int(result))"
    }
}