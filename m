Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 43086A5587
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:06:02 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MTLt3ThKzDqW5
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:05:58 +1000 (AEST)
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
 header.b="TTaKIim1"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MTLq0lYnzDqMh
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:05:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rQBNmZ3r7tPYZ93qcdgzs9aT3ulfgxUExQ/2KE/PgFY=; b=TTaKIim1bhF1mLqocBrdBlH85
 8sJEL9o/uIe3NswXx32FNw7orE6U35jhrCh6sKd2DBNdat+AXAON5TRrFb+KuxHVqrpOG/xPmLgZs
 tYTVBj16cMNmFbCXUpVfkgAXmoJVqikEKnhkVgXzufH7+RRgECy7TvQ7BtSQiCllCIbBDpFgWO6Ga
 UpLklxlrYvFyjCFfvqjYUDl0MNEGMbf2VASynnkfV2PLD3mrLYFZY1Pi4UsguCMW69cUtuJ0CbY5L
 mrrAOEjySYvNc6lJitTAD3pije93p6JhN8g570szEXj+Ehs+eLTSKX+G6uWyoq6iRWyp51Y3XfJWa
 NprfvUrGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4l5g-0005RV-BO; Mon, 02 Sep 2019 12:05:48 +0000
Date: Mon, 2 Sep 2019 05:05:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 02/21] erofs: on-disk format should have explicitly
 assigned numbers
Message-ID: <20190902120548.GB15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-3-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-3-hsiangkao@aol.com>
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

On Sun, Sep 01, 2019 at 01:51:11PM +0800, Gao Xiang wrote:
>  enum {
> -	EROFS_INODE_FLAT_PLAIN,
> -	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
> -	EROFS_INODE_FLAT_INLINE,
> -	EROFS_INODE_FLAT_COMPRESSION,
> +	EROFS_INODE_FLAT_PLAIN			= 0,
> +	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
> +	EROFS_INODE_FLAT_INLINE			= 2,
> +	EROFS_INODE_FLAT_COMPRESSION		= 3,
>  	EROFS_INODE_LAYOUT_MAX
>  };
>  
> @@ -184,7 +184,7 @@ struct erofs_xattr_entry {
>  
>  /* available compression algorithm types */
>  enum {
> -	Z_EROFS_COMPRESSION_LZ4,
> +	Z_EROFS_COMPRESSION_LZ4	= 0,
>  	Z_EROFS_COMPRESSION_MAX
>  };

This all looks ok - it somtimes also helps to have a comment near
the numbers to indicate where they are stored, must that isn't a must.
