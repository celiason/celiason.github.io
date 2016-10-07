# makefile

tail +7 cv/cv-pandoc.md > cv/cv-body.md
pandoc -S cv/cv-body.md -o cv/cv-body.tex
perl -p -i -e "s/~/\\\ /g" cv/cv-body.tex
perl -p -i -e "s/M.Sc./M.Sc.\\\/g" cv/cv-body.tex
perl -p -i -e "s/B.Sc./B.Sc.\\\/g" cv/cv-body.tex
perl -p -i -e "s/itemsep1pt/itemsep3pt/g" cv/cv-body.tex
pdflatex -output-directory=cv cv/EliasonCV.tex
# latexmk -outdir=cv cv/EliasonCV.tex
pandoc cv/cv-body.md -o cv/cv-body-clean.md
cat cv/cv-header.txt cv/cv-body-clean.md > cv/EliasonCV.txt
perl -p -i -e "s/–/--/g" cv/EliasonCV.txt
rm cv/cv-body.md
#rm cv-body.tex
rm cv/cv-body-clean.md
rm cv/*.log cv/*.out cv/*.aux cv/*.fdb_latexmk cv/*.fls
# and pre-process the HTML with pandoc
# because redcarpet markdown doesn't do definition lists
pandoc -S cv/cv-pandoc.md -o cv/cv-temp.html
cat cv/cv-pandoc-header.md cv/cv-temp.html > cv/cv.html
rm cv/cv-temp.html
# cp EliasonCV.pdf ~/Dropbox/public/EliasonCV.pdf

