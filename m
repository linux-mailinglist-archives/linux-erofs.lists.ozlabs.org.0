Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 282169EE825
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 15:00:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8DdH73dSz30dx
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 01:00:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734012034;
	cv=none; b=AX6ZBpq750PooUC2VTsVNBlfbNUOF+jQ8Dqw401nN4rT2nEMfk0p/Q9eJXp8ll2M0SlFJWKLBtewxtpGIT7xN6dHsjQiyO46pf6/+hQrJtnzzeYRuAP0J9ZbJcDkAoaTLn5KJnV/GVNaAz5wSpd3TerMX6OX+dSOIxgXIEbNzHrcQQ71J9fPIIPhopn81qOb19wuz8rAhgOI94Htr6YHvDD+guZF67WipgPhA3sZgJvcQns/YOI6qvOAZTQyxHPBdEuYb0zY0yQBSMpPICwPlTOTiFMAro/sOXLXnR4UcgkmV6yxKEYS3/tdT7vKBCbsDBM61J8HrLSOAWqB9H8DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734012034; c=relaxed/relaxed;
	bh=5gc0bRJCpIG4tutuIj5pkRbOJhzp+xhsTvwg4nuv3+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0c/K/QbLSzn6q6dgUasndhA1/tP21/s+UvtyhaiySWJ+0hWoPubI5Aywm5AAEoc9leon3f/AQ4qKCqHWFxQh7p0ga/7ZKuRxAUmLbxzwItI5KpHVEwuNsFS1WdU53eH4xj+7DUoAiOz5zYzdntlsOe6n4p3JqWhiv0R93bWyfgXwI5tqC7bjm7X1q0EmGbJyNZlH/p4EvZ8/Av49c2l65Y13p/GeSC2MThRNAHLGbUwtoKw09wai3InJSPPcykp0uTDpr4STfoM8peb9YuVBwTRKj9NgHPeBVdKtN813x407w1jOL0J/GMeacWpYIoVXgxTvhl7EBq6hCLPcbq72w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FCquUfgJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FCquUfgJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8DdC6tC1z306d
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 01:00:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734012026; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5gc0bRJCpIG4tutuIj5pkRbOJhzp+xhsTvwg4nuv3+c=;
	b=FCquUfgJPsTTOOCo+1eOJ4JRPeRPHmq7SP5GpGKAuYtiIXF/SRcqnsd5Ce8+dqofUz7ZZo5TkT1YVHG/02woCjapFgsIfnGWQq12pHABOZ9yHVRLsVlvupyrUHUndknN/vebgnuW8Axd0HW5JsSqUfZ+HX3E4pLBsrEj/dmCiV8=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLvROZ_1734012019 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 22:00:25 +0800
Message-ID: <400d4426-1a19-4821-96ff-93c079d13bd6@linux.alibaba.com>
Date: Thu, 12 Dec 2024 22:00:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: add --hardlink-dereference option
To: Paul Meyer <katexochen0@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20241212135630.15811-1-katexochen0@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241212135630.15811-1-katexochen0@gmail.com>
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
Cc: Leonard Cohnen <leonard.cohnen@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/12 21:56, Paul Meyer wrote:
> Add option --hardlink-dereference to dereference hardlinks when
> creating an image. Instead of reusing the inode, hardlinks are added
> as separate inodes. This is useful for reproducible builds, when the
> rootfs is space-optimized using hardlinks on some machines, but not on
> others.
> 

The subject and commit message is still unchanged...

> Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
> Signed-off-by: Paul Meyer <katexochen0@gmail.com>
> ---
> 
> v1: https://lore.kernel.org/all/20241211150734.97830-1-katexochen0@gmail.com/
> change since v1:
>   - rename option to --hard-dereference
>   - add usage
> 
>   include/erofs/config.h | 1 +
>   lib/inode.c            | 2 +-
>   mkfs/main.c            | 5 +++++
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index cff4cea..bb03e70 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -58,6 +58,7 @@ struct erofs_configure {
>   	bool c_extra_ea_name_prefixes;
>   	bool c_xattr_name_filter;
>   	bool c_ovlfs_strip;
> +	bool c_hard_dereference;
>   
>   #ifdef HAVE_LIBSELINUX
>   	struct selabel_handle *sehnd;
> diff --git a/lib/inode.c b/lib/inode.c
> index 7e5c581..0404a8d 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
>   	 * hard-link, just return it. Also don't lookup for directories
>   	 * since hard-link directory isn't allowed.
>   	 */
> -	if (!S_ISDIR(st.st_mode)) {
> +	if (!S_ISDIR(st.st_mode) && (!cfg.c_hard_dereference)) {
>   		inode = erofs_iget(st.st_dev, st.st_ino);
>   		if (inode)
>   			return inode;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d422787..7eb86f5 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -85,6 +85,7 @@ static struct option long_options[] = {
>   	{"mkfs-time", no_argument, NULL, 525},
>   	{"all-time", no_argument, NULL, 526},
>   	{"sort", required_argument, NULL, 527},
> +	{"hard-dereference", no_argument, NULL, 528},
>   	{0, 0, 0, 0},
>   };
>   
> @@ -214,6 +215,7 @@ static void usage(int argc, char **argv)
>   #ifdef EROFS_MT_ENABLED
>   		, erofs_get_available_processors() /* --workers= */
>   #endif
> +		" --hard-dereference    dereference hardlinks, add links as separate inodes\n"


Does it compile with EROFS_MT_ENABLED?...

Also `--hard-dereference` should be moved upwards to match
alphabetical order.

Thanks,
Gao Xiang

>   	);
>   }
>   
> @@ -846,6 +848,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   			if (!strcmp(optarg, "none"))
>   				erofstar.try_no_reorder = true;
>   			break;
> +		case 528:
> +			cfg.c_hard_dereference = true;
> +			break;
>   		case 'V':
>   			version();
>   			exit(0);

