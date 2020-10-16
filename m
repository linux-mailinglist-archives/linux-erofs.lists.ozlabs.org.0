Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 54611290982
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 18:18:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCWXt33VBzDqjQ
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 03:18:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602865102;
	bh=Lg1n3Ne8KWiLgshce/B4ALYui7I5u/4QSfd5G6zkngo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZngDpP7YZiIJMQszdXK8oFSTcnLyfjZawsRQQDA+nkRu4M6399A9TU2NeO8r2TeOF
	 ilS7guMMaxAJiqXoqmijdpeoDmzDfPA9JZoFSig6JWN9F7K4lE1C8++YDahVzlngQh
	 odc/wS9bLyBTM5T2bZ/M9pOIFCM/uSewAzNPGDbvP/U/nEAejzOk0nG8DEKlUekozQ
	 0mKVa95VgXJunTH73ArDEM5q/RYIK3Kvt1jimPl9PMb1lXIJyo4FLbDe168LykM9oC
	 w080QNtH9Z/ASB1OmBtDsAM8nEh4vU+evfYrWMT48v3VzP52WxpkIcfVVmwo0AQ0ML
	 AK/ge6eSb7c/g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=sPdnefCx; dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCWXh1CltzDqNy
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 03:18:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602865084; bh=3hSu0swZk7JNbeNTiQrh8Yew85IqPsCi24IyhZErt64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=sPdnefCx3o0orTkQvRDICD7REKz1XbddjCbMqzn05HFpZHgtXDZj8GdfFklq+sJDFIIuIvY1KsstOT+/QCr3yoRJlNizYzgH3oHSJrzg0LTwhG6JaHUHUwpkF86map7WCUvdYrOXOOcdNE7+KBUiufpdJSqLgKi6k/rQNiKkX63Xi7LmBID/3BDlIggB1yQKK/NXYx3qaNaBe4egWI4h4wmRygKTa2isnQxpCz2muJZBAaHHARBIJT64Ijek9qnlcdmY/3UnJF7Hyy0yTIAEj1E4IDgB0cjkZZNqN7VG8g0clSWsNPIhPj7R10TMUitjEVjysMUKq0iUWLpWEsF+rg==
X-YMail-OSG: 7xzFU0cVM1m_FyyUZdFP6KLmT.SnJi1hIDrYUQwgO_2prwokm8cQdcPPCjpLhwJ
 vAnl77RWjUIA9IXeYnximbeaxJawF6GRti8ccBRBtyOcxFftzhsuu7hSX3epZr_.Ck860m9kCvKt
 KK2X7Vf1tspl2dno4mNkT93MKg_36Q_I0NgPKYsHSYLgMsTl2p3pswG6OJv7NLsAfQa8xFbL_5Br
 zKhFWxklo_ztrFJE3BD4RiOpmbbsbqf76WP4kPa.8.6ya_VYNI.kP9DcgtZR3PaDJ1KSPrzyUPXy
 wRZKCTjmoPBnH4molu9g9zMYZsJhTjHiFY7hsMJ2tEU5uMlUn8ETs30abY1aAlD_yqQegLLESAEN
 _rgvn30PcbKpbQlTOVoSaPQEK.C9jQJ4xlN1sp3eVtNNv4Fjt5Gkfm2cGTEZkhPa7ZouCiT_W4O9
 Q..R6r.p_oKgr3R6eHsjpAcCXinWa3l6cw3vxyI47q4el9pGW4IiLUljGqS_AGNW30Bv4cq85dqt
 55Ayq34nEPbac9hPwqZUOwTutBzUGLikIn7oJ5u_d2gRgzuDpeJFy9G3Nz3Q8BWGI.KsHZeVK3RM
 5ZD7sX8io654BX8Burq2sv2Ly_FAcw5eRb6_mjsxQuVrRmwLNKW0B.F0JPPSkccnM1CEaO.cB5v1
 SSPShzX96GJKlUiEB5VJ9HRBjvuR5kU2_NejbeUY40vPnnnWYaaPJy7AyRJ8AnLz7BqmtoThAEsh
 SbpLaXicqfXe9nhoQHF8JNrJBEeqt2PkgeeMuhfV6VU1olnPW6PKwz83shyXaPnq0tcFOpGvBRTQ
 KWw7nrwhDbI1akuAGIorNYD61yABpZxnkCkllpJIwUh6FWkINSFbLBWO1MPCFtwkSiqcamkaLLTM
 8CNdTgNn2H55SS4N9k8GNLcZI5J0sUskLKg.I9bHFiThUFhr824U.RwlVgou5iREEqgdg1fVnWCn
 4i5hpmY9endtmpQaCJSnMDjEAYvVEpyEF2gvy_BseYCrP7WMVrIxj.oKa8nRTNCWf_KeY36z.sGi
 srHYT6iha_Gm6cyByeDzqSbhXLu5IYmFmzL4Tj7lDs2enD.eJYdDkzdsP_LNjyJV8bcecLlZSnYg
 WRXH5nZWIIOUo62AWQhh65B78AioyF6Mf30UEQqnft0scEcgYi.UJz0dECTg9ixmM3RHw9ur483x
 rYFQPj053kAFTwnqPef5YNmJE64bkojSuuvaYKRMDsTswbw5oduQTscjN9Vb9vcUz_7lmES3eOcn
 vugBnBR19CWE99i44b__t6xUnCq8XiXextM7V7jvmssU5frDgnkEcxwzIniVqj75caXIQQWsNPRL
 AIzF3QGXbvX7X_SciR.F8nAn0YY0oQ9IYmH.sMMwudYCP9qmDKgBadGfaGAyJVNR7nfoexumrprO
 OAJbbET6jYgQ32fK1Rid.YeGzXbTyMRGFhMiLfrfbnapwxBn3Ezd_qx2Ondj0.8np8pDbcrsbiic
 Req1iAmeLHqnmu5OvW7PabWGnvnZDBu5AbVNx_f3SdZ39D6Ji9444
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 16 Oct 2020 16:18:04 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID e225e6c9015955083992fc8f34e51817; 
 Fri, 16 Oct 2020 16:17:57 +0000 (UTC)
