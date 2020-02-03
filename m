Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6315091E
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Feb 2020 16:07:42 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48BB5Q6jVYzDqMX
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Feb 2020 02:07:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1580742458;
	bh=iRLM44GysmCZgHO7CdVJGMP8nHTI/O0WQWiqMjpvGDo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jtv4P5l0PCNvGU4INMG+wYjSyHbrjmT22lFlixgwf62fTQiioPwYcWQkkPaHKHqHS
	 8tB4hcExYCZrdqsPy40+I5kSZ1HlAqQajw2hCDxw7sTd7f4En2cSXzsllWqEi3xoNw
	 HgMXw57vF+CxKjN4RoCXpSJmmYlJSSjvqOtWZNBIHESY9k00ngPRBVq6kbLr0CDDLE
	 yxxj/MAogrfKSZgfcsUnYOj2md13kznyouGb14sRskNHmSURkEG5Z3GUFcFPR9DdVo
	 RTfxr0sKJ/uxPoOPFGu+gFbQVcMP5y7EHz3QiiLF4MfZU2VuQpKUfCAyVLShHPsz6Q
	 WPtuNJAtj9Wlw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.110; helo=sonic306-47.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=JcwOzxw1; dkim-atps=neutral
Received: from sonic306-47.consmr.mail.gq1.yahoo.com
 (sonic306-47.consmr.mail.gq1.yahoo.com [98.137.68.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48BB5J6JxnzDqLn
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Feb 2020 02:07:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1580742446; bh=UfHoWVbj+UD2v+CA4BpvNv8vzGpEnRSIHCMtT42wcOY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=JcwOzxw1CzLGgIP4ebnhyudfgpxj3+QAwO1+G3DEED2DjK/O0i98i8kz77vgJ2gA9ibOuVRW4QUenslepbgq5GGsrxDK0552R0qRY8jRNkmbobowm+qzxA7vRzsQqAlcN53LPQS/0znP4aErYdlLbqRENkE/kKmS8pCor9zF1FokxxyCWd3tdsftpe1fBeO6jRGlPykZ7d1flEtwnWEjwq8eX9IgzQZoR3qRocIsZ5qgpYXSc1DUPm7rO2hytPIXcOZv6YIBSkIlYbRymfNREmYMp3SuQcX5sOzEWXrHn0DugGxr09+oZJpGlNf0kBfOdsy2yJs/rFBtTHCVk3tSWQ==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Feb 2020 15:07:26 +0000
Received: by smtp428.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID bf5c9b1c130356bd7a8bae21408fe309; 
 Mon, 03 Feb 2020 15:05:23 +0000 (UTC)
Date: Mon, 3 Feb 2020 23:05:12 +0800
To: Li Guifu <blucerlee@sina.com>
Subject: Re: [PATCH v1] erofs-utils: introduce exclude dirs and files
Message-ID: <20200203150508.GB25738@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200203090853.GA114889@architecture4>
 <3142ea67-ca7f-4fe3-e23d-ce30c6694541@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3142ea67-ca7f-4fe3-e23d-ce30c6694541@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15149 hermes Apache-HttpAsyncClient/4.1.4
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
Cc: linux-erofs@lists.ozlabs.org, LGF <wylgf01@163.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 03, 2020 at 10:47:21PM +0800, Li Guifu wrote:
> 
> Gao Xiang
> 
> It seems a good iead about functions' names and commit message, I will
> fix them asap

Yes, great!

> 
> A value is needed to long option exclude-path in the getopt_long, Do you
> have a another idea ?

I suggested a soltion in the previous email as well, see what we did for
"--help" option...

quote here

> >>  static struct option long_options[] = {
> >>  	{"help", no_argument, 0, 1},
> >> +	{"exclude-path", required_argument, NULL, 'e'},
> >         {"exclude-path", required_argument, NULL, 2},
> >
> >>  	{0, 0, 0, 0},
> >>  };
> >>  
> >> @@ -127,7 +129,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >>  	char *endptr;
> >>  	int opt, i;
> >>  
> >> -	while((opt = getopt_long(argc, argv, "d:x:z:E:T:",
> >> +	while((opt = getopt_long(argc, argv, "d:x:z:E:T:e:",
> > Leave it unchanged.
> >
> > (opt = getopt_long(argc, argv, "d:x:z:E:T:",
> >
> >>  				 long_options, NULL)) != -1) {
> >>  		switch (opt) {
> >>  		case 'z':
> >> @@ -178,6 +180,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >>  			}
> >>  			break;
> >>  
> >> +		case 'e':
> > 		case 2:


Thanks,
Gao Xiang

> 
> 
> On 2020/2/3 17:08, Gao Xiang wrote:
> > Hi Guifu,
> >
> > On Thu, Jan 23, 2020 at 03:04:02PM +0800, Li Guifu wrote:
> >> From: Li Guifu <blucer.lee@foxmail.com>
> > I could imagine that gmail is hard to work on mainland China,
> > but what's wrong with @foxmail.com this time? It could be better
> > to use some email address from a stable provider.
> >
> >> Add support exlcude directory when build image with long option
> >> arg --exclude-path=dir1/dir2,dir11/dir22 or short option arg
> >> -e dir1/dir2,dir11/dir22 that seperated by ','
> > How about the following commit message?
> >
> > Add excluded file feature "--exclude-path=", which can be used
> > to build EROFS image without some user specific files or dirs.
> > Such multiple files can be seperated by ','.
> >
> > and I tend to avoid the short option '-e' in order to keep it
> > for later use (e.g. file system encryption).
> >
> >> Signed-off-by: Li Guifu <blucer.lee@foxmail.com>
> >> ---
> >>  include/erofs/exclude.h |  28 ++++++++
> >>  lib/Makefile.am         |   2 +-
> >>  lib/exclude.c           | 149 ++++++++++++++++++++++++++++++++++++++++
> >>  lib/inode.c             |  10 +++
> >>  mkfs/main.c             |  13 +++-
> >>  5 files changed, 200 insertions(+), 2 deletions(-)
> >>  create mode 100644 include/erofs/exclude.h
> >>  create mode 100644 lib/exclude.c
> >>
> >> diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
> >> new file mode 100644
> >> index 0000000..3f9fb4d
> >> --- /dev/null
> >> +++ b/include/erofs/exclude.h
> >> @@ -0,0 +1,28 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * erofs-utils\include\erofs\exclude.h
> > erofs-utils/include/erofs/exclude.h
> >
> > No backslash here
> >
> >> + * Created by Li Guifu <blucer.lee@foxmail.com>
> >> + */
> >> +
> >> +#ifndef __EROFS_EXCLUDE_H
> >> +#define __EROFS_EXCLUDE_H
> >> +
> >> +struct rule_entry {
> > rule is too general here. exclude_rule_entry
> >
> >> +	struct list_head list;
> >> +	struct list_head hlist;
> >> +	char *name;
> >> +};
> >> +
> >> +void erofs_init_rules(void);
> >> +void erofs_free_rules(void);
> >
> > Same here erofs_init_exclude_rules(), erofs_free_exclude_rules();
> >
> >> +int erofs_parse_exclude_path(const char *args);
> >> +struct rule_entry *erofs_pattern_matched(const char *s);
> >> +struct rule_entry *erofs_entry_matched(struct rule_entry *e,
> >> +				   const char *s, unsigned int len);
> >> +
> >> +static inline int erofs_is_pattern_end(struct rule_entry *e)
> >> +{
> >> +	return list_empty(&e->hlist);
> >> +}
> >> +#endif
> >> +
> >> diff --git a/lib/Makefile.am b/lib/Makefile.am
> >> index 1ff81f9..e4b51e6 100644
> >> --- a/lib/Makefile.am
> >> +++ b/lib/Makefile.am
> >> @@ -3,7 +3,7 @@
> >>  
> >>  noinst_LTLIBRARIES = liberofs.la
> >>  liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
> >> -		      compress.c compressor.c
> >> +		      compress.c compressor.c exclude.c
> >>  liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> >>  if ENABLE_LZ4
> >>  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> >> diff --git a/lib/exclude.c b/lib/exclude.c
> >> new file mode 100644
> >> index 0000000..25a9d32
> >> --- /dev/null
> >> +++ b/lib/exclude.c
> >> @@ -0,0 +1,149 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * erofs-utils\lib\exclude.c
> > Same here.
> >
> >> + * Created by Li Guifu <blucer.lee@foxmail.com>
> >> + */
> >> +
> >> +#include <string.h>
> >> +#include <errno.h>
> >> +#include <stdlib.h>
> >> +
> >> +#include "erofs/defs.h"
> >> +#include "erofs/list.h"
> >> +#include "erofs/print.h"
> >> +#include "erofs/exclude.h"
> >> +
> >> +static struct rule_entry ext_rule;
> > exclude_rule ?
> >
> >> +
> >> +static struct rule_entry *new_entry(const char *s, unsigned int len)
> > The function name is too general as well. new_exclude_rule() 
> >
> >> +{
> >> +	struct rule_entry *e = malloc(sizeof(struct rule_entry));
> >> +
> >> +	if (!e)
> >> +		return NULL;
> > How about using ERR_PTR(-ENOMEM) instead...
> >
> >> +
> >> +	e->name = strndup(s, len);
> >> +	if (!e->name)
> >> +		goto err_strdup;
> >> +
> >> +	init_list_head(&e->hlist);
> >> +	init_list_head(&e->list);
> >> +
> >> +	return e;
> >> +
> >> +err_strdup:
> >> +	free(e);
> >> +	return NULL;
> > Same here.
> >
> >> +}
> >> +
> >> +struct rule_entry *erofs_entry_matched(struct rule_entry *e,
> >> +				   const char *s, unsigned int len)
> >> +{
> >> +	struct rule_entry *pos;
> >> +
> >> +	while (*s == '/') {
> >> +		s++;
> >> +		len--;
> >> +	}
> >> +	list_for_each_entry(pos, &e->hlist, list) {
> >> +		unsigned int l = strlen(pos->name);
> >> +
> >> +		if (l == len && !strcmp(pos->name, s))
> >> +			return pos;
> >> +	}
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +static int add_rules(struct rule_entry *e, const char *s)
> > Same here.
> >
> >> +{
> >> +	const char *ptr;
> >> +	struct rule_entry *le;
> >> +
> >> +	while (*s == '/')
> >> +		s++;
> >> +	ptr = s;
> >> +
> >> +forward:
> >> +	while(*ptr != '/' && *ptr != '\0')
> >> +		ptr++;
> >> +
> >> +	le = erofs_entry_matched(e, s, ptr - s);
> >> +	if (!le) {
> >> +		struct rule_entry *me = new_entry(s, ptr - s);
> >> +
> >> +		if (!me)
> >> +			return -ENOMEM;
> >> +		list_add_tail(&me->list, &e->hlist);
> >> +		le = me;
> >> +	}
> >> +	e = le;
> >> +
> >> +	if (*ptr++ != '\0') {
> >> +		s = ptr;
> >> +		goto forward;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void free_rules(struct list_head *h)
> > Same here.
> >
> >> +{
> >> +	struct rule_entry *e, *n;
> >> +
> >> +	list_for_each_entry_safe(e, n, h, list) {
> >> +		list_del(&e->list);
> >> +		free_rules(&e->hlist);
> >> +		free(e->name);
> >> +		free(e);
> >> +	}
> >> +}
> >> +void erofs_init_rules(void)
> >> +{
> >> +	init_list_head(&ext_rule.list);
> >> +	init_list_head(&ext_rule.hlist);
> >> +	ext_rule.name = "/";
> >> +}
> >> +
> >> +void erofs_free_rules(void)
> >> +{
> >> +	free_rules(&ext_rule.hlist);
> >> +}
> >> +
> >> +int erofs_parse_exclude_path(const char *args)
> >> +{
> >> +	const char *str, *ptr = args;
> >> +	const char sep = ',';
> >> +
> >> +forward:
> >> +	while(*ptr != sep && *ptr != '\0')
> >> +		ptr++;
> >> +
> >> +	str = strndup(args, ptr - args);
> >> +	if (!str)
> >> +		goto err_free_paths;
> >> +
> >> +	if (add_rules(&ext_rule, str))
> >> +		goto err_free_paths;
> >> +
> >> +	if (*ptr++ != '\0') {
> >> +		args = ptr;
> >> +		goto forward;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +err_free_paths:
> >> +	erofs_free_rules();
> >> +	return -ENOMEM;
> >> +}
> >> +
> >> +struct rule_entry *erofs_pattern_matched(const char *s)
> >> +{
> >> +	unsigned int len = strlen(s);
> >> +
> >> +	if (!len)
> >> +		return &ext_rule;
> >> +
> >> +	return erofs_entry_matched(&ext_rule, s, len);
> >> +}
> >> diff --git a/lib/inode.c b/lib/inode.c
> >> index bd0652b..6278ff8 100644
> >> --- a/lib/inode.c
> >> +++ b/lib/inode.c
> >> @@ -20,6 +20,7 @@
> >>  #include "erofs/io.h"
> >>  #include "erofs/compress.h"
> >>  #include "erofs/xattr.h"
> >> +#include "erofs/exclude.h"
> >>  
> >>  struct erofs_sb_info sbi;
> >>  
> >> @@ -825,6 +826,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> >>  	DIR *_dir;
> >>  	struct dirent *dp;
> >>  	struct erofs_dentry *d;
> >> +	struct rule_entry *e;
> >>  
> >>  	ret = erofs_prepare_xattr_ibody(dir->i_srcpath, &dir->i_xattrs);
> >>  	if (ret < 0)
> >> @@ -863,6 +865,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> >>  		return ERR_PTR(-errno);
> >>  	}
> >>  
> >> +	e = erofs_pattern_matched(dir->i_srcpath + strlen(cfg.c_src_path));
> >>  	while (1) {
> >>  		/*
> >>  		 * set errno to 0 before calling readdir() in order to
> >> @@ -876,7 +879,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> >>  		if (is_dot_dotdot(dp->d_name) ||
> >>  		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
> >>  			continue;
> >> +		if (e) {
> >> +			struct rule_entry *le;
> >>  
> >> +			le = erofs_entry_matched(e, dp->d_name,
> >> +						 strlen(dp->d_name));
> >> +			if (le && erofs_is_pattern_end(le))
> >> +				continue;
> >> +		}
> >>  		d = erofs_d_alloc(dir, dp->d_name);
> >>  		if (IS_ERR(d)) {
> >>  			ret = PTR_ERR(d);
> >> diff --git a/mkfs/main.c b/mkfs/main.c
> >> index 817a6c1..ab718cb 100644
> >> --- a/mkfs/main.c
> >> +++ b/mkfs/main.c
> >> @@ -21,6 +21,7 @@
> >>  #include "erofs/io.h"
> >>  #include "erofs/compress.h"
> >>  #include "erofs/xattr.h"
> >> +#include "erofs/exclude.h"
> >>  
> >>  #ifdef HAVE_LIBUUID
> >>  #include <uuid/uuid.h>
> >> @@ -30,6 +31,7 @@
> >>  
> >>  static struct option long_options[] = {
> >>  	{"help", no_argument, 0, 1},
> >> +	{"exclude-path", required_argument, NULL, 'e'},
> >         {"exclude-path", required_argument, NULL, 2},
> >
> >>  	{0, 0, 0, 0},
> >>  };
> >>  
> >> @@ -127,7 +129,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >>  	char *endptr;
> >>  	int opt, i;
> >>  
> >> -	while((opt = getopt_long(argc, argv, "d:x:z:E:T:",
> >> +	while((opt = getopt_long(argc, argv, "d:x:z:E:T:e:",
> > Leave it unchanged.
> >
> > (opt = getopt_long(argc, argv, "d:x:z:E:T:",
> >
> >>  				 long_options, NULL)) != -1) {
> >>  		switch (opt) {
> >>  		case 'z':
> >> @@ -178,6 +180,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >>  			}
> >>  			break;
> >>  
> >> +		case 'e':
> > 		case 2:
> >
> > Thanks,
> > Gao Xiang
> >
> >> +			if (erofs_parse_exclude_path(optarg)) {
> >> +				usage();
> >> +				exit(0);
> >> +			}
> >> +			break;
> >> +
> >>  		case 1:
> >>  			usage();
> >>  			exit(0);
> >> @@ -334,6 +343,7 @@ int main(int argc, char **argv)
> >>  	struct timeval t;
> >>  
> >>  	erofs_init_configure();
> >> +	erofs_init_rules();
> >>  	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
> >>  
> >>  	cfg.c_legacy_compress = false;
> >> @@ -429,6 +439,7 @@ exit:
> >>  	z_erofs_compress_exit();
> >>  	dev_close();
> >>  	erofs_exit_configure();
> >> +	erofs_free_rules();
> >>  
> >>  	if (err) {
> >>  		erofs_err("\tCould not format the device : %s\n",
> >> -- 
> >> 2.17.1
> >>
> >>
> >
> 
