Return-Path: <linux-erofs+bounces-2504-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO1dNdvrqGnnygAAu9opvQ
	(envelope-from <linux-erofs+bounces-2504-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 03:35:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26420A38A
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 03:35:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRDCV2lkmz30MZ;
	Thu, 05 Mar 2026 13:35:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772678102;
	cv=none; b=lKlL4iG4gVDpFD1xgbqBfWai/BPBLHqbOUd4KUbkyF/uTKd3PEmjEQJwiEV0cjy3Dk4gN918/0AZx7yna160Oo9Yui6LKnkiiM7jby7SyqPbE3hm9Z+mbR4vn1bglDVshNNDN/73QrEru2lN2O9tMApTGH6+JTVyuzBt47I95oTjJz45c5H5HntYAKd7dtG8oKHYq3CvtR66joV6S00bBS0+7WMm5Vm++y95CD5cluA8NFe5k7954kbI5AnDYlgUuomzV8RUIyIUUXcoYP3rbhlVrAU03uwOtF1/hUwe11WIYTPjDlSXiMCTTMfi/SaXNZUGI42RraOBY1T9PYCkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772678102; c=relaxed/relaxed;
	bh=HzvTbUZ6MsrkMIAD/mXn/Fy+qMSjHjDdRGbhCwZ5nyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=efT+yEH0R7ESGs+j6MjrZtQmfI84NOhPeg2nE/128nmMEmMCC6WV66Wz0mb1Ro/yXvGUupu3b93yVdwRRTYaGY2zHknEUSai9aUXavEcGtkZ9xHPVzX6MDPZUzjsF3Q2D3/hDyyRz8eEzY6xKlXwy6Zqh06EoocrPcqylIEeuVHLUV23gVhwm030GbitT+vNJ0m+c3tiu4gyf4vDGVOYNTcIrQzdq3lVDRuJFwUfVRQAnpP4BEH2n0z0G1bOyon4o+2JlH4VwtzVrP3zwv6Nnx5PmerNERybbMqmAkXQhEXnoX/u+5MuACCLS+RvdwZDxQhOt8DdEZtCRHlaA9a7Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=pIFS9zhh; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=pIFS9zhh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRDCR492nz30FF
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 13:34:55 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HzvTbUZ6MsrkMIAD/mXn/Fy+qMSjHjDdRGbhCwZ5nyY=;
	b=pIFS9zhhsgEPCta5KX6goQyprutzQtga5vc988rSv4WH+BW2gDb/qlQbY52PXAfI+IeJLVuSG
	1FsSWpnVxFPH6sYhHlSQKgegtbku5KZzneTNIJhc0T1Y3TM5IOymwwMZ6vwhwhqR7HYv2pEpjCz
	d5fsZLbzastvqt6x+5iwP40=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fRD5x5YcHznV02;
	Thu,  5 Mar 2026 10:30:13 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 07AE840562;
	Thu,  5 Mar 2026 10:34:50 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Mar 2026 10:34:49 +0800
Message-ID: <9df761dd-7ec1-4471-8a2b-2949e043e9fb@huawei.com>
Date: Thu, 5 Mar 2026 10:34:49 +0800
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
Subject: Re: [PATCH 4/5] erofs-utils: mfks: add rebuild FULLDATA for combined
 EROFS images
To: Lucas Karpinski <lkarpinski@nvidia.com>, <linux-erofs@lists.ozlabs.org>
CC: <jcalmels@nvidia.com>
References: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
 <20260302-merge-fs-v1-4-a7254423447c@nvidia.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260302-merge-fs-v1-4-a7254423447c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 5F26420A38A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2504-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,nvidia.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

On 2026/3/3 4:01, Lucas Karpinski wrote:
> This patch introduces experimental support for merging multiple source
> images in mkfs. Each source image uses its stored UUID as the device table
> tag. The raw block data from each source is copied using
> erofs_copy_file_range.
>
> This does not yet support chunk-based files at this time or compressed
> images.
>
> Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
> ---
>   lib/cache.c            |   6 ++
>   lib/liberofs_cache.h   |   1 +
>   lib/liberofs_rebuild.h |   5 ++
>   lib/rebuild.c          | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   mkfs/main.c            |   6 +-
>   5 files changed, 183 insertions(+), 4 deletions(-)
>
> diff --git a/lib/cache.c b/lib/cache.c
> index 4c7c386..49742bc 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -544,6 +544,12 @@ erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr)
>   	return bmgr->metablkcnt;
>   }
>   
> +void erofs_bset_tail(struct erofs_bufmgr *bmgr, erofs_blk_t blkaddr)
> +{
> +	if (blkaddr > bmgr->tail_blkaddr)
> +		bmgr->tail_blkaddr = blkaddr;
> +}
> +
>   void erofs_buffer_exit(struct erofs_bufmgr *bmgr)
>   {
>   	DBG_BUGON(__erofs_bflush(bmgr, NULL, true));
> diff --git a/lib/liberofs_cache.h b/lib/liberofs_cache.h
> index baac609..55e8f25 100644
> --- a/lib/liberofs_cache.h
> +++ b/lib/liberofs_cache.h
> @@ -138,6 +138,7 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
>   		 struct erofs_buffer_block *bb);
>   
>   void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
> +void erofs_bset_tail(struct erofs_bufmgr *bmgr, erofs_blk_t blkaddr);
>   void erofs_buffer_exit(struct erofs_bufmgr *bmgr);
>   
>   #ifdef __cplusplus
> diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
> index d8c4c8a..32d9e2f 100644
> --- a/lib/liberofs_rebuild.h
> +++ b/lib/liberofs_rebuild.h
> @@ -17,6 +17,11 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
>   			    enum erofs_rebuild_datamode mode,
>   			    erofs_blk_t uniaddr_offset);
>   
> +int erofs_rebuild_load_trees_full(struct erofs_inode *root,
> +				  struct erofs_sb_info *sbi,
> +				  struct list_head *src_list,
> +				  unsigned int src_count);
> +
>   int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
>   			       unsigned int *i_nlink);
>   #endif
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 7e62bc9..16ef0cf 100644
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
>   
>   #ifdef HAVE_LINUX_AUFS_TYPE_H
>   #include <linux/aufs_type.h>
> @@ -221,9 +223,60 @@ err:
>   	return ret;
>   }
>   
> +static int erofs_rebuild_write_full_data(struct erofs_inode *inode,
> +					 erofs_blk_t uniaddr_offset)
> +{
> +	struct erofs_sb_info *src_sbi = inode->sbi;
> +	int err = 0;
> +
> +	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN) {
> +		if (inode->u.i_blkaddr != EROFS_NULL_ADDR)
> +			inode->u.i_blkaddr += uniaddr_offset;
> +	} else if (inode->datalayout == EROFS_INODE_FLAT_INLINE) {
> +		erofs_blk_t nblocks = erofs_blknr(src_sbi, inode->i_size);
> +		unsigned int inline_size = inode->i_size % erofs_blksiz(src_sbi);
> +
> +		if (nblocks > 0 && inode->u.i_blkaddr != EROFS_NULL_ADDR)
> +			inode->u.i_blkaddr += uniaddr_offset;
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
> -				      enum erofs_rebuild_datamode datamode)
> +				      enum erofs_rebuild_datamode datamode,
> +				      erofs_blk_t uniaddr_offset)
>   {
>   	int err = 0;
>   
> @@ -265,6 +318,8 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
>   			err = erofs_rebuild_write_blob_index(dst_sb, inode);
>   		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
>   			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
> +		else if (datamode == EROFS_REBUILD_DATA_FULL)
> +			err = erofs_rebuild_write_full_data(inode, uniaddr_offset);
>   		else
>   			err = -EOPNOTSUPP;
>   		break;
> @@ -387,7 +442,8 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
>   			inode->i_nlink = 1;
>   
>   			ret = erofs_rebuild_update_inode(&g_sbi, inode,
> -							 rctx->datamode);
> +							 rctx->datamode,
> +							 rctx->uniaddr_offset);
>   			if (ret) {
>   				erofs_iput(inode);
>   				goto out;
> @@ -425,6 +481,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
>   {
>   	struct erofs_inode inode = {};
>   	struct erofs_rebuild_dir_context ctx;
> +	struct erofs_inode *mergedir;
>   	char uuid_str[37];
>   	char *fsid = sbi->devname;
>   	int ret;
> @@ -447,16 +504,19 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
>   		erofs_err("failed to read root inode of %s", fsid);
>   		return ret;
>   	}
> +
> +	mergedir = root;
>   	inode.i_srcpath = strdup("/");
>   
>   	ctx = (struct erofs_rebuild_dir_context) {
>   		.ctx.dir = &inode,
>   		.ctx.cb = erofs_rebuild_dirent_iter,
> -		.mergedir = root,
> +		.mergedir = mergedir,
>   		.datamode = mode,
>   		.uniaddr_offset = uniaddr_offset,
>   	};
>   	ret = erofs_iterate_dir(&ctx.ctx, false);
> +
>   	free(inode.i_srcpath);
>   	return ret;
>   }
> @@ -556,3 +616,106 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
>   	};
>   	return erofs_iterate_dir(&ctx.ctx, false);
>   }
> +
> +static int erofs_rebuild_copy_src_blocks(struct erofs_sb_info *sbi,
> +					 struct list_head *src_list)
> +{
> +	struct erofs_device_info *devs = sbi->devs;
> +	struct erofs_sb_info *src;
> +	erofs_blk_t current_addr = sbi->primarydevice_blocks;
> +	int idx = 0;
> +
> +	list_for_each_entry(src, src_list, list) {
> +		erofs_blk_t src_blocks = devs[idx].blocks;
> +		u64 src_off = 0, dst_off;
> +		u64 len;
> +		int src_fd, dst_fd;
> +
> +		devs[idx].uniaddr = current_addr;
> +
> +		erofs_info("Copying %s: %u blocks at unified address %u",
> +			   src->devname, src_blocks, current_addr);
> +
> +		src_fd = src->bdev.fd;
> +		dst_fd = sbi->bdev.fd;
> +
> +		if (src_fd < 0 || dst_fd < 0) {
> +			erofs_err("failed to get file descriptors");
> +			return -EINVAL;
> +		}
> +
> +		dst_off = erofs_pos(sbi, current_addr);
> +		len = erofs_pos(src, src_blocks);
> +
> +		while (len > 0) {
> +			ssize_t copied = erofs_copy_file_range(
> +				src_fd, &src_off, dst_fd, &dst_off, len);
> +			if (copied < 0) {
> +				erofs_err("failed to copy data from %s: %s",
> +					  src->devname, erofs_strerror(-copied));
> +				return copied;
> +			}
> +			if (copied == 0)
> +				break;
> +			len -= copied;
> +		}
> +
> +		current_addr += src_blocks;
> +		idx++;
> +	}
> +	sbi->primarydevice_blocks = current_addr;
> +	return 0;
> +}
> +
> +int erofs_rebuild_load_trees_full(struct erofs_inode *root,
> +				  struct erofs_sb_info *sbi,
> +				  struct list_head *src_list,
> +				  unsigned int src_count)

