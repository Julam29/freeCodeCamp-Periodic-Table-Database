#!/bin/bash
PSQL="psql -X -A -t --username=freecodecamp --dbname=periodic_table -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_ID=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  if [[ -z $ELEMENT_ID ]]
  then
    echo "I could not find that element in the database."
    exit
  fi

  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $1")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  echo "The element with atomic number $ELEMENT_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE,\
 with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius\
 and a boiling point of $BOILING_POINT celsius."


elif [[ ${#1} -le 2 ]]
then
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  if [[ -z $ELEMENT_SYMBOL ]]
  then
    echo "I could not find that element in the database."
    exit
  fi
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")

  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE,\
 with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius\
 and a boiling point of $BOILING_POINT celsius."

else
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
  if [[ -z $ELEMENT_NAME ]]
  then
    echo "I could not find that element in the database."
    exit
  fi
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")

  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $TYPE,\
 with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius\
 and a boiling point of $BOILING_POINT celsius."
  
fi
