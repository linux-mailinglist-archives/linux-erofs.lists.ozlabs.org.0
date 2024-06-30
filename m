Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0991CFE0
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jun 2024 04:51:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ug+vfT52;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WBYbW2Hhnz3c5X
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jun 2024 12:51:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ug+vfT52;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WBYbP2MyPz30TF
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jun 2024 12:51:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719715882; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=k2mW9kF0tcNvyXieKkWUUqtbjUaDk9gY5NZvuOVoRas=;
	b=Ug+vfT52xLwOlKQ47oav8ZXuMRAxfkikoK9cVRv8SxhmL/oXehloy1k+QOs8eRcJHtHy/fNOSRy5hX2+VlMYaZzYVCXp7W+Lxwq8h6nvnEXgnzZQh+1jS6GiKP0ZgzNOz4xMOjk84JRDGXUaWbLiqrXirNW84KvJ82EEeLU4ISg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9UWqM4_1719715880;
Received: from 30.27.95.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9UWqM4_1719715880)
          by smtp.aliyun-inc.com;
          Sun, 30 Jun 2024 10:51:21 +0800
Message-ID: <7adcf002-864e-489a-ac70-99c9850ea4f1@linux.alibaba.com>
Date: Sun, 30 Jun 2024 10:51:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: ensure m_llen is reset to 0 if metadata is invalid
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
References: <20240629185743.2819229-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240629185743.2819229-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/30 02:57, Gao Xiang wrote:
> Sometimes, the on-disk metadata might be invalid due to storage
> failure or other unknown issues.
user interrupts, storage failures, or other unknown causes.

> 
> In that case, z_erofs_map_blocks_iter() may still return a valid
> m_llen while other fields remain invalid (e.g., m_plen can be 0).
> 
> Due to the return value of z_erofs_scan_folio() in some path will
> be ignored on purpose, the following z_erofs_scan_folio() could
> then use the invalid value by accident.
> 
> Let's reset m_llen to 0 to prevent this.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 9b248ee5fef2..74d3d7bffcf3 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -711,6 +711,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
>   
>   	err = z_erofs_do_map_blocks(inode, map, flags);
>   out:
> +	if (err)
> +		map->m_llen = 0;
>   	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
>   	return err;
>   }
