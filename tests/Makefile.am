check_PROGRAMS = \
	check_markdown

TESTS = \
	$(check_PROGRAMS)

check_markdown_SOURCES = \
	check_markdown.c

AM_CFLAGS = \
	$(all_includes) \
	$(BALDE_CFLAGS) \
	-I$(top_srcdir)/include

AM_LDFLAGS = \
	$(BALDE_LIBS) \
	$(top_builddir)/src/libbalde_markdown.la

clean-local:
	-rm -rf valgrind-*.xml

if USE_VALGRIND
valgrind: clean
	$(MAKE) check TESTS_ENVIRONMENT=" \
		G_SLICE=always-malloc \
		G_DEBUG=gc-friendly \
		$(LIBTOOL) \
			--mode=execute \
			$(VALGRIND) \
				--tool=memcheck \
				--xml=yes \
				--xml-file=valgrind-%p.xml \
				--leak-check=full \
				--leak-resolution=high \
				--num-callers=20 \
				--show-possibly-lost=no"
endif
