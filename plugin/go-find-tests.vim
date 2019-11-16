function! GoFindTests()
	let curLine=line('.')
	let curCol=col('.')
	let curFile=@%

	let args="./".curFile." ".curLine." ".curCol
	let output=systemlist('go-find-tests -print-positions'." ".args)
	let positions = []
	for outLine in output 
		let pos = split(outLine, ':')
		let qfItem={"filename": pos[1], "lnum": pos[2], "col": pos[3], "text": pos[0]}
		call add(positions, qfItem)
	endfor

	" TODO: should try to jump straight to first item without having to
	" open quickfix list
	if len(positions) == 0
		echo "No tests found"
		return
	endif

	call setqflist(positions)
	execute 'botright copen'
	redraw!
endfunction

command! -bang -nargs=* GoFindTests call GoFindTests()

