#! /bin/bash
PSQL="psql --username=amjad --dbname=periodic_table -t --no-align -c"

ELEMENT_FINDER(){

if [[ $1 == "Number" ]]
then
COLUMN=atomic_number
elif [[ $1 == "Symbol" ]]
then
COLUMN=symbol
elif [[ $1 == "Name" ]]
then
COLUMN=name
fi

NAME=$($PSQL "SELECT name FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
SYMBOL=$($PSQL "SELECT symbol FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
TYPE=$($PSQL "SELECT type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $COLUMN=$2;")
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."

} 

 
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
ELEMENT_FINDER "Number" $1
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
ELEMENT_FINDER "Symbol" "'$1'"
fi


