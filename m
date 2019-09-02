Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ADEA55CA
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:20:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MTgb5s26zDqZl
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:20:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+8d7e6b8ef813b711cfc0+5853+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="E6jprwKT"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MTgV5s7SzDqY6
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:20:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i5OA/qh7001EI8dEeuvEnN4yuwyVMoB29w/Q1Jv0ARc=; b=E6jprwKTuDlVOxDRxjwN01ZmY
 Nl4A7Gq/ofd05hhiVv23gYTwweQKRIPZIjo/I4xYXs4OHbudOK+HsjZ2uBzMApSEl1lrZhbuFGGQ+
 EMKutBgK98psJybQMiEI0ZrJsKr0oHIfsdZYxtgmHe7BE+lAyKPoO3IMoe0EXLue4OmZqYkNPnXfi
 Ms3HTCy/ToEpSCMwZfAY2mWGr5zMZefoyJGcHZ2GUL6+pV7jiTVzh42lmUbPb5R6CD9gmf5n4tWBS
 Pe9vcKYu7xR07oYJjzJx9/SkZmAZAKkkK0lOrdjq96nJdjapKb6/bF26m20lH8gFNH/mU0ICdaiPU
 uCIldhptQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lJg-00022h-Ua; Mon, 02 Sep 2019 12:20:16 +0000
Date: Mon, 2 Sep 2019 05:20:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 13/21] erofs: simplify erofs_grab_bio() since bio_alloc()
 never fail
Message-ID: <20190902122016.GL15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-14-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-14-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 01, 2019 at 01:51:22PM +0800, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Christoph pointed out [1], "erofs_grab_bio tries to
> handle a bio_alloc failure, except that the function will
> not actually fail due the mempool backing it."
> 
> Sorry about useless code, fix it now.

A lot of file systems used to have this, it is a classic that gets
copy and pasted everywhere.  If you feel like doing a little project
it might make sense to check for other places that do the same.

> +		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio);
>  
>  		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
>  			err = -EFAULT;
> @@ -275,13 +270,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  		if (nblocks > BIO_MAX_PAGES)
>  			nblocks = BIO_MAX_PAGES;
>  
> -		bio = erofs_grab_bio(sb, blknr, nblocks, sb,
> -				     read_endio, false);
> -		if (IS_ERR(bio)) {
> -			err = PTR_ERR(bio);
> -			bio = NULL;
> -			goto err_out;
> -		}
> +		bio = erofs_grab_bio(sb, blknr, nblocks, sb, read_endio);

Btw, I think you should remove erofs_grab_bio in its current form.
The full code in data.c is indeed used in two places, so a local
erofs_raw_page_alloc_bio (or whatever name you prefer) helper here
that hardcodes the sb amd read_endio argument to simplify it a bit
makes sense.

> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index f06a2fad7af2..abe28565d6c0 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1265,7 +1265,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
>  		if (!bio) {
>  			bio = erofs_grab_bio(sb, first_index + i,
>  					     BIO_MAX_PAGES, bi_private,
> -					     z_erofs_vle_read_endio, true);
> +					     z_erofs_vle_read_endio);

But I think here you might as well open code it entirely, or at least
us a separate (and local to zdata.c) helper.
