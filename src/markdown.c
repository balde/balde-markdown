/*
 * balde-markdown: A balde extension that adds Markdown support.
 * Copyright (C) 2014 Rafael G. Martins <rafael@rafaelmartins.eng.br>
 *
 * This program can be distributed under the terms of the LGPL-2 License.
 * See the file COPYING.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif /* HAVE_CONFIG_H */

#include <balde.h>
#include <mkdio.h>
#include <string.h>

#include <balde-markdown.h>


gchar*
balde_markdown_parse(balde_app_t *app, const gchar *mkd_source)
{
    gchar *rv = NULL;
    gchar *text;
    MMIOT *doc = mkd_string(mkd_source, strlen(mkd_source), MKD_TABSTOP);
    if (doc == NULL) {
        balde_abort_set_error(app, 500);
        goto point0;
    }
    mkd_compile(doc, MKD_TABSTOP);
    mkd_document(doc, &text);
    rv = g_strdup(text);
point0:
    mkd_cleanup(doc);
    return rv;
}


gchar*
balde_tmpl_markdown(balde_app_t *app, balde_request_t *request, const gchar *mkd)
{
    gchar *parsed_mkd = balde_markdown_parse(app, mkd != NULL ? mkd : "");
    if (app->error != NULL) {
        // ops... something went wrong, but we are already building the response
        // (this function is called by templates), so the GLib error reporting
        // infrastructure isn't enough!
        g_free(parsed_mkd);
        // FIXME: improve this error
        return g_strdup("<p>Error while parsing markdown!</p>\n");
    }
    return parsed_mkd;
}
