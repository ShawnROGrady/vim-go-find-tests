function! gofindtests#Jump(cmdArgs)
	" validate args
	for cmdArg in split(a:cmdArgs)
		if cmdArg =~ "json" || cmdArg =~ "line-fmt"
			" TODO: I dislike having this check, ideally there
			" should be exactly 1 ouput fmt which is useful for
			" command-line usage but is plugin friendly
			echo "Formatting options not allowed"
			return
		endif
	endfor

	let curLine=line('.')
	let curCol=col('.')
	let curFile=@%

	let posArg="./".curFile.":".curLine.".".curCol

	let output=systemlist('go-find-tests -print-positions -line-fmt %t:%f:%l:%c'." ".a:cmdArgs." ".posArg)
	if v:shell_error
		" TODO: should populate qflist to help resolve errors finding
		" covering tests
		echo output
		return
	endif

	let positions = []
	" set items for quickfix list
	for outLine in output 
		let pos = split(outLine, ':')
		let qfItem={"filename": pos[1], "lnum": pos[2], "col": pos[3], "text": pos[0]}
		call add(positions, qfItem)
	endfor

	if len(positions) == 0
		echo "No tests found"
		return
	endif

	" set quickfix list
	call setqflist(positions)
	" jump to first item
	execute 'cc' 
	redraw!
endfunction

function gofindtests#List(cmdArgs)
	let curLine=line('.')
	let curCol=col('.')
	let curFile=@%
	let posArg="./".curFile.":".curLine.".".curCol

	let output=system('go-find-tests'." ".a:cmdArgs." ".posArg)
	if v:shell_error
		" TODO: should populate qflist to help resolve errors finding
		" covering tests
		echo output
		return
	endif 

	echo output
	return
endfunction
