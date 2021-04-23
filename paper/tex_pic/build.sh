if [[ "$#" == "0" ]]; then
    FileName="neuron.tex"
    echo $FileName
elif [[ "$#" == "1" ]]; then
    FileName="$1"
else
    echo "Error: wrong filename!"
    exit
fi
  
FileName=${FileName/.tex}


Tmp="Tmp"
if [[ ! -d $Tmp ]]; then
    mkdir -p $Tmp
fi

pdflatex -output-directory=$Tmp $FileName || exit

echo "build finished!"

open ./$Tmp/"$FileName".pdf || exit
cp ./$Tmp/"$FileName".pdf ../Img/
