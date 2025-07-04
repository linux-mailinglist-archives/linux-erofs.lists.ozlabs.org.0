Return-Path: <linux-erofs+bounces-521-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896BFAF9BC6
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 22:46:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYlz455Pbz2xlL;
	Sat,  5 Jul 2025 06:46:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751661968;
	cv=none; b=QJ14AGCJHzTY5YkcSQtWPKiuRKh4OH3+vzfvEg0WwP5HuOQqXui6QXXjQ4lBLdRGFcyfTMwGfbszhrQtCS6KuVtGJ+kNZMoP1V7evMY81Zbz7dKOJJLbQo5dYQCjvhuFIrGmnEEV8DinskpZY8N/TYp/rxZS/NoO4558/F8uK/+gnYMTe7HtJkVzlCNKxgCUs8P0BgvYoWRz3txnYcuwqpmTxMi8D8ZqiAXqRqyCN/V1w+x7CTUn3k7pJDc+tsDtgDv+eA88xBJSAG8Lve0eU8pym7gt1SUDCTTCnUKFclhHKAlJCWjQe0ezVO5lkxU8Wzl3uYruOhbg51/Taem7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751661968; c=relaxed/relaxed;
	bh=BkqEiSCYRiMq5GvIK/tLvEQtc8kIHzDfW/Kz1KaWbXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6ZBS9Kb8ltrIbc2ouPK3MWxtR42TOqm+nEg3k7LW8Ilib85SbfNmHJLPPGp23zPxIiXUvbreS0F5GyXbQfUhLRWSwQpIiUNecZtZHUeTUpYC1XECeh4Q1Ei0A9yHRJyjwv8nww+oUyeMaMOi9uVS098MuYpL0qVJOkLS+sZqA+Xf2i4lgmTr5n7qA0U7JHRBCOk5xLB3QPNiwWlZ9EVFsN1AVA85sXEHoHGERocj5/bx861hNFYdy7FrCt4ZrVO0BJyMB/EisX6Rr+wqS2jLKiikHEi0eWlKJceEPv9c6E0CFAsC3v7Na80atTpKdFPrscq/ICPKNIeDV1olLMV3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZEc32Sow; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZEc32Sow;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYlz12XbRz2xd3
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 06:46:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751661960; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BkqEiSCYRiMq5GvIK/tLvEQtc8kIHzDfW/Kz1KaWbXU=;
	b=ZEc32Sowak6/QeF71GIrvaLQJ8k7vMTKtCYFJSYquUdq3XBeIwE6GNbt2KamHskSoqvbL8qXY50yO5dhiwM/CnwniE5gQqKOwjSVS3eEmobf62FgtC7HTCyz/4N8phN0gT4tAEEviovm576CR7jHCreFV9uRYwIXA+sdfe6f71g=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhMxItr_1751661957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 04:45:58 +0800
Message-ID: <20df607b-21da-4898-a5e1-bdd1be104636@linux.alibaba.com>
Date: Sat, 5 Jul 2025 04:45:57 +0800
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
Subject: Re: [PATCH RFC 3/4] erofs: apply the page cache share feature
To: Christian Brauner <brauner@kernel.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-3-0ce1f6be28ee@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250703-work-erofs-pcs-v1-3-0ce1f6be28ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christian,

On 2025/7/3 20:23, Christian Brauner wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This modifies relevant functions to apply the page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Link: https://lore.kernel.org/20240902110620.2202586-4-hongzhen@linux.alibaba.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/erofs/data.c  | 33 +++++++++++++++++++++++++++++++++
>   fs/erofs/inode.c | 15 ++++++++++++++-
>   fs/erofs/super.c | 29 +++++++++++++++++++++++++++++
>   fs/erofs/zdata.c | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6a329c329f43..fb54162f4c54 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -351,12 +351,45 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	struct erofs_inode *vi = NULL;
> +	int ret;
> +
> +	if (file && file->private_data) {
> +		vi = file->private_data;
> +		if (vi->ano_inode == file_inode(file))
> +			folio->mapping->host = &vi->vfs_inode;

This is one of the parts I asked Hongzhen to refactor
because it simply doesn't work.

The background is that:
  - since the folio is from the anon_inode mapping now,
    so .iomap_begin() will use the anon inode rather
    than a real inode in a sb, which causes iomap
    don't find the real data source to read;

  - Hongzhen just switch `folio->mapping->host` but it's
    just broken.  Also `file` here can be NULL if the
    request is a kernel-internal request, so we'd better
    not rely on `file` argument.

  - My suggestion was that maintain a inode list so that
    erofs_iomap_begin() can find any valid sb inode to
    find data source instead.

> +		else
> +			vi = NULL;
> +	}
> +	ret = iomap_read_folio(folio, &erofs_iomap_ops);
> +	if (vi)
> +		folio->mapping->host = file_inode(file);

here.

> +	return ret;
> +#else
>   	return iomap_read_folio(folio, &erofs_iomap_ops);
> +#endif
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE

Also the #ifdef are too ugly from the upstream code cycle.

Thanks,
Gao Xiang

