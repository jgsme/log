DEST = ./build
LSC = ./node_modules/.bin/lsc
PORT = 3000

all: assets article indexpage archive rss

before:
	@mkdir -p $(DEST)

clean:
	@rm -rf $(DEST)

assets: gfm cname favicon stylus live

gfm: before
	@cp ./node_modules/github-markdown-css/github-markdown.css $(DEST)

cname: before
	@cp ./src/CNAME $(DEST)

favicon: before
	@cp -r ./src/favicons/* $(DEST)

stylus: before
	@./node_modules/.bin/stylus ./src/*.styl --out $(DEST) -c

live: before
	@$(LSC) -cbo $(DEST) ./src/*.ls

article: before
	@$(LSC) ./scripts/article.ls

indexpage: before
	@$(LSC) ./scripts/indexpage.ls

archive: before
	@$(LSC) ./scripts/archive.ls

rss: before
	@$(LSC) ./scripts/rss.ls

write:
	@$(LSC) ./scripts/write.ls

serve:
	@./node_modules/.bin/static -p $(PORT) $(DEST)

.PHONY: before clean assets gfm cname favicon stylus live article indexpage archive rss write serve