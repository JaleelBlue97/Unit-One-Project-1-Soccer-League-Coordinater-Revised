/*
 Attemps to represent the internal state of a class named league that
 is needs to be instantiated with an array of player object references
 this interal states carries out specific task through the use of its various methods
 */

/*
 Takes in an array of players and sorts them by height
 */
func sortPlayersByHeight(players: [[String : String]]) -> [[String : String]] {
    var sortedHeights : [Double] = []
    var sortedPlayers : [[String : String]] = []
    
    // iterate through players and add the heights to sortedHeights
    for player in players {
        let height = Double(player["height"]!)!
        if sortedHeights.contains(height){
            continue
        } else {
            sortedHeights.append(height)
        }
    }
    
    sortedHeights.sort(by: >)
    
    // iterate through sortedHeights and assign the items in players
    // to sortedPlayers in the order that their height values match the values
    // in sortedHeights
    
    for height in sortedHeights {
        let strHeight = String(height)
        for player in players {
            if strHeight == player["height"]{
                sortedPlayers.append(player)
            }
        }
    }
    
    return sortedPlayers
    
    
}



/*
 Takes a team name and a team, and iterates through the team to produce letters
 to the guardians of each player
 */

func composeLettersFrom(team: [[String : String]], for name: String) -> [String]{
    var letters: [String] = []
    switch name {
    case "Sharks":
        // Uses the half open range operator so that index will stop shy of
        // the last index for team since that index contains the dictionary that
        // holds the Average Height of the team and will result in an error
        for index in 0..<team.count - 1 {
            let sharkPlayer = team[index]
            let guardian = sharkPlayer["guardians"]!
            let playerName = sharkPlayer["name"]!
            let letter = "Dear \(guardian) your child \(playerName)"
                + " is on team \(name) so their team meets for practice on " +
            "March 17, 3pm"
            letters.append(letter)
        }
    case "Dragons":
        for index in 0..<team.count - 1 {
            let dragonPlayer = team[index]
            let guardian = dragonPlayer["guardians"]!
            let playerName = dragonPlayer["name"]!
            let letter = "Dear \(guardian) your child \(playerName)"
                + " is on team \(name) so their team meets for practice on " +
            "March 17, 1pm"
            letters.append(letter)
        }
    case "Raptors":
        for index in 0..<team.count - 1 {
            let raptorPlayer = team[index]
            let guardian = raptorPlayer["guardians"]!
            let playerName = raptorPlayer["name"]!
            let letter = "Dear \(guardian) your child \(playerName)"
                + " is on team \(name) so their team meets for practice on " +
            "March 18, 1pm"
            letters.append(letter)
        }
    default: return letters
        
    }
    // Strings are added to the front and back of the letters array so
    // that printing is easier later on
    letters.insert("-----------------\(name)-------------------", at: 0)
    letters.append("-------------------------------------------")
    return letters
}


/*
 Takes a tuple representing teams and returns a tuple
 containing arrays of letters to the guardians of each player
 based on the team the player is on
 */
func makeLetters(from teams: ([[String : String]], [[String : String]],[[String : String]]))
    -> ([String], [String], [String])
{
    
    let sharks = teams.0
    let dragons = teams.1
    let raptors = teams.2
    
    let sharkLetters : [String] = composeLettersFrom(team: sharks, for: "Sharks")
    let dragonLetters : [String] = composeLettersFrom(team: dragons, for: "Dragons")
    let raptorLetters : [String] = composeLettersFrom(team: raptors, for: "Raptors")
    
    return (sharkLetters, dragonLetters, raptorLetters)
    
}


/*
 Takes in a tuple containing letters and outputs them
 */
func outputLetters(letters : ([String], [String], [String])){
    let sharkLetters = letters.0
    let dragonLetters = letters.1
    let raptorLetters = letters.2
    
    for letter in sharkLetters{
        print(letter)
    }
    
    for letter in dragonLetters{
        print(letter)
    }
    
    for letter in raptorLetters{
        print(letter)
    }
}

/*
 Takes in a team and returns the average height
 */
func getAverageHeight(from team: [[String: String]]) -> Double {
    var average = 0.0
    for player in team{
        let height = player["height"]!
        average += Double(height)!
    }
    
    return average / Double(team.count)
}

/*
 takes in a string and returns a report of the average height of that team
 */
func reportAverageHeightFor(team: [[String : String]], name: String) -> String{
    let averageHeight = team[team.count - 1]["Average Height"]!
    
    return "Team \(name) = \(averageHeight)"
}

/*
 References a set of given players within a league and returns two arrays
 one that holds experienced players and one that holds inexperienced players
 */
func sortByExperience(from players: [[String : String]] ) -> ([[String : String]], [[String : String]]){
    var experienced: [[String : String]] = []
    var inexperienced: [[String : String]] = []
    
    for player in players{
        let isExperienced = player["experienced"]!
        if isExperienced == "true"{
            experienced.append(player)
        } else {
            inexperienced.append(player)
        }
    }
    return (experienced, inexperienced)
}

/*
 Takes in an Array of players each represented by a dictionary and returns
 a tuple containing three arrays each representing a team made from the players, such
 that each team contains the same number of experienced players
 */
