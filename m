Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDF64B121
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 09:27:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWWpM0xy5z3bh4
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 19:27:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWWpC1Xzzz3bZx
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 19:27:45 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VXDK.vC_1670920058;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXDK.vC_1670920058)
          by smtp.aliyun-inc.com;
          Tue, 13 Dec 2022 16:27:40 +0800
Date: Tue, 13 Dec 2022 16:27:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: fix fragmentoff overflow for large packed
 inode
Message-ID: <Y5g3eauzxLvKyyms@B-P7TQMD6M-0146.local>
References: <20221213071643.11874-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221213071643.11874-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, Khem Raj <raj.khem@gmail.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(cc Khem Raj <raj.khem@gmail.com>... Since I'd like to apply this first
 and then enable _FILE_OFFSET_BITS=64 unconditionally so that we could
 clean up all hard-coded _FILE_OFFSET_BITS in the source code.)

Hi Yue,

On Tue, Dec 13, 2022 at 03:16:43PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The return value of ftell() is a long int, use ftello{64} instead. Also,
> use lseek64 for large file position to avoid this error if we have it.
> And need to return at once if they fail.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  configure.ac    |  2 ++
>  lib/fragments.c | 34 +++++++++++++++++++++++++++++-----
>  lib/inode.c     |  9 +++++++--
>  3 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index a736ff0..5c9666a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -190,6 +190,8 @@ AC_CHECK_FUNCS(m4_flatten([
>  	llistxattr
>  	memset
>  	realpath
> +	lseek64
> +	ftello64
>  	pread64
>  	pwrite64
>  	strdup
> diff --git a/lib/fragments.c b/lib/fragments.c
> index e69ae47..4302cd5 100644
> --- a/lib/fragments.c
> +++ b/lib/fragments.c
> @@ -3,7 +3,18 @@
>   * Copyright (C), 2022, Coolpad Group Limited.
>   * Created by Yue Hu <huyue2@coolpad.com>
>   */
> +#ifndef _LARGEFILE_SOURCE
> +#define _LARGEFILE_SOURCE
> +#endif
> +#ifndef _LARGEFILE64_SOURCE
> +#define _LARGEFILE64_SOURCE
> +#endif
> +#ifndef _FILE_OFFSET_BITS
> +#define _FILE_OFFSET_BITS 64
> +#endif
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include "erofs/err.h"
> @@ -30,6 +41,13 @@ static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
>  static FILE *packedfile;
>  const char *frags_packedname = "packed_file";
>  
> +#ifndef HAVE_LSEEK64
> +static inline off_t lseek64(int fd, u64 offset, int set)
> +{
> +	return lseek(fd, offset, set);
> +}
> +#endif

Could we use another function name other than native lseek64?

> +
>  static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
>  					 u32 crc)
>  {
> @@ -53,8 +71,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	ret = lseek(fd, inode->i_size - length, SEEK_SET);
> -	if (ret < 0) {
> +	if (lseek64(fd, inode->i_size - length, SEEK_SET) < 0) {
>  		ret = -errno;
>  		goto out;
>  	}
> @@ -113,8 +130,7 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
>  	if (inode->i_size <= EROFS_TOF_HASHLEN)
>  		return 0;
>  
> -	ret = lseek(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET);
> -	if (ret < 0)
> +	if (lseek64(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET) < 0)
>  		return -errno;
>  
>  	ret = read(fd, data_to_hash, EROFS_TOF_HASHLEN);
> @@ -192,9 +208,17 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
>  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
>  			   unsigned int len, u32 tofcrc)
>  {
> +#ifdef HAVE_FTELLO64
> +	off64_t offset = ftello64(packedfile);
> +#else
> +	off_t offset = ftello(packedfile);
> +#endif
>  	int ret;
>  
> -	inode->fragmentoff = ftell(packedfile);
> +	if (offset < 0)
> +		return -errno;
> +
> +	inode->fragmentoff = (erofs_off_t)offset;
>  	inode->fragment_size = len;
>  
>  	if (fwrite(data, len, 1, packedfile) != 1)
> diff --git a/lib/inode.c b/lib/inode.c
> index 9de4dec..a8510f3 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1196,7 +1196,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
>  	struct erofs_inode *inode;
>  	int ret;
>  
> -	lseek(fd, 0, SEEK_SET);
> +	ret = lseek(fd, 0, SEEK_SET);
> +	if (ret < 0)
> +		return ERR_PTR(-errno);

This should be in a seperate patch, please don't fix it here.

> +
>  	ret = fstat64(fd, &st);
>  	if (ret)
>  		return ERR_PTR(-errno);
> @@ -1223,7 +1226,9 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
>  
>  	ret = erofs_write_compressed_file(inode, fd);
>  	if (ret == -ENOSPC) {
> -		lseek(fd, 0, SEEK_SET);
> +		ret = lseek(fd, 0, SEEK_SET);
> +		if (ret < 0)

Same here.

Thanks,
Gao Xiang

> +			return ERR_PTR(-errno);
>  		ret = write_uncompressed_file_from_fd(inode, fd);
>  	}
>  
> -- 
> 2.17.1
