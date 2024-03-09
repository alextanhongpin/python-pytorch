include .env
export

jupyter:
	@poetry run jupyter-lab

kernel:
	poetry run python -m pip install ipykernel
	poetry run python -m ipykernel install --user

setup-formatter:
	poetry add jupyterlab-code-formatter
	poetry add black isort
	jupyter nbextension enable --py widgetsnbextension

convert_all:
	# jupytext doesn't preserve image.
	#@find . -name "*.ipynb" ! -path '*/.*' -exec poetry run jupytext --to md {} \;
	@find . -name "*.ipynb" ! -path '*/.*' -exec poetry run jupyter nbconvert --to markdown --output-dir=docs {} \;

# Similar to convert, but only convert the diff files.
convert:
	@poetry run jupyter nbconvert --to markdown --output-dir=docs $(shell git diff HEAD --name-only | grep .ipynb)
