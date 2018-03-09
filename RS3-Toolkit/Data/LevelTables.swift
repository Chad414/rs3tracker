//
//  LevelTables.swift
//  RS3-Toolkit
//
//  Created by Chad Hamdan on 3/2/18.
//  Copyright © 2018 Chad Hamdan. All rights reserved.
//

import Foundation

struct LevelTables {
    static func getXPForLevel(_ level: Int) -> Int {
        switch level {
        case 1:
            return 0
        case 2:
            return 83
        case 3:
            return 174
        case 4:
            return 276
        case 5:
            return 388
        case 6:
            return 512
        case 7:
            return 650
        case 8:
            return 801
        case 9:
            return 969
        case 10:
            return 1154
        case 11:
            return 1358
        case 12:
            return 1584
        case 13:
            return 1833
        case 14:
            return 2107
        case 15:
            return 2411
        case 16:
            return 2746
        case 17:
            return 3115
        case 18:
            return 3523
        case 19:
            return 3973
        case 20:
            return 4470
        case 21:
            return 5018
        case 22:
            return 5624
        case 23:
            return 6291
        case 24:
            return 7028
        case 25:
            return 7842
        case 26:
            return 8740
        case 27:
            return 9730
        case 28:
            return 10824
        case 29:
            return 12031
        case 30:
            return 13363
        case 31:
            return 14833
        case 32:
            return 16456
        case 33:
            return 18247
        case 34:
            return 20224
        case 35:
            return 22406
        case 36:
            return 24815
        case 37:
            return 27473
        case 38:
            return 30408
        case 39:
            return 33648
        case 40:
            return 37224
        case 41:
            return 41171
        case 42:
            return 45529
        case 43:
            return 50339
        case 44:
            return 55649
        case 45:
            return 61512
        case 46:
            return 67983
        case 47:
            return 75127
        case 48:
            return 83014
        case 49:
            return 91721
        case 50:
            return 101333
        case 51:
            return 111945
        case 52:
            return 123660
        case 53:
            return 136594
        case 54:
            return 150872
        case 55:
            return 166636
        case 56:
            return 184040
        case 57:
            return 203254
        case 58:
            return 224466
        case 59:
            return 247886
        case 60:
            return 273742
        case 61:
            return 302288
        case 62:
            return 333804
        case 63:
            return 368599
        case 64:
            return 407015
        case 65:
            return 449428
        case 66:
            return 496254
        case 67:
            return 547953
        case 68:
            return 605032
        case 69:
            return 668051
        case 70:
            return 737627
        case 71:
            return 814445
        case 72:
            return 899257
        case 73:
            return 992895
        case 74:
            return 1096278
        case 75:
            return 1210421
        case 76:
            return 1336443
        case 77:
            return 1475581
        case 78:
            return 1629200
        case 79:
            return 1798808
        case 80:
            return 1986068
        case 81:
            return 2192818
        case 82:
            return 2421087
        case 83:
            return 2673114
        case 84:
            return 2951373
        case 85:
            return 3258594
        case 86:
            return 3597792
        case 87:
            return 3972294
        case 88:
            return 4385776
        case 89:
            return 4842295
        case 90:
            return 5346332
        case 91:
            return 5902831
        case 92:
            return 6517253
        case 93:
            return 7195629
        case 94:
            return 7944614
        case 95:
            return 8771558
        case 96:
            return 9684577
        case 97:
            return 10692629
        case 98:
            return 11805606
        case 99:
            return 13034431
        case 100:
            return 14391160
        case 101:
            return 15889109
        case 102:
            return 17542976
        case 103:
            return 19368992
        case 104:
            return 21385073
        case 105:
            return 23611006
        case 106:
            return 26068632
        case 107:
            return 28782069
        case 108:
            return 31777943
        case 109:
            return 35085654
        case 110:
            return 38737661
        case 111:
            return 42769801
        case 112:
            return 47221641
        case 113:
            return 52136869
        case 114:
            return 57563718
        case 115:
            return 63555443
        case 116:
            return 70170840
        case 117:
            return 77474828
        case 118:
            return 85539082
        case 119:
            return 94442737
        case 120:
            return 104273167
        case 121:
            return 115126838
        case 122:
            return 127110260
        case 123:
            return 140341028
        case 124:
            return 154948977
        case 125:
            return 171077457
        case 126:
            return 188884740
        case 127:
            return 200000000
        default:
            print("Invalid level patameter")
            return 1
        }
    }
    
