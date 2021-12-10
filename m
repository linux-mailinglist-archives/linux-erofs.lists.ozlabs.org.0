Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3E46F9AD
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 04:52:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9H6R4vnWz3c4w
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 14:52:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9H6G3l6yz305J
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 14:52:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0V-7NgRO_1639108328; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-7NgRO_1639108328) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 11:52:10 +0800
Date: Fri, 10 Dec 2021 11:52:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <huyue2@yulong.com>
Subject: Re: [RFC PATCH v3 1/2] erofs-utils: support tail-packing inline
 compressed data
Message-ID: <YbLO6C8Xpnsi5fr5@B-P7TQMD6M-0146.local>
References: <cover.1637140430.git.huyue2@yulong.com>
 <b1b3b72371dd4a6b46137dce2fab04899e111df9.1637140430.git.huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1b3b72371dd4a6b46137dce2fab04899e111df9.1637140430.git.huyue2@yulong.com>
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
Cc: geshifei@yulong.com, zhangwen@yulong.com, linux-erofs@lists.ozlabs.org,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Wed, Nov 17, 2021 at 05:22:00PM +0800, Yue Hu wrote:
> Currently, we only support tail-end inline data for uncompressed
> files, let's support it as well for compressed files.
> 
> The idea is from Xiang.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Sorry about delay. Finally I seeked some time to look into this...

> ---
> v3:
> - based on commit 9fe440d0ac03 ("erofs-utils: mkfs: introduce --quiet option").
> - move h_idata_size ahead of h_advise for compatibility.
> - rename feature/update messages which i think they are more exact.
> 
> v2:
> - add 2 bytes to record compressed size of tail-pcluster suggested from
>   Xiang and update related code.
> 
>  include/erofs/internal.h |  1 +
>  include/erofs_fs.h       | 10 ++++-
>  lib/compress.c           | 83 ++++++++++++++++++++++++++++++----------
>  lib/compressor.c         |  9 +++--
>  lib/decompress.c         |  4 ++
>  lib/inode.c              | 42 ++++++++++----------
>  mkfs/main.c              |  7 ++++
>  7 files changed, 108 insertions(+), 48 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 8b154ed..54e5939 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -110,6 +110,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
>  EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
>  EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
>  EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
> +EROFS_FEATURE_FUNCS(tail_packing, incompat, INCOMPAT_TAIL_PACKING)

How about moving fuse support as [PATCH 1/2] and introducing these?

Also the on-disk feature name is somewhat confusing, maybe
INCOMPAT_ZTAILPACKING

is better?

