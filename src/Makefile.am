lib_LTLIBRARIES = libbalde_markdown.la

libbalde_markdown_la_SOURCES = \
	markdown.c

libbalde_markdown_la_CFLAGS = \
	$(AM_CFLAGS) \
	$(BALDE_CFLAGS) \
	-I$(top_srcdir)/include

libbalde_markdown_la_LDFLAGS = \
	$(AM_LDADD) \
	$(BALDE_LIBS) \
	-version-info $(LT_VERSION_INFO)
