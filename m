Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DB4797EE
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 01:53:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JG6lz17fQz307W
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 11:53:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JG6lr5cNzz2xtM
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 11:53:07 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R641e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V-xBnhO_1639788768; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-xBnhO_1639788768) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 18 Dec 2021 08:52:49 +0800
Date: Sat, 18 Dec 2021 08:52:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: erofs-utils: lib: add API to get pathname of EROFS inode
Message-ID: <Yb0w3hY2mOTk/R+Y@B-P7TQMD6M-0146.local>
References: <CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Igor,

On Fri, Dec 17, 2021 at 02:30:55PM +0200, Igor Eisberg wrote:
> 

Thanks for your patch. I have to sleep for a while since I'm really
tired these days..

As Yue Hu said, you could send out patches in the text rather as a
attachment. That is the common way for most communities.

Some comments below (if you don't mind I will update when I apply):

> From 3061d65ebab01802782bfe791b829bc00b386f91 Mon Sep 17 00:00:00 2001
> From: Igor Ostapenko <igoreisberg@gmail.com>
> Date: Fri, 17 Dec 2021 14:08:23 +0200
> Subject: erofs-utils: lib: add API to get pathname of EROFS inode
> 
> * General-purpose erofs_get_pathname function utilizing erofs_iterate_dir,
>   with recursion and a reused context to avoid overflowing the stack.
>   Recommended buffer size is PATH_MAX. Zero-filling the buffer is not
>   necessary.
> * dump: PATH_MAX+1 is not required since the definition of PATH_MAX is
>   "chars in a path name including nul".
> * Fix missing ctx->de_ftype = de->file_type; in traverse_dirents
>   (was never set).

Thanks for catching this. I will fold it in the original patch...

> * Return err from erofs_iterate_dir instead of hardcoded 0, to allow
>   breaking the iteration by the callback using a non-zero return code.
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
> ---
>  dump/main.c         | 72 ++--------------------------------
>  include/erofs/dir.h |  1 +
>  lib/dir.c           | 96 ++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 98 insertions(+), 71 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 7f3f743..3c3cc3f 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -328,71 +328,6 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
>  	return dname_len;
>  }
>  
> -static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
> -		erofs_nid_t target, char *path, unsigned int pos)
> -{
> -	int err;
> -	erofs_off_t offset;
> -	char buf[EROFS_BLKSIZ];
> -	struct erofs_inode inode = { .nid = nid };
> -
> -	path[pos++] = '/';
> -	if (target == sbi.root_nid)
> -		return 0;
> -
> -	err = erofs_read_inode_from_disk(&inode);
> -	if (err) {
> -		erofs_err("read inode failed @ nid %llu", nid | 0ULL);
> -		return err;
> -	}
> -
> -	offset = 0;
> -	while (offset < inode.i_size) {
> -		erofs_off_t maxsize = min_t(erofs_off_t,
> -					inode.i_size - offset, EROFS_BLKSIZ);
> -		struct erofs_dirent *de = (void *)buf;
> -		struct erofs_dirent *end;
> -		unsigned int nameoff;
> -
> -		err = erofs_pread(&inode, buf, maxsize, offset);
> -		if (err)
> -			return err;
> -
> -		nameoff = le16_to_cpu(de->nameoff);
> -		end = (void *)buf + nameoff;
> -		while (de < end) {
> -			const char *dname;
> -			int len;
> -
> -			nameoff = le16_to_cpu(de->nameoff);
> -			dname = (char *)buf + nameoff;
> -			len = erofs_checkdirent(de, end, maxsize, dname);
> -			if (len < 0)
> -				return len;
> -
> -			if (le64_to_cpu(de->nid) == target) {
> -				memcpy(path + pos, dname, len);
> -				path[pos + len] = '\0';
> -				return 0;
> -			}
> -
> -			if (de->file_type == EROFS_FT_DIR &&
> -			    le64_to_cpu(de->nid) != parent_nid &&
> -			    le64_to_cpu(de->nid) != nid) {
> -				memcpy(path + pos, dname, len);
> -				err = erofs_get_pathname(le64_to_cpu(de->nid),
> -						nid, target, path, pos + len);
> -				if (!err)
> -					return 0;
> -				memset(path + pos, 0, len);
> -			}
> -			++de;
> -		}
> -		offset += maxsize;
> -	}
> -	return -1;
> -}
> -
>  static int erofsdump_map_blocks(struct erofs_inode *inode,
>  		struct erofs_map_blocks *map, int flags)
>  {
> @@ -411,7 +346,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
>  	erofs_off_t size;
>  	u16 access_mode;
>  	struct erofs_inode inode = { .nid = dumpcfg.nid };
> -	char path[PATH_MAX + 1] = {0};
> +	char path[PATH_MAX];
>  	char access_mode_str[] = "rwxrwxrwx";
>  	char timebuf[128] = {0};
>  	unsigned int extent_count = 0;
> @@ -441,8 +376,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
>  		return;
>  	}
>  
> -	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid,
> -				 inode.nid, path, 0);
> +	err = erofs_get_pathname(&inode, path, sizeof(path));
>  	if (err < 0) {
>  		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
>  		return;
> @@ -598,7 +532,7 @@ static void erofsdump_print_statistic(void)
>  		.cb = erofsdump_dirent_iter,
>  		.de_nid = sbi.root_nid,
>  		.dname = "",
> -		.de_namelen = 0
> +		.de_namelen = 0,
>  	};
>  
>  	err = erofsdump_readdir(&ctx);
> diff --git a/include/erofs/dir.h b/include/erofs/dir.h
> index 25d6ce7..9d56f3f 100644
> --- a/include/erofs/dir.h
> +++ b/include/erofs/dir.h
> @@ -45,6 +45,7 @@ struct erofs_dir_context {
>  
>  /* iterate over inodes that are in directory */
>  int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck);
> +int erofs_get_pathname(struct erofs_inode *inode, char *buf, size_t size);
>  
>  #ifdef __cplusplus
>  }
> diff --git a/lib/dir.c b/lib/dir.c
> index 63e35ba..a3edf0b 100644
> --- a/lib/dir.c
> +++ b/lib/dir.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#include <stdlib.h>
>  #include "erofs/print.h"
>  #include "erofs/dir.h"
> -#include <stdlib.h>
>  
>  static int traverse_dirents(struct erofs_dir_context *ctx,
>  			    void *dentry_blk, unsigned int lblk,
> @@ -64,6 +64,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
>  
>  		ctx->dname = de_name;
>  		ctx->de_namelen = de_namelen;
> +		ctx->de_ftype = de->file_type;
>  		ctx->dot_dotdot = is_dot_dotdot_len(de_name, de_namelen);
>  		if (ctx->dot_dotdot) {
>  			switch (de_namelen) {
> @@ -121,7 +122,7 @@ out:
>  int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
>  {
>  	struct erofs_inode *dir = ctx->dir;
> -	int err;
> +	int err = 0;
>  	erofs_off_t pos;
>  	char buf[EROFS_BLKSIZ];
>  
> @@ -163,5 +164,96 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
>  			  dir->nid | 0ULL);
>  		return -EFSCORRUPTED;
>  	}
> +	return err;
> +}
> +
> +#define EROFS_PATHNAME_FOUND 1
> +
> +struct get_pathname_context {
> +	struct erofs_dir_context ctx;
> +	erofs_nid_t nid;
> +	char *buf;
> +	size_t size;
> +	size_t pos;
> +};
> +
> +static int get_pathname_iter(struct erofs_dir_context *ctx)
> +{
> +	int ret;
> +	struct get_pathname_context *pctx = (void *)ctx;
> +	const char *dname = ctx->dname;
> +	size_t len = ctx->de_namelen;
> +	size_t pos = pctx->pos;
> +
> +	if (ctx->de_nid == pctx->nid) {
> +		if (pos + len + 2 > pctx->size) {
> +			erofs_err("get_pathname buffer not large enough: len %zd, size %zd",
> +				  pos + len + 2, pctx->size);
> +			return -ENOMEM;
> +		}
> +
> +		pctx->buf[pos++] = '/';
> +		strncpy(pctx->buf + pos, dname, len);
> +		pctx->buf[pos + len] = '\0';
> +		return EROFS_PATHNAME_FOUND;
> +	}
> +
> +	if (ctx->de_ftype == EROFS_FT_DIR && !ctx->dot_dotdot) {
> +		struct erofs_inode dir = { .nid = ctx->de_nid };
> +
> +		ret = erofs_read_inode_from_disk(&dir);
> +		if (ret) {
> +			erofs_err("read inode failed @ nid %llu", dir.nid | 0ULL);
> +			return ret;
> +		}
> +
> +		ctx->dir = &dir;

I think old `ctx->dir', `pnid' and `flag' should be saved
when fsck == true.

If fsck == false, I'd suggest not set
EROFS_READDIR_VALID_PNID as well. Let me revise it.

Thanks,
Gao Xiang
