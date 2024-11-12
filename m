Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E79C4B8D
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 02:11:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnSzG05NJz2yYf
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 12:11:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731373864;
	cv=none; b=eVeE6evWVQXFNMLygv4pjBPNzeE/yGk/Wef8KU08p/NRJK9CrDSHNiRQRbjUileIFGwMmIJNPfkPjxNJ7Jv5AoDNvj+aCzvDe9EBIkvgetJNrgWNtBqPsBwNYC2h480bGf0X8iMdzKhyadT3c6eP/tLmPBTF3E3ISm5UuANXjvTS9T5voxJjkuMIfISFQnrLbC66ppK3bjuxcLmMrjHAYwLVqO6pdrbPsMrenKPe9BB2/XUK4n9lGI/Uod4LmW7WE1uwNIgZBWcYXjxb/ZslnGTvvRkRqoEfKuxXUnlfh9Hpjr5Tk8v9y25KsXayHLK/MIm2niVMqSzAePo4z7Vrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731373864; c=relaxed/relaxed;
	bh=q7oCKpsoAhbSTG9R6KFNp3G1KEsnEQyl3BDZDVztKbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ROauJYZUwa/dkpx/r6XoHWf2za5OwMeqKLc9M2mV5JbRKVGgwo5Bd07ibq7zifAFBpJyf3mEZFU3HeAU1RQ42wBsLTwqlZQD+smh6N86KLyCINN+x8HzYrzY/vZBAC/MJPs+b/jB8nmcoBQw2CbK7eT86TBVQ+38ZdMpcWx+GwEkp2YO/z7PsYtUN0y+N//bgCuUK5e0qD4bvccKpAChS1kwd4t79QAkcXrWdnSCqCaYyUWVc6LR1vzd0JiAEbXNa0bCgFUgGUO1//eZzQF43ceBAxg12Ry1ek3L1D8VEoU3O6iiExQ0I2rxQd+HOe7Q1E/izpudvY8iCqKi+CSflA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NxHYO9X5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NxHYO9X5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnSz86BJGz2xk7
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 12:10:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731373855; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=q7oCKpsoAhbSTG9R6KFNp3G1KEsnEQyl3BDZDVztKbE=;
	b=NxHYO9X5tX3GCOWr/zOTSlnsLMhdPTolIr6JA9EAmQqUUdq4HJqYtapOzWI3wedplxwBSXmc373SnoBJaz4dbeO1Xr+OYKFlQ3kRcpmvpTIdBooV3Arfhxsd/h23LybXbpChsiLM5K9eLM9jOBPdxCN2t5UCeuOLX2EPb4rASlM=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJF2QG._1731373854 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:10:54 +0800
Message-ID: <c0f5795a-991e-4d5a-86c3-5169dcbd7da1@linux.alibaba.com>
Date: Tue, 12 Nov 2024 09:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: capture errors from
 {mkfs,rebuild}_handle_inode()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241111110926.3909753-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241111110926.3909753-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/11 19:09, Hongzhen Luo wrote:
> Currently, the error code returned by erofs_{mkfs,rebuild}_handle_inode()
> in erofs_mkfs_dump_tree() may be ignored. This patch introduces `err1` and
> `err2` to capture errors from the {mkfs,rebuild}_handle_inode() functions.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   lib/inode.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 7abde7f4a3b5..e2ca07f1c18c 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1733,7 +1733,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,

add `int err, err2` here.

>   	}
>   
>   	do {
> -		int err;
> +		int err1, err2;

here the original `int err` is redundant.

>   		struct erofs_inode *dir = dumpdir;
>   		/* used for adding sub-directories in reverse order due to FIFO */
>   		struct erofs_inode *head, **last = &head;
> @@ -1753,11 +1753,11 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
>   				erofs_mark_parent_inode(inode, dir);
>   
>   				if (!rebuild)
> -					err = erofs_mkfs_handle_inode(inode);
> +					err1 = erofs_mkfs_handle_inode(inode);
>   				else
> -					err = erofs_rebuild_handle_inode(inode,
> +					err1 = erofs_rebuild_handle_inode(inode,
>   								incremental);
> -				if (err)
> +				if (err1)
>   					break;

no need to change this.

>   				if (S_ISDIR(inode->i_mode)) {
>   					*last = inode;
> @@ -1770,10 +1770,10 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
>   		}
>   		*last = dumpdir;	/* fixup the last (or the only) one */
>   		dumpdir = head;
> -		err = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
> +		err2 = erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR_BH,
>   				    &dir, sizeof(dir));
		err2 = ...

> -		if (err)
> -			return err;
> +		if (err1 || err2)
> +			return err1 ? err1 : err2;

		if (err || err2)
			return err ? err : err2;
>   	} while (dumpdir);
>   
>   	return err;

