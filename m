Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A922F5B92AC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 04:28:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSh2v0QMvz3bc8
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 12:28:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSh2r4hp4z2xrH
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 12:28:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPqk5.y_1663208911;
Received: from 30.221.129.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPqk5.y_1663208911)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 10:28:32 +0800
Message-ID: <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
Date: Thu, 15 Sep 2022 10:28:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 1/6] erofs: use kill_anon_super() to kill super in
 fscache mode
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-2-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220914105041.42970-2-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/14/22 6:50 PM, Jia Zhu wrote:
> Use kill_anon_super() instead of generic_shutdown_super() since the
> mount() in erofs fscache mode uses get_tree_nodev() and associated
> anon bdev needs to be freed.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Thanks. You're welcome to use "Suggested-by" in this case. The same with
patch 2.

> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3173debeaa5a..9716d355a63e 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>  
>  	if (erofs_is_fscache_mode(sb))
> -		generic_shutdown_super(sb);
> +		kill_anon_super(sb);
>  	else
>  		kill_block_super(sb);
>  

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
