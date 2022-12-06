vim.cmd [[
    " let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki'}]
    let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
    let g:vimwiki_global_ext = 0 " make sure vimwiki doesn't own all .md files
    

  function! VimwikiLinkHandler(link)
    let link = a:link
    if link =~# '^vfile:'
      let link = link[1:]
    else
      return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
      echomsg 'Vimwiki Error: Unable to resolve link!'
      return 0
    else
      exe 'e ' . fnameescape(link_infos.filename)
      return 1
    endif
  endfunction

    autocmd FileType vimwiki set ft=markdown
]]
