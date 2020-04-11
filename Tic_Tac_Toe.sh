#!/bin/bash -x
echo "Welcome to Tic Tac Toe Game"

#variable
position=0
toss=0
one=1
two=2
three=3
four=4
five=5
six=6
seven=7
eight=8
nine=9

declare -a board

for (( position=1 ; position<=9 ; position++ ))
do
	board[$position]=$position
done

function printBoard() {
	echo " ${board[$one]} | ${board[$two]} | ${board[$three]}"
	echo "-----------"
	echo " ${board[$four]} | ${board[$five]} | ${board[$six]}"
   echo "-----------"
	echo " ${board[$seven]} | ${board[$eight]} | ${board[$nine]}"
}
printBoard

function playFirst() {
	toss=$((RANDOM % 2))
	if [ $toss -eq $one ]
	then
		echo "Player win the toss"
	else
		echo "Computer win the toss"
fi
}
playFirst
