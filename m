Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E313F6D05
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 03:18:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvSls6vdQz2yKB
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Aug 2021 11:18:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvSlk6H3Tz2xlC
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 11:18:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Ulfv4WS_1629854259; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Ulfv4WS_1629854259) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 25 Aug 2021 09:17:41 +0800
Date: Wed, 25 Aug 2021 09:17:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] erofs-utils: support per-inode compress pcluster
Message-ID: <YSWaMjYusTMt7Ccf@B-P7TQMD6M-0146.local>
References: <20210816094043.43772-1-huangjianan@oppo.com>
 <20210818042715.24416-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818042715.24416-1-huangjianan@oppo.com>
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 18, 2021 at 12:27:15PM +0800, Huang Jianan via Linux-erofs wrote:
> Add an option to configure per-inode compression strategy. Each line
> of the file should be in the following form:
> 
> <Regular-expression> <pcluster-in-bytes>
> 
> When pcluster is 0, it means that the file shouldn't be compressed.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Sorry for the delay. Due to busy work, I will look into the details
this weekend. Some comments in advance.

> ---
> changes since v1:
>  - rename c_pclusterblks to c_physical_clusterblks and place it in union
>  - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster()
>    since it's per-inode compression strategy
> 
>  include/erofs/compress_rule.h |  25 ++++++++

How about calling "compress_hints"? Does it sound better?

>  include/erofs/config.h        |   1 +

...

> index 0000000..497d662
> --- /dev/null
> +++ b/lib/compress_rule.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * erofs-utils/lib/compress_rule.c
> + *
> + * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
> + * Created by Huang Jianan <huangjianan@oppo.com>
> + */
> +#include <string.h>
> +#include <stdlib.h>
> +#include "erofs/err.h"
> +#include "erofs/list.h"
> +#include "erofs/print.h"
> +#include "erofs/compress_rule.h"
> +
> +static LIST_HEAD(compress_rule_head);
> +
> +static void dump_regerror(int errcode, const char *s, const regex_t *preg)
> +{
> +	char str[512];
> +
> +	regerror(errcode, preg, str, sizeof(str));
> +	erofs_err("invalid regex %s (%s)\n", s, str);
> +}
> +
> +static int erofs_insert_compress_rule(const char *s, unsigned int blks)
> +{
> +	struct erofs_compress_rule *r;
> +	int ret = 0;
> +
> +	r = malloc(sizeof(struct erofs_compress_rule));
> +	if (!r)
> +		return -ENOMEM;
> +
> +	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
> +	if (ret) {
> +		dump_regerror(ret, s, &r->reg);
> +		goto err;
> +	}
> +	r->c_physical_clusterblks = blks;
> +
> +	list_add_tail(&r->list, &compress_rule_head);
> +	erofs_info("insert compress rule %s: %u", s, blks);
> +	return ret;
> +
> +err:
> +	free(r);
> +	return ret;
> +}
> +
> +unsigned int erofs_parse_pclusterblks(struct erofs_inode *inode)
> +{
> +	const char *s;
> +	struct erofs_compress_rule *r;
> +
> +	if (inode->c_physical_clusterblks)
> +		return inode->c_physical_clusterblks;
> +
> +	s = erofs_fspath(inode->i_srcpath);
> +
> +	list_for_each_entry(r, &compress_rule_head, list) {
> +		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
> +
> +		if (!ret) {
> +			inode->c_physical_clusterblks = r->c_physical_clusterblks;
> +			return r->c_physical_clusterblks;
> +		}
> +		if (ret > REG_NOMATCH)
> +			dump_regerror(ret, s, &r->reg);
> +	}
> +
> +	inode->c_physical_clusterblks = cfg.c_physical_clusterblks;
> +	return cfg.c_physical_clusterblks;
> +}
> +
> +int erofs_load_compress_rule()
> +{
> +	char buf[PATH_MAX + 100];
> +	FILE* f;
> +	int ret = 0;
> +
> +	if (!cfg.compress_rule_file)
> +		return 0;
> +
> +	f = fopen(cfg.compress_rule_file, "r");
> +	if (f == NULL)
> +		return -errno;
> +
> +	while (fgets(buf, sizeof(buf), f)) {
> +		char* line = buf;
> +		char* s;
> +		unsigned int blks;
> +
> +		s = strtok(line, " ");
> +		blks = atoi(strtok(NULL, " "));
> +		if (blks % EROFS_BLKSIZ) {

We might need to guarantee these are power of 2.
Also, how about just printing out warning message but using default "-C"
value instead?

> +			erofs_err("invalid physical clustersize %u", blks);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		erofs_insert_compress_rule(s, blks / EROFS_BLKSIZ);
> +	}
> +
> +out:
> +	fclose(f);
> +	return ret;
> +}

...

> diff --git a/mkfs/main.c b/mkfs/main.c
> index 10fe14d..467e875 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -23,6 +23,7 @@
>  #include "erofs/xattr.h"
>  #include "erofs/exclude.h"
>  #include "erofs/block_list.h"
> +#include "erofs/compress_rule.h"
>  
>  #ifdef HAVE_LIBUUID
>  #include <uuid.h>
> @@ -44,11 +45,12 @@ static struct option long_options[] = {
>  	{"random-pclusterblks", no_argument, NULL, 8},
>  #endif
>  	{"max-extent-bytes", required_argument, NULL, 9},
> +	{"compress-rule", required_argument, NULL, 10},
>  #ifdef WITH_ANDROID
> -	{"mount-point", required_argument, NULL, 10},
> -	{"product-out", required_argument, NULL, 11},
> -	{"fs-config-file", required_argument, NULL, 12},
> -	{"block-list-file", required_argument, NULL, 13},
> +	{"mount-point", required_argument, NULL, 20},
> +	{"product-out", required_argument, NULL, 21},
> +	{"fs-config-file", required_argument, NULL, 22},
> +	{"block-list-file", required_argument, NULL, 23},

I think we might clean up these first with a separated patch.
Use >= 256 for all of them instead.

Thanks,
Gao Xiang

