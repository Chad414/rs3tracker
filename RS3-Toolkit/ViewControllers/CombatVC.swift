//
//  CombatVC.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/15/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import UIKit

class CombatVC: UIViewController, UISearchBarDelegate {

    //@IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var combatLevelLabel: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var combatLevelTitle: UILabel!
    
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
    
    @IBOutlet var attackSubConst: NSLayoutConstraint!
    @IBOutlet var attackAddConst: NSLayoutConstraint!
    @IBOutlet var strengthSubConst: NSLayoutConstraint!
    @IBOutlet var strengthAddConst: NSLayoutConstraint!
    @IBOutlet var defenceSubConst: NSLayoutConstraint!
    @IBOutlet var defenceAddConst: NSLayoutConstraint!
    @IBOutlet var constSubConst: NSLayoutConstraint!
    @IBOutlet var constAddConst: NSLayoutConstraint!
    @IBOutlet var rangedSubConst: NSLayoutConstraint!
    @IBOutlet var rangedAddConst: NSLayoutConstraint!
    @IBOutlet var magicSubConst: NSLayoutConstraint!
    @IBOutlet var magicAddConst: NSLayoutConstraint!
    @IBOutlet var prayerSubConst: NSLayoutConstraint!
    @IBOutlet var prayerAddConst: NSLayoutConstraint!
    @IBOutlet var summonSubConst: NSLayoutConstraint!
    @IBOutlet var summonAddConst: NSLayoutConstraint!
    
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
    
