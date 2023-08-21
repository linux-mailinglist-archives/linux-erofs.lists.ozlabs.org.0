Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE887827CE
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 13:20:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RTqlW1vl2z30f4
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 21:20:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RTqlL1pBmz2yjD
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Aug 2023 21:20:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqHOw5K_1692616803;
Received: from 30.221.146.126(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqHOw5K_1692616803)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 19:20:04 +0800
Message-ID: <1e0c8826-7e6b-0eae-336d-2d3902e0cc3f@linux.alibaba.com>
Date: Mon, 21 Aug 2023 19:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs-utils: sbi->devs should be cleared after freed
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230821070901.121008-1-hsiangkao@linux.alibaba.com>
 <20230821093929.17146-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230821093929.17146-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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



On 8/21/23 5:39 PM, Gao Xiang wrote:
> Otherwise, it could cause double-free if sbi reuses
> when fuzzing [1].
> 
> [1] https://github.com/erofs/erofsnightly/actions/runs/5921003885/job/16053013007
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
> changes since v1:
>  - add a missing sbi->devs = NULL in erofs_init_devices().
> 
>  lib/super.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/super.c b/lib/super.c
> index 58e2574..38caf4d 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -53,6 +53,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>  		ret = dev_read(sbi, 0, &dis, pos, sizeof(dis));
>  		if (ret < 0) {
>  			free(sbi->devs);
> +			sbi->devs = NULL;
>  			return ret;
>  		}
>  
> @@ -123,14 +124,18 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
>  		return ret;
>  
>  	ret = erofs_xattr_prefixes_init(sbi);
> -	if (ret)
> +	if (ret && sbi->devs) {
>  		free(sbi->devs);
> +		sbi->devs = NULL;
> +	}
>  	return ret;
>  }
>  
>  void erofs_put_super(struct erofs_sb_info *sbi)
>  {
> -	if (sbi->devs)
> +	if (sbi->devs) {
>  		free(sbi->devs);
> +		sbi->devs = NULL;
> +	}
>  	erofs_xattr_prefixes_cleanup(sbi);
>  }

-- 
Thanks,
Jingbo
