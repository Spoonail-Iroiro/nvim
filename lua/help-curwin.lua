vim.cmd [[
	let s:did_open_help = v:false
	
	function s:HelpCurwin(subject) abort
	  let mods = 'silent noautocmd keepalt'
	  if !s:did_open_help
	    execute mods .. ' help'
	    execute mods .. ' helpclose'
	    let s:did_open_help = v:true
	  endif
	  if !empty(getcompletion(a:subject, 'help'))
	    execute mods .. ' edit ' .. &helpfile
	    set buftype=help
	  endif
	  return 'help ' .. a:subject
	endfunction
	command -bar -nargs=? -complete=help H execute s:HelpCurwin(<q-args>)
]]