    // Skill Labels
    @IBOutlet var attackLabel: UILabel!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var defenceLabel: UILabel!
    @IBOutlet var constLabel: UILabel!
    @IBOutlet var rangedLabel: UILabel!
    @IBOutlet var magicLabel: UILabel!
    @IBOutlet var prayerLabel: UILabel!
    @IBOutlet var summoningLabel: UILabel!
    
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
        guard combatSkills["const"]! > 10 else {
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
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*if Global.darkMode {
            self.view.backgroundColor = UIColor.black
            //self.view.backgroundColor = Global.darkBackgroundColor
            
            // Make Labels White
            combatLevelLabel.textColor = UIColor.white
            combatLevelTitle.textColor = UIColor.white
            calculatedCombatLevelLabel.textColor = UIColor.white
            attackLevelLabel.textColor = UIColor.white
            strengthLevelLabel.textColor = UIColor.white
            defenceLevelLabel.textColor = UIColor.white
            constLevelLabel.textColor = UIColor.white
            rangedLevelLabel.textColor = UIColor.white
            magicLevelLabel.textColor = UIColor.white
            prayerLevelLabel.textColor = UIColor.white
            summonLevelLabel.textColor = UIColor.white
            
            attackLabel.textColor = UIColor.white
            strengthLabel.textColor = UIColor.white
            defenceLabel.textColor = UIColor.white
            constLabel.textColor = UIColor.white
            rangedLabel.textColor = UIColor.white
            magicLabel.textColor = UIColor.white
            prayerLabel.textColor = UIColor.white
            summoningLabel.textColor = UIColor.white
        } else {
            self.view.backgroundColor = Global.backgroundColor
            
            combatLevelLabel.textColor = UIColor.black
            combatLevelTitle.textColor = UIColor.black
            calculatedCombatLevelLabel.textColor = UIColor.black
            attackLevelLabel.textColor = UIColor.black
            strengthLevelLabel.textColor = UIColor.black
            defenceLevelLabel.textColor = UIColor.black
            constLevelLabel.textColor = UIColor.black
            rangedLevelLabel.textColor = UIColor.black
            magicLevelLabel.textColor = UIColor.black
            prayerLevelLabel.textColor = UIColor.black
            summonLevelLabel.textColor = UIColor.black
            
            attackLabel.textColor = UIColor.black
            strengthLabel.textColor = UIColor.black
            defenceLabel.textColor = UIColor.black
            constLabel.textColor = UIColor.black
            rangedLabel.textColor = UIColor.black
            magicLabel.textColor = UIColor.black
            prayerLabel.textColor = UIColor.black
            summoningLabel.textColor = UIColor.black
        }*/
        
        self.tabBarController?.navigationItem.searchController?.searchBar.delegate = self
        
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        
        if Global.cachedUserData != nil {
            LogVC.user = Global.cachedUserData!
            updateViewData()
        } else {
            updateUserData()
            updating = true
        }
        
        if Global.cachedUserAvatar != nil {
            //profileImage.image = Global.cachedUserAvatar!
        } else {
            updateUserAvatar()
        }
        
        if Global.displayIsCompact() {
            combatLevelConst.constant = 50
            leftSkillsConst.constant = 40
            rightSkillsConst.constant = 40
            
            attackStrengthConst.constant = 10
            strengthDefenceConst.constant = 10
            defenceConstitutionConst.constant = 10
            rangedMagicConst.constant = 10
            magicPrayerConst.constant = 10
            prayerSummoningConst.constant = 10
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let trailingLeadingConst = CGFloat(240.0)
            leadingAttackConst.constant = trailingLeadingConst
            leadingDefenceConst.constant = trailingLeadingConst
            leadingStrengthConst.constant = trailingLeadingConst
            leadingConstitutionConst.constant = 220
            trailingMagicConst.constant = trailingLeadingConst
            trailingPrayerConst.constant = trailingLeadingConst
            trailingRagnedConst.constant = trailingLeadingConst
            trailingSummoningConst.constant = 218
        
            leftSkillsConst.constant = 120
            rightSkillsConst.constant = 120
            
            calculatedCombatLevelLabel.font = calculatedCombatLevelLabel.font.withSize(CGFloat(64.0))
            combatLevelTitle.font = combatLevelTitle.font.withSize(CGFloat(32.0))
            
            let skillLabelFontSize = CGFloat(28.0)
            attackLabel.font = attackLabel.font.withSize(skillLabelFontSize)
            strengthLabel.font = strengthLabel.font.withSize(skillLabelFontSize)
            defenceLabel.font = defenceLabel.font.withSize(skillLabelFontSize)
            constLabel.font = constLabel.font.withSize(skillLabelFontSize)
            rangedLabel.font = rangedLabel.font.withSize(skillLabelFontSize)
            magicLabel.font = magicLabel.font.withSize(skillLabelFontSize)
            prayerLabel.font = prayerLabel.font.withSize(skillLabelFontSize)
            summoningLabel.font = summoningLabel.font.withSize(skillLabelFontSize)
            
            let skillLevelLabelFontSize = CGFloat(24.0)
            attackLevelLabel.font = attackLevelLabel.font.withSize(skillLevelLabelFontSize)
            strengthLevelLabel.font = strengthLevelLabel.font.withSize(skillLevelLabelFontSize)
            defenceLevelLabel.font = defenceLevelLabel.font.withSize(skillLevelLabelFontSize)
            constLevelLabel.font = constLevelLabel.font.withSize(skillLevelLabelFontSize)
            rangedLevelLabel.font = rangedLevelLabel.font.withSize(skillLevelLabelFontSize)
            magicLevelLabel.font = magicLevelLabel.font.withSize(skillLevelLabelFontSize)
            prayerLevelLabel.font = prayerLevelLabel.font.withSize(skillLevelLabelFontSize)
            summonLevelLabel.font = summonLevelLabel.font.withSize(skillLevelLabelFontSize)
            
            attackSubConst.constant = 8.0
            attackAddConst.constant = 8.0
            strengthSubConst.constant = 8.0
            strengthAddConst.constant = 8.0
            defenceSubConst.constant = 8.0
            defenceAddConst.constant = 8.0
            constSubConst.constant = 8.0
            constAddConst.constant = 8.0
            rangedSubConst.constant = 8.0
            rangedAddConst.constant = 8.0
            magicSubConst.constant = 8.0
            magicAddConst.constant = 8.0
            prayerSubConst.constant = 8.0
            prayerAddConst.constant = 8.0
            summonSubConst.constant = 8.0
            summonAddConst.constant = 8.0
            
            updateLayoutFor97iPad()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            updateLayoutFor97iPad()
        }
    }
    
