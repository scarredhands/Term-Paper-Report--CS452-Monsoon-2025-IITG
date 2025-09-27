# Makefile for CS452 Term Paper Report
# Simplifies LaTeX compilation and cleanup

# Variables
MAIN_FILE = CS452_Term_Paper_Report
BIB_FILE = references.bib
TEX_ENGINE = pdflatex
BIB_ENGINE = bibtex

# Default target
all: pdf

# Compile PDF with bibliography
pdf: $(MAIN_FILE).pdf

$(MAIN_FILE).pdf: $(MAIN_FILE).tex $(BIB_FILE)
	$(TEX_ENGINE) $(MAIN_FILE).tex
	$(BIB_ENGINE) $(MAIN_FILE)
	$(TEX_ENGINE) $(MAIN_FILE).tex
	$(TEX_ENGINE) $(MAIN_FILE).tex

# Quick compile without bibliography
quick: $(MAIN_FILE).tex
	$(TEX_ENGINE) $(MAIN_FILE).tex

# Clean auxiliary files
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.fdb_latexmk *.fls *.synctex.gz

# Clean everything including PDF
cleanall: clean
	rm -f $(MAIN_FILE).pdf

# View PDF (requires a PDF viewer)
view: $(MAIN_FILE).pdf
	@if command -v evince > /dev/null; then \
		evince $(MAIN_FILE).pdf & \
	elif command -v okular > /dev/null; then \
		okular $(MAIN_FILE).pdf & \
	elif command -v xdg-open > /dev/null; then \
		xdg-open $(MAIN_FILE).pdf & \
	else \
		echo "No PDF viewer found. Please open $(MAIN_FILE).pdf manually."; \
	fi

# Check for LaTeX installation
check:
	@echo "Checking LaTeX installation..."
	@command -v $(TEX_ENGINE) >/dev/null 2>&1 || { echo "pdflatex not found. Please install LaTeX."; exit 1; }
	@command -v $(BIB_ENGINE) >/dev/null 2>&1 || { echo "bibtex not found. Please install LaTeX."; exit 1; }
	@echo "LaTeX installation found."

# Help target
help:
	@echo "Available targets:"
	@echo "  all      - Compile PDF with bibliography (default)"
	@echo "  pdf      - Compile PDF with bibliography"
	@echo "  quick    - Quick compile without bibliography"
	@echo "  clean    - Remove auxiliary files"
	@echo "  cleanall - Remove all generated files including PDF"
	@echo "  view     - Open PDF in default viewer"
	@echo "  check    - Check LaTeX installation"
	@echo "  help     - Show this help message"

.PHONY: all pdf quick clean cleanall view check help