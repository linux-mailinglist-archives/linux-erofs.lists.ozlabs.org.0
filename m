Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705D784F27
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 05:16:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVrvl2hRkz3bxY
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 13:16:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVrvc2h1vz2yD4
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 13:15:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VqOd2eO_1692760545;
Received: from 30.97.48.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqOd2eO_1692760545)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 11:15:47 +0800
Message-ID: <f67475ee-c352-8de6-8638-65f0d2fdb9c5@linux.alibaba.com>
Date: Wed, 23 Aug 2023 11:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/11] erofs-utils: lib: scan devtable if extra_devices
 is not specified
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230822092457.114686-1-jefflexu@linux.alibaba.com>
 <20230822092457.114686-3-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230822092457.114686-3-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/22 17:24, Jingbo Xu wrote:
> Scan the devtable (if any) automatically when reading superblock from
> disk if sbi->extra_devices is not specified, and initialize
> sbi->extra_devices with the number of on-disk device slots.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   lib/super.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/super.c b/lib/super.c
> index 4fe81c3..fc709fc 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -37,7 +37,8 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   	else
>   		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
>   
> -	if (ondisk_extradevs != sbi->extra_devices) {
> +	if (sbi->extra_devices &&
> +	    ondisk_extradevs != sbi->extra_devices) {

If you'd like to keep in sync with the kernel
erofs_scan_devices(), please point it out explicitly in the commit message.

Thanks,
Gao Xiang

>   		erofs_err("extra devices don't match (ondisk %u, given %u)",
>   			  ondisk_extradevs, sbi->extra_devices);
>   		return -EINVAL;
> @@ -45,6 +46,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   	if (!ondisk_extradevs)
>   		return 0;
>   
> +	sbi->extra_devices = ondisk_extradevs;
>   	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
>   	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
>   	if (!sbi->devs)
