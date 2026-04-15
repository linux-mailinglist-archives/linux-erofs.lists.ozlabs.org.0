Return-Path: <linux-erofs+bounces-3307-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P/uPCH0H32nWNwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3307-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 05:35:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31E40000E
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 05:35:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwRc65nFxz2yvL;
	Wed, 15 Apr 2026 13:35:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776224118;
	cv=none; b=n2BpdynVQoB/Wb6wpmJrlUIReoX7PuS3zGrfdte69JmqWKa+06hOO4lwLlHjbGsBsZ3/qVvOHhJmBTpyLFvrocsXUYsFQtwjf/Bg+ucONWpUHxnKX4uTYtXkxuqMmZGk/B7Q9+AnHanD3la6r5oViaA0qqu3mtu+g2kjICJZXraUzL8ff6IDblr3zNClFtg+jBqdxCJ63CavppOzaje5UwEqsLiXao67hbg8pH++C/Q71TANhMBlQ7uR8LkMg6cnb488YHkDXnMEqY8UAQIFVCxuCZZMcSomK0TlCx3iTyIn+zaSDwnIptRwbJDnRb0Ubryz5q/KaRALggatLtPzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776224118; c=relaxed/relaxed;
	bh=2j/TKbuPgDBJrRUeZwZMIb7BqVtTe5v4Gx1EF0/FiI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oIxzMOkJ+GQTm55eErjV0gec8ci+AMiX2eEYZcV3ZL1785a7hhBKUEzRMQOQ7eR8ruHIX2FrNJSAMmWFV3CFNziPEDK/kg2pJBvs9u0g0O3HER/yd9SEsYHB4ZcDq6QwJ3PuT8rk/cyUlSizgfoEqYYDaMdsc8XdvZuwMJScb8Bap0QEL079XUEg8ex2xMi+JwAzkVnWcz+JLXu8jcWHc9qEItqj/OEE3App/Hva8ASSU3h508CZYM1jWiAudGaNow7gsMpTQA1SCkBosKIDGVNw6LKkhu8zM8UT2jsX90A8BIcsy263g9UL2MJ2TSjft0bWfgNimlN2XDniLwjNdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y4Hy9aWX; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y4Hy9aWX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwRc33RSdz2yth
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 13:35:13 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2j/TKbuPgDBJrRUeZwZMIb7BqVtTe5v4Gx1EF0/FiI0=;
	b=y4Hy9aWXXvEWM0svRDs6DiCF5rtFIkNFD3cXmjJgtrwSGGDj8bdpTYFE4o6iEr3lXcgp0bXp5
	BNKMIV6Rr9VWda1S8SRyWRQMKZmE3sZuNM7HN1c3zv0SLYafWrvH7YbHEJl+JsWFu2HYd6QFJTU
	Njl2qvc58CmrGGRH2/bCycw=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fwRSl5cY4zpT03;
	Wed, 15 Apr 2026 11:28:55 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id D122140569;
	Wed, 15 Apr 2026 11:35:07 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Apr 2026 11:35:07 +0800
Message-ID: <3d420aa9-b123-4ba8-be3c-0b395dabb070@huawei.com>
Date: Wed, 15 Apr 2026 11:35:06 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] erofs-utils: mfks: add rebuild FULLDATA for
 combined EROFS images
To: Lucas Karpinski <lkarpinski@nvidia.com>, <linux-erofs@lists.ozlabs.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <jcalmels@nvidia.com>
References: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
 <20260414-merge-fs-v3-3-266bd1367fd2@nvidia.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260414-merge-fs-v3-3-266bd1367fd2@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3307-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 5A31E40000E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch incorrectly handles inline inode:

Reproduce in erofs-utils directory:
     mkfs/mkfs.erofs 1.erofs man/
     mkfs/mkfs.erofs 2.erofs docs/
     mkfs/mkfs.erofs --clean=data merged.erofs 1.erofs 2.erofs

Then PERFORMANCE.md in merged.erofs contains incorrect data after offset 
0x2000.

Fixed with following diff:

