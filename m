Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A729374F0
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 10:19:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JpmX0r2H;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQMyl5dqbz3cXG
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 18:19:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JpmX0r2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQMyg69pKz3bNs
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jul 2024 18:19:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721377143; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NQxfvuv/x3tpOXeDldbXM6cGd/sXYA4MiM9VFkgBA34=;
	b=JpmX0r2HgtvVLzNc0/jJsMEEez071apvftNEpXYJQaY6tKcTo4z1cFQANHTV6Clj2N6h/+K8ZfmBuyWLxBRLKHVRtBhqG4ehkzoyWFTGa7cVY5aiaxPjrGzFWSZG2YCANHzEA4h9f/dwjigWXWdflXvtTJ/Z4Ibxw6DJJl8NUsI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAr9wl5_1721377141;
Received: from 30.97.48.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAr9wl5_1721377141)
          by smtp.aliyun-inc.com;
          Fri, 19 Jul 2024 16:19:02 +0800
Message-ID: <86b8dca3-65bb-4f15-b0a4-c1fbdf80381f@linux.alibaba.com>
Date: Fri, 19 Jul 2024 16:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] erofs-utils: lib: enhance erofs_rebuild_get_dentry
 with bloom filter
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
 <20240718054025.427439-3-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240718054025.427439-3-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/18 13:40, Hongzhen Luo wrote:
> Add a bloom filter to exclude entries that are not in `pwd->i_subdirs`,
> thereby improving the performance of `erofs_rebuild_get_dentry`. Below
> are the results for different # of files in the same directory:
> 
> +---------+--------------------+
> | # files | time reduction (%) |
> +---------+--------------------+
> |   1e4   |         55%        |
> +---------+--------------------+
> |   1e5   |         98%        |
> +---------+--------------------+
> |   2e5   |         98%        |
> +---------+--------------------+
> |   3e5   |         99%        |
> +---------+--------------------+
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   lib/rebuild.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-------
>   lib/super.c   |  2 ++
>   mkfs/main.c   |  4 ++++
>   3 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 9e8bf8f..3fd3ea0 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -15,6 +15,7 @@
>   #include "erofs/xattr.h"
>   #include "erofs/blobchunk.h"
>   #include "erofs/internal.h"
> +#include "erofs/bloom_filter.h"
>   #include "liberofs_uuid.h"
>   
>   #ifdef HAVE_LINUX_AUFS_TYPE_H
> @@ -62,14 +63,48 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
>   		char *path, bool aufs, bool *whout, bool *opq, bool to_head)
>   {
>   	struct erofs_dentry *d = NULL;
> -	unsigned int len = strlen(path);
> -	char *s = path;
> +	unsigned int len, p = 0;
> +	char *s;
> +	struct erofs_sb_info *sbi = pwd->sbi;
> +	char buf[4096];
>   
>   	*whout = false;
>   	*opq = false;
>   
> +	s = pwd->i_srcpath;
> +	len = strlen(pwd->i_srcpath);
> +	/* normalize the pwd path, e.g., /./../xxx/yyy -> /xxx/yyy */
> +	buf[p++] = '/';
> +	while (s < pwd->i_srcpath + len) {

Why should we need that?


> +		char *slash = memchr(s, '/', pwd->i_srcpath + len - s);
> +		if (slash) {
> +			if (s == slash) {
> +				while(*++s == '/');
> +				continue;;
> +			}
> +			*slash = '\0';
> +		}
> +		if (memcmp(s, ".", 2) && memcmp(s, "..", 3)) {
> +			memcpy(buf + p, s, strlen(s));
> +			p += strlen(s);
> +			buf[p++] = '/';
> +
> +		}
> +		if (slash) {
> +			*slash = '/';
> +			s = slash + 1;
> +		} else{
> +			break;
> +		}
> +	}
> +	if (buf[p - 1] != '/')
> +		buf[p++] = '/';
> +
> +	s = path;
> +	len = strlen(path);
>   	while (s < path + len) {
>   		char *slash = memchr(s, '/', path + len - s);
> +		int bloom, slen;
>   
>   		if (slash) {
>   			if (s == slash) {
> @@ -97,13 +132,19 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
>   				}
>   			}
>   
> -			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
> -				if (!strcmp(d->name, s)) {
> -					if (d->type != EROFS_FT_DIR && slash)
> -						return ERR_PTR(-EIO);
> -					inode = d->inode;
> -					break;
> +			slen = strlen(s);
> +			memcpy(buf + p, s, slen);
> +			p += slen;
> +			if ((bloom = erofs_bloom_test(sbi, buf, p)) > 0) {
> +				list_for_each_entry(d, &pwd->i_subdirs, d_child) {
> +					if (!strcmp(d->name, s)) {
> +						if (d->type != EROFS_FT_DIR && slash)
> +							return ERR_PTR(-EIO);
> +						inode = d->inode;
> +						break;
> +					}
>   				}
> +
>   			}
>   
>   			if (inode) {
> @@ -124,6 +165,10 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
>   					return d;
>   				pwd = d->inode;
>   			}
> +			if (!bloom && erofs_bloom_add(sbi, buf, p))
> +				return ERR_PTR(-EINVAL);
> +			if (slash)
> +				buf[p++] = '/';
>   		}
>   		if (slash) {
>   			*slash = '/';
> diff --git a/lib/super.c b/lib/super.c
> index 45233c4..7289236 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -7,6 +7,7 @@
>   #include "erofs/print.h"
>   #include "erofs/xattr.h"
>   #include "erofs/cache.h"
> +#include "erofs/bloom_filter.h"
>   
>   static bool check_layout_compatibility(struct erofs_sb_info *sbi,
>   				       struct erofs_super_block *dsb)
> @@ -153,6 +154,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
>   		erofs_buffer_exit(sbi->bmgr);
>   		sbi->bmgr = NULL;
>   	}
> +	erofs_bloom_exit(sbi);
>   }
>   
>   int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 20f12fc..27a2ea0 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,7 @@
>   #include "../lib/liberofs_private.h"
>   #include "../lib/liberofs_uuid.h"
>   #include "../lib/compressor.h"
> +#include "erofs/bloom_filter.h"
>   
>   static struct option long_options[] = {
>   	{"version", no_argument, 0, 'V'},
> @@ -1344,6 +1345,9 @@ int main(int argc, char **argv)
>   	}
>   
>   	erofs_inode_manager_init();
> +	srand(time(NULL));
> +	/* 1000000 should be enough */
> +	erofs_bloom_init(&g_sbi, 5, 1000000, rand());

I don't want to add any new init function anymore, please wrap
all init functions into a common one.

Also what's the meaning of hard-coded 1000000?

Thanks,
Gao Xiang
