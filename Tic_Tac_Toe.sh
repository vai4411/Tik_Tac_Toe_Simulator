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
chooseboardition=0
computerboardition=0
turn=0
value=""

declare -a flag

declare -a board

function printBoard() {
	echo " ${board[$one]} | ${board[$two]} | ${board[$three]}"
	echo "-----------"
	echo " ${board[$four]} | ${board[$five]} | ${board[$six]}"
	echo "-----------"
	echo " ${board[$seven]} | ${board[$eight]} | ${board[$nine]}"
}

function turnFlag() {
	board[$chooseboardition]=$1
	printBoard
	flag[$chooseboardition]=1
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
	read -p "Enter the choice:" chooseboardition
	turnFlag $player
	turn=1
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
	computerboardition=$((RANDOM % 9 + 1))
	chooseboardition=$computerboardition
	turnFlag $computer
	turn=0
}

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

function checkWin() {
	if ([[ "${board[$one]}" == "$value" ]] && [[ "${board[$two]}" == "$value" ]] && [[ "${board[$three]}" == "$value" ]]) ||
	   ([[ "${board[$four]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$six]}" == "$value" ]]) ||
	   ([[ "${board[$seven]}" == "$value" ]] && [[ "${board[$eight]}" == "$value" ]] && [[ "${board[$nine]}" == "$value" ]]) ||
	   ([[ "${board[$one]}" == "$value" ]] && [[ "${board[$four]}" == "$value" ]] && [[ "${board[$seven]}" == "$value" ]]) ||
	   ([[ "${board[$two]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$eight]}" == "$value" ]]) ||
	   ([[ "${board[$three]}" == "$value" ]] && [[ "${board[$six]}" == "$value" ]] && [[ "${board[$nine]}" == "$value" ]]) ||
	   ([[ "${board[$one]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$nine]}" == "$value" ]]) ||
	   ([[ "${board[$three]}" == "$value" ]] && [[ "${board[$five]}" == "$value" ]] && [[ "${board[$seven]}" == "$value" ]]) 
	then
		if [[ "$value" == "$player" ]]
		then
			echo "Player wins..."
		else
			echo "Computer wins..."
		fi
	fi
	exit
}

for (( boardition=1 ; boardition<=9 ; boardition++ ))
do
   flag[$boardition]=0
done
for (( boardition=1 ; boardition<=9 ; boardition++ ))
do
   board[$boardition]=$boardition
done
playFirst
