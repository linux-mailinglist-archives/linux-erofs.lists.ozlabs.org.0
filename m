Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F228A414F61
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 19:49:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF5QV45G5z2yP7
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 03:49:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF5QQ4Gwqz2xYN
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 03:49:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R741e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=bo.liu@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0UpFichl_1632332936; 
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0UpFichl_1632332936) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 01:49:03 +0800
Date: Thu, 23 Sep 2021 01:48:56 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix misbehavior of unsupported chunk format check
Message-ID: <20210922174856.GA87201@rsjd01523.et2sqa>
References: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: bo.liu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 22, 2021 at 05:51:41PM +0800, Gao Xiang wrote:
> Unsupported chunk format should be checked with
> "if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"
> 
> Found when checking with 4k-byte blockmap (although currently mkfs
> uses inode chunk indexes format by default.)
>

Good catch.

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

thanks,
liubo

> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 31ac3a7..a552399 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -176,7 +176,7 @@ static struct page *erofs_read_inode(struct inode *inode,
>  	}
>  
>  	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
> -		if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_ALL)) {
> +		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
>  			erofs_err(inode->i_sb,
>  				  "unsupported chunk format %x of nid %llu",
>  				  vi->chunkformat, vi->nid);
> -- 
> 1.8.3.1
