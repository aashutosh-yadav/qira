if !has('python3')
  echo "vim must be compiled with +python3"
  finish
endif

" highlight the line
" hi CursorLine cterm=NONE ctermbg=darkblue
set cursorline

function! UpdateQIRALine()

python3 << EOF

import socketio
import vim

fn = vim.current.window.buffer.name
(row, col) = vim.current.window.cursor

sio = socketio.Client()
sio.connect('http://localhost:3002', namespaces=['/cda'])
sio.emit('navigateline', fn, row, namespace='/cda')
sio.disconnect()

EOF

endfunction

autocmd CursorMoved * :call UpdateQIRALine()
