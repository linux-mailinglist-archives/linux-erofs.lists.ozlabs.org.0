Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95A915BE
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 11:10:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BB8p2mjNzDrQB
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 19:10:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="0UZqnSyo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BB8h58NczDrQ6
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 19:09:54 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F3792173B;
 Sun, 18 Aug 2019 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566119392;
 bh=zJeFs7U/OKJWGGAMgwGEyd/YRXXtatS0kuwxKva2EtI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0UZqnSyoKKQI2GubQ7wUWVIzzCcywbZk0Vo5WOBVxQoz0OxWGEiiXXyd2WEKHQbN8
 +nUz3Fi4lJqCIQKluFrSEk+kOlmFp23ugbEb7oiWGNF8pk3mmYPGEdXDrRd6Z4NSDn
 /sYRTOi+IAPVeIgSOSpwJEki9pCCk8/4CidsmOIE=
Date: Sun, 18 Aug 2019 11:09:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818090949.GA30276@kroah.com>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Darrick <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 tytso <tytso@mit.edu>, torvalds <torvalds@linux-foundation.org>,
 David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 11:03:53AM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > I agree with you, but what can we do now is trying our best to fuzz
> > all the fields.
> > 
> > So, what is your opinion about EROFS?
> 
> All I'm saying is that you should not blindly trust the disk.
> 
> Another thing that raises my attention is in superblock_read():
>         memcpy(sbi->volume_name, layout->volume_name,
>                sizeof(layout->volume_name));
> 
> Where do you check whether ->volume_name has a NUL terminator?
> Currently this field has no user, maybe will add a check upon usage.
> But this kind of things makes me wonder.

You have looked at reiserfs lately, right?  :)

Not to say that erofs shouldn't be worked on to fix these kinds of
issues, just that it's not an unheard of thing to trust the disk image.
Especially for the normal usage model of erofs, where the whole disk
image is verfied before it is allowed to be mounted as part of the boot
process.

thanks,

greg k-h