>  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>  
>  #define EROFS_I_EA_INITED	(1 << 0)
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 66a68e3..0ebcd5b 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -22,11 +22,13 @@
>  #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
>  #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
>  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> +#define EROFS_FEATURE_INCOMPAT_TAIL_PACKING	0x00000010
>  #define EROFS_ALL_FEATURE_INCOMPAT		\
>  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
>  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
>  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> +	 EROFS_FEATURE_INCOMPAT_TAIL_PACKING)
>  
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
> @@ -266,13 +268,17 @@ struct z_erofs_lz4_cfgs {
>   *                                  (4B) + 2B + (4B) if compacted 2B is on.
>   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
>   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> + * bit 3 : tail-packing inline (un)compressed data
>   */
>  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> +#define Z_EROFS_ADVISE_INLINE_DATA		0x0008
>  
>  struct z_erofs_map_header {
> -	__le32	h_reserved1;
> +	__le16	h_reserved1;
> +	/* record the (un)compressed size of tail-packing pcluster */
> +	__le16	h_idata_size;
>  	__le16	h_advise;
>  	/*
>  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> diff --git a/lib/compress.c b/lib/compress.c
> index 6ca5bed..d7d60b9 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -70,11 +70,10 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
>  
>  	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
>  
> -	/* whether the tail-end uncompressed block or not */
> +	/* whether the tail-end (un)compressed block or not */
>  	if (!d1) {
> -		/* TODO: tail-packing inline compressed data */
> -		DBG_BUGON(!raw);
> -		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
> +		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
> +			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
>  		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
>  
>  		di.di_advise = advise;
> @@ -162,6 +161,17 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
>  	return cfg.c_pclusterblks_def;
>  }
>  
> +static int z_erofs_fill_inline_data(struct erofs_inode *inode, char *data,
> +				    unsigned int len)
> +{
> +	inode->idata_size = len;
> +	inode->idata = malloc(inode->idata_size);
> +	if (!inode->idata)
> +		return -ENOMEM;
> +	memcpy(inode->idata, data, inode->idata_size);
> +	return 0;
> +}
> +
>  static int vle_compress_one(struct erofs_inode *inode,
>  			    struct z_erofs_vle_compress_ctx *ctx,
>  			    bool final)
> @@ -172,15 +182,20 @@ static int vle_compress_one(struct erofs_inode *inode,
>  	int ret;
>  	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
>  	char *const dst = dstbuf + EROFS_BLKSIZ;
> +	bool tail_pcluster = false;
>  
>  	while (len) {
> -		const unsigned int pclustersize =
> +		unsigned int pclustersize =
>  			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
>  		bool raw;
>  
> -		if (len <= pclustersize) {
> +		if (!tail_pcluster && len <= pclustersize) {
>  			if (final) {
> -				if (len <= EROFS_BLKSIZ)
> +				/* TODO: compress with 2 pclusters */
> +				if (erofs_sb_has_tail_packing()) {
> +					tail_pcluster = true;
> +					pclustersize = EROFS_BLKSIZ;
> +				} else if (len <= EROFS_BLKSIZ)
>  					goto nocompression;
>  			} else {

It seems somewhat messy...
Just a rough thought, how about the following code (not even tested...)

--- a/lib/compress.c
+++ b/lib/compress.c
@@ -182,21 +182,22 @@ static int vle_compress_one(struct erofs_inode *inode,
        int ret;
        static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
        char *const dst = dstbuf + EROFS_BLKSIZ;
-       bool tail_pcluster = false;
+       bool trailing = false;

        while (len) {
                unsigned int pclustersize =
                        z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
                bool raw;

-               if (!tail_pcluster && len <= pclustersize) {
+               if (len <= pclustersize) {
                        if (final) {
                                /* TODO: compress with 2 pclusters */
                                if (erofs_sb_has_tail_packing()) {
-                                       tail_pcluster = true;
+                                       trailing = true;
                                        pclustersize = EROFS_BLKSIZ;
-                               } else if (len <= EROFS_BLKSIZ)
+                               } else if (len <= EROFS_BLKSIZ) {
                                        goto nocompression;
+                               }
                        } else {
                                break;
                        }
@@ -211,23 +212,29 @@ static int vle_compress_one(struct erofs_inode *inode,
                                          inode->i_srcpath,
                                          erofs_strerror(ret));
                        }
-                       if (tail_pcluster && len < EROFS_BLKSIZ) {
+                       if (trailing && len < EROFS_BLKSIZ) {
                                ret = z_erofs_fill_inline_data(inode,
                                        (char *)(ctx->queue + ctx->head), len);
                                if (ret)
                                        return ret;
                                count = len;
                                raw = true;
+                               ctx->compressedblks = 0;
+                       } else {
+nocompression:
+                               ret = write_uncompressed_extent(ctx, &len, dst);
+                               if (ret < 0)
+                                       return ret;
+                               count = ret;
                                ctx->compressedblks = 1;
-                               goto add_head;
+                               raw = true;
                        }
-nocompression:
-                       ret = write_uncompressed_extent(ctx, &len, dst);
-                       if (ret < 0)
+               } else if (trailing && ret < EROFS_BLKSIZ && len == count) {
+                       ret = z_erofs_fill_inline_data(inode, dst, ret);
+                       if (ret)
                                return ret;
-                       count = ret;
-                       ctx->compressedblks = 1;
-                       raw = true;
+                       raw = false;
+                       ctx->compressedblks = 0;
                } else {
                        if (tail_pcluster && ret < EROFS_BLKSIZ &&
                            !(len - count)) {
@@ -262,7 +269,6 @@ nocompression:
                        raw = false;
                }

-add_head:
                ctx->head += count;
                /* write compression indexes for this pcluster */
                vle_write_indexes(ctx, count, raw);

Thanks,
Gao Xiang
