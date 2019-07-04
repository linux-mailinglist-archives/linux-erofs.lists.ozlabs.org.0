Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF655F245
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 07:27:05 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fRLH2rP7zDqbD
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 15:27:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="pLn7CV1p"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fRL829n6zDqYq
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jul 2019 15:26:55 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E7426218A3;
 Thu,  4 Jul 2019 05:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562218012;
 bh=I+0cH+uMT7VJ70KPqMIW9T45sVtfmgYmhLBmxgsq+no=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pLn7CV1p02AUDr60ZlfdxpQ5bkJ8gd6ERqKq4pMX+CjKvnIsgmHtPNGcgQlejITNx
 NYrdzjP+yqOoe/er9SU58/O+EPX1S24y3KThzgRsDyRl3FzS0RfRVPF4fe7AVvg1qd
 vD6iQ1lux/9E6IXGm/cgxz7eruZZHPTmQYa6snQE=
Date: Thu, 4 Jul 2019 07:26:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190704052649.GA7454@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
 <20190703162038.GA31307@kroah.com>
 <20190704095903.0000565e.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704095903.0000565e.zbestahu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 04, 2019 at 09:59:03AM +0800, Yue Hu wrote:
> On Wed, 3 Jul 2019 18:20:38 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Already check if ->datamode is supported in read_inode(), no need to check
> > > again in the next fill_inline_data() only called by fill_inode().
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > > no change
> > > 
> > >  drivers/staging/erofs/inode.c | 2 --
> > >  1 file changed, 2 deletions(-)  
> > 
> > This is already in my tree, right?
> 
> Seems not, i have received notes about other 2 patches below mergerd:
> 
> ```note1
> This is a note to let you know that I've just added the patch titled
> 
>     staging: erofs: don't check special inode layout
> 
> to my staging git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> in the staging-next branch.
> ```
> 
> ```note2
> This is a note to let you know that I've just added the patch titled
> 
>     staging: erofs: return the error value if fill_inline_data() fails
> 
> to my staging git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> in the staging-next branch.
> ```
> 
> No this patch in below link checked:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing

Then if it is not present, it needs to be rebased as it does not apply.

Please do so and resend it.

thanks,

greg k-h
