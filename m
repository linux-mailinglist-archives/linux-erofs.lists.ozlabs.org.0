Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D144A560C
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:31:40 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MTwT3pDtzDqXB
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:31:37 +1000 (AEST)
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
 header.b="nZE3UBBQ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MTwN5s8HzDqH1
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:31:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtOXrhZ6Qo2E9DiEP7YXIr28AIXW+0S0Ci2r4SnPHSc=; b=nZE3UBBQdpl31RWqK8b4lIqyc
 YNuxzTF6JzAbvix1mEl6wIYepkdU5wsfqTp2AI2Z5LCz+DvE1PglTfCQkjncbxOcdLPmpxi+KWjV4
 Rk/fESJLFGmo7mdQYNkbb8dq5A3BH6QbTcRnQ2rNyvZwMIdernWqo55AdvxwBMkj7No3/PcYu0Vlb
 oqonhW0z/6oPX3i1RL/OKFNUwyiTpkRanwau/B/TNZ6JhWY22G2VBP3DoBv5sghAgqE8GMdAkEqfU
 xWUBQmZrMYo5Vc1XQLIbyE76Yr08z0HT5raE7mEGwqHLk2ev/FFbbsmkgVuHAycF2Z0YVH1xSdLaO
 iyykZgaKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lUS-0005TK-Qb; Mon, 02 Sep 2019 12:31:24 +0000
Date: Mon, 2 Sep 2019 05:31:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 20/21] erofs: kill use_vmap module parameter
Message-ID: <20190902123124.GR15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-21-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-21-hsiangkao@aol.com>
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

> @@ -224,9 +220,6 @@ static void *erofs_vmap(struct page **pages, unsigned int count)
>  {
>  	int i = 0;
>  
> -	if (use_vmap)
> -		return vmap(pages, count, VM_MAP, PAGE_KERNEL);
> -
>  	while (1) {
>  		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);

I think you can just open code this in the caller.

>  static void erofs_vunmap(const void *mem, unsigned int count)
>  {
> -	if (!use_vmap)
> -		vm_unmap_ram(mem, count);
> -	else
> -		vunmap(mem);
> +	vm_unmap_ram(mem, count);
>  }

And this wrapper can go away entirely.

And don't forget to report your performance observations to the arm64
maintainers!
