Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 925369C4D13
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 04:10:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnWch6mDmz2yWK
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 14:10:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731381011;
	cv=none; b=N43sYdMxV/+3ajXl8Q9WB/mACbi8vApiWv2c8s8GSMum22lqfipqwA7+FRwhveLX1NsQmHfJg0abFSFhLKUNn3PCKEQYXX8auLGD4oM/+AM0bEDEdtburOmjMU3vv+HB23BO7SEOdpP0kq0RopqBO1kp3NQqJJ8U17PlQ2Zoq2r59+JQ9K6Kf8zW7Zd0/yhgekNwpRZ4J4suUtgWbnwsqHVhHHB72IK2VUFJyvbXwCweRFP2NdkMATfG3/hky8Tb2wDtLG5xznFdeR9nTvp+B8kXC2TJIGH6kgEHUMC32JMhN97R65b4mbV6CtYCnNWZGOsTyGgIGiApOESdi1ewxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731381011; c=relaxed/relaxed;
	bh=gN3YaYLgY9SUyrMbc88gJjv3MN+sgD5Bg199MEKibO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvN9jITJOOzheoKaS59PHrjGs8+ClxjLEA9iMprWopGTZsB0D5uS0mdpbAs1+PIiltHaBVKjXuyMV06z8mLdU0YwoDx5FmuDG6TV7pnHpKQoR2YE12AqitZ3jFHYF4g09qFjM75KSSVDk3CvWAAkGbk0ONBpnBRD+5uWFtceGueVRyROg0jPnF2B4ss0Mvxg4xYjLxAmKnCFcM0HBaOnpgr4udbp5ga731MEtEXhW+71U7crliZ8CembgnCY4xbMquJew4gXgIvAHyDzeQBODWTOTKV8ShYiY6AhzujpBexS9uQ2A2FQVvlp4TdrWexD7OCeCeYwYKdFQXsZiRyVRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B1OLLHWS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B1OLLHWS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnWcc0QDZz2xmS
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 14:10:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731380998; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gN3YaYLgY9SUyrMbc88gJjv3MN+sgD5Bg199MEKibO4=;
	b=B1OLLHWSQmWcmrIqJuTzhST3zPPyEvP3JRRPF8zNra0b11+tBS+qqI0BIvndnLpXcDXYn2U/CGSI3LmHS9Yg2kT7an7s+ueOvJeI1Hklg+0rVDU+3WBgW4mLH80+QYSia7yXrzJxrxQRQbWCOv2WqlwY7ssFMfa3de7vK8LiHNg=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFQ1wm_1731380995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 11:09:56 +0800
Message-ID: <3cc99567-b3e6-419f-820c-f772e26aa85d@linux.alibaba.com>
Date: Tue, 12 Nov 2024 11:09:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: clean up the cache if cached decompression is
 disabled
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241112031513.528474-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112031513.528474-1-guochunhai@vivo.com>
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



On 2024/11/12 11:15, Chunhai Guo wrote:
> Clean up the cache when cached decompression strategy is changed to
> EROFS_ZIP_CACHE_DISABLED by remount.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/super.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 320d586c3896..de2af862e65b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -743,6 +743,11 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
>   	else
>   		fc->sb_flags &= ~SB_POSIXACL;
>   
> +	if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {

I guess we need to check if
	(sbi->opt.cache_strategy != new_sbi->opt.cache_strategy &&
	new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED)


Thanks,
Gao Xiang

> +		mutex_lock(&sbi->umount_mutex);
> +		z_erofs_shrink_scan(sbi, ~0UL);
> +		mutex_unlock(&sbi->umount_mutex);
> +	}
>   	sbi->opt = new_sbi->opt;
>   
>   	fc->sb_flags |= SB_RDONLY;

