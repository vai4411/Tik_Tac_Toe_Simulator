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
position=0
toss=0
choice=0
player=""
computer=""
computerChoice=0
choosePosition=0
computerPosition=0
turn=0

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
	board[$choosePosition]=$1
   printBoard
   flag[$choosePosition]=1
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
	read -p "Enter the choice:" choosePosition
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
	computerPosition=$((RANDOM % 9 + 1))
	choosePosition=$computerPosition
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

for (( position=1 ; position<=9 ; position++ ))
do
   flag[$position]=0
done
for (( position=1 ; position<=9 ; position++ ))
do
   board[$position]=$position
done
playFirst
