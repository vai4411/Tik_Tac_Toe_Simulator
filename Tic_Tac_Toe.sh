#!/bin/bash -x
echo "Welcome to Tic Tac Toe Game"

#constant
one=1
two=2
three=3
four=4
five=5
six=6
seven=7
eight=8
nine=9

#variable
boardPosition=0
toss=0
choice=0
player=""
computer=""
computerChoice=0
chooseBoardPosition=0
computerBoardPosition=0
turn=0
turnCheck=0
value=""
count=0
win=0
winMove=0

declare -a available

declare -a board

#function for print board
function printBoard() {
	echo " ${board[$one]} | ${board[$two]} | ${board[$three]}"
	echo "-----------"
	echo " ${board[$four]} | ${board[$five]} | ${board[$six]}"
	echo "-----------"
	echo -e " ${board[$seven]} | ${board[$eight]} | ${board[$nine]}\n"
}

#change position available for showing position is already occupied
function turnavailable() {
	board[$chooseBoardPosition]=$1
	printBoard
	available[$chooseBoardPosition]=1
}

#taking user input
function takePlayerInput() {
	read -p "Enter the choice:" chooseBoardPosition
}

function playerMove() {
	turnavailable $player
	turn=1
}

#using random function generate computer input
function takeComputerInput() {
	computerBoardPosition=$((RANDOM % 9 + 1))
	chooseBoardPosition=$computerBoardPosition
}

function computerMove() {
	turnavailable $computer
	turn=0
}

#player choose option
function playerChooseOption() {
	read -p "Enter letter X or O:" choice
	player=$choice
	if [[ $choice == "X" ]]
	then
		computer="O"
	else
		computer="X"
	fi
	takePlayerInput
	playerMove
}

#computer choose option
function computerChooseOption() {
	computerChoice=$((RANDOM % 2))
	if [ $computerChoice -eq 1 ]
	then
		computer="X"
		player="O"
	else
		computer="O"
		player="X"
	fi
	takeComputerInput
	computerMove
	echo -e "Computer choose $chooseBoardPosition\n"
}

#toss for check who plays first
function playFirst() {
	toss=$((RANDOM % 2))
	if [ $toss -eq $one ]
	then
		echo "Player win the toss"
		playerChooseOption
	else
		echo "Computer win the toss"
		computerChooseOption
	fi
}

function testCondition() {
	[[ "${board[$1]}" == "$value" ]] && [[ "${board[$2]}" == "$value" ]] && [[ "${board[$3]}" == "$value" ]]
}

#all winning conditions
function winCondition() {
	if ( testCondition $one $two $three ) || ( testCondition $four $five $six ) || ( testCondition $seven $eight $nine ) || 
		( testCondition $one $four $seven ) || ( testCondition $two $five $eight ) || ( testCondition $three $six $nine ) ||
		( testCondition $one $five $nine ) || ( testCondition $three $five $seven )
	then
		win=1
	fi
}

#display winning moves for player
function winningMove() {
	for (( boardPosition=1 ; boardPosition<=9 ; boardPosition++ ))
	do
		if [ ${available[$boardPosition]} -eq 0 ]
		then
			board[$boardPosition]=$player
			value=$player
			winCondition
			if [ $win -eq 1 ]
			then
				win=0
				echo "Choose $boardPosition for win"
				break
			fi
			board[$boardPosition]=$boardPosition
		fi
	done
}

#display computer win block moves
function blockMove() {
	for (( boardPosition=1 ; boardPosition<=9 ; boardPosition++ ))
	do
		if [ ${available[$boardPosition]} -eq 0 ]
		then
			board[$boardPosition]=$computer
			value=$computer
			winCondition
			if [ $win -eq 1 ]
			then
				board[$boardPosition]=$boardPosition
				win=0
				echo "Choose $boardPosition for block"
				break
			fi
			board[$boardPosition]=$boardPosition
		fi
	done
}

#check player or computer win
function checkWin() {
	value=$1
	win=0
	winCondition
	if [ $win -eq 1 ]
	then
		if [[ "$value" == "$player" ]] 
		then
			echo "Player wins..."
			exit
		else
			echo "Computer wins..."
			exit
		fi
	fi
}

#display available corner
function availablePosition() {
	for (( boardPosition=1 ; boardPosition<=9 ; boardPosition++ ))
	do
		if [ ${available[$boardPosition]} -eq 0 ]
		then
			if [ ${available[$one]} -eq 0 ] || [ ${available[$three]} -eq 0 ] || [ ${available[$seven]} -eq 0 ] || [ ${available[$nine]} -eq 0 ]
			then
				echo "corner $boardPosition is available"
			elif [ ${available[$five]} -eq 0 ]
			then
				echo "center 5 is available"
			elif [ ${available[$two]} -eq 0 ] || [ ${available[$four]} -eq 0 ] || [ ${available[$six]} -eq 0 ] || [ ${available[$eight]} -eq 0 ]
			then
				echo "side $boardPosition in available"
			fi
		fi
	done 
}

function nextInput() {
	if [ $turnCheck -eq 0 ]
	then
		takePlayerInput
	else
		takeComputerInput
	fi
}

function nextMove() {
	if [ $turnCheck -eq 0 ]
	then
		playerMove
	else
		computerMove
	fi
}

#checking every moves of player and computer
function checkMove() {
	turnCheck=$turn
	nextInput
	if [ ${available[$chooseBoardPosition]} -eq 0 ]
	then
		nextMove
	else
		while [ ${available[$chooseBoardPosition]} -ne 0 ]
		do
			nextInput
		done 
		nextMove
	fi
}

#play player and computer moves
function main() {
	for (( boardPosition=1 ; boardPosition<=9 ; boardPosition++ ))
	do
		available[$boardPosition]=0
	done
	for (( boardPosition=1 ; boardPosition<=9 ; boardPosition++ ))
	do
		board[$boardPosition]=$boardPosition
	done
	playFirst
	while [ $count -lt $eight ]
	do
		if [ $turn -eq 0 ]
		then
			checkMove
			checkWin $player
		else
			checkMove
			echo -e "Computer choose $chooseBoardPosition\n"
		fi
		count=$(($count + 1))
		checkWin $computer
		winningMove
		blockMove
		if [ $count -gt $six ]
		then
			availablePosition
		fi
	done
	echo "Draw Game..."
}

#calling main function
main
