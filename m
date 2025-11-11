Return-Path: <linux-erofs+bounces-1361-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7ECC4B229
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Nov 2025 03:02:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d58t41Zrhz2ySq;
	Tue, 11 Nov 2025 13:02:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762826524;
	cv=none; b=n1culeka+fNb4Vs/3hbXV+pPqBlZTjG24ScZd6vcTA+NgEvpbp5ezei0jPLvgFaBvruAOHjajdsX1R6GOrRK5YhorhJm7+siV3LEyx+3gR3VQ6VnIv2djC88GQPTLvUGTIrOFOPbL7oTxDqOdf9820SdgSIIR+0wqVSiqh8AUUEoo2Y8WQzp9/JLYEjbngOvRkRS2+bljc1dksOqWvfVxZOaZVI3JCnALaECQ0PM6N/6qgykLTSs4/1YxBFbW9xf//eaCNliuaBGXU1bVJgC5ZPhiyfg3ZaqzM1lYHQN62w4nKQESqYL6SM4WkxS/zv+8EoN4J50rLMYK5oe0A0Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762826524; c=relaxed/relaxed;
	bh=xXWj2lYQWVwDOadOGHrZLyW7TDRaqhHP9ClRejotOTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JyqPv4FMwb1grY0S+tbkeNqnd2nWh1NEB5K5xqJ58pDp/Akl54X4YtbbM2VQLedjBQsHioOjcAWEZTlXgJudHTPG2uc30MbdO0+0PCw4gfZ1lu4wgBQfBhY+7BSBcbwfPJXGKsOL9OkdQddVVesd7Nsi977C0/ZvaELNToZVQ6nTvsXHK/Wr/lpol2vWhRHeXISj3nycgt7zTzcgfuZxrF/8/pokCL4c0+dUq6wh1NDmWWrvyM++sQWGWRJksWCTePPjCEUglhXQvv0QgtDopBOoCA+ZQkKD2OyAu/FPsW6+8ugDDCOsAtedkKcu21UGG+i9WpkQAg9N0jU8Er8SMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KL/dwKLI; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=KL/dwKLI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d58t152d1z2yGM
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Nov 2025 13:01:59 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xXWj2lYQWVwDOadOGHrZLyW7TDRaqhHP9ClRejotOTg=;
	b=KL/dwKLIFi1itKj2nE4Tw8yAlzMEx9Rp3tfw4V6iljZGfZh176Ud+H+W5xMP/ghW5doNlKNDR
	t2//x252UE6TkDMHM80MFkNkNpygcULwYzbLbmb1euhqA9rK5oLfL3uSq2FM3jGfh9yXQmK/DcM
	6rjh0Xq02TupSYumlb7AX/g=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d58qz1r41z1cyTg
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Nov 2025 10:00:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 47B191A016C
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Nov 2025 10:01:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 10:01:53 +0800
Message-ID: <4d91ca1b-6ac8-481a-9355-df5093cccaec@huawei.com>
Date: Tue, 11 Nov 2025 10:01:53 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] erofs-utils: lib: ibmgr should be assigned in advance
To: <linux-erofs@lists.ozlabs.org>
References: <20251107100609.2917122-1-hsiangkao@linux.alibaba.com>
 <20251107100609.2917122-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251107100609.2917122-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/7 18:06, Gao Xiang wrote:
> Otherwise, metabox won't keep several types of inodes.
> 
> Fixes: 7928074b7643 ("erofs-utils: introduce metadata compression [metabox]")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   lib/inode.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index f9b5ee997877..09b2e507c609 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -903,8 +903,7 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
>   {
>   	const struct erofs_importer_params *params = im->params;
>   	struct erofs_sb_info *sbi = im->sbi;
> -	struct erofs_bufmgr *bmgr = sbi->bmgr;
> -	struct erofs_bufmgr *ibmgr = bmgr;
> +	struct erofs_bufmgr *ibmgr;
>   	unsigned int inodesize;
>   	struct erofs_buffer_head *bh, *ibh;
>   
> @@ -922,6 +921,13 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
>   	if (inode->extent_isize)
>   		inodesize = roundup(inodesize, 8) + inode->extent_isize;
>   
> +	if (!erofs_is_special_identifier(inode->i_srcpath) &&
> +	    erofs_metabox_bmgr(sbi))
> +		inode->in_metabox = true;
> +
> +	if (inode->in_metabox)
> +		ibmgr = erofs_metabox_bmgr(sbi) ?: sbi->bmgr;
> +
>   	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN)
>   		goto noinline;
>   
> @@ -942,12 +948,6 @@ static int erofs_prepare_inode_buffer(struct erofs_importer *im,
>   			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
>   	}
>   
> -	if (!erofs_is_special_identifier(inode->i_srcpath) &&
> -	    erofs_metabox_bmgr(sbi))
> -		inode->in_metabox = true;
> -
> -	if (inode->in_metabox)
> -		ibmgr = erofs_metabox_bmgr(sbi) ?: bmgr;
>   	bh = erofs_balloc(ibmgr, INODE, inodesize, inode->idata_size);
>   	if (bh == ERR_PTR(-ENOSPC)) {
>   		int ret;

