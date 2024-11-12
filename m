Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25C9C5AE1
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 15:51:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xnq9Z5pbCz2yhM
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 01:51:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731423073;
	cv=none; b=F/MEL56vyiF+8TjxvsIb3eeinsu0pVuBMLNXcKvaGBe2oqDyp72uAFHkD1BRPAotDIeruMQkdhDOtwWnvSSt5i/KLT8p7miPrZsLsqK4lM7ckUW5lpAbkkptOgnamNVjosizg0XSCIDBgnrJ2F5WhTGDvQ/cNm4zwVvg7cS8/X85slUUogq7hCpiq14iHDp2DdwdoqomC8QNrGciFc+NTcThnZDNBFrxmPCkFi7GQabfSkBS6IdnjrprJ8IDcc7eAmV0iPMeWDhO+1CHP4EatzoMfTR+Ev1ZaFThtX5KOtQCFbHbb86gQ0zmz535rDrtGY4HgqDzheU0ZJe0inbpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731423073; c=relaxed/relaxed;
	bh=qqPGlldiKA/0frstxqxDfQ+0+1Zynw9+m2wDIl7/ooo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuIYIH+/u7mq3Gt89MLXgiqGH/VXkrCz4HlbKVvmw9FbvTI1IsaA6bzqmAQ8mpypmFWomwnjlvuUnEEFE8g4wDQfkPoeUBeb2sNLrwy0CbdnLNtQgCme/vds8U90A4NUoU6dQ5j6bEgTEMgW98NLrzC0Pu0SaR/2c0JRkfbRThvaB5NX+r68SUvE+KDoKd+cDsgI9e4+814Ug16xjCzxbleQw2YiS/aArvAB9wh08zqprPWtFd972So7tnhmZEMy5rQGjlnWUMDwUr4CZikASnpe4FUj+lkZtzPt1LBu6qHK1QktyGY9ic4ZnFqcvjIeue4hIC6u46fzDca46yX0nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gvGw3rw7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gvGw3rw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnq9Q6s9Mz2xJ8
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 01:51:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731423061; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qqPGlldiKA/0frstxqxDfQ+0+1Zynw9+m2wDIl7/ooo=;
	b=gvGw3rw7gDpOrk4Qb9rdKif0dJYG+GItWmR8ZfpPi8SEJGJL/VvLU91RpjKgqHLhImxpEZ9QZdeb2Giqj2LNijZ3qeVf554ZmINZU82NZBW/11ZnODbNqIg5g+/XRCCTdwYD0lQ5a1RmnpQVjryQTCegSEgPq5hvh7hpCssvl0o=
Received: from 192.168.88.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJHtRez_1731423059 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 22:51:00 +0800
Message-ID: <0b56f59e-b973-4ac2-b234-b362af8adedc@linux.alibaba.com>
Date: Tue, 12 Nov 2024 22:50:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: add sysfs node to drop internal caches
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241112114034.618402-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112114034.618402-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/12 19:40, Chunhai Guo wrote:
> Add a sysfs node to drop compression-related caches, currently used to
> drop in-memory pclusters and compressed folios.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v1: https://lore.kernel.org/linux-erofs/fabdfe9f-9293-45c2-8cf2-3d86c248ab4c@linux.alibaba.com
> change since v1:
>   - Change subject as suggested by Gao Xiang.
>   - Use different bits to indicate different meanings in the sysfs node.
> ---
>   Documentation/ABI/testing/sysfs-fs-erofs | 11 +++++++++++
>   fs/erofs/internal.h                      |  2 ++
>   fs/erofs/sysfs.c                         | 15 +++++++++++++++
>   fs/erofs/zdata.c                         |  1 -
>   4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index 284224d1b56f..44d863cd07b5 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -16,3 +16,14 @@ Description:	Control strategy of sync decompression:
>   		  readahead on atomic contexts only.
>   		- 1 (force on): enable for readpage and readahead.
>   		- 2 (force off): disable for all situations.
> +
> +What:		/sys/fs/erofs/<disk>/drop_caches
> +Date:		November 2024
> +Contact:	"Guo Chunhai" <guochunhai@vivo.com>
> +Description:	Writing to this will drop compression-related caches,
> +		currently used to drop in-memory pclusters and
> +		compressed folios:

		cached compressed folios:

> +
> +		- 1 : drop in-memory compressed folios

		- 1 : invalidate cached compressed folios

> +		- 2 : drop in-memory pclusters
> +		- 3 : drop in-memory pclusters and compressed folios

		- 3 : drop in-memory pclusters and cached compressed folios

> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3905d991c49b..0328e6b98c1b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -450,6 +450,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>   void erofs_release_pages(struct page **pagepool);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
> +#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
> +
>   extern atomic_long_t erofs_global_shrink_cnt;
>   void erofs_shrinker_register(struct super_block *sb);
>   void erofs_shrinker_unregister(struct super_block *sb);
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 63cffd0fd261..01d509e43827 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -10,6 +10,7 @@
>   
>   enum {
>   	attr_feature,
> +	attr_drop_caches,
>   	attr_pointer_ui,
>   	attr_pointer_bool,
>   };
> @@ -57,11 +58,13 @@ static struct erofs_attr erofs_attr_##_name = {			\
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
> +EROFS_ATTR_FUNC(drop_caches, 0200);
>   #endif
>   
>   static struct attribute *erofs_attrs[] = {
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	ATTR_LIST(sync_decompress),
> +	ATTR_LIST(drop_caches),
>   #endif
>   	NULL,
>   };
> @@ -163,6 +166,18 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   			return -EINVAL;
>   		*(bool *)ptr = !!t;
>   		return len;
> +	case attr_drop_caches:
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if (t < 1 || t > 3)
> +			return -EINVAL;> +
> +		if (t & 1)
> +			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
> +		if (t & 2)
> +			z_erofs_shrink_scan(sbi, ~0UL);

Please switch the order to

		if (t & 2)
			z_erofs_shrink_scan(sbi, ~0UL);

		if (t & 1)
			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);

So that all cached folios could be disconnected first.

Thanks,
Gao Xiang
