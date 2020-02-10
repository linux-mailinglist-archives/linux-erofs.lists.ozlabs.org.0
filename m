Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A932157FE7
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2020 17:36:49 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48GWl2701qzDqM6
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 03:36:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1581352606;
	bh=tkQpt5aXsSIQw+g0CCRyjdoxaJ1F2S5STaoWppJaiwo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y/+alnWy4EM4CeUHzHH3/sPxWJdZz5j/Qcsq/uCyLS7cDH/7EL64dN2LBBQidvhCx
	 N6ASr1gE/4+6DWi8X6TLhpU6cG5CtXPYHAlMTAgvyppRiENOfW1v16esRPFddhMil2
	 Owa1FnxVUN07VadhPdlflmbpBdlM+/5Qoy4xnnh/s9osUh8iS/yjxwtsytHBoiVhQg
	 IF5WdVPvKD7mCRTnxQNqaEk6YQVeJ3wwHsoGlzmTDiIovaMgkkOppOG82+5YgYapRE
	 oxy9XfOIjP2N0K/AHhsfQnBBiklsMB8BMMgxahCXt0iiDhxWiGP6skVs27lNvqxX06
	 vUMcettg7nRxQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.233; helo=sonic304-51.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=grmnB9SZ; dkim-atps=neutral
