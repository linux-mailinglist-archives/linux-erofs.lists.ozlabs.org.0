Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177669C5244
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 10:42:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnhKk3Ntmz2yYd
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 20:42:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731404568;
	cv=none; b=Ciln3wrRsLRCIXRXzLw0cuVNN5MdVRHrp+RWzq4rmKKynDspBxUoU1rQw3VE5xd9QhIoUQ5nu1HHGHOCkx5kTPdB8ODpJvvh1lJvsIyTa3iKMMVi0H5RnJAg9x8L8kVbZuha/+HLWXt/XG8toBGqos5idOI3RypuQGSqRyUzzvqieW45jqv1+kPp1W394iZORCdaUBb9NT6c6DYQaYAzU82ykhLNkOUuKQiT8PwTWCijtdKg/oBlb8nExzIzNd7G6veqJa6h8Gjh/MRbTLwtNGtDFKJcsod4XclhqDKtIon86yvazTGMSHYams8xw3q9r+qSTOcvJD2gG6d+iotDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731404568; c=relaxed/relaxed;
	bh=voksCnbA+4EpaI3K9bQUHmFEWIROIUAhEOXE8dJ5UrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2wOdYM73EubpCwT27N4HBlspbwWo25Qb7J4s538KXA4AYaA0i92l9/2KFd8DKuCvBBtKyrks8RYnhsq0AhtuG1QJ1v4VlNttqayZKZlR1ptI4FYDsOTP5a1zMyeIZpwealk6y2ROeXGlfL5vtOCv0pMX8l2NUkZXWO6m1Q4FMAcmvVCaF9eJLS1Cp8YJpRBa2kwQXobELax+e8skwVe5/JPS6vSWzcEd9oX/aKvGZTAqJfpxQoCBpQTSpHCbPlpmm+LpK2zAGXYMpy+s5Ybef6Y1vRa9o1EU6wIBCcUCH7rcUPsnkGrpMHFjeG9lJ5sLVU87OKCS0BC+ezYekNC0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HmdqKxCF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HmdqKxCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnhKc4f5mz2xvh
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 20:42:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731404554; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=voksCnbA+4EpaI3K9bQUHmFEWIROIUAhEOXE8dJ5UrU=;
	b=HmdqKxCF72E7qe6DoSPwncWKpzE40oKsAPG5oX41rfneQN5vO2eQLTkDajGaSPd+W+SDc1WT0OA38Edvqxh7zBAo3JoWZnzV5MrDaxbktimyrSwokM7Qdnwvy9bJGQEvxkZdfgi3oFpRIDbtk8KFZhIaEAA4t+OMIXM/wiKMbZs=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJGo4pJ_1731404551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 17:42:32 +0800
Message-ID: <fabdfe9f-9293-45c2-8cf2-3d86c248ab4c@linux.alibaba.com>
Date: Tue, 12 Nov 2024 17:42:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add sysfs node to drop all compression-related
 caches
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241112091403.586545-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112091403.586545-1-guochunhai@vivo.com>
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

Hi Chunhai,

On 2024/11/12 17:14, Chunhai Guo wrote:
> Add a sysfs node to drop all compression-related caches, including
> pclusters and attached compressed pages.

subject: erofs: add sysfs node to drop internal caches

Add a sysfs node to drop compression-related caches, currently
used to drop in-memory pclusters and compressed folios.

I don't think it really drops `compressed folios`, also see
my comment below:

> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-erofs |  7 +++++++
>   fs/erofs/sysfs.c                         | 11 +++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index 284224d1b56f..b66a3f6d3fdf 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -16,3 +16,10 @@ Description:	Control strategy of sync decompression:
>   		  readahead on atomic contexts only.
>   		- 1 (force on): enable for readpage and readahead.
>   		- 2 (force off): disable for all situations.
> +
> +What:		/sys/fs/erofs/<disk>/drop_caches
> +Date:		November 2024
> +Contact:	"Guo Chunhai" <guochunhai@vivo.com>
> +Description:	Writing 1 to this will cause the erofs to drop all
> +		compression-related caches, including pclusters and attached
> +		compressed pages. Any other value is invalid.
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 63cffd0fd261..f068f01437d5 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -10,6 +10,7 @@
>   
>   enum {
>   	attr_feature,
> +	attr_drop_caches,
>   	attr_pointer_ui,
>   	attr_pointer_bool,
>   };
> @@ -57,11 +58,13 @@ static struct erofs_attr erofs_attr_##_name = {			\
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
> +EROFS_ATTR_FUNC(drop_caches, 0200);
>   #endif
>   
>   static struct attribute *erofs_attrs[] = {
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	ATTR_LIST(sync_decompress),
> +	ATTR_LIST(drop_caches),
>   #endif
>   	NULL,
>   };
> @@ -163,6 +166,14 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   			return -EINVAL;
>   		*(bool *)ptr = !!t;
>   		return len;
> +	case attr_drop_caches:
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if (t != 1)
> +			return -EINVAL;

		if (t & 2)
			z_erofs_shrink_scan(sbi, ~0UL);

		if (t & 1)
			invalidate_mapping_pages(EROFS_I_SB(inode)->managed_cache->i_mapping, 0, -1);

or you could export MNGD_MAPPING macros again.

Thanks,
Gao Xiang
