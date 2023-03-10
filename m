Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F36B34A0
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 04:16:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXrmr6MwZz3cdK
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 14:16:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=b3pgLg2B;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=b3pgLg2B;
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXrmh1Z8Dz3bm6
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 14:16:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=11AJMu/0cs/HvqxMiNs1sKMgouvxxTSuRzL9iqx/214=; b=b3pgLg2BGWVTYim4F7KQAXgPuh
	tvBvaspI+ZuT6n1dLXX0xe2CfyfmScno/rVPwocMA8nAysYzCglC41V3TUPJUjcvIvMYWMgbcWsqA
	mNb7CSDVKPDqEj9FhBJ3BlqtTv2rfZ3lApjmVElaxCebclvKldUPhAJs11i/u4Rq7Yp36tiJrOEj4
	Md5bov/9vJTU9iQSlhFi31jlZEUol6H70DxfbHVTEk7oeZGF6OI/AiRPNpvQTL4/P+kXsBTDJm/bm
	ojuazI9oWqv2bmVjTzwhBLB9gBk6dOhlqYyB/hAillxfNGe/u82JeojkeXAlQWl4Eq3y/so5OQ8Wj
	4Bsb00ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1paTER-00FCSC-2a;
	Fri, 10 Mar 2023 03:15:47 +0000
Date: Fri, 10 Mar 2023 03:15:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v3 2/6] erofs: convert to use i_blockmask()
Message-ID: <20230310031547.GD3390869@ZenIV>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309152127.41427-2-frank.li@vivo.com>
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
Cc: brauner@kernel.org, tytso@mit.edu, agruenba@redhat.com, joseph.qi@linux.alibaba.com, mark@fasheh.com, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, rpeterso@redhat.com, huyue2@coolpad.com, adilger.kernel@dilger.ca, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 09, 2023 at 11:21:23PM +0800, Yangtao Li wrote:
> Use i_blockmask() to simplify code.

Umm...  What's the branchpoint for that series?  Not the mainline -
there we have i_blocksize() open-coded...

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -none
> v2:
> -convert to i_blockmask()
>  fs/erofs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 7e8baf56faa5..e9d1869cd4b3 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		if (bdev)
>  			blksize_mask = bdev_logical_block_size(bdev) - 1;
>  		else
> -			blksize_mask = i_blocksize(inode) - 1;
> +			blksize_mask = i_blockmask(inode);
>  
>  		if ((iocb->ki_pos | iov_iter_count(to) |
>  		     iov_iter_alignment(to)) & blksize_mask)
> -- 
> 2.25.1
> 
