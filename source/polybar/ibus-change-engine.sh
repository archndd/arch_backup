engine=$(ibus engine)
if [ "$engine" == "Bamboo" ]; then 
    ibus engine "xkb:us::eng"
else
    ibus engine "Bamboo"
fi