Date: Sat, 17 Oct 2020 00:17:45 +0800
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 5/5] erofs-utils: support read compressed file
Message-ID: <20201016161736.GC32727@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201015133959.61007-1-huangjianan@oppo.com>
 <20201015133959.61007-5-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015133959.61007-5-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Thu, Oct 15, 2020 at 09:39:59PM +0800, Huang Jianan wrote:
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

I read the logic below, and generally it looks good! <thumb>

I'm now handling some minor thing about this and I will
update as the following patch to speed up the development.

> ---

...

> diff --git a/fuse/decompress.c b/fuse/decompress.c
> new file mode 100644
> index 0000000..e2df3ce
> --- /dev/null
> +++ b/fuse/decompress.c

we might need to move this file to lib/decompress.c

> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
> + * Created by Huang Jianan <huangjianan@oppo.com>
> + */
> +
> +#include <stdlib.h>
> +#include <lz4.h>
> +
> +#include "erofs/internal.h"
> +#include "erofs/err.h"
> +#include "decompress.h"
> +#include "logging.h"
> +#include "init.h"
> +
> +static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq)
> +{
> +	char *dest = rq->out + rq->ofs_out;

I think ofs_out can be omited, since we only care about the dest buffer here.
so (new) rq->out == (old)rq->out + rq->ofs_out.

> +	char *src = rq->in + rq->ofs_head;

need to judge if the outputsize is larger than EROFS_BLKSIZ, since it's
undefined on-disk behavior, and can be implemented in the future
on-disk update.

> +
> +	memcpy(dest, src, rq->outputsize - rq->ofs_head);
> +
> +	return 0;
> +}

And this function can be folded into z_erofs_decompress(), because the
implementation here is much simple enough.

> +
> +static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)

it might be renamed into z_erofs_decompress_lz4.

