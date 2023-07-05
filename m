Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7369747B78
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 04:21:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qwk1n2KHXz30PR
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 12:21:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qwk1f3BcGz2yDM
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 12:21:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VmelV7U_1688523687;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmelV7U_1688523687)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 10:21:36 +0800
Message-ID: <60263449-74c1-a713-fec9-ce23af65427d@linux.alibaba.com>
Date: Wed, 5 Jul 2023 10:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs-utils: mkfs: don't clean cached xattr items
 prematurely
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230705021040.76265-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230705021040.76265-1-jefflexu@linux.alibaba.com>
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



On 2023/7/5 10:10, Jingbo Xu wrote:
> Extended attributes read from file are cached in a hash table when
> building shared extended attributes.  However the cached xattr items
> for inline xattrs are cleaned up from the hash table when the processing
> for shared extended attributes has finished, while later the hash table
> is reconstructed from scratch when building the inode tree (see
> erofs_mkfs_build_tree_from_path()).
> 
> Don't clean up the xattr hash table halfway until mkfs exits.  Also move
> the logic of cleaning long xattr name prefixes into erofs_cleanxattrs().
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   include/erofs/xattr.h |  2 +-
>   lib/xattr.c           | 30 ++++++++----------------------
>   mkfs/main.c           |  2 +-
>   3 files changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 14fc081..b202f78 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -75,9 +75,9 @@ static inline unsigned int xattrblock_offset(unsigned int xattr_id)
>   int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
>   char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
>   int erofs_build_shared_xattrs_from_path(const char *path);
> +void erofs_cleanxattrs(void);
>   
>   int erofs_xattr_insert_name_prefix(const char *prefix);
> -void erofs_xattr_cleanup_name_prefixes(void);
>   int erofs_xattr_write_name_prefixes(FILE *f);
>   
>   #ifdef __cplusplus
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 7d7dc54..8d0079f 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -547,24 +547,23 @@ fail:
>   	return ret;
>   }
>   
> -static void erofs_cleanxattrs(bool sharedxattrs)
> +void erofs_cleanxattrs(void)
>   {
>   	unsigned int i;
>   	struct xattr_item *item;
>   	struct hlist_node *tmp;
> +	struct ea_type_node *tnode, *n;
>   
>   	hash_for_each_safe(ea_hashtable, i, tmp, item, node) {
> -		if (sharedxattrs && item->shared_xattr_id >= 0)
> -			continue;

I'm not sure it's the expected behavior. Previously we will remove
all non-shared xattrs which are below xattr threshold in the shared
xattr generation process.

But now, such non-shared xattrs will be left in memory.  What
the benefits of this?  In addition, I'm not sure if we need to add
non-shared (inline) xattrs to hash table as well.

Thanks,
Gao Xiang