diff --git a/lib/inode.c b/lib/inode.c
   index bd10e26..36dce56 100644
   --- a/lib/inode.c
   +++ b/lib/inode.c
   @@ -683,6 +683,13 @@ static int erofs_write_unencoded_data(struct 
erofs_inode *inode,

         /* read the tail-end data */
         if (inode->idata_size) {
   +             /*
   +              * If inode->idata is already present, the caller has 
prepared
   +              * the tail data and nothing more needs to be done here.
   +              */
   +             if (inode->idata)
   +                     return 0;
   +
                 inode->idata = malloc(inode->idata_size);
                 if (!inode->idata)
                         return -ENOMEM;


On 2026/4/15 3:10, Lucas Karpinski wrote:
> This patch introduces experimental support for merging multiple source
> images in mkfs. Each regular file record the source image path and its byte
> offset. During the blob mkfs opens the blob and pulls the payload in via
> erofs_io_xcopy.
>
> This does not yet support chunk-based files or compressed images.
>
> Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
> ---
>   include/erofs/internal.h |  3 +++
>   lib/inode.c              | 31 ++++++++++++++++++---
>   lib/rebuild.c            | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
>   mkfs/main.c              |  7 +++--
>   4 files changed, 105 insertions(+), 6 deletions(-)
>
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index c780228c..450e2647 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -208,6 +208,7 @@ struct erofs_diskbuf;
>   #define EROFS_INODE_DATA_SOURCE_LOCALPATH	1
>   #define EROFS_INODE_DATA_SOURCE_DISKBUF		2
>   #define EROFS_INODE_DATA_SOURCE_RESVSP		3
> +#define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB	4
>   
>   #define EROFS_I_BLKADDR_DEV_ID_BIT		48
>   
> @@ -253,6 +254,8 @@ struct erofs_inode {
>   		char *i_link;
>   		struct erofs_diskbuf *i_diskbuf;
>   	};
> +	char *rebuild_blobpath;
> +	erofs_off_t rebuild_src_dataoff;
>   	unsigned char datalayout;
>   	unsigned char inode_isize;
>   	/* inline tail-end packing size */
> diff --git a/lib/inode.c b/lib/inode.c
> index 2f78d9b8..bd10e267 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -158,6 +158,8 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>   	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
>   		erofs_diskbuf_close(inode->i_diskbuf);
>   		free(inode->i_diskbuf);
> +	} else if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
> +		free(inode->rebuild_blobpath);
>   	} else {
>   		free(inode->i_link);
>   	}
> @@ -697,7 +699,10 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
>   
>   int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
>   {
> -	if (cfg.c_chunkbits) {
> +	struct erofs_vfile vf = { .fd = fd };
> +
> +	if (cfg.c_chunkbits &&
> +	    inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
>   		inode->u.chunkbits = cfg.c_chunkbits;
>   		/* chunk indexes when explicitly specified */
>   		inode->u.chunkformat = 0;
> @@ -706,10 +711,15 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
>   		return erofs_blob_write_chunked_file(inode, fd, fpos);
>   	}
>   
> +	if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
> +		if (erofs_io_lseek(&vf, fpos, SEEK_SET) != (off_t)fpos)
> +			return -EIO;
> +		return erofs_write_unencoded_data(inode, &vf, fpos, true, false);
> +	}
> +
>   	inode->datalayout = EROFS_INODE_FLAT_INLINE;
>   	/* fallback to all data uncompressed */
> -	return erofs_write_unencoded_data(inode,
> -			&(struct erofs_vfile){ .fd = fd }, fpos,
> +	return erofs_write_unencoded_data(inode, &vf, fpos,
>   			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF, false);
>   }
>   
> @@ -1508,6 +1518,12 @@ out:
>   		free(inode->i_diskbuf);
>   		inode->i_diskbuf = NULL;
>   		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
> +	} else if (inode->datasource == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
> +		free(inode->rebuild_blobpath);
> +		inode->rebuild_blobpath = NULL;
> +		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
> +		DBG_BUGON(ctx->fd < 0);
> +		close(ctx->fd);
>   	} else {
>   		DBG_BUGON(ctx->fd < 0);
>   		close(ctx->fd);
> @@ -2014,6 +2030,12 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
>   			if (ctx.fd < 0)
>   				return -errno;
>   			break;
> +		case EROFS_INODE_DATA_SOURCE_REBUILD_BLOB:
> +			ctx.fd = open(inode->rebuild_blobpath, O_RDONLY | O_BINARY);
> +			if (ctx.fd < 0)
> +				return -errno;
> +			ctx.fpos = inode->rebuild_src_dataoff;
> +			break;
>   		default:
>   			goto out;
>   		}
> @@ -2022,7 +2044,8 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
>   		if (ret < 0)
>   			return ret;
>   
> -		if (inode->sbi->available_compr_algs &&
> +		if (inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
> +		    inode->sbi->available_compr_algs &&
>   		    erofs_file_is_compressible(im, inode)) {
>   			ctx.ictx = erofs_prepare_compressed_file(im, inode);
>   			if (IS_ERR(ctx.ictx))
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 7ab2b499..3785afd0 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -14,8 +14,10 @@
>   #include "erofs/xattr.h"
>   #include "erofs/blobchunk.h"
>   #include "erofs/internal.h"
> +#include "erofs/io.h"
>   #include "liberofs_rebuild.h"
>   #include "liberofs_uuid.h"
> +#include "liberofs_cache.h"

Unnecessary include `liberofs_cache.h`


Thanks,

Yifan Zhao

>   
>   #ifdef HAVE_LINUX_AUFS_TYPE_H
>   #include <linux/aufs_type.h>
> @@ -221,6 +223,71 @@ err:
>   	return ret;
>   }
>   
> +static int erofs_rebuild_write_full_data(struct erofs_inode *inode)
> +{
> +	struct erofs_sb_info *src_sbi = inode->sbi;
> +	int err = 0;
> +
> +	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN) {
> +		if (inode->u.i_blkaddr == EROFS_NULL_ADDR) {
> +			if (inode->i_size)
> +				return -EFSCORRUPTED;
> +			return 0;
> +		}
> +		inode->rebuild_blobpath = strdup(src_sbi->devname);
> +		if (!inode->rebuild_blobpath)
> +			return -ENOMEM;
> +		inode->rebuild_src_dataoff =
> +			erofs_pos(src_sbi, erofs_inode_dev_baddr(inode));
> +		inode->datasource = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
> +	} else if (inode->datalayout == EROFS_INODE_FLAT_INLINE) {
> +		erofs_blk_t nblocks = erofs_blknr(src_sbi, inode->i_size);
> +		unsigned int inline_size = inode->i_size % erofs_blksiz(src_sbi);
> +
> +		if (nblocks > 0 && inode->u.i_blkaddr != EROFS_NULL_ADDR) {
> +			inode->rebuild_blobpath = strdup(src_sbi->devname);
> +			if (!inode->rebuild_blobpath)
> +				return -ENOMEM;
> +			inode->rebuild_src_dataoff =
> +				erofs_pos(src_sbi,
> +					  erofs_inode_dev_baddr(inode));
> +			inode->datasource = EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
> +		}
> +
> +		inode->idata_size = inline_size;
> +		if (inline_size > 0) {
> +			struct erofs_vfile vf;
> +			erofs_off_t tail_offset = erofs_pos(src_sbi, nblocks);
> +
> +			inode->idata = malloc(inline_size);
> +			if (!inode->idata)
> +				return -ENOMEM;
> +			err = erofs_iopen(&vf, inode);
> +			if (err) {
> +				free(inode->idata);
> +				inode->idata = NULL;
> +				return err;
> +			}
> +			err = erofs_pread(&vf, inode->idata, inline_size,
> +					  tail_offset);
> +			if (err) {
> +				free(inode->idata);
> +				inode->idata = NULL;
> +				return err;
> +			}
> +		}
> +	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
> +		erofs_err("chunk-based files not yet supported: %s",
> +			  inode->i_srcpath);
> +		err = -EOPNOTSUPP;
> +	} else if (is_inode_layout_compression(inode)) {
> +		erofs_err("compressed files not yet supported: %s",
> +			  inode->i_srcpath);
> +		err = -EOPNOTSUPP;
> +	}
> +	return err;
> +}
> +
>   static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
>   				      struct erofs_inode *inode,
>   				      enum erofs_rebuild_datamode datamode)
> @@ -265,6 +332,8 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
>   			err = erofs_rebuild_write_blob_index(dst_sb, inode);
>   		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
>   			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
> +		else if (datamode == EROFS_REBUILD_DATA_FULL)
> +			err = erofs_rebuild_write_full_data(inode);
>   		else
>   			err = -EOPNOTSUPP;
>   		break;
> @@ -553,3 +622,4 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
>   	};
>   	return erofs_iterate_dir(&ctx.ctx, false);
>   }
> +
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 6867478b..d75c97b2 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1756,7 +1756,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
>   		extra_devices += src->extra_devices;
>   	}
>   
> -	if (datamode != EROFS_REBUILD_DATA_BLOB_INDEX)
> +	if (datamode == EROFS_REBUILD_DATA_RESVSP)
>   		return 0;
>   
>   	/* Each blob has either no extra device or only one device for TarFS */
> @@ -1766,6 +1766,9 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
>   		return -EOPNOTSUPP;
>   	}
>   
> +	if (datamode == EROFS_REBUILD_DATA_FULL)
> +		return 0;
> +
>   	ret = erofs_mkfs_init_devices(&g_sbi, rebuild_src_count);
>   	if (ret)
>   		return ret;
> @@ -1788,7 +1791,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
>   			memcpy(devs[idx].tag, tag, sizeof(devs[0].tag));
>   		else
>   			/* convert UUID of the source image to a hex string */
> -			erofs_uuid_unparse_as_tag(src->uuid, (char *)g_sbi.devs[idx].tag);
> +			erofs_uuid_unparse_as_tag(src->uuid, (char *)devs[idx].tag);
>   	}
>   	return 0;
>   }
>

