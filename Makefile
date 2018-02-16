##
##  Copyright (c) 2014-2018 Ralf S. Engelschall <rse@engelschall.com>
##
##  Permission is hereby granted, free of charge, to any person obtaining
##  a copy of this software and associated documentation files (the
##  "Software"), to deal in the Software without restriction, including
##  without limitation the rights to use, copy, modify, merge, publish,
##  distribute, sublicense, and/or sell copies of the Software, and to
##  permit persons to whom the Software is furnished to do so, subject to
##  the following conditions:
##
##  The above copyright notice and this permission notice shall be included
##  in all copies or substantial portions of the Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
##  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
##  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
##  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
##  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
##  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##

all: convert

convert:
	@echo "++ creating temporary working area"; \
	rm -rf tmp; mkdir tmp; mkdir tmp/stage1 tmp/stage2 tmp/stage3
	@echo "++ converting font from OTF to TTF format"; \
	fontconvert CombiNumeralsLtd.otf tmp/stage1/CombiNumeralsLtd.ttf >/dev/null 2>&1
	@echo "++ reducing tables of TTF format"; \
	ttftable -delete DSIG,FFTM,GPOS,GDEF,GSUB tmp/stage1/CombiNumeralsLtd.ttf tmp/stage2/CombiNumeralsLtd.ttf
	@echo "++ converting from TTF to sub-set TFF/EOT/WOFF/SVGZ format"; \
	fontface -l -h -u '0000-FFFF' -o tmp/stage3 tmp/stage2/CombiNumeralsLtd.ttf
	@echo "++ providing font information"; \
	cat BLURB.txt LICENSE.txt >tmp/stage3/CombiNumeralsLtd.txt
	@echo "++ assembling results"; \
	rm -f tmp/stage3/CombiNumeralsLtd.html; \
	rm -f tmp/stage3/CombiNumeralsLtd.css; \
	cp -p tmp/stage3/* .
	@echo "++ cleanup temporary working area"; \
	rm -rf tmp

clean:
	rm -rf tmp

distclean: clean

realclean: distclean
	rm -f CombiNumeralsLtd.txt
	rm -f CombiNumeralsLtd.woff
	rm -f CombiNumeralsLtd.eot
	rm -f CombiNumeralsLtd.svgz
	rm -f CombiNumeralsLtd.ttf

