Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D99142E2
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 08:37:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FHr++eHl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W6yv10jz9z3cGS
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 16:37:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FHr++eHl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W6ytx3sgLz30VJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 16:37:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719211046; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=32Dq1ei0TpOjlntaFkXPDM0XjjYUvUHaXm0NcC8Peo4=;
	b=FHr++eHl7qD6SCTeri9jaIuAz5w180dLRPvH1PcAZodJ03YJ+RM5fEBS87ubRhl5ASqNue+x1iXzYupM4B5VdgeCEAK14tHdcyXaN9KBG7rQF/IaW4yOHibmjCrGT65DJC2Ia4vAqJHmg4xqugcAqHa5mZxq7mZ9fIVs3kiPBGA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W94DJdA_1719211043;
Received: from 30.97.48.156(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W94DJdA_1719211043)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 14:37:24 +0800
Message-ID: <453a4339-56ef-48ad-8536-111f6be144d7@linux.alibaba.com>
Date: Mon, 24 Jun 2024 14:37:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: convert to use super_set_uuid to support for
 FS_IOC_GETFSUUID
To: Huang Xiaojia <huangxiaojia2@huawei.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, yuehaibing@huawei.com
References: <20240624063704.2476070-1-huangxiaojia2@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240624063704.2476070-1-huangxiaojia2@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/24 14:37, Huang Xiaojia wrote:
> FS_IOC_GETFSUUID ioctl exposes the uuid of a filesystem. To support
> the ioctl, init sb->s_uuid with super_set_uuid().
> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>

Thanks for fixing:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c93bd24d2771..1b91d9513013 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -343,7 +343,7 @@ static int erofs_read_superblock(struct super_block *sb)
>   	sbi->build_time = le64_to_cpu(dsb->build_time);
>   	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
>   
> -	memcpy(&sb->s_uuid, dsb->uuid, sizeof(dsb->uuid));
> +	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>   
>   	ret = strscpy(sbi->volume_name, dsb->volume_name,
>   		      sizeof(dsb->volume_name));
