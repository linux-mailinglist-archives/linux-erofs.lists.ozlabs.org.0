Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B7772648B97
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 01:24:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NTTCf6qNZz3bfT
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 11:24:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dMnz6XKH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dMnz6XKH;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NTTCX444Hz2xCd
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Dec 2022 11:24:08 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6E7D7B82A04;
	Sat, 10 Dec 2022 00:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C92C433D2;
	Sat, 10 Dec 2022 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670631843;
	bh=mkQRf8rZZglel4X8c1Cmb05WYQ3DlvFSrxTlbe8Fg2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMnz6XKHeIK4xxbwY8/aw7uvotAQAU6pwJkOnr4m50CTmHQ5L4VYgCy3jcQS3N4wJ
	 +PoUSkzTLsuzy6M1t/Kjq/TKu5WXRpasc9GlSesdmGO5uP9Ic4z5MYWJVJ82oDat8v
	 Xm96TbwCFMNH/xrY1t3OaEcKk+M9t8KllQkfD4uxQnrl/ehrUQ8H23NQ/AZ4dEh+sU
	 JpnjuHTEcIYN0HCzII0hDOEc25H+O3G42oe8nQpLOOCTtHu4gc3eXwaWw7vM7a0wqF
	 W63W423ele92yNoHXQvcZ+tENnmPTO2kCybaa77XwtvJ5mvvDqzF1hCu6eL2Tk6DTS
	 7CBcuMDcTHJ2Q==
Date: Sat, 10 Dec 2022 08:23:57 +0800
From: Gao Xiang <xiang@kernel.org>
To: Siddh Raman Pant <code@siddh.me>
Subject: Re: [PATCH v2] erofs/zmap.c: Fix incorrect offset calculation
Message-ID: <Y5PRnfFDJkIOXRCB@debian>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
	Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs <linux-erofs@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
References: <20221209102151.311049-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221209102151.311049-1-code@siddh.me>
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
Cc: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com, linux-kernel <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 09, 2022 at 03:51:51PM +0530, Siddh Raman Pant via Linux-erofs wrote:
> Effective offset to add to length was being incorrectly calculated,
> which resulted in iomap->length being set to 0, triggering a WARN_ON
> in iomap_iter_done().
> 
> Fix that, and describe it in comments.
> 
> This was reported as a crash by syzbot under an issue about a warning
> encountered in iomap_iter_done(), but unrelated to erofs.
> 
> C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
> Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> 
> Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

It looks good to me!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> Changes since v2:
> - Fix the calculation instead of bailing out.
> 
>  fs/erofs/zmap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..a171e4caba3c 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -790,12 +790,16 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
>  		iomap->type = IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  		/*
> -		 * No strict rule how to describe extents for post EOF, yet
> -		 * we need do like below. Otherwise, iomap itself will get
> +		 * No strict rule on how to describe extents for post EOF, yet
> +		 * we need to do like below. Otherwise, iomap itself will get
>  		 * into an endless loop on post EOF.
> +		 *
> +		 * Calculate the effective offset by subtracting extent start
> +		 * (map.m_la) from the requested offset, and add it to length.
> +		 * (NB: offset >= map.m_la always)
>  		 */
>  		if (iomap->offset >= inode->i_size)
> -			iomap->length = length + map.m_la - offset;
> +			iomap->length = length + offset - map.m_la;
>  	}
>  	iomap->flags = 0;
>  	return 0;
> -- 
> 2.35.1
> 
> 
