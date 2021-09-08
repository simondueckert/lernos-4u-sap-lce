@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core Repository

REM Variables
set filename="lernOS-for-You-Guide"
set chapters=./src/index.md ./src/1-0-Introduction.md ./src/1-1-Lifelong-Learning-and-Knowledge-Work.md ./src/1-2-lernOS-Canvas.md ./src/1-3-lernOS-Flow.md ./src/1-4-lernOS-Workplace.md ./src/1-5-lernOS-Memex.md ./src/2-0-Learning-Paths.md ./src/2-1-0-Learning-Path-PS.md ./src/2-1-1-Kata-1.md ./src/2-1-2-Kata-2.md ./src/2-1-3-Kata-3.md ./src/2-1-4-Kata-4.md ./src/2-1-5-Kata-5.md ./src/2-1-6-Kata-6.md ./src/2-1-7-Kata-7.md ./src/2-1-8-Kata-8.md ./src/2-1-9-Kata-9.md ./src/2-1-10-Kata-10.md ./src/2-1-11-Kata-11.md ./src/3-Appendix.md

REM Delete Old Versions
echo Deleting old versions ...
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf

REM Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml -s --resource-path="./src" %chapters% -o %filename%.docx

REM Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml -s --resource-path="./src" --toc %chapters% -o %filename%.html

REM Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

REM Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown --resource-path="./src" --template lernOS --number-sections -V lang=de-de %chapters% -o %filename%.pdf 

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 %filename%.pdf[0] src/images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml -s --resource-path="./src" --epub-cover-image=src/images/ebook-cover.jpg %chapters% -o %filename%.epub
ebook-convert %filename%.epub %filename%.mobi


echo Done. Check for error messages or warnings above. 

pause
