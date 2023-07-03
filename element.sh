#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
    
  else
    re='^[0-9]+$'
    if [[ $1 =~ $re ]]
      then
        ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number = $1;")
        if [[ -z $ELEMENT ]]
          then
            echo "I could not find that element in the database."
          else
            echo $ELEMENT | while read A_NUMBER BAR SYMBOL BAR NAME BAR A_MASS BAR MELT BAR BOIL BAR TYPE_ID
            do
              TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID;" | sed -E 's/ //')
              echo "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $A_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
            done
        fi
      
      else
        ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol = '$1' OR name = '$1';")
        if [[ -z $ELEMENT ]]
          then
            echo "I could not find that element in the database."
          else
            echo $ELEMENT | while read A_NUMBER BAR SYMBOL BAR NAME BAR A_MASS BAR MELT BAR BOIL BAR TYPE_ID
            do
              TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID;" | sed -E 's/ //')
              echo "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $A_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
            done
        fi
    fi
fi

