Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0623445AF28
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 23:33:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzJnl63JDz2xsv
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 09:33:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a28vYZhc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a28vYZhc; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzJnj1GS2z2xD3
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 09:33:29 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB4B60F5B;
 Tue, 23 Nov 2021 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637706806;
 bh=SG6EdrV2iuRFaD+Ge9einOddVfpnmRARc8QmBaBuuzo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a28vYZhcK/L0+J3l2uz5lhbmBhpTNulgccQeW1VL7mEr/zZaDVT126YrHPn7DruBK
 8Dy2V7WvHSnxPoMv3Gmu/1GTlY8EPd2dzNH9XHbolRma1e6Zpqtzf6JbsTjbYzzl6q
 /LVxnqhglf1xKWmfXFryoBxBdoHQQS2TGBau2wxcst2u36MyQbyUVzIbr1colB13gR
 wQzb+Dj6/firAkz9pcYUjB0iNOa3KRetffwJcQeOR7c+gKFW1h2B5nylwGkZa95fAU
 cFRVmzlVAG8TbWgvsCffLBfLECxv6dPoy5cc+WVPS/yPlzYpaMN7vsLCMga9wFzZD7
 Bx6joLa58GHEQ==
Date: Tue, 23 Nov 2021 14:33:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/29] fsdax: remove a pointless __force cast in
 copy_cow_page_dax
Message-ID: <20211123223326.GG266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-13-hch@lst.de>
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 09, 2021 at 09:32:52AM +0100, Christoph Hellwig wrote:
> Despite its name copy_user_page expected kernel addresses, which is what
> we already have.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a916..73bd1439d8089 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -728,7 +728,7 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  		return rc;
>  	}
>  	vto = kmap_atomic(to);
> -	copy_user_page(vto, (void __force *)kaddr, vaddr, to);
> +	copy_user_page(vto, kaddr, vaddr, to);
>  	kunmap_atomic(vto);
>  	dax_read_unlock(id);
>  	return 0;
> -- 
> 2.30.2
> 