func makeTeamFrom(_ experienced: [[String : String]] , _ inexperienced: [[String : String]],
                  numberOfTeams: Int) -> ([[String : String]], [[String : String]],
    [[String : String]]){
        
        let sortedExperienced = sortPlayersByHeight(players: experienced)
        let sortedInExperienced = sortPlayersByHeight(players: inexperienced)
        
        var sharks: [[String: String]] = []
        var dragons: [[String: String]] = []
        var raptors: [[String: String]] = []
        
        let players = [sharks, dragons, raptors]
        
        for index in 0..<sortedExperienced.count{
            if index % players.count == 0 {
                sharks.append(sortedExperienced[index])
            }
            else if index % players.count == 1 {
                dragons.append(sortedExperienced[index])
            }
            else if index % players.count > 1 {
                raptors.append(sortedExperienced[index])
            }
        }
        
        // iterates through sortedInExperienced backwards so that the shortest
        // inexperienced players, are first assigned to sharks then dragons, then
        // raptors. so that the difference in the average heigth between the sharks and raptors
        // may be mitigated
        var index = sortedInExperienced.count - 1
        for _ in 0..<sortedInExperienced.count {
            if index % players.count == 0 {
                raptors.append(sortedInExperienced[index])
            }
            else if index % players.count == 1 {
                dragons.append(sortedInExperienced[index])
            }
            else if index % players.count > 1 {
                sharks.append(sortedInExperienced[index])
            }
            
            index -= 1
        }
        
        sharks.append(["Average Height" : String(getAverageHeight(from: sharks))])
        dragons.append(["Average Height" : String(getAverageHeight(from: dragons))])
        raptors.append(["Average Height" : String(getAverageHeight(from: raptors))])
        
        
        return (sharks, dragons, raptors)
}
/*
 Makes an array dictionaries that represent each player
 */
var league: [[String: String]] = [["name" : "Joe Smith", "height" : "42.0",
                                   "experienced" : "true", "guardians" : "Jim and Jan smith"],
                                  ["name": "Jill Tanner" , "height": "36.0", "experienced": "true" , "guardians": "Clara Tanner" ],
                                  ["name": "Bill Bon" , "height": "43.0", "experienced": "true" , "guardians": "Sara and Jenny Bon"],
                                  ["name": "Eva Gordon" , "height": "45.0", "experienced": "false", "guardians": "Wendy and Mike Gordon" ],
                                  ["name": "Matt Gill" , "height": "40.0", "experienced": "false" , "guardians": "Charles and Sylvia Gill"],
                                  ["name": "Kimmy Stein" , "height": "41.0", "experienced": "false" , "guardians": "Bill and Hillary Stein" ],
                                  ["name": "Sammy Adams", "height": "45.0", "experienced": "false" , "guardians": "Jeff Adams" ],
                                  ["name": "Karl Saygan" , "height": "42.0", "experienced": "true", "guardians": "Heather Bledsoe"],
                                  ["name": "Suzane Greenberg", "height": "44.0", "experienced": "true", "guardians": "Henrietta Dumas" ],
                                  ["name": "Sal Dall", "height": "41.0", "experienced": "false", "guardians": "Gala Dall"],
                                  ["name": "Joe Kavaller" , "height": "39.0", "experienced": "false", "guardians": "Sam and Elaine Kavaller" ],
                                  ["name": "Ben Finkelstein" , "height": "44.0", "experienced": "false" , "guardians": "Aaron and Jill Finkelstein" ],
                                  ["name": "Diego Soto" , "height": "41.0", "experienced": "true", "guardians": "Robin and Sarika Soto"],
                                  ["name": "Chole Alaska", "height": "47.0", "experienced": "false" , "guardians": "David and Jamie Alaska" ],
                                  ["name": "Arnold Willis" , "height": "43.0", "experienced": "false" , "guardians": "Clair Willis"],
                                  ["name": "Phillip Helm", "height": "44.0", "experienced": "true" , "guardians": "Thomas Helm and Eva Jones"],
                                  ["name": "Les Clay" , "height": "42.0", "experienced": "true", "guardians": "Wyonna Brown" ],
                                  ["name": "Herschel Krustofski", "height": "45.0", "experienced": "true", "guardians": "Hyman and Rachel Krustofski" ]]

// represents the set of experienced and inexperienced players
var experiencedPlayers: [[String : String]] = []
var inExperiencedPlayers: [[String : String]] = []

// represent each team
var sharks: [[String: String]] = []
var dragons: [[String : String]] = []
var raptors: [[String: String]] = []


// sort the league of players by height so that distribution between experienced and
// inexperinced players may occur the intention is to represent the use method in a class
// that would sort the given instances of a player class that will be stored in a field
// of the class league
league = sortPlayersByHeight(players: league)

// uses the function sortByExperience to assign experienced players
// to the experiencedPlayers and in experienced players to inExperiencedPlayers
// I think of this being akin to using a method in the constructor for league
// that would reference a field dedicated to all of the players and assign fields
// within itsself that would represent experienced players and inexperienced players
let sortedPlayerPool = sortByExperience(from: league)
experiencedPlayers = sortedPlayerPool.0
inExperiencedPlayers = sortedPlayerPool.1

// reassigns the sharks, dragons, and raptors with the result
// of using the function makeTeam which acts like a method
// that would reference three fields in the class each holding
// a different team name and assigns players to those teams
let teams = makeTeamFrom( experiencedPlayers, inExperiencedPlayers, numberOfTeams: 3)
sharks = teams.0
dragons = teams.1
raptors = teams.2


// The code above acts like the internal state of an object
// code from this point acts as if the user created an instance
// of the class league with instances of the player class as arguments that the
// constructor of league would use

// if we wanted to use display the letters of  each team we use a method
// the following code attemps to model that
outputLetters(letters: makeLetters(from: (sharks, dragons, raptors)))

// represents a method that would be present in the league class
// that would print out the average height of each team on demand
print("-----------------Average Height-------------------")
print(reportAverageHeightFor(team: sharks, name: "Sharks"))
print(reportAverageHeightFor(team: dragons, name: "Dragons"))
print(reportAverageHeightFor(team: raptors, name: "Raptors"))
