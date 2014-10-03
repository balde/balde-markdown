AC_PREREQ([2.69])

AC_INIT([balde-markdown],
  [m4_esyscmd(build-aux/git-version-gen .tarball-version)],
  [https://github.com/balde/balde-markdown], [balde-markdown],
  [https://github.com/balde/balde-markdown])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

# code changed: REVISION++.
# interface changed: CURRENT++, REVISION=0.
# interface changed (backwards compatible): AGE++, else AGE=0.
CURRENT=0
AGE=0
REVISION=0

LT_VERSION_INFO="$CURRENT:$REVISION:$AGE"
AC_SUBST(LT_VERSION_INFO)

AM_INIT_AUTOMAKE([1.13 foreign dist-bzip2 dist-xz subdir-objects serial-tests])
AC_CONFIG_HEADERS([config.h])
AM_SILENT_RULES([yes])
AM_MAINTAINER_MODE([enable])

LT_INIT

AC_PROG_CC_C99
AS_IF([test "x$ac_cv_prog_cc_c99" = "xno"], [
  AC_MSG_ERROR([no C99 compiler found, balde-markdown requires a C99 compiler.])
])

AC_SEARCH_LIBS([mkd_in], [markdown], ,
  AC_MSG_ERROR([mkd_in not found. please install the discount markdown parser library.])
)

AC_ARG_WITH([valgrind], AS_HELP_STRING([--without-valgrind],
            [ignore presence of valgrind]))
AS_IF([test "x$with_valgrind" != "xno"], [
  AC_PATH_PROG([valgrind], [valgrind])
  AS_IF([test "x$ac_cv_path_valgrind" = "x"], [
    have_valgrind=no
  ], [
    have_valgrind=yes
  ])
])
AS_IF([test "x$have_valgrind" = "xyes"], , [
  AS_IF([test "x$with_valgrind" = "xyes"], [
    AC_MSG_ERROR([valgrind requested but not found])
  ])
])
AM_CONDITIONAL([USE_VALGRIND], [test "x$have_valgrind" = "xyes"])
VALGRIND="$ac_cv_path_valgrind"
AC_SUBST(VALGRIND)

GLIB_DEP="glib-2.0 >= 2.34"
BALDE_DEP="balde >= 0.1"
FULL_DEP="${GLIB_DEP}, ${BALDE_DEP}"
AC_SUBST(FULL_DEP)

PKG_PROG_PKG_CONFIG
PKG_CHECK_MODULES([GLIB], [$GLIB_DEP])
PKG_CHECK_MODULES([BALDE], [$BALDE_DEP])

AC_CONFIG_FILES([
    Makefile
    include/Makefile
    src/Makefile
    tests/Makefile
    balde-markdown.pc
])
AC_OUTPUT

AS_ECHO("
        ==== ${PACKAGE_STRING} ====

        prefix:       ${prefix}
        exec_prefix:  ${exec_prefix}
        bindir:       ${bindir}

        compiler:     ${CC}
        cflags:       ${CFLAGS}
        ldflags:      ${LDFLAGS}

        valgrind:     ${VALGRIND}
")
