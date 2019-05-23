Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BC627597
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2019 07:37:32 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458dYk2JpyzDqQj
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2019 15:37:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458dYd12yrzDqPB
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2019 15:37:22 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 589108418E12DE85B633;
 Thu, 23 May 2019 13:37:17 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 23 May
 2019 13:37:11 +0800
Subject: Re: [PATCH] erofs-utils: fix an uninitialized variable
To: Lianjun Huang <huanglianjun@vivo.com>, <bluce.liguifu@huawei.com>,
 <miaoxie@huawei.com>, <fangwei1@huawei.com>, Chao Yu <yuchao0@huawei.com>
References: <20190523045717.GA15346@hlj.localdomain>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <43a07df7-324f-eb40-b2bc-e1606d126986@huawei.com>
Date: Thu, 23 May 2019 13:37:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190523045717.GA15346@hlj.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Lianjun,

On 2019/5/23 12:57, Lianjun Huang wrote:
> This fixes a building failure caused by using a variable before initialization.
> 
> Signed-off-by: Lianjun Huang <huanglianjun@vivo.com>

Thanks for your patch. I will apply this patch to the current mkfs-dev branch this evening.

p.s. could you have some time to take a look at erofs-mkfs and do some test/fixes on the new code,
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental

I plan to send new mkfs code to mailing list for review, and switch new erofs-mkfs from experimental
to dev branch, and mark the current mkfs obsoleted since the new mkfs is more cleaner, powerful
(with designs to support the upcoming erofs features) and seems already stable...

Thanks,
Gao Xiang

> ---
>  mkfs/erofs_cache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/erofs_cache.c b/mkfs/erofs_cache.c
> index 5bb293b..0d7acf7 100644
> --- a/mkfs/erofs_cache.c
> +++ b/mkfs/erofs_cache.c
> @@ -142,7 +142,7 @@ int erofs_flush_all_blocks(void)
>  	char *erofs_blk_buf;
>  	char *pbuf;
>  	int count;
> -	int ret;
> +	int ret = 0;
>  
>  	erofs_blk_buf = malloc(EROFS_BLKSIZE);
>  	if (!erofs_blk_buf)
> 
