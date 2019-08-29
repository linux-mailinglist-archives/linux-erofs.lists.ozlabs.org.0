Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 102AFA1637
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 12:34:23 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JzW002rlzDrB2
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 20:34:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+c7f673d4bdabd04d2ac5+5849+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="bOFsHPhy"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JzJV5V3tzDqRx
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2019 20:25:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2+CihOn1ngbaXeMiWDZKT9pHBOLXEG5xdssh2kdm+FU=; b=bOFsHPhysKyAq5Gk7Q+fYHwPG
 iIQh3sbehCzj0y6PhFfTvp0pxAies6r61lOhRpVgZFqpYU0tVuks3QRfD3w/P1ReFRdy1NHICjQIl
 H9PIKfxeTt0owWTegVbv7eKZ+k9+pxGOkVmcXB9mj7Y7obaXREYDY6tBtNOGDF2QWGC5PV4nOivWW
 RLNyP7iov5cz6Y6dr9AnnWUuYsVyZtHyfqKXb5daSGwhX8UeLoqHFtwAkA20OkYz2kuExCC/qZl9T
 9fxqPbUktLqeJ9dyGSAeIrQexg3y6XhSrvysYYtUg0IE1It6mQxA/aqGEQXz8csfXdYWu1ijAOe09
 2U5M+blcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i3Hbz-0007WE-RG; Thu, 29 Aug 2019 10:25:03 +0000
Date: Thu, 29 Aug 2019 03:25:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v6 06/24] erofs: support special inode
Message-ID: <20190829102503.GF20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-7-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-7-gaoxiang25@huawei.com>
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 02, 2019 at 08:53:29PM +0800, Gao Xiang wrote:
> This patch adds to support special inode, such as
> block dev, char, socket, pipe inode.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/erofs/inode.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index b6ea997bc4ae..637bf6e4de44 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -34,7 +34,16 @@ static int read_inode(struct inode *inode, void *data)
>  		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
>  
>  		inode->i_mode = le16_to_cpu(v2->i_mode);
> -		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
> +		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> +		    S_ISLNK(inode->i_mode))
> +			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
> +		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> +			inode->i_rdev =
> +				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
> +		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
> +			inode->i_rdev = 0;
> +		else
> +			return -EIO;

Please use a switch statement when dealing with the file modes to
make everything easier to read.
