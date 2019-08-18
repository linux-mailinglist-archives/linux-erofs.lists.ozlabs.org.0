Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E391423
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 04:21:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46B15H3GjNzDrcC
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 12:21:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46B154168BzDrby
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 12:21:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rTepqUiIUx2nnEvuuf1IfBTS43BjeweB+IeE+bLV2H0=; b=jA5GcXNq9MfyEvl9UgqfCv2uN
 KduJxuHrPS02dFDVNAioWXKihTJvtK+MC0OIWgHKRKgWVRh4vlxhFM2sqx+9PkAGFxQrdG3sbHW/Q
 YLQSj9SqVXiZFbfvnfC2q5R/l8VeTCUNqYUCKj9DL5w+R8UYF9PUDDPy5h54axO+TzRK/pgQQZqmE
 sKb71/Rdfb4ZEcyOREIhAspSOIeiiM14fnbtnYO7e6jxzsJ7jaEW+encFkdeMqG/W9MaXcZS7Y/zA
 w/Dgbb9xXuEE95rAY/kK8se2W7Yn2s8XtVyvkFNLYO3smemDaVVdEajDo74CszfjMM7gXz/Flg7uU
 +/+5Qy5SA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hzAoR-0001XG-Pw; Sun, 18 Aug 2019 02:20:55 +0000
Date: Sat, 17 Aug 2019 19:20:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v2] staging: erofs: fix an error handling in
 erofs_readdir()
Message-ID: <20190818022055.GA14592@bombadil.infradead.org>
References: <20190818014835.5874-1-hsiangkao@aol.com>
 <20190818015631.6982-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818015631.6982-1-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: devel@driverdev.osuosl.org, Richard Weinberger <richard@nod.at>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 09:56:31AM +0800, Gao Xiang wrote:
> @@ -82,8 +82,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  		unsigned int nameoff, maxsize;
>  
>  		dentry_page = read_mapping_page(mapping, i, NULL);
> -		if (IS_ERR(dentry_page))
> -			continue;
> +		if (IS_ERR(dentry_page)) {
> +			errln("fail to readdir of logical block %u of nid %llu",
> +			      i, EROFS_V(dir)->nid);
> +			err = PTR_ERR(dentry_page);
> +			break;

I don't think you want to use the errno that came back from
read_mapping_page() (which is, I think, always going to be -EIO).
Rather you want -EFSCORRUPTED, at least if I understand the recent
patches to ext2/ext4/f2fs/xfs/...
