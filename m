Return-Path: <linux-erofs+bounces-376-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D387ACAB6A
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Jun 2025 11:31:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b9pWm24Ytz2yLT;
	Mon,  2 Jun 2025 19:31:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748856708;
	cv=none; b=L/7enoWksniovZSPnzwi+XoDAWMZ9aPVMY5GY44Pw7Vep8Ys5R0a+1l4ogn6oUOEvKogTGFj0meGD7SJHckuHvmyoIUFrB2Uvd+oRswQtNt076gHmES1LihNKynhh5aJ/LQ4wzdBZpMIxqy2hAM6f4o/xOyXGHC5l872TZ1WhEzpIeEwQFMHhZHJ/LwaMWPPV7yHp90KSaoKPzUJb4odpSofycoWk6YB9Bj9Ej8+1QBXcQ0UitOje9Ncy7xMfA/AD2xnAyJ/2pxZwAsjUHD+d3+yVPMVM2anhxXzXs4SvLpJPbR8PULYvs/cuprD3m5yOAV1uhaH2/A5/zB8hbGB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748856708; c=relaxed/relaxed;
	bh=DWjKvYhYNc2pWW7tdJIeBXFodDfvxFf4zxxAxUxs+7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=RvQ0eHtk8eWAWnKt6lqeOtrT7cJEfTdtr2PuEFpi89jN5IvbjPOCIz0cnE0daNqY8uX/BodGJREkaHAdh6/zBO5EivwiBQ+mBRlQKto1cvBKsljzmrBMK3rluw4tVAqwfcRXoefyG+jV5hTDXFpDQXKLE+6SPbDc4OVfNwKzgaRyQKhzTk9ggY2dTN9/fHqu4JDU0+BJutWOAUOoYxvhATih6ZkEmto/sxekFOKGvmoL2szAgwVt6NOO8iDd10VkMDxIr5SZE8I9r+Xm8cd+WT0hnM/u1+BiRcB0DgIYGubm3oXGPPbxPBztSyVtieHM7my9pRYsDKEIbNZ6XRrHnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b9pWk6w2Zz2xBV
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Jun 2025 19:31:44 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b9pRC6gz8zCtYk;
	Mon,  2 Jun 2025 17:27:51 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 612F91402CC;
	Mon,  2 Jun 2025 17:31:39 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Jun 2025 17:31:38 +0800
Message-ID: <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
Date: Mon, 2 Jun 2025 17:31:38 +0800
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
Subject: Re: [PATCH] erofs-utils: mkfs: fix image reproducibility of
 `-E(all-)fragments`
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20250531002954.432151-1-hsiangkao@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250531002954.432151-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Xiang,

On 2025/5/31 8:29, Gao Xiang wrote:
> The timestamp of the packed inode should be fixed to the build time.
> 
> Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   lib/inode.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 7a10624..ca49a80 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -910,7 +910,8 @@ out:
>   	return 0;
>   }
>   
> -static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
> +static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
> +					    const char *path)
>   {
>   	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
>   		return true;
> @@ -924,7 +925,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>   		return true;
>   	if (inode->i_nlink > USHRT_MAX)
>   		return true;
> -	if ((inode->i_mtime != inode->sbi->build_time ||
> +	if (path != EROFS_PACKED_INODE &&
> +	    (inode->i_mtime != inode->sbi->build_time ||
>   	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
>   	    !cfg.c_ignore_mtime)
>   		return true;
> @@ -1016,6 +1018,10 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
>   		erofs_err("gid overflow @ %s", path);
>   	inode->i_gid += cfg.c_gid_offset;
>   
> +	if (path == EROFS_PACKED_INODE) {
> +		inode->i_mtime = sbi->build_time;
> +		inode->i_mtime_nsec = 0;
> +	}
>   	inode->i_mtime = st->st_mtime;
>   	inode->i_mtime_nsec = ST_MTIM_NSEC(st);

Should we put the condition in here? Because it will be reassigned if we 
do like this.

And what about assigning sbi->build_time_nsec to inode->i_mtime_nsec 
like the FIXED case?

Thanks,
Hongbo

>   
> @@ -1065,7 +1071,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
>   	if (!inode->i_srcpath)
>   		return -ENOMEM;
>   
> -	if (erofs_should_use_inode_extended(inode)) {
> +	if (erofs_should_use_inode_extended(inode, path)) {
>   		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
>   			erofs_err("file %s cannot be in compact form",
>   				  inode->i_srcpath);
> @@ -1610,7 +1616,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
>   	erofs_update_progressinfo("Processing %s ...", trimmed);
>   	free(trimmed);
>   
> -	if (erofs_should_use_inode_extended(inode)) {
> +	if (erofs_should_use_inode_extended(inode, inode->i_srcpath)) {
>   		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
>   			erofs_err("file %s cannot be in compact form",
>   				  inode->i_srcpath);