> +{
> +	int ret = 0;
> +	char *dest = rq->out + rq->ofs_out;
> +	char *src = rq->in;
> +	char *buff = NULL;
> +	bool support_0padding = false;
> +	unsigned int inputmargin = 0;
> +
> +	if (sbk->feature_incompat & EROFS_FEATURE_INCOMPAT_LZ4_0PADDING) {
> +		support_0padding = true;
> +
> +		while (!src[inputmargin & ~PAGE_MASK])
> +			if (!(++inputmargin & ~PAGE_MASK))
> +				break;
> +
> +		if (inputmargin >= rq->inputsize)
> +			return -EIO;
> +	}
> +
> +	if (rq->ofs_head) {

we might need to rethink about the name of ofs_head.

> +		buff = malloc(rq->outputsize);
> +		if (!buff)
> +			return -ENOMEM;
> +		dest = buff;

need some cleanup, and dest variable is assigned for several times,
but without making the logic simpler.

> +	}
> +
> +	if (rq->partial_decoding || !support_0padding)
> +		ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
> +						  rq->inputsize - inputmargin,
> +						  rq->outputsize, rq->outputsize);
> +	else
> +		ret = LZ4_decompress_safe(src + inputmargin, dest,
> +					  rq->inputsize - inputmargin,
> +					  rq->outputsize);
> +
> +	if (ret != (int)rq->outputsize) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	if (rq->ofs_head) {
> +		src = dest + rq->ofs_head;
> +		dest = rq->out + rq->ofs_out;
> +		memcpy(dest, src, rq->outputsize - rq->ofs_head);
> +	}
> +
> +out:
> +	if (buff)
> +		free(buff);
> +
> +	return ret;
> +}
> +
> +int z_erofs_decompress(struct z_erofs_decompress_req *rq)
> +{
> +	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
> +		return z_erofs_shifted_transform(rq);
> +
> +	return z_erofs_decompress_generic(rq);
> +}
> diff --git a/fuse/decompress.h b/fuse/decompress.h
> new file mode 100644
> index 0000000..cd395c3
> --- /dev/null
> +++ b/fuse/decompress.h

move this file to include/erofs/decompress.h

> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
> + * Created by Huang Jianan <huangjianan@oppo.com>
> + */
> +
> +#ifndef __EROFS_DECOMPRESS_H
> +#define __EROFS_DECOMPRESS_H
> +
> +#include "erofs/internal.h"
> +
> +enum {
> +	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> +	Z_EROFS_COMPRESSION_RUNTIME_MAX
> +};
> +
> +struct z_erofs_decompress_req {
> +	char *in, *out;
> +
> +	size_t ofs_out, ofs_head;
> +	unsigned int inputsize, outputsize;
> +
> +	/* indicate the algorithm will be used for decompression */
> +	unsigned int alg;
> +	bool partial_decoding;
> +};
> +
> +#ifdef LZ4_ENABLED
> +int z_erofs_decompress(struct z_erofs_decompress_req *rq);
> +#else
> +int z_erofs_decompress(struct z_erofs_decompress_req *rq)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
> +#endif
> diff --git a/fuse/dentry.h b/fuse/dentry.h
> index ee2144d..f89c506 100644
> --- a/fuse/dentry.h
> +++ b/fuse/dentry.h
> @@ -10,10 +10,11 @@
>  #include <stdint.h>
>  #include "erofs/internal.h"
>  
> +/* fixme: Deal with names that exceed the allocated size */
>  #ifdef __64BITS
> -#define DCACHE_ENTRY_NAME_LEN       40
> +#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
>  #else
> -#define DCACHE_ENTRY_NAME_LEN       48
> +#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
>  #endif

not related to this patch, does it relate to another preexist
bug about erofsfuse codebase?

