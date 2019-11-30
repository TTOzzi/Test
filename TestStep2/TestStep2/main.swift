//
//  main.swift
//  TestStep2
//
//  Created by TTOzzi on 2019/11/29.
//  Copyright © 2019 TTOzzi. All rights reserved.
//
import Foundation

struct Hitter {
    let number: Int
    let name: String
    var h: Double
}

struct Team {
    let teamName: String
    var players: [Hitter]
}

func main() {
    var teams = [Team]()
    while true {
        print("신나는 야구시합\n1. 데이터 입력\n2. 데이터 출력\n")
        print("메뉴 선택 (1 - 2)")
        let input = readLine()!
        if input == "1", teams.count == 0 {
            teams = inputData()
        } else if input == "1" {
            print("이미 데이터를 입력하셨습니다.\n")
        } else if input == "2", teams.count == 0 {
            print("출력 할 데이터가 없습니다.\n")
        } else if input == "2" {
            printData(teams)
            break
        } else {
            print("잘못된 값을 입력하셨습니다.\n")
        }
    }
}

func inputData() -> [Team] {
    var ret = [Team]()
    for i in 1...2 {
        print("\(i)팀의 이름을 입력하세요>")
        let teamName = readLine()!
        var players = [Hitter]()
        for j in 1...9 {
            print("\(j)번 타자 정보 입력>")
            let input = readLine()!.components(separatedBy: ", ")
            players.append(Hitter(number: j, name: input[0], h: Double(input[1])!))
        }
        ret.append(Team(teamName: teamName, players: players))
    }
    print("팀 데이터 입력이 완료되었습니다\n")
    return ret
}

func printData(_ team: [Team]) {
    team.forEach {
        print("\($0.teamName) 팀 정보")
        $0.players.forEach {
            print("\($0.number)번 \($0.name), \($0.h)")
        }
        print("\n")
    }
}

main()
