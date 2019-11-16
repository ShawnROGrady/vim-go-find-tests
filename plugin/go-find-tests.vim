function! GoFindTests()
	let curLine=line('.')
	let curCol=col('.')
	let curFile=@%

	let args="./".curFile." ".curLine." ".curCol
	let output=systemlist('go-find-tests -print-positions'." ".args)
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

command! -bang -nargs=* GoFindTests call GoFindTests()

