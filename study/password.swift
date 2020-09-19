//
//  password.swift
//  study
//
//  Created by 渡辺奈央騎 on 2020/08/19.
//  Copyright © 2020 渡辺奈央騎. All rights reserved.
//

import UIKit

func wordSearcher(a:Int, b:Int, c:Bool) -> String {

    if c == true {
        
        let num = (a+b)%65+1
        
        switch num {
        case 1:
            return "a"

        case 2:
            return "b"

        case 3:
            return "c"

        case 4:
            return "d"

        case 5:
            return "e"

        case 6:
            return "f"

        case 7:
            return "g"

        case 8:
            return "h"

        case 9:
            return "i"

        case 10:
            return "j"

        case 11:
            return "k"

        case 12:
            return "l"

        case 13:
            return "m"

        case 14:
            return "n"

        case 15:
            return "o"

        case 16:
            return "p"

        case 17:
            return "q"
            
        case 18:
            return "r"
            
        case 19:
            return "s"
            
        case 20:
            return "t"
            
        case 21:
            return "u"
            
        case 22:
            return "v"
            
        case 23:
            return "w"
            
        case 24:
            return "x"
            
        case 25:
            return "y"
            
        case 26:
            return "z"
            
        case 27:
            return "A"

        case 28:
            return "B"

        case 29:
            return "C"

        case 30:
            return "D"

        case 31:
            return "E"

        case 32:
            return "F"

        case 33:
            return "G"

        case 34:
            return "H"

        case 35:
            return "I"

        case 36:
            return "J"

        case 37:
            return "K"

        case 38:
            return "L"

        case 39:
            return "M"

        case 40:
            return "N"

        case 41:
            return "O"

        case 42:
            return "P"

        case 43:
            return "Q"
            
        case 44:
            return "R"
            
        case 45:
            return "S"
            
        case 46:
            return "T"
            
        case 47:
            return "U"
            
        case 48:
            return "V"
            
        case 49:
            return "W"
            
        case 50:
            return "X"
            
        case 51:
            return "Y"
            
        case 52:
            return "Z"
            
        case 53:
            return "0"
            
        case 54:
        return "1"
            
        case 55:
        return "2"
            
        case 56:
        return "3"
            
        case 57:
        return "4"
            
        case 58:
        return "5"
            
        case 59:
        return "6"
            
        case 60:
        return "7"
            
        case 61:
        return "8"
            
        case 62:
        return "9"
            
        case 63:
        return "@"
            
        case 64:
        return "#"
            
        case 65:
        return "&"

        default:
            return "ERROR1"
        }

    }else{
        
        let num = (a+b)%77+1
        
        
        switch num {
        case 1:
            return "あ"

        case 2:
            return "い"

        case 3:
            return "う"

        case 4:
            return "え"

        case 5:
            return "お"

        case 6:
            return "か"

        case 7:
            return "き"

        case 8:
            return "く"

        case 9:
            return "け"

        case 10:
            return "こ"

        case 11:
            return "さ"

        case 12:
            return "し"

        case 13:
            return "す"

        case 14:
            return "せ"

        case 15:
            return "そ"

        case 16:
            return "た"

        case 17:
            return "ち"
            
        case 18:
            return "つ"
            
        case 19:
            return "て"
            
        case 20:
            return "と"
            
        case 21:
            return "な"
            
        case 22:
            return "に"
            
        case 23:
            return "ぬ"
            
        case 24:
            return "ね"
            
        case 25:
            return "の"
            
        case 26:
            return "は"
            
        case 27:
            return "ひ"

        case 28:
            return "ふ"

        case 29:
            return "へ"

        case 30:
            return "ほ"

        case 31:
            return "ま"

        case 32:
            return "み"

        case 33:
            return "む"

        case 34:
            return "め"

        case 35:
            return "も"

        case 36:
            return "や"

        case 37:
            return "ゆ"

        case 38:
            return "よ"

        case 39:
            return "ら"

        case 40:
            return "り"

        case 41:
            return "る"

        case 42:
            return "れ"

        case 43:
            return "ろ"
            
        case 44:
            return "わ"
            
        case 45:
            return "を"
            
        case 46:
            return "ん"
            
        case 47:
            return "が"
            
        case 48:
            return "ぎ"
            
        case 49:
            return "ぐ"
            
        case 50:
            return "げ"
            
        case 51:
            return "ご"
            
        case 52:
            return "ざ"

        case 53:
            return "じ"

        case 54:
            return "ず"

        case 55:
            return "ぜ"

        case 56:
            return "ぞ"

        case 57:
            return "だ"

        case 58:
            return "ぢ"

        case 59:
            return "づ"

        case 60:
            return "で"

        case 61:
            return "ど"

        case 62:
            return "ば"

        case 63:
            return "び"
            
        case 64:
            return "ぶ"
            
        case 65:
            return "べ"
            
        case 66:
            return "ぼ"
            
        case 67:
            return "ぱ"
            
        case 68:
            return "ぴ"
            
        case 69:
            return "ぷ"
            
        case 70:
            return "ぺ"
            
        case 71:
            return "ぽ"
            
        case 72:
            return "ゃ"
            
        case 73:
            return "ゅ"
            
        case 74:
            return "ょ"
            
        case 75:
            return "っ"
            
        case 76:
            return "ゐ"
            
        case 77:
            return "ゑ"

        default:
            return "ERROR2 \(num)"
        }
        
    }
}

extension Int{
    
    /****偶数だった場合、return TRUE****/
    func judge_num_To_Even_OR_Odd() -> Bool {
        
        if self%2 == 0 {
            return true
        }
        
        return false
    }
    
}

func capital1(input: Int)->String{

    let a = (input%10000)/100
    let b = input%100
    let c:Bool = (input/100000).judge_num_To_Even_OR_Odd()
    
    return wordSearcher(a: a, b: b, c: c)
}

func capital2(input: Int)->String{

    let a = (input/100000)*10 + (input/1000)%10
    let b = (input%1000)/10
    let c:Bool = (input/10).judge_num_To_Even_OR_Odd()
    
    return wordSearcher(a: a, b: b, c: c)
}

func capital3(input: Int)->String{

    let a = (((input/1000))%10)*10 + (input/10000)%10
    let b = ((input%100)/10)*5 + input/5000
    let c:Bool = (input/100).judge_num_To_Even_OR_Odd()
    
    return wordSearcher(a: a, b: b, c: c)
}

func capital4(input: Int)->String{

    let a = (input/300)%100
    let b = (input/5000)%323
    let c:Bool = ((((input/1000))%10)*10 + (input/10000)%10).judge_num_To_Even_OR_Odd()
    
    return wordSearcher(a: a, b: b, c: c)
}

func capital5(input: Int)->String{

    let a = (input/30000 + input/1719)%100
    let b = (((input%100)/10)*5 + input/5000)*4/5
    let c:Bool = (((input%100)/10)*5 + input/5000).judge_num_To_Even_OR_Odd()
    
    return wordSearcher(a: a, b: b, c: c)
}

func capital6(input: Int)->String{

    let a = (input/30000 + input/323)%100
    let b = ((input%100)/9)*4 + input/5000
    let c:Bool = ((input/100000)*10 + (input/1000)%10).judge_num_To_Even_OR_Odd()
    
    return wordSearcher(a: a, b: b, c: c)
}

