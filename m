Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DDD6A3E87
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 10:42:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQFsm4zSQz3bm9
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Feb 2023 20:42:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQFsg48Qcz306Y
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 20:42:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VccFXUx_1677490960;
Received: from 30.97.48.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VccFXUx_1677490960)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 17:42:41 +0800
Message-ID: <4c6ada29-234f-623d-c4c6-1a98a678323b@linux.alibaba.com>
Date: Mon, 27 Feb 2023 17:42:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: don't warn ztailpacking feature anymore
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230227084457.3510-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230227084457.3510-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/27 16:44, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The ztailpacking feature has been merged for a year, it has been mostly
> stable now.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Let's update erofs-utils as well?

> ---
>   fs/erofs/super.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..733c22bcc3eb 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -417,8 +417,6 @@ static int erofs_read_superblock(struct super_block *sb)
>   	/* handle multiple devices */
>   	ret = erofs_scan_devices(sb, dsb);
>   
> -	if (erofs_sb_has_ztailpacking(sbi))
> -		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
>   	if (erofs_is_fscache_mode(sb))
>   		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
>   	if (erofs_sb_has_fragments(sbi))
