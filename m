Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300722E813D
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Dec 2020 17:31:48 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D6DFF2f2hzDqKT
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 03:31:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1609432305;
	bh=xXIgT9asUyjh0PUJO4W4AXek2QizkTh37MWXohnlvx0=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HXqnKg9DJFZFB1V3FBaN4kdqHnQrMcjsugj/boVHOfRlALJ8arQHKcxQ2bC4tmy0D
	 Qh7TPSZdVV/Ocdk6fb8rOKBM3tpBi3lMIG3ssU+Hf6/kIeIxzQ0rj0scuIqiHZ253U
	 7h9Q39vCFVlztFa/+PMDDLRFO38xCCj0rGFdiEM+/uW1bx9XaB9uaSivGtz3V+4dkb
	 pESbyctoxOKI3zskJV3fqvW8xsvnBII6uW3wKjM9x7X5AA1ERktN2yq6GIyV2qcrFy
	 5ut5zpJP1SFhrs/9RH4/v1lZRZ8QoU9JJ5OpsKsm6fAomJ3F7ImuxtV8Dw7Pm4BF7N
	 8jwwQpKQSM13A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.39;
 helo=out30-39.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=d/2EIhUr; dkim-atps=neutral
Received: from out30-39.freemail.mail.aliyun.com
 (out30-39.freemail.mail.aliyun.com [115.124.30.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6DF52ZybzDqK3
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Jan 2021 03:31:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1609432284; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=6WTgHt6mSB3yeN7e4hPr/1nBM4SGqjk7dZc3wPxGbWM=;
 b=d/2EIhUr0ry2G+RSfC/rz8zHS3eNgJOTEvTRd59D1RobTNzsyp1SALh5jxnJTtjwYwTYJp7ApTYM0HWe26/sRdZO7mrLI3dg3EaB6RHzOBcI1TjKdt8++6xT6njXPENUIvn9FOEL6Bv3VbqS/n0rlDdGK65ESjAP478ilWKkR4c=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07389534|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0681609-0.000559044-0.93128;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04394; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---0UKKd4u-_1609432282; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UKKd4u-_1609432282) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 01 Jan 2021 00:31:22 +0800
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org,
 Yue Hu <zbestahu@gmail.com>, Huang Jianan <huangjianan@oppo.com>
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
Message-ID: <bbfb6dba-7db1-a0ab-e766-e6f3c4d10976@aliyun.com>
Date: Fri, 1 Jan 2021 00:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201228105146.2939914-1-hsiangkao@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Cc: Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thank for your works, Yue Hu, Jianan, Gao Xiang

On 2020/12/28 18:51, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> "failed to find [%s] in canned fs_config" was observed by using
> "--fs-config-file" option as reported by Yue Hu [1].
> 
> The root cause was that the mountpoint prefix to subdirectories is
> also needed if "--mount-point" presents. However, such prefix cannot
> be added by just using erofs_fspath().
> 
> One exception is that the root directory itself needs to be handled
> specially for canned fs_config. For such case, the prefix of the root
> directory has to be dropped instead.
> 
> [1] https://lkml.kernel.org/r/20201222020430.12512-1-zbestahu@gmail.com
> 
> Link: https://lore.kernel.org/r/20201226062736.29920-1-hsiangkao@aol.com
> Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> Reported-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> changes since v2:
>  - fix IS_ROOT misuse reported by Jianan, very sorry about this since
>    I know little about canned fs_config.
> 
> (please kindly test again...)
> 
>  lib/inode.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 0c4839d..e6159c9 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  	/* filesystem_config does not preserve file type bits */
>  	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
>  	unsigned int uid = 0, gid = 0, mode = 0;
> -	char *fspath;
> +	const char *fspath;
> +	char *decorated = NULL;
>  
>  	inode->capabilities = 0;
> +	if (!cfg.fs_config_file && !cfg.mount_point)
> +		return 0;
> +
> +	if (!cfg.mount_point ||
> +	/* have to drop the mountpoint for rootdir of canned fsconfig */
> +	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
> +		fspath = erofs_fspath(path);
> +	} else {
> +		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
> +			     erofs_fspath(path)) <= 0)
> +			return -ENOMEM;
> +		fspath = decorated;
> +	}
> +
erofs_fspath has been written for three times, and called always.
What do you think refact it ? Do it with
fspath = erofs_fspath(path);
if need decorated:
   fspath = decorated

