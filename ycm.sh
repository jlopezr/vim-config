# YCM Profile 
function ycm_profile() {
   if [[ "$1" == "" ]]; then
        echo "Selected YCM profile:"
        basename `readlink -f $HOME/.vim/ycm_extra_conf.py`	
	echo "Available YCM profiles are:"
	dir $HOME/.vim/ycm
   else
        if [[ -f "$HOME/.vim/ycm/$1" ]]; then
	     rm ~/.vim/ycm_extra_conf.py
	     ln -s ~/.vim/ycm/$1 ~/.vim/ycm_extra_conf.py
        else
             echo "YCM profile $1 not found."
        fi 
   fi
}

function ycm_new() {
   if [[ "$#" != "2" ]]; then
      echo "ycm_new <new_profile> <base_profile>"
   else 	   
      cp ~/.vim/ycm/$2 ~/.vim/ycm/$1
   fi
}
