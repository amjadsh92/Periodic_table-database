#! /bin/bash
PSQL="psql --username=amjad --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
name=$($PSQL "SELECT name FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1;")
echo $name
fi