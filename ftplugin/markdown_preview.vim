" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" https://gist.github.com/723126
command! -nargs=0 MarkdownPreview call MarkdownRenderBufferToPreview()
setlocal ignorecase
setlocal wrap
setlocal lbr

function! MarkdownRender(lines)
  if (system('which ruby') == "")
    throw "Could not find ruby!"
  end

  let text = join(a:lines, "\n")
  let html = system("ruby -e \"def e(msg); puts msg; exit 1; end; begin; require 'rubygems'; rescue LoadError; e('rubygems not found'); end; begin; require 'rdiscount'; rescue LoadError; e('RDiscount gem not installed.  Run this from the terminal: sudo gem install rdiscount'); end; puts(RDiscount.new(\\$stdin.read).to_html)\"", text)
  return html
endfunction

function! MarkdownRenderFile(lines, filename)
  let html = MarkdownRender(getbufline(bufname("%"), 1, '$'))
  let html = "<html><head><title>" . bufname("%") . "</title><body>\n" . html . "\n</body></html>"
  return writefile(split(html, "\n"), a:filename)
endfunction

function! MarkdownRenderBufferToPreview()
  let filename = "/tmp/markdown-preview.html"
  call MarkdownRenderFile(getbufline(bufname("%"), 1, '$'), filename)

  " Modify this line to make it compatible on other platforms
  call system("open ". filename)
endfunction
