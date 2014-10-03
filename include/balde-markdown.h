/*
 * balde-markdown: A balde extension that adds Markdown support.
 * Copyright (C) 2014 Rafael G. Martins <rafael@rafaelmartins.eng.br>
 *
 * This program can be distributed under the terms of the LGPL-2 License.
 * See the file COPYING.
 */

#ifndef _BALDE_MARKDOWN_H
#define _BALDE_MARKDOWN_H

#include <glib.h>
#include <balde.h>

gchar* balde_markdown_parse(balde_app_t *app, const gchar *mkd_source);
gchar* balde_tmpl_markdown(balde_app_t *app, balde_request_t *request,
    const gchar *mkd);

#endif /* _BALDE_MARKDOWN_H */