Received: from sonic304-51.consmr.mail.gq1.yahoo.com
 (sonic304-51.consmr.mail.gq1.yahoo.com [98.137.68.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48GWkn5XklzDqLc
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 03:36:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1581352587; bh=DDeuvKSzIBpO7iqM5ardWwKkeM9NvksLjw/k41tIugg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=grmnB9SZ5eZHsLmqV/uPPJKpu0D8hZyRe06bi3xYSxKfJm0eeyRyHONocm1oeHqm4NbfLsXyUlLPOqxSNMaOGucqIxTiaJvbXJNIHxIzpg0uLH6v4spmoD/ofEztpoNeKiPfUNFeAtaxT+WUENTp71uwm1piRixIHFQ+SkdrtAEB6FZmLm901ljp5MEGKslQKj46MgaYMJEtM3C/hWthobsfvE30KVXxoN3iH/bdSxi1Tic7kxKJvF6fMfVfA0d19AS11Bx30Rb8+j+AglTH0THFR3HMKZuVtaoHDhKIIGC92Z5BXcN5+KhkRv2WnasIVyIdHZ51EfLoLlsGb5cdRA==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Mon, 10 Feb 2020 16:36:27 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f3b366825fbea485c5af10e6c919ebe0; 
 Mon, 10 Feb 2020 16:34:26 +0000 (UTC)
Date: Tue, 11 Feb 2020 00:34:19 +0800
To: Li Guifu <blucer.lee@foxmail.com>
Subject: Re: [PATCH v2] erofs-utils: introduce exclude dirs and files
Message-ID: <20200210163359.GA26366@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200203153811.5239-1-blucerlee@sina.com>
 <20200204170205.GA12610@hsiangkao-HP-ZHAN-66-Pro-G1>
 <108bd2aa-182f-c5d3-53eb-54ad0e313b76@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108bd2aa-182f-c5d3-53eb-54ad0e313b76@foxmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 10, 2020 at 09:41:04PM +0800, Li Guifu wrote:
> Gao Xiang,
>  It would make a long string match on each path sprintfed from a dir.

It seems that your @foxmail.com email is still broken, because I haven't
seen this email on mailing list till now. I'd suggest you could fix
your email first.

> The parent's path don'y need to compare every times,just loop the sub dirs.

It's a very simple approach to implement this feature (exact match) as
the first step. Because for most paths without valid prefix, it will
just bail out on the first char and it will have no impact if we don't
use this feature.

Laterly, I'd suggest some sorted string array to solve what you
mentioned. (You could improve it in the following way.)

Take an example, we could keep such sorted string array in memory.

  0 A/B
  1 A/B/C
  2 A/B/D
  3 A/B/E/F
  4 A/G
  5 H

For each access, we can binary search and narrow down the range dynamicly.
e.g. if we open A dir, the search range will be from 0 to 4. and if we
open A/B dir, the search range will then be narrowed down to 0~3.

>  It also would better to use relate path on image path not the absolute
> path in the exclude path.

No, I think it works on relative path. You could test it out first.

Thanks,
Gao Xiang

> 
>   What your's opinion ?
> 
> On 2020/2/5 1:02, Gao Xiang via Linux-erofs wrote:
> > Hi Guifu,
> > 
> > I cleanup the whole patch and get rid of all dedupe check in order
> > to make it as simple as possible since I think not too many exclude
> > files in general.
> > 
> > Please take some time helping testing the following patch and
> > hope to get your feedback.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > 
> > 
> >>From 600fc166cdaaa0e458181729245ce11affa83ac5 Mon Sep 17 00:00:00 2001
> > From: Li Guifu <blucer.lee@foxmail.com>
> > Date: Mon, 3 Feb 2020 23:38:11 +0800
> > Subject: [PATCH v3] erofs-utils: introduce exclude dirs and files
> > 
> > Add excluded file feature "--exclude-path=", which can be used
> > to build EROFS image without some user specific files or dirs.
> > 
> > Note that you may give multiple `--exclude-path' options.
> > 
> > Signed-off-by: Li Guifu <blucer.lee@foxmail.com>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> > changes since v2:
> >  - cleanup the whole implementation;
> >  - complete usage message;
> >  - complete manual page.
> > 
> >  include/erofs/exclude.h | 23 +++++++++++
> >  lib/Makefile.am         |  2 +-
> >  lib/exclude.c           | 89 +++++++++++++++++++++++++++++++++++++++++
> >  lib/inode.c             |  5 +++
> >  man/mkfs.erofs.1        |  4 ++
> >  mkfs/main.c             | 26 +++++++++---
> >  6 files changed, 142 insertions(+), 7 deletions(-)
> >  create mode 100644 include/erofs/exclude.h
> >  create mode 100644 lib/exclude.c
> > 
> > diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
> > new file mode 100644
> > index 0000000..580fefe
> > --- /dev/null
> > +++ b/include/erofs/exclude.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * erofs-utils/include/erofs/exclude.h
> > + *
> > + * Created by Li Guifu <blucer.lee@foxmail.com>
> > + */
> > +#ifndef __EROFS_EXCLUDE_H
> > +#define __EROFS_EXCLUDE_H
> > +
> > +struct erofs_exclude_rule {
> > +	struct list_head list;
> > +
> > +	char *pattern;
> > +};
> > +
> > +void erofs_exclude_set_root(const char *rootdir);
> > +void erofs_cleanup_exclude_rules(void);
> > +
> > +int erofs_parse_exclude_path(const char *args);
> > +struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
> > +						 const char *name);
> > +#endif
> > +
> > diff --git a/lib/Makefile.am b/lib/Makefile.am
> > index 1ff81f9..e4b51e6 100644
> > --- a/lib/Makefile.am
> > +++ b/lib/Makefile.am
> > @@ -3,7 +3,7 @@
> >  
> >  noinst_LTLIBRARIES = liberofs.la
> >  liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
> > -		      compress.c compressor.c
> > +		      compress.c compressor.c exclude.c
> >  liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> >  if ENABLE_LZ4
> >  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> > diff --git a/lib/exclude.c b/lib/exclude.c
> > new file mode 100644
> > index 0000000..9b48325
> > --- /dev/null
> > +++ b/lib/exclude.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * erofs-utils/lib/exclude.c
> > + *
> > + * Created by Li Guifu <blucer.lee@foxmail.com>
> > + */
> > +#include <string.h>
> > +#include <stdlib.h>
> > +#include "erofs/err.h"
> > +#include "erofs/list.h"
> > +#include "erofs/print.h"
> > +#include "erofs/exclude.h"
> > +
> > +static LIST_HEAD(exclude_head);
> > +static unsigned int rpathlen;		/* root directory prefix length */
> > +
> > +void erofs_exclude_set_root(const char *rootdir)
> > +{
> > +	rpathlen = strlen(rootdir);
> > +}
> > +
> > +static struct erofs_exclude_rule *erofs_insert_exclude(const char *s)
> > +{
> > +	struct erofs_exclude_rule *e;
> > +
> > +	e = malloc(sizeof(*e));
> > +	if (!e)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	/* exact match */
> > +	e->pattern = strdup(s);
> > +	if (!e->pattern) {
> > +		free(e);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	list_add_tail(&e->list, &exclude_head);
> > +	erofs_info("exclude path %s inserted", e->pattern);
> > +	return e;
> > +}
> > +
> > +void erofs_cleanup_exclude_rules(void)
> > +{
> > +	struct erofs_exclude_rule *e, *n;
> > +
> > +	list_for_each_entry_safe(e, n, &exclude_head, list) {
> > +		list_del(&e->list);
> > +		free(e->pattern);
> > +		free(e);
> > +	}
> > +}
> > +
> > +int erofs_parse_exclude_path(const char *args)
> > +{
> > +	struct erofs_exclude_rule *e = erofs_insert_exclude(args);
> > +
> > +	if (IS_ERR(e)) {
> > +		erofs_cleanup_exclude_rules();
> > +		return PTR_ERR(e);
> > +	}
> > +	return 0;
> > +}
> > +
> > +struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
> > +						 const char *name)
> > +{
> > +	char buf[PATH_MAX];
> > +	const char *s;
> > +	struct erofs_exclude_rule *e;
> > +
> > +	if (!dir) {
> > +		/* no prefix */
> > +		s = name;
> > +	} else {
> > +		sprintf(buf, "%s/%s", dir, name);
> > +		s = buf;
> > +	}
> > +
> > +	s += rpathlen;
> > +	while (*s == '/')
> > +		s++;
> > +
> > +	list_for_each_entry(e, &exclude_head, list) {
> > +		if (!strcmp(e->pattern, s))
> > +			return e;
> > +	}
> > +	return NULL;
> > +}
> > +
> > diff --git a/lib/inode.c b/lib/inode.c
> > index bd0652b..7114023 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -20,6 +20,7 @@
> >  #include "erofs/io.h"
> >  #include "erofs/compress.h"
> >  #include "erofs/xattr.h"
> > +#include "erofs/exclude.h"
> >  
> >  struct erofs_sb_info sbi;
> >  
> > @@ -877,6 +878,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> >  		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
> >  			continue;
> >  
> > +		/* skip if it's a exclude file */
> > +		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
> > +			continue;
> > +
> >  		d = erofs_d_alloc(dir, dp->d_name);
> >  		if (IS_ERR(d)) {
> >  			ret = PTR_ERR(d);
> > diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> > index d6bf828..aa927a9 100644
> > --- a/man/mkfs.erofs.1
> > +++ b/man/mkfs.erofs.1
> > @@ -52,6 +52,10 @@ Forcely generate extended inodes (64-byte inodes) to output.
> >  Set all files to the given UNIX timestamp. Reproducible builds requires setting
> >  all to a specific one.
> >  .TP
> > +.BI "\-\-exclude-path=" path
> > +Ignore file that matches the exact literal path.
> > +You may give multiple `--exclude-path' options.
> > +.TP
> >  .B \-\-help
> >  Display this help and exit.
> >  .SH AUTHOR
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 817a6c1..d913b5d 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -21,6 +21,7 @@
> >  #include "erofs/io.h"
> >  #include "erofs/compress.h"
> >  #include "erofs/xattr.h"
> > +#include "erofs/exclude.h"
> >  
> >  #ifdef HAVE_LIBUUID
> >  #include <uuid/uuid.h>
> > @@ -30,6 +31,7 @@
> >  
> >  static struct option long_options[] = {
> >  	{"help", no_argument, 0, 1},
> > +	{"exclude-path", required_argument, NULL, 2},
> >  	{0, 0, 0, 0},
> >  };
> >  
> > @@ -50,12 +52,13 @@ static void usage(void)
> >  {
> >  	fputs("usage: [options] FILE DIRECTORY\n\n"
> >  	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
> > -	      " -zX[,Y]   X=compressor (Y=compression level, optional)\n"
> > -	      " -d#       set output message level to # (maximum 9)\n"
> > -	      " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
> > -	      " -EX[,...] X=extended options\n"
> > -	      " -T#       set a fixed UNIX timestamp # to all files\n"
> > -	      " --help    display this help and exit\n"
> > +	      " -zX[,Y]          X=compressor (Y=compression level, optional)\n"
> > +	      " -d#              set output message level to # (maximum 9)\n"
> > +	      " -x#              set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
> > +	      " -EX[,...]        X=extended options\n"
> > +	      " -T#              set a fixed UNIX timestamp # to all files\n"
> > +	      " --exclude-path=X avoid including file X (X = exact literal path)\n"
> > +	      " --help           display this help and exit\n"
> >  	      "\nAvailable compressors are: ", stderr);
> >  	print_available_compressors(stderr, ", ");
> >  }
> > @@ -178,6 +181,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  			}
> >  			break;
> >  
> > +		case 2:
> > +			opt = erofs_parse_exclude_path(optarg);
> > +			if (opt) {
> > +				erofs_err("failed to parse exclude path: %s",
> > +					  erofs_strerror(opt));
> > +				return opt;
> > +			}
> > +			break;
> > +
> >  		case 1:
> >  			usage();
> >  			exit(0);
> > @@ -372,6 +384,7 @@ int main(int argc, char **argv)
> >  	}
> >  
> >  	erofs_show_config();
> > +	erofs_exclude_set_root(cfg.c_src_path);
> >  
> >  	sb_bh = erofs_buffer_init();
> >  	if (IS_ERR(sb_bh)) {
> > @@ -428,6 +441,7 @@ int main(int argc, char **argv)
> >  exit:
> >  	z_erofs_compress_exit();
> >  	dev_close();
> > +	erofs_cleanup_exclude_rules();
> >  	erofs_exit_configure();
> >  
> >  	if (err) {
> > 
