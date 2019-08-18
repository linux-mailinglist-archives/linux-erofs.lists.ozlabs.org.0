Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8184E91695
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 14:33:38 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BGgg3FWSzDrCJ
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 22:33:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="D8+f2Wvk"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BGgW17p6zDr8v
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 22:33:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xzB0N5KXoocholH/YOkGDtfICAB0yGZ8RmgdPY4pQBk=; b=D8+f2WvkG3p4WYc9upT4VTsHh
 f5SeQ1l6W8TPkD72cRq3W/6BHXnBllsfy1ZRsOACKqpIfcdUUAeByjXNJlgPSq9O6kKyUS/vDaaB4
 TMH0oiTgiT4gbsjz/lmiTBkQV/X1Ifiq/f5X6PXYemIACo1rf3KK5yxYaJhdlgAXXPwEktdLrNdly
 3vYZcGes35B0aRNrWAwQ16HHXF/hiODC26eK1gpfhSbGTlhsZcluX2QuzZAsAYbte77evggr1Piz0
 UKbu6+itGXx4A24C1YJJc27Hgbnu4ZqXCrZ0eNPmmHhmA+VZctKuXUPyxYACWV2lHw2uck+Y+2NYi
 qkVoejm9Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hzKN0-0004ZF-AZ; Sun, 18 Aug 2019 12:33:14 +0000
Date: Sun, 18 Aug 2019 05:33:14 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v3 RESEND] staging: erofs: fix an error handling in
 erofs_readdir()
Message-ID: <20190818123314.GA29733@bombadil.infradead.org>
References: <20190818030109.GA8225@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818032111.9862-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818032111.9862-1-hsiangkao@aol.com>
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

On Sun, Aug 18, 2019 at 11:21:11AM +0800, Gao Xiang wrote:
> +		if (dentry_page == ERR_PTR(-ENOMEM)) {
> +			errln("no memory to readdir of logical block %u of nid %llu",
> +			      i, EROFS_V(dir)->nid);

I don't think you need the error message.  If we get a memory allocation
failure, there's already going to be a lot of spew in the logs from the
mm system.  And if we do fail to allocate memory, we don't need to know
the logical block number or the nid -- it has nothiing to do with those;
the system simply ran out of memory.

> +			err = -ENOMEM;
> +			break;
> +		} else if (IS_ERR(dentry_page)) {
> +			errln("fail to readdir of logical block %u of nid %llu",
> +			      i, EROFS_V(dir)->nid);
> +			err = -EFSCORRUPTED;
> +			break;
> +		}
>  
>  		de = (struct erofs_dirent *)kmap(dentry_page);
>  
> -- 
> 2.17.1
> 
