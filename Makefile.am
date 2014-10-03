ACLOCAL_AMFLAGS = -I m4

EXTRA_DIST = \
	$(top_srcdir)/autogen.sh \
	$(top_srcdir)/.version \
	$(top_srcdir)/README.md

BUILT_SOURCES = \
	$(top_srcdir)/.version

$(top_srcdir)/.version:
	echo $(VERSION) > $@-t && mv $@-t $@

dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version

include_HEADERS = include/balde-markdown.h

lib_LTLIBRARIES = libbalde_markdown.la

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = balde-markdown.pc

check_PROGRAMS = \
	tests/check_markdown

TESTS = \
	$(check_PROGRAMS)

libbalde_markdown_la_SOURCES = \
	src/markdown.c

libbalde_markdown_la_CFLAGS = \
	$(AM_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(BALDE_CFLAGS) \
	-I$(top_srcdir)/include

libbalde_markdown_la_LDFLAGS = \
	$(AM_LDADD) \
	$(GLIB_LIBS) \
	$(BALDE_LIBS) \
	-version-info $(LT_VERSION_INFO)

tests_check_markdown_SOURCES = \
	tests/check_markdown.c

tests_check_markdown_CFLAGS = \
	$(all_includes) \
	$(BALDE_CFLAGS) \
	-I$(top_srcdir)/include

tests_check_markdown_LDADD = \
	$(BALDE_LIBS) \
	libbalde_markdown.la

tests_check_markdown_LDFLAGS = \
	-no-install

clean-local:
	-rm -rf valgrind-*.xml

if USE_VALGRIND
valgrind: all
	$(MAKE) check TESTS_ENVIRONMENT=" \
		G_SLICE=always-malloc \
		G_DEBUG=gc-friendly \
		$(LIBTOOL) \
			--mode=execute \
			$(VALGRIND) \
				--tool=memcheck \
				--leak-check=full \
				--leak-resolution=high \
				--num-callers=20 \
				--show-possibly-lost=no"

valgrind-ci: all clean-local
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
