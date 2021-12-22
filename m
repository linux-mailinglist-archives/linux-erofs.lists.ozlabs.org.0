Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884247CAE8
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:46:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJblY055nz2yp9
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:46:33 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJblT4wCPz2xvP
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:46:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V.NrWup_1640137571; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.NrWup_1640137571) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 22 Dec 2021 09:46:13 +0800
Date: Wed, 22 Dec 2021 09:46:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1 2/2] Add API to get on disk size of an inode
Message-ID: <YcKDYzlMEt01YjdU@B-P7TQMD6M-0146.local>
References: <20211221142829.4123631-1-zhangkelvin@google.com>
 <20211221142829.4123631-2-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211221142829.4123631-2-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 21, 2021 at 06:28:29AM -0800, Kelvin Zhang wrote:
> Change-Id: I60fa9346737b14418bd3fa1d12f760aaf0a0cca5
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>

The same to the previous patch.

Also could we remove dump_get_occupied_size() entirely?

Thanks,
Gao Xiang

> ---
>  dump/main.c              |  4 ++--
>  include/erofs/internal.h |  2 ++
>  lib/data.c               | 21 +++++++++++++++++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 71b44b4..cdde561 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -175,7 +175,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  	return 0;
>  }
>  
> -static int erofs_get_occupied_size(struct erofs_inode *inode,
> +static int dump_get_occupied_size(struct erofs_inode *inode,
>  		erofs_off_t *size)
>  {
>  	*size = 0;
> @@ -291,7 +291,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
>  		return err;
>  	}
>  
> -	err = erofs_get_occupied_size(&inode, &occupied_size);
> +	err = dump_get_occupied_size(&inode, &occupied_size);
>  	if (err) {
>  		erofs_err("get file size failed\n");
>  		return err;
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 947304f..8f13e69 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -320,6 +320,8 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
>  int erofs_map_blocks(struct erofs_inode *inode,
>  		struct erofs_map_blocks *map, int flags);
>  int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
> +int erofs_get_occupied_size(const struct erofs_inode *inode,
> +			    erofs_off_t *size);
>  /* zmap.c */
>  int z_erofs_fill_inode(struct erofs_inode *vi);
>  int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> diff --git a/lib/data.c b/lib/data.c
> index 27710f9..92e54b5 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -320,3 +320,24 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
>  	}
>  	return -EINVAL;
>  }
> +
> +int erofs_get_occupied_size(const struct erofs_inode *inode,
> +			    erofs_off_t *size)
> +{
> +	*size = 0;
> +	switch (inode->datalayout) {
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_FLAT_PLAIN:
> +	case EROFS_INODE_CHUNK_BASED:
> +		*size = inode->i_size;
> +		break;
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +	case EROFS_INODE_FLAT_COMPRESSION:
> +		*size = inode->u.i_blocks * EROFS_BLKSIZ;
> +		break;
> +	default:
> +		erofs_err("unknown datalayout");
> +		return -1;
> +	}
> +	return 0;
> +}
> -- 
> 2.34.1.307.g9b7440fafd-goog
