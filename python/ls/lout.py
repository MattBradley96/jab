import os
import argv

argv.add( [
	( 'quiet', 'hide directories, blank lines, etc', False),
	( 'lines', 'separate by returns (tabs is default)', False),
] )

def local_rules(*args):
	pass
lout_rules = local_rules

def screen_width():
	try:
		return int(os.environ['COLUMNS']) - 1
	except KeyError:
		return 0

def show_dirs(dirs):
	if argv.options.quiet: return
	os.system('/bin/ls -d %s' % ' '.join([ ' '.join(d.dirs()) for d in dirs]))
	print

def pad(out, bands = 4):
	chars_per_band = screen_width() / bands
	out_chars = len(out)
	out_bands = ( out_chars / chars_per_band ) + 1
	out_size = out_bands * chars_per_band
	assert out_size >= out_chars, '%d < %d' % ( out_size, out_chars )
	extra = out_size - out_chars
	return ''.join([out,' ' * extra])

def sort_by_name(x):
	return sorted(x)

def format(names):
	names_and_extensions = []
	for name, files in names.iteritems():
		ordered_exts = [ 'py', 'j', 'g', 'test', 'tests', 'fail', 'pyc', 'pyo' ]
		try:
			opt_exts = argv.options.exts
			missing = [ e for e in argv.options.exts if e[1:] not in ordered_exts ]
			assert not missing
		except AttributeError:
			pass
		f_exts = [ f.ext[1:] for f in files ]
		lout_rules(f_exts)
		exts = [ e for e in ordered_exts if e in f_exts ] + [ e for e in f_exts if e not in ordered_exts ]
		lout_rules(f_exts)
		name_and_extensions = '%s.%s' % (name,','.join(exts))
		lout_rules(name_and_extensions)
		names_and_extensions += [ name_and_extensions ]
	return sort_by_name(names_and_extensions)

def show_line(outs,columns_per_line):
	columns_this_line, remainder = outs[:columns_per_line], outs[columns_per_line:]
	separator = '\t'
	if argv.options.lines: separator = '\n'
	print separator.join(columns_this_line)
	if remainder: show_line(remainder,columns_per_line)
		
def show(outs):
	try: column_width = max( [ len(o) for o in outs ] )
	except ValueError: return
	columns_per_line = screen_width() / column_width
	padded = [ '%-*s' % ( column_width, o ) for o in outs ]
	show_line(padded,columns_per_line)

