Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EE49ED0E9
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 17:11:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7gZj4XPhz30RJ
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 03:11:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733933483;
	cv=none; b=U17tLejsRou3MZzqh1O2W1A2OrgMA4t8KrlUWWtKz5JNsfA6oF3UHMVx2p7iD3xtGXfcyPiHT8pkIRb7NkkjyVnh2+v+hnrwMYpj06DFJRgtMkgXYaKWTCtqRE8pGIn9Zavj98kTFCu7l8dZSpdsOs+pl+ZOuOE1Sno/uR1FQBLJIR3q7isLU+UexPUaUS+fiVKPHrM3CuA64PyDv4Bq47IXzwKSWX09IOM6txBFl03H3eyAqs4pJz5pVtLInEVI/FVrTtY970nB2Mbg2hGGp9mgwrOlc3DZzWU2poa7Z5+XVL0VBRz3jtGHSYvVp0dVukiCqklvV047Uv4ugVxbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733933483; c=relaxed/relaxed;
	bh=0XWewsV4GA8JmilDHeOPlyQb9x0fvqls8nkRsMFOhCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRRylJgWJC6rwwO9o4KDgYaScSazv6GU/bl+X+P7/YJJ7jkNWNrEuiI6jBGj+ba4eGznA85XRYjvJjBgSyjWo5ek4BfVB6lhvKuvf9z7ejTQNZ3B/VE8DiF/LMNdOjimCpfvhiS7LEY+r5gvADTP4D9DyFFIFxJf3Wjgy/+Nb7yaN8NEg41zZQp3OUfvisIVv70foDE5vCrLXOkYfLJXijUSqexnYr6ie6mcWhAs4h9VtSWUOU2FAmEBJLwPeCCBtzGb95jTUvUWhHf/Pqc9yU85R/mY5BD6U/brm35a3EszHwkRR/AiztSeF0diFL3eYHntfgV6K6/V3lwldQS6gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XZ0clpZL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XZ0clpZL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7gZZ2648z2yJL
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 03:11:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733933466; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0XWewsV4GA8JmilDHeOPlyQb9x0fvqls8nkRsMFOhCM=;
	b=XZ0clpZLFnGLKDwA9BXRzLG92KecTehBw5V3nLoonNV2/DyVBJy93YYevKHBxCnfTqd/S/oSZY3kNQ3p0e1ytcpZPW5PCjdKP3Xomn67UV98mF7RwxCmGJro6Ma8fK/H+Q4cmUrg0ajxE1E59OTYfwYGUQzaVm3k+Q7qvqQluV0=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLIoMo._1733933459 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 00:11:04 +0800
Message-ID: <41009b11-08e2-4e48-99be-3d59666593ad@linux.alibaba.com>
Date: Thu, 12 Dec 2024 00:10:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: add --hardlink-dereference option
To: Paul Meyer <katexochen0@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20241211150734.97830-1-katexochen0@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241211150734.97830-1-katexochen0@gmail.com>
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

Hi Paul,

On 2024/12/11 23:07, Paul Meyer wrote:
> Add option --hardlink-dereference to dereference hardlinks when
> creating an image. Instead of reusing the inode, hardlinks are added
> as separate inodes. This is useful for reproducible builds, when the
> rootfs is space-optimized using hardlinks on some machines, but not on
> others.

Thanks for the patch!

Yet I fail to parse the feature, why this feature is useful
for reproducible builds? IOWs, without this feature (or
hardlinks are used), what's the exact impact that you don't
want to?

Thanks,
Gao Xiang

> 
> Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
> Signed-off-by: Paul Meyer <katexochen0@gmail.com>
> ---
>   include/erofs/config.h | 1 +
>   lib/inode.c            | 2 +-
>   mkfs/main.c            | 4 ++++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index cff4cea..8399afb 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -58,6 +58,7 @@ struct erofs_configure {
>   	bool c_extra_ea_name_prefixes;
>   	bool c_xattr_name_filter;
>   	bool c_ovlfs_strip;
> +	bool c_hardlink_dereference;
>   
>   #ifdef HAVE_LIBSELINUX
>   	struct selabel_handle *sehnd;
> diff --git a/lib/inode.c b/lib/inode.c
> index 7e5c581..5d181b3 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
>   	 * hard-link, just return it. Also don't lookup for directories
>   	 * since hard-link directory isn't allowed.
>   	 */
> -	if (!S_ISDIR(st.st_mode)) {
> +	if (!S_ISDIR(st.st_mode) && (!cfg.c_hardlink_dereference)) {
>   		inode = erofs_iget(st.st_dev, st.st_ino);
>   		if (inode)
>   			return inode;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d422787..09e39f5 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -85,6 +85,7 @@ static struct option long_options[] = {
>   	{"mkfs-time", no_argument, NULL, 525},
>   	{"all-time", no_argument, NULL, 526},
>   	{"sort", required_argument, NULL, 527},
> +	{"hardlink-dereference", no_argument, NULL, 528},
>   	{0, 0, 0, 0},
>   };
>   
> @@ -846,6 +847,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   			if (!strcmp(optarg, "none"))
>   				erofstar.try_no_reorder = true;
>   			break;
> +		case 528:
> +			cfg.c_hardlink_dereference = true;
> +			break;
>   		case 'V':
>   			version();
>   			exit(0);