>  
>  /* This struct declares a node of a k-tree.  Every node has a pointer to one of
> diff --git a/fuse/init.c b/fuse/init.c
> index 8198fa7..e9cc9f8 100644
> --- a/fuse/init.c
> +++ b/fuse/init.c
> @@ -17,7 +17,23 @@
>  
>  
>  struct erofs_super_block super;
> -static struct erofs_super_block *sbk = &super;
> +struct erofs_super_block *sbk = &super;
> +
> +static bool check_layout_compatibility(struct erofs_super_block *sb,
> +				       struct erofs_super_block *dsb)
> +{
> +	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
> +
> +	sb->feature_incompat = feature;
> +
> +	/* check if current kernel meets all mandatory requirements */
> +	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
> +		loge("unidentified incompatible feature %x, please upgrade kernel version",
> +		     feature & ~EROFS_ALL_FEATURE_INCOMPAT);
> +		return false;
> +	}
> +	return true;
> +}
>  
>  int erofs_init_super(void)
>  {
> @@ -40,6 +56,9 @@ int erofs_init_super(void)
>  		return -EINVAL;
>  	}
>  
> +	if (!check_layout_compatibility(sbk, sb))
> +		return -EINVAL;
> +
>  	sbk->checksum = le32_to_cpu(sb->checksum);
>  	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
>  	sbk->blkszbits = sb->blkszbits;
> @@ -56,6 +75,7 @@ int erofs_init_super(void)
>  	sbk->root_nid = le16_to_cpu(sb->root_nid);
>  
>  	logp("%-15s:0x%X", STR(magic), SUPER_MEM(magic));
> +	logp("%-15s:0x%X", STR(feature_incompat), SUPER_MEM(feature_incompat));
>  	logp("%-15s:0x%X", STR(feature_compat), SUPER_MEM(feature_compat));
>  	logp("%-15s:%u",   STR(blkszbits), SUPER_MEM(blkszbits));
>  	logp("%-15s:%u",   STR(root_nid), SUPER_MEM(root_nid));
> diff --git a/fuse/init.h b/fuse/init.h
> index d7a97b5..3fc4eb5 100644
> --- a/fuse/init.h
> +++ b/fuse/init.h
> @@ -13,6 +13,8 @@
>  
>  #define BOOT_SECTOR_SIZE	0x400
>  
> +extern struct erofs_super_block *sbk;
> +
>  int erofs_init_super(void);
>  erofs_nid_t erofs_get_root_nid(void);
>  erofs_off_t nid2addr(erofs_nid_t nid);
> diff --git a/fuse/namei.c b/fuse/namei.c
> index 7ed1168..510fcfd 100644
> --- a/fuse/namei.c
> +++ b/fuse/namei.c
> @@ -49,7 +49,7 @@ static inline dev_t new_decode_dev(u32 dev)
>  
>  int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
>  {
> -	int ret;
> +	int ret, ifmt;
>  	char buf[EROFS_BLKSIZ];
>  	struct erofs_inode_compact *v1;
>  	const erofs_off_t addr = nid2addr(nid);
> @@ -60,6 +60,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
>  		return -EIO;
>  
>  	v1 = (struct erofs_inode_compact *)buf;
> +	/* fixme: support extended inode */
> +	ifmt = le16_to_cpu(v1->i_format);
> +	if (__inode_version(ifmt) != EROFS_INODE_LAYOUT_COMPACT)
> +		return -EOPNOTSUPP;
> +
>  	vi->datalayout = __inode_data_mapping(le16_to_cpu(v1->i_format));
>  	vi->inode_isize = sizeof(struct erofs_inode_compact);
>  	vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
> @@ -88,6 +93,10 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
>  		return -EIO;
>  	}
>  
> +	vi->z_inited = false;
> +	if (erofs_inode_is_data_compressed(vi->datalayout))
> +		z_erofs_fill_inode(vi);
> +
>  	return 0;
>  }
>  
> diff --git a/fuse/read.c b/fuse/read.c
> index 3ce5c4f..cc0781f 100644
> --- a/fuse/read.c
> +++ b/fuse/read.c
> @@ -16,6 +16,7 @@
>  #include "namei.h"
>  #include "disk_io.h"
>  #include "init.h"
> +#include "decompress.h"
>  
>  size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
>  		       size_t size, off_t offset)
> @@ -78,6 +79,73 @@ finished:
>  
>  }
>  
> +size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
> +		       size_t size, off_t offset)
> +{
> +	int ret;
> +	size_t end, count, ofs, sum = size;
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +	};
> +	bool partial;
> +	unsigned int algorithmformat;
> +	char raw[EROFS_BLKSIZ];
> +
> +	while (sum) {
> +		end = offset + sum;
> +		map.m_la = end - 1;
> +
> +		ret = z_erofs_map_blocks_iter(vnode, &map);
> +		if (ret)
> +			return ret;
> +
> +		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +			sum -= map.m_llen;
> +			continue;
> +		}
> +
> +		ret = dev_read(raw, EROFS_BLKSIZ, map.m_pa);
> +		if (ret < 0 || (size_t)ret != EROFS_BLKSIZ)
> +			return -EIO;
> +
> +		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
> +						Z_EROFS_COMPRESSION_LZ4 :
> +						Z_EROFS_COMPRESSION_SHIFTED;
> +
> +		if (end >= map.m_la + map.m_llen) {
> +			count = map.m_llen;
> +			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
> +		} else {
> +			count = end - map.m_la;
> +			partial = true;
> +		}

