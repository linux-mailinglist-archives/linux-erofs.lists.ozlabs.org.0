Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10658A1344C
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 08:51:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYZn94j0gz3by8
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 18:51:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737013883;
	cv=none; b=LuLo51qw54D9EC3SykVFxRA9Ly/t/8cEzk+rKh+zRxgurn0zCVUsXgDvGygJQ4JP6fmuraOM/o9vlBDw5QiO9l01rqXXC2d+tVb+f0bLvwryhco2ngISMhDEHWJa+OdXulaDIY6im0HtrUuv0TSuBGpsE6PS4a0EdV99cUu5KMjm4dS7Y9DmKTwCCI/Im3DzMFXqV5yhNHCWxFnZcdXPDDWD5iZtE2ajhlv2EzmyhXQXql36dJZ2z9r1RVnj1JzCVCjCXErDuT2fd0A2y8FWEMF+0dJpmeZynyN282pau9MWqtr9xphxUGOARHlJTc35arBV7Wy2eyCk54xFQEZ8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737013883; c=relaxed/relaxed;
	bh=5/uQUXKHYLMtTWj1lVfWlv4rTg4eAI8aIXpMUNNc0hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wu30pih8rYQ/ejGZukmBrtkCaDmUmR/+sgJSvT34yY2tlxir3zaNoZ5ota9QfE9M9ua9rXREc+Z1VMBi7G4U1Kf1GS5l7XNAh8w65Z3Nhex6/UJ4UYPyPG1DKA68jALWJ/18eMZSAWaVD1DK9LfgkzYivZxJ9+5Abb+Y0uhllNu+dMyqWHPxg1AWdAGpW7ZZ6hI0VIjyJenkO2/pUVfVrAgfswB59kNkDCYpAAn1kcZ1f5WdpfHwcma4EdYRbVlGs6s0TubkBBXofI/YzA/jQSnR17P7eDuYc7FUwHAUl/PknN9VOluTi/aLTGiQrcke0nMAII62Q3lFyOSnybM93Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XcOSR6uB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XcOSR6uB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYZn527Hcz2ysg
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 18:51:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737013875; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5/uQUXKHYLMtTWj1lVfWlv4rTg4eAI8aIXpMUNNc0hU=;
	b=XcOSR6uBurdPmHyxo72quHRmdj93D8PgG6jkZrDTZg5K/82qRfx4Rj7xfmowA28VASCllBYG9mOzT75VhfSPKJ+q0V1vAmlKLbKxo5Da2kOy2XNBWCFaC4FroFuG7ho39M2jgoUmzuuejwOd+0pZJKhj+b1ZKP29PAI6se6Pp6E=
Received: from 30.221.130.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNksvNR_1737013872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 15:51:13 +0800
Message-ID: <b33944b1-18fa-4a27-858f-5922ea1e1003@linux.alibaba.com>
Date: Thu, 16 Jan 2025 15:51:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs(shrinker): return SHRINK_EMPTY if no objects to
 free
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <433DB98624BCDF95+20250116072042.189710-1-chenlinxuan@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <433DB98624BCDF95+20250116072042.189710-1-chenlinxuan@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linxuan,

On 2025/1/16 15:20, Chen Linxuan wrote:
> Comments in file include/linux/shrinker.h says that
> `count_objects` of `struct shrinker` should return SHRINK_EMPTY
> when there are no objects to free.
> 
>> If there are no objects to free, it should return SHRINK_EMPTY,
>> while 0 is returned in cases of the number of freeable items cannot
>> be determined or shrinker should skip this cache for this time
>> (e.g., their number is below shrinkable limit).

Thanks for the patch!

Yeah, it seems that is the case.  Yet it'd better to document
what the impact if 0 is returned here if you know more..

> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>   fs/erofs/zutil.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 0dd65cefce33..682863fa9e1c 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -243,7 +243,9 @@ void erofs_shrinker_unregister(struct super_block *sb)
>   static unsigned long erofs_shrink_count(struct shrinker *shrink,
>   					struct shrink_control *sc)
>   {
> -	return atomic_long_read(&erofs_global_shrink_cnt);
> +	unsigned long count = atomic_long_read(&erofs_global_shrink_cnt);
> +
> +	return count ? count : SHRINK_EMPTY;

I guess you could just use

	return atomic_long_read(&erofs_global_shrink_cnt) ?: SHRINK_EMPTY;

Thanks,
Gao Xiang

>   }
>   
>   static unsigned long erofs_shrink_scan(struct shrinker *shrink,