    static func getLevelForXP(_ xp: Int) -> Int {
        if xp < 13034431 {
            return 98
        } else if xp < 14391160 {
            return 99
        } else if xp < 15889109 {
            return 100
        } else if xp < 17542976 {
            return 101
        } else if xp < 19368992 {
            return 102
        } else if xp < 21385073 {
            return 103
        } else if xp < 23611006 {
            return 104
        } else if xp < 26068632 {
            return 105
        } else if xp < 28782069 {
            return 106
        } else if xp < 31777943 {
            return 107
        } else if xp < 35085654 {
            return 108
        } else if xp < 38737661 {
            return 109
        } else if xp < 42769801 {
            return 110
        } else if xp < 47221641 {
            return 111
        } else if xp < 52136869 {
            return 112
        } else if xp < 57563718 {
            return 113
        } else if xp < 63555443 {
            return 114
        } else if xp < 70170840 {
            return 115
        } else if xp < 77474828 {
            return 116
        } else if xp < 85539082 {
            return 117
        } else if xp < 94442737 {
            return 118
        } else if xp < 104273167 {
            return 119
        } else if xp < 115126838 {
            return 120
        } else if xp < 127110260 {
            return 121
        } else if xp < 140341028 {
            return 122
        } else if xp < 154948977 {
            return 123
        } else if xp < 171077457 {
            return 124
        } else if xp < 188884740 {
            return 125
        } else if xp < 200000000 {
            return 126
        } else {
            return 126
        }
    }
    
