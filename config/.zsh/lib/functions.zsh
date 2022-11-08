# function for grep
function find-grep(){
	find . -name \*.$1 -exec grep -nH $2 {} \;
}

# misc
function lines(){
	if [ $# -ne 0 ]; then
		sum=0
		for source in `find . -type f -name "*.$@"`
		do
			lines=`wc -l $source | sed -e "s/ [^ ]*$//" | sed -e "s/ //g"`
			sum=`expr $lines + $sum`
			printf "%6d $source\n" $lines
		done
		echo "Total: $sum"
	else
		echo "Usage: lines [extension]"
	fi
}

# command history analyzer
function analyze() {
	cat ~/.zsh_history | awk 'BEGIN {FS=";"} {print $2}' | awk '{print $1}' | sort | uniq -c | sort -nr | head -n 15
}

# replace foo bar #=> s/foo/bar/
function replace() {
	gg --name-only $1 | xargs sed -i "" -e "s/$1/$2/g"
}

function kill-applespell() {
  if [ -e /System/Library/Services/AppleSpell.service/Contents/Resources ]; then
		sudo mv /System/Library/Services/AppleSpell.service/Contents/Resources{,.disabled}
	fi
	pkill AppleSpell
}