    func updateLayoutFor97iPad() { // This function should only get called when device is an iPad
        if UIDevice.current.orientation != UIDeviceOrientation.portrait && UIDevice.current.orientation != UIDeviceOrientation.portraitUpsideDown {
            if Global.deviceIs97InchiPad() {
                guard leftSkillsConst != nil && rightSkillsConst != nil else { return }
                leftSkillsConst.constant = 60
                rightSkillsConst.constant = 60
            } else { // Device is Large iPad
                guard leadingAttackConst != nil,
                    leadingDefenceConst != nil,
                    leadingStrengthConst != nil,
                    leadingConstitutionConst != nil,
                    trailingMagicConst != nil,
                    trailingPrayerConst != nil,
                    trailingRagnedConst != nil,
                    trailingSummoningConst != nil else { return }
                
                let trailingLeadingConst = CGFloat(450.0)
                leadingAttackConst.constant = trailingLeadingConst
                leadingDefenceConst.constant = trailingLeadingConst
                leadingStrengthConst.constant = trailingLeadingConst
                leadingConstitutionConst.constant = 430
                trailingMagicConst.constant = trailingLeadingConst
                trailingPrayerConst.constant = trailingLeadingConst
                trailingRagnedConst.constant = trailingLeadingConst
                trailingSummoningConst.constant = 432
            }
        } else {
            if Global.deviceIs97InchiPad() {
                guard leftSkillsConst != nil && rightSkillsConst != nil else { return }
                leftSkillsConst.constant = 120
                rightSkillsConst.constant = 120
            } else { // Device is Large iPad
                guard leadingAttackConst != nil,
                    leadingDefenceConst != nil,
                    leadingStrengthConst != nil,
                    leadingConstitutionConst != nil,
                    trailingMagicConst != nil,
                    trailingPrayerConst != nil,
                    trailingRagnedConst != nil,
                    trailingSummoningConst != nil else { return }
                
                let trailingLeadingConst = CGFloat(240.0)
                leadingAttackConst.constant = trailingLeadingConst
                leadingDefenceConst.constant = trailingLeadingConst
                leadingStrengthConst.constant = trailingLeadingConst
                leadingConstitutionConst.constant = 220
                trailingMagicConst.constant = trailingLeadingConst
                trailingPrayerConst.constant = trailingLeadingConst
                trailingRagnedConst.constant = trailingLeadingConst
                trailingSummoningConst.constant = 218
            }
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
                //self.profileImage.image = avatar
                Global.cachedUserAvatar = avatar
            case .failure:
                print("Failed to Fetch User Avatar")
            }
        }
    }
    
    func updateViewData() {
        self.tabBarController?.title = localUser.name
        
        let combatLevelText = NSMutableAttributedString()
        combatLevelText.headerbold("Combat Level: ")
        combatLevelText.header("\(localUser.combatlevel)")
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
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        timer = Timer.scheduledTimer(timeInterval: 8, target: self,   selector: (#selector(failedToFetchData)), userInfo: nil, repeats: true)
        
    }
    
    @objc func failedToFetchData() {
        stopLoading()
        
        Global.cachedUserData = UserData()
        //profileImage.image = UIImage(named: "chadtek.png")
        updateViewData()
        
        let errorMessage = "Please check your internet connection."
        let ac = UIAlertController(title: "No response from server", message: errorMessage, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        ac.addAction(closeAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    func stopLoading() {
        timer.invalidate()
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Clicked!")
        let input = searchBar.text?.replacingOccurrences(of: " ", with: "_") ?? Global.username
        
        if searchBar.text == "" {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.tabBarController?.navigationItem.searchController?.isActive = false
            return
        }
        
        if searchBar.text?.rangeOfCharacter(from: Global.usernameChar.inverted) != nil {
            print("Invalid username")
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.tabBarController?.navigationItem.searchController?.isActive = false
            
            let errorMessage = "Please enter a valid username."
            let ac = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            ac.addAction(closeAction)
            self.present(ac, animated: true, completion: nil)
            
            return
        }
        
        Global.username = input
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tabBarController?.navigationItem.searchController?.isActive = false
        tapGesture.isEnabled = false
        updateUserData()
        updateUserAvatar()
        updating = true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.tabBarController?.navigationItem.searchController?.isActive = false
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