    static func getXPForEliteLevel(_ level: Int) -> Int {
        switch level {
        case 1:
            return 0
        case 2:
            return 830
        case 3:
            return 1861
        case 4:
            return 2902
        case 5:
            return 3980
        case 6:
            return 5126
        case 7:
            return 6390
        case 8:
            return 7787
        case 9:
            return 9400
        case 10:
            return 11275
        case 11:
            return 13605
        case 12:
            return 16372
        case 13:
            return 19656
        case 14:
            return 23546
        case 15:
            return 28138
        case 16:
            return 33520
        case 17:
            return 39809
        case 18:
            return 47109
        case 19:
            return 55535
        case 20:
            return 64802
        case 21:
            return 77190
        case 22:
            return 90811
        case 23:
            return 106221
        case 24:
            return 123573
        case 25:
            return 143025
        case 26:
            return 164742
        case 27:
            return 188893
        case 28:
            return 215651
        case 29:
            return 245196
        case 30:
            return 277713
        case 31:
            return 316311
        case 32:
            return 358547
        case 33:
            return 404634
        case 34:
            return 454796
        case 35:
            return 509259
        case 36:
            return 568254
        case 37:
            return 632019
        case 38:
            return 700797
        case 39:
            return 774834
        case 40:
            return 854383
        case 41:
            return 946227
        case 42:
            return 1044569
        case 43:
            return 1149696
        case 44:
            return 1261903
        case 45:
            return 1381488
        case 46:
            return 1508756
        case 47:
            return 1644015
        case 48:
            return 1787581
        case 49:
            return 1939773
        case 50:
            return 2100917
        case 51:
            return 2283490
        case 52:
            return 2476369
        case 53:
            return 2679907
        case 54:
            return 2894505
        case 55:
            return 3120508
        case 56:
            return 3358307
        case 57:
            return 3608290
        case 58:
            return 3870846
        case 59:
            return 4146374
        case 60:
            return 4435275
        case 61:
            return 4758122
        case 62:
            return 5096111
        case 63:
            return 5449685
        case 64:
            return 5819299
        case 65:
            return 6205407
        case 66:
            return 6608473
        case 67:
            return 7028964
        case 68:
            return 7467354
        case 69:
            return 7924122
        case 70:
            return 8399751
        case 71:
            return 8925664
        case 72:
            return 9472665
        case 73:
            return 10041285
        case 74:
            return 10632061
        case 75:
            return 11245538
        case 76:
            return 11882262
        case 77:
            return 12542789
        case 78:
            return 13227679
        case 79:
            return 13937496
        case 80:
            return 14672812
        case 81:
            return 15478994
        case 82:
            return 16313404
        case 83:
            return 17176661
        case 84:
            return 18069395
        case 85:
            return 18992239
        case 86:
            return 19945833
        case 87:
            return 20930821
        case 88:
            return 21947856
        case 89:
            return 22997593
        case 90:
            return 24080695
        case 91:
            return 25259906
        case 92:
            return 26475754
        case 93:
            return 27728955
        case 94:
            return 29020233
        case 95:
            return 30350318
        case 96:
            return 31719944
        case 97:
            return 33129852
        case 98:
            return 34580790
        case 99:
            return 36073511
        case 100:
            return 37608773
        case 101:
            return 39270442
        case 102:
            return 40978509
        case 103:
            return 42733789
        case 104:
            return 44537107
        case 105:
            return 46389292
        case 106:
            return 48291180
        case 107:
            return 50243611
        case 108:
            return 52247435
        case 109:
            return 54303504
        case 110:
            return 56412678
        case 111:
            return 58575823
        case 112:
            return 60793812
        case 113:
            return 63067521
        case 114:
            return 65397835
        case 115:
            return 67785643
        case 116:
            return 70231841
        case 117:
            return 72737330
        case 118:
            return 75303019
        case 119:
            return 77929820
        case 120:
            return 80618654
        case 121:
            return 83370445
        case 122:
            return 86186124
        case 123:
            return 89066630
        case 124:
            return 92012904
        case 125:
            return 95025896
        case 126:
            return 98106559
        case 127:
            return 101255855
        case 128:
            return 104474750
        case 129:
            return 107764216
        case 130:
            return 111125230
        case 131:
            return 114558777
        case 132:
            return 118065845
        case 133:
            return 121647430
        case 134:
            return 125304532
        case 135:
            return 129038159
        case 136:
            return 132849323
        case 137:
            return 136739041
        case 138:
            return 140708338
        case 139:
            return 144758242
        case 140:
            return 148889790
        case 141:
            return 153104021
        case 142:
            return 157401983
        case 143:
            return 161784728
        case 144:
            return 166253312
        case 145:
            return 170808801
        case 146:
            return 175452262
        case 147:
            return 180184770
        case 148:
            return 185007406
        case 149:
            return 189921255
        case 150:
            return 194927409
        default:
            return 200000000
        }
    }
    
    static func getEliteLevelForXP(_ xp: Int) -> Int {
        if xp < 80618654 {
            return 119
        } else if xp < 83370445 {
            return 120
        } else if xp < 86186124 {
            return 121
        } else if xp < 89066630 {
            return 122
        } else if xp < 92012904 {
            return 123
        } else if xp < 95025896 {
            return 124
        } else if xp < 98106559 {
            return 125
        } else if xp < 101255855 {
            return 126
        } else if xp < 104474750 {
            return 127
        } else if xp < 107764216 {
            return 128
        } else if xp < 111125230 {
            return 129
        } else if xp < 114558777 {
            return 130
        } else if xp < 118065845 {
            return 131
        } else if xp < 121647430 {
            return 132
        } else if xp < 125304532 {
            return 133
        } else if xp < 129038159 {
            return 134
        } else if xp < 132849323 {
            return 135
        } else if xp < 136739041 {
            return 136
        } else if xp < 140708338 {
            return 137
        } else if xp < 144758242 {
            return 138
        } else if xp < 148889790 {
            return 139
        } else if xp < 153104021 {
            return 140
        } else if xp < 157401983 {
            return 141
        } else if xp < 161784728 {
            return 142
        } else if xp < 166253312 {
            return 143
        } else if xp < 170808801 {
            return 144
        } else if xp < 175452262 {
            return 145
        } else if xp < 180184770 {
            return 146
        } else if xp < 185007406 {
            return 147
        } else if xp < 189921255 {
            return 148
        } else if xp < 194927409 {
            return 149
        } else {
            return 150
        }
    }
}
