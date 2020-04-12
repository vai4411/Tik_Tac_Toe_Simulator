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
boardition=0
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

declare -a flag

declare -a board

#function for print board
function printBoard() {
	echo " ${board[$one]} | ${board[$two]} | ${board[$three]}"
	echo "-----------"
	echo " ${board[$four]} | ${board[$five]} | ${board[$six]}"
	echo "-----------"
	echo -e " ${board[$seven]} | ${board[$eight]} | ${board[$nine]}\n"
}

#change position flag for showing position is already occupied
function turnFlag() {
	board[$chooseBoardPosition]=$1
	printBoard
	flag[$chooseBoardPosition]=1
}

#taking user input
function takePlayerInput() {
	read -p "Enter the choice:" chooseBoardPosition
}

function playerMove() {
	turnFlag $player
	turn=1
}

#using random function generate computer input
function takeComputerInput() {
	computerBoardPosition=$((RANDOM % 9 + 1))
	chooseBoardPosition=$computerBoardPosition
}

function computerMove() {
	turnFlag $computer
	turn=0
}

#checking every moves of player and computer
function checkMove() {
	turnCheck=$turn
	if [ $turnCheck -eq 0 ]
	then
		takePlayerInput
	else
		takeComputerInput
	fi
	if [ ${flag[$chooseBoardPosition]} -eq 0 ]
	then
		if [ $turnCheck -eq 0 ]
		then
			playerMove
		else
			computerMove
		fi
	else
		while [ ${flag[$chooseBoardPosition]} -ne 0 ]
		do
			if [ $turnCheck -eq 0 ]
			then
				takePlayerInput
			else
				takeComputerInput
			fi
		done 
		if [ $turnCheck -eq 0 ]
		then 
			playerMove
		else
			computerMove
		fi
	fi
}

#play player and computer moves
function boardMoves() {
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
		if [ $count -gt $one ]
		then
			winningMove
			blockMove
		fi
		if [ $count -gt $six ]
		then
			availablePosition
		fi
	done
	echo "Draw Game..."
}

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

function winCondition() {
	if ([[ "${board[$one]}" == "$value" ]] && [[ "${board[$two]}" == "$value" ]] && [[ "${board[$three]}" == "$value" ]]) ||
		([[ "${board[$four]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$six]}" == "$value" ]]) ||
		([[ "${board[$seven]}" == "$value" ]] && [[ "${board[$eight]}" == "$value" ]] && [[ "${board[$nine]}" == "$value" ]]) ||
		([[ "${board[$one]}" == "$value" ]] && [[ "${board[$four]}" == "$value" ]] && [[ "${board[$seven]}" == "$value" ]]) ||
		([[ "${board[$two]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$eight]}" == "$value" ]]) ||
		([[ "${board[$three]}" == "$value" ]] && [[ "${board[$six]}" == "$value" ]] && [[ "${board[$nine]}" == "$value" ]]) ||
		([[ "${board[$one]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$nine]}" == "$value" ]]) ||
		([[ "${board[$three]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$seven]}" == "$value" ]]) 
	then
		win=1
	fi
}

#display winning moves for player
function winningMove() {
	for (( boardition=1 ; boardition<=9 ; boardition++ ))
	do
		if [ ${flag[$boardition]} -eq 0 ]
		then
			board[$boardition]=$player
			value=$player
			winCondition
			if [ $win -eq 1 ]
			then
				win=0
				echo "Choose $boardition for win"
				break
			fi
			board[$boardition]=$boardition
		fi
	done
}

#display computer win block moves
function blockMove() {
	for (( boardition=1 ; boardition<=9 ; boardition++ ))
	do
		if [ ${flag[$boardition]} -eq 0 ]
		then
			board[$boardition]=$computer
			value=$computer
			winCondition
			if [ $win -eq 1 ]
			then
				board[$boardition]=$boardition
				win=0
				echo "Choose $boardition for block"
				break
			fi
			board[$boardition]=$boardition
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
	if [ ${flag[$one]} -eq 0 ]
	then
		echo "corner 1 is available"
	elif [ ${flag[$three]} -eq 0 ]
	then
		echo "corner 3 is available"
	elif [ ${flag[$seven]} -eq 0 ]
	then
		echo "corner 7 is available"
	elif [ ${flag[$nine]} -eq 0 ]
	then
		echo "corner 9 is available"
	elif [ ${flag[$five]} -eq 0 ]
	then
		echo "center 5 is available"
	elif [ ${flag[$two]} -eq 0 ]
	then
		echo "side 2 is available"
	elif [ ${flag[$four]} -eq 0 ]
	then
		echo "side 4 is available"
	elif [ ${flag[$six]} -eq 0 ]
	then
		echo "side 6 is available"
	elif [ ${flag[$eight]} -eq 0 ]
	then
		echo "side 8 is available"
	fi 
}

#set all positions are unoccupied
for (( boardition=1 ; boardition<=9 ; boardition++ ))
do
   flag[$boardition]=0
done
#set all the position number
for (( boardition=1 ; boardition<=9 ; boardition++ ))
do
   board[$boardition]=$boardition
done
boardMoves