it would be better to make the logic more explicitly, like:

-               if (end >= map.m_la + map.m_llen) {
-                       count = map.m_llen;
-                       partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
-               } else {
+               /*
+                * trim to the needed size if the returned extent is quite
+                * larger than requested, and set up partial flag as well.
+                */
+               if (end < map.m_la + map.m_llen) {
                        count = end - map.m_la;
                        partial = true;
+               } else {
+                       ASSERT(end == map.m_la + map_m_llen);
+                       count = map.m_llen;
+                       partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
                }

> +
> +		if ((off_t)map.m_la < offset) {
> +			ofs = offset - map.m_la;
> +			sum = 0;
> +		} else {
> +			ofs = 0;
> +			sum -= count;
> +		}

a bit weird here, anyway, let me clean up here as well.

> +
> +		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> +					.in = raw,
> +					.out = buffer,
> +					.ofs_out = sum,
> +					.ofs_head = ofs,
> +					.inputsize = EROFS_BLKSIZ,
> +					.outputsize = count,
> +					.alg = algorithmformat,
> +					.partial_decoding = partial
> +					 });
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	logi("nid:%u size=%zd offset=%llu done",
> +	     vnode->nid, size, (long long)offset);
> +	return size;
> +}
>  
>  int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
>  	       struct fuse_file_info *fi)
> @@ -107,7 +175,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
>  
>  	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
>  	case EROFS_INODE_FLAT_COMPRESSION:
> -		/* Fixme: */
> +		return erofs_read_data_compression(&v, buffer, size, offset);
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/fuse/zmap.c b/fuse/zmap.c
> new file mode 100644
> index 0000000..022ca1b
> --- /dev/null
> +++ b/fuse/zmap.c

let's move this file to lib/ as well.

> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Let's relicense this file to GPL-2.0+ for erofs-utils
(since I'm the original author, and assume you agree on this as well..)

> +/*
> + * Many parts of codes are copied from Linux kernel/fs/erofs.
> + *
> + * Copyright (C) 2018-2019 HUAWEI, Inc.
> + *             https://www.huawei.com/
> + * Created by Gao Xiang <gaoxiang25@huawei.com>
> + * Modified by Huang Jianan <huangjianan@oppo.com>
> + */
> +
> +#include "init.h"
> +#include "disk_io.h"
> +#include "logging.h"
> +
> +int z_erofs_fill_inode(struct erofs_vnode *vi)
> +{
> +	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
> +		vi->z_advise = 0;
> +		vi->z_algorithmtype[0] = 0;
> +		vi->z_algorithmtype[1] = 0;
> +		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> +		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
> +		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
> +		vi->z_inited = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
> +{
> +	int ret;
> +	erofs_off_t pos;
> +	struct z_erofs_map_header *h;
> +	char buf[8];
> +
> +	if (vi->z_inited)
> +		return 0;
> +
> +	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
> +
> +	pos = round_up(nid2addr(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
> +
> +	ret = dev_read(buf, 8, pos);
> +	if (ret < 0 && (uint32_t)ret != 8)
> +		return -EIO;
> +
> +	h = (struct z_erofs_map_header *)buf;
> +	vi->z_advise = le16_to_cpu(h->h_advise);
> +	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> +	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> +
> +	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> +		loge("unknown compression format %u for nid %llu",
> +		     vi->z_algorithmtype[0], vi->nid);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
> +	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
> +					((h->h_clusterbits >> 3) & 3);
> +
> +	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
> +		loge("unsupported physical clusterbits %u for nid %llu",
> +		     vi->z_physical_clusterbits[0], vi->nid);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
> +					((h->h_clusterbits >> 5) & 7);
> +	vi->z_inited = true;
> +
> +	return 0;
> +}
> +
> +struct z_erofs_maprecorder {
> +	struct erofs_vnode *vnode;
> +	struct erofs_map_blocks *map;
> +	void *kaddr;
> +
> +	unsigned long lcn;
> +	/* compression extent information gathered */
> +	u8  type;
> +	u16 clusterofs;
> +	u16 delta[2];
> +	erofs_blk_t pblk;
> +};
> +
> +static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> +				  erofs_blk_t eblk)
> +{
> +	int ret;
> +	struct erofs_map_blocks *const map = m->map;
> +	char *mpage = map->mpage;
> +
> +	if (map->index == eblk)
> +		return 0;
> +
> +	ret = dev_read(mpage, EROFS_BLKSIZ, blknr_to_addr(eblk));
> +	if (ret < 0 && (uint32_t)ret != EROFS_BLKSIZ)
> +		return -EIO;
> +
> +	map->index = eblk;
> +
> +	return 0;
> +}
> +
> +static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> +					 unsigned long lcn)
> +{
> +	struct erofs_vnode *const vi = m->vnode;
> +	const erofs_off_t ibase = nid2addr(vi->nid);
> +	const erofs_off_t pos =
> +		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
> +					       vi->xattr_isize) +
> +		lcn * sizeof(struct z_erofs_vle_decompressed_index);
> +	struct z_erofs_vle_decompressed_index *di;
> +	unsigned int advise, type;
> +	int err;
> +
> +	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> +	if (err)
> +		return err;
> +
> +	m->lcn = lcn;
> +	di = m->kaddr + erofs_blkoff(pos);
> +
> +	advise = le16_to_cpu(di->di_advise);
> +	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
> +		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
> +	switch (type) {
> +	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +		m->clusterofs = 1 << vi->z_logical_clusterbits;
> +		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
> +		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
> +		break;
> +	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +		m->clusterofs = le16_to_cpu(di->di_clusterofs);
> +		m->pblk = le32_to_cpu(di->di_u.blkaddr);
> +		break;
> +	default:
> +		DBG_BUGON(1);
> +		return -EOPNOTSUPP;
> +	}
> +	m->type = type;
> +	return 0;
> +}
> +
> +static unsigned int decode_compactedbits(unsigned int lobits,
> +					 unsigned int lomask,
> +					 u8 *in, unsigned int pos, u8 *type)
> +{
> +	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
> +	const unsigned int lo = v & lomask;
> +
> +	*type = (v >> lobits) & 3;
> +	return lo;
> +}
> +
> +static int unpack_compacted_index(struct z_erofs_maprecorder *m,
> +				  unsigned int amortizedshift,
> +				  unsigned int eofs)
> +{
> +	struct erofs_vnode *const vi = m->vnode;
> +	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> +	const unsigned int lomask = (1 << lclusterbits) - 1;
> +	unsigned int vcnt, base, lo, encodebits, nblk;
> +	int i;
> +	u8 *in, type;
> +
> +	if (1 << amortizedshift == 4)
> +		vcnt = 2;
> +	else if (1 << amortizedshift == 2 && lclusterbits == 12)
> +		vcnt = 16;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> +	base = round_down(eofs, vcnt << amortizedshift);
> +	in = m->kaddr + base;
> +
> +	i = (eofs - base) >> amortizedshift;
> +
> +	lo = decode_compactedbits(lclusterbits, lomask,
> +				  in, encodebits * i, &type);
> +	m->type = type;
> +	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
> +		m->clusterofs = 1 << lclusterbits;
> +		if (i + 1 != (int)vcnt) {
> +			m->delta[0] = lo;
> +			return 0;
> +		}
> +		/*
> +		 * since the last lcluster in the pack is special,
> +		 * of which lo saves delta[1] rather than delta[0].
> +		 * Hence, get delta[0] by the previous lcluster indirectly.
> +		 */
> +		lo = decode_compactedbits(lclusterbits, lomask,
> +					  in, encodebits * (i - 1), &type);
> +		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
> +			lo = 0;
> +		m->delta[0] = lo + 1;
> +		return 0;
> +	}
> +	m->clusterofs = lo;
> +	m->delta[0] = 0;
> +	/* figout out blkaddr (pblk) for HEAD lclusters */
> +	nblk = 1;
> +	while (i > 0) {
> +		--i;
> +		lo = decode_compactedbits(lclusterbits, lomask,
> +					  in, encodebits * i, &type);
> +		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
> +			i -= lo;
> +
> +		if (i >= 0)
> +			++nblk;
> +	}
> +	in += (vcnt << amortizedshift) - sizeof(__le32);
> +	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
> +	return 0;
> +}
> +
> +static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> +					    unsigned long lcn)
> +{
> +	struct erofs_vnode *const vi = m->vnode;
> +	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> +	const erofs_off_t ebase = round_up(nid2addr(vi->nid) + vi->inode_isize +
> +					   vi->xattr_isize, 8) +
> +		sizeof(struct z_erofs_map_header);
> +	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
> +	unsigned int compacted_4b_initial, compacted_2b;
> +	unsigned int amortizedshift;
> +	erofs_off_t pos;
> +	int err;
> +
> +	if (lclusterbits != 12)
> +		return -EOPNOTSUPP;
> +
> +	if (lcn >= totalidx)
> +		return -EINVAL;
> +
> +	m->lcn = lcn;
> +	/* used to align to 32-byte (compacted_2b) alignment */
> +	compacted_4b_initial = (32 - ebase % 32) / 4;
> +	if (compacted_4b_initial == 32 / 4)
> +		compacted_4b_initial = 0;
> +
> +	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> +		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> +	else
> +		compacted_2b = 0;
> +
> +	pos = ebase;
> +	if (lcn < compacted_4b_initial) {
> +		amortizedshift = 2;
> +		goto out;
> +	}
> +	pos += compacted_4b_initial * 4;
> +	lcn -= compacted_4b_initial;
> +
> +	if (lcn < compacted_2b) {
> +		amortizedshift = 1;
> +		goto out;
> +	}
> +	pos += compacted_2b * 2;
> +	lcn -= compacted_2b;
> +	amortizedshift = 2;
> +out:
> +	pos += lcn * (1 << amortizedshift);
> +	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> +	if (err)
> +		return err;
> +	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
> +}
> +
> +static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> +					  unsigned int lcn)
> +{
> +	const unsigned int datamode = m->vnode->datalayout;
> +
> +	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
> +		return legacy_load_cluster_from_disk(m, lcn);
> +
> +	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> +		return compacted_load_cluster_from_disk(m, lcn);
> +
> +	return -EINVAL;
> +}
> +
> +static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> +				   unsigned int lookback_distance)
> +{
> +	struct erofs_vnode *const vi = m->vnode;
> +	struct erofs_map_blocks *const map = m->map;
> +	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> +	unsigned long lcn = m->lcn;
> +	int err;
> +
> +	if (lcn < lookback_distance) {
> +		loge("bogus lookback distance @ nid %llu", vi->nid);
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	/* load extent head logical cluster if needed */
> +	lcn -= lookback_distance;
> +	err = z_erofs_load_cluster_from_disk(m, lcn);
> +	if (err)
> +		return err;
> +
> +	switch (m->type) {
> +	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +		if (!m->delta[0]) {
> +			loge("invalid lookback distance 0 @ nid %llu",
> +				  vi->nid);
> +			DBG_BUGON(1);
> +			return -EFSCORRUPTED;
> +		}
> +		return z_erofs_extent_lookback(m, m->delta[0]);
> +	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> +		map->m_flags &= ~EROFS_MAP_ZIPPED;
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +		map->m_la = (lcn << lclusterbits) | m->clusterofs;
> +		break;
> +	default:
> +		loge("unknown type %u @ lcn %lu of nid %llu",
> +		     m->type, lcn, vi->nid);
> +		DBG_BUGON(1);
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
> +			    struct erofs_map_blocks *map)
> +{
> +	struct z_erofs_maprecorder m = {
> +		.vnode = vi,
> +		.map = map,
> +		.kaddr = map->mpage,
> +	};
> +	int err = 0;
> +	unsigned int lclusterbits, endoff;
> +	unsigned long long ofs, end;
> +
> +	/* when trying to read beyond EOF, leave it unmapped */
> +	if (map->m_la >= vi->i_size) {
> +		map->m_llen = map->m_la + 1 - vi->i_size;
> +		map->m_la = vi->i_size;
> +		map->m_flags = 0;
> +		goto out;
> +	}
> +
> +	err = z_erofs_fill_inode_lazy(vi);
> +	if (err)
> +		goto out;
> +
> +	lclusterbits = vi->z_logical_clusterbits;
> +	ofs = map->m_la;
> +	m.lcn = ofs >> lclusterbits;
> +	endoff = ofs & ((1 << lclusterbits) - 1);
> +
> +	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
> +	if (err)
> +		goto out;
> +
> +	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
> +	end = (m.lcn + 1ULL) << lclusterbits;
> +	switch (m.type) {
> +	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> +		if (endoff >= m.clusterofs)
> +			map->m_flags &= ~EROFS_MAP_ZIPPED;
> +	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +		if (endoff >= m.clusterofs) {
> +			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> +			break;
> +		}
> +		/* m.lcn should be >= 1 if endoff < m.clusterofs */
> +		if (!m.lcn) {
> +			loge("invalid logical cluster 0 at nid %llu",
> +			     vi->nid);
> +			err = -EFSCORRUPTED;
> +			goto out;
> +		}
> +		end = (m.lcn << lclusterbits) | m.clusterofs;
> +		map->m_flags |= EROFS_MAP_FULL_MAPPED;
> +		m.delta[0] = 1;
> +	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +		/* get the correspoinding first chunk */
> +		err = z_erofs_extent_lookback(&m, m.delta[0]);
> +		if (err)
> +			goto out;
> +		break;
> +	default:
> +		loge("unknown type %u @ offset %llu of nid %llu",
> +		     m.type, ofs, vi->nid);
> +		err = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	map->m_llen = end - map->m_la;
> +	map->m_plen = 1 << lclusterbits;
> +	map->m_pa = blknr_to_addr(m.pblk);
> +	map->m_flags |= EROFS_MAP_MAPPED;
> +
> +out:
> +	logd("m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
> +	     map->m_la, map->m_pa,
> +	     map->m_llen, map->m_plen, map->m_flags);
> +
> +	DBG_BUGON(err < 0 && err != -ENOMEM);
> +	return err;
> +}
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index a9c769e..06d29a9 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -173,5 +173,18 @@ typedef int64_t         s64;
>  #define __maybe_unused      __attribute__((__unused__))
>  #endif
>  
> +struct __una_u32 { u32 x; } __packed;
> +
> +static inline u32 __get_unaligned_cpu32(const void *p)
> +{
> +	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
> +	return ptr->x;
> +}
> +
> +static inline u32 get_unaligned_le32(const void *p)
> +{
> +	return __get_unaligned_cpu32((const u8 *)p);
> +}

need to handle big-endian, anyway, minor for now.

Thanks,
Gao Xiang

