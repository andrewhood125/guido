OS="";
unique_deps=()

. "${ESTABLISH_DIR}/lib/load.sh"

# look for depends.sh or fail
if [ -n "$TEST" ] ; then
  echo "TEST MODE"
elif [ ! -e "depends.sh" ] ; then
  echo "depends.sh not found."
  exit;
else
  # load depends.sh
  . "depends.sh"
fi

# determine operating system
if [ -f "/etc/debian_version" ] ; then
  OS="debian";
elif [ `uname` == "Darwin" ] ; then
  OS="mac";
else
  echo "Operating system not supported."
  exit;
fi

# load dependencies
_load_books "depends.sh" "${deps[@]}"

# remove duplicates
unique_deps=$( awk 'BEGIN{RS=ORS=" "}!a[$0]++' <<<${deps[@]} );
unique_deps=${unique_deps//-/_}

echo "Installing: ${unique_deps[@]}"

# install dependencies
for i in ${unique_deps[@]}; do

  if [ "$COMMAND" == "down" ] ; then

    echo "Removing ${i}..."

    if _${i}_installed; then
      eval _${i}_down;
    else
      echo -e "\tnot installed."
    fi

  elif [ "$COMMAND" == "upgrade" ] ; then

    echo "Upgrading ${i}..."

    eval _${i}_upgrade;

  else

    if ! _${i}_installed; then
      printf "Installing ${i}" 
      _${i}_up &
      while kill -0 $! 2> /dev/null; do
        printf "."
        sleep 1
      done
    else
      printf "${i}"
    fi

    echo -e " \xE2\x9C\x93"

  fi
done

# run _after if it exists
if $(type -t _after > /dev/null) ; then
  _after
fi