Hi Karpinski,


Thanks for your patches and it works well in my simple test.


I really think this function has some similar logic with 
erofs_rebuild_load_trees,

could we integrate it with the existing logic?


Thanks,

Yifan

> +{
> +	struct erofs_device_info *devs;
> +	struct erofs_sb_info *src;
> +	int ret, idx = 0;
> +
> +	ret = erofs_mkfs_init_devices(sbi, src_count);
> +	if (ret) {
> +		erofs_err("failed to initialize devices: %s",
> +			  erofs_strerror(ret));
> +		return ret;
> +	}
> +	devs = sbi->devs;
> +
> +	/* Read source superblocks and populate device table */
> +	list_for_each_entry(src, src_list, list) {
> +		ret = erofs_read_superblock(src);
> +		if (ret) {
> +			erofs_err("failed to read superblock of %s: %s",
> +				  src->devname, erofs_strerror(ret));
> +			return ret;
> +		}
> +		devs[idx].blocks = src->primarydevice_blocks;
> +		erofs_uuid_unparse_as_tag(src->uuid, (char *)devs[idx].tag);
> +		idx++;
> +	}
> +
> +	/* Copy source data blocks */
> +	ret = erofs_rebuild_copy_src_blocks(sbi, src_list);
> +	if (ret)
> +		return ret;
> +
> +	/* Advance buffer manager past copied data */
> +	erofs_bset_tail(sbi->bmgr, sbi->primarydevice_blocks);
> +
> +	/* Load filesystem trees with unified block addresses */
> +	idx = 0;
> +	list_for_each_entry(src, src_list, list) {
> +		ret = erofs_rebuild_load_tree(root, src,
> +					      EROFS_REBUILD_DATA_FULL,
> +					      devs[idx].uniaddr);
> +		if (ret) {
> +			erofs_err("failed to load %s", src->devname);
> +			return ret;
> +		}
> +		idx++;
> +	}
> +	return 0;
> +}
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a8f9a5e..124a024 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -15,9 +15,11 @@
>   #include <getopt.h>
>   #include "erofs/config.h"
>   #include "erofs/print.h"
> +#include "erofs/io.h"
>   #include "erofs/importer.h"
>   #include "erofs/diskbuf.h"
>   #include "erofs/inode.h"
> +#include "erofs/dir.h"
>   #include "erofs/tar.h"
>   #include "erofs/dedupe.h"
>   #include "erofs/xattr.h"
> @@ -1726,7 +1728,9 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
>   		break;
>   	case EROFS_MKFS_DATA_IMPORT_FULLDATA:
>   		datamode = EROFS_REBUILD_DATA_FULL;
> -		break;
> +		return erofs_rebuild_load_trees_full(root, &g_sbi,
> +						     &rebuild_src_list,
> +						     rebuild_src_count);
>   	case EROFS_MKFS_DATA_IMPORT_RVSP:
>   		datamode = EROFS_REBUILD_DATA_RESVSP;
>   		break;
>

