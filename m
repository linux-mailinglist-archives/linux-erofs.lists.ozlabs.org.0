Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580225F9F0
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 16:19:32 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fg8d6PKzzDqWW
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jul 2019 00:19:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="PlX/ktVQ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fg7Q586TzDqcG
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Jul 2019 00:18:26 +1000 (AEST)
Received: from localhost (unknown [89.205.128.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24895206A3;
 Thu,  4 Jul 2019 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562249904;
 bh=cFI7gsep8Qxgf6t/KUmGtDTJS73oSB20jxbsCf34SMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PlX/ktVQS0xxhZhoXYepWVoUrNk/epvE+t+W9ujTKM6Vo91JfUmGOerPmQbJByftX
 uwNiz0xeJf/LH90Kqjiabks5LNuyl+MKVVrIF+UL7QQo4kwxVO6pAWlWJBd9BXG47J
 AivLxBg4jLAfj0aU2i1A2G0cdFIe/VQKP88B6L4U=
Date: Thu, 4 Jul 2019 16:18:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] erofs: promote erofs from staging
Message-ID: <20190704141819.GA5782@kroah.com>
References: <20190704133413.43012-1-gaoxiang25@huawei.com>
 <20190704135002.GB13609@kroah.com>
 <29e713d5-8146-80cf-8ffd-138b15349489@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e713d5-8146-80cf-8ffd-138b15349489@huawei.com>
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
Cc: devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 04, 2019 at 10:00:53PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2019/7/4 21:50, Greg Kroah-Hartman wrote:
> > On Thu, Jul 04, 2019 at 09:34:13PM +0800, Gao Xiang wrote:
> >> EROFS file system has been in Linux-staging for about a year.
> >> It has been proved to be stable enough to move out of staging
> >> by 10+ millions of HUAWEI Android mobile phones on the market
> >> from EMUI 9.0.1, and it was promoted as one of the key features
> >> of EMUI 9.1 [1], including P30(pro).
> >>
> >> EROFS is a read-only file system designed to save extra storage
> >> space with guaranteed end-to-end performance by applying
> >> fixed-size output compression, inplace I/O and decompression
> >> inplace technologies [2] to Linux filesystem.
> >>
> >> In our observation, EROFS is one of the fastest Linux compression
> >> filesystem using buffered I/O in the world. It will support
> >> direct I/O in the future if needed. EROFS even has better read
> >> performance in a large CR range compared with generic uncompressed
> >> file systems with proper CPU-storage combination, which is
> >> a reason why erofs can be landed to speed up mobile phone
> >> performance, and which can be probably used for other use cases
> >> such as LiveCD and Docker image as well.
> >>
> >> Currently erofs supports 4k LZ4 fixed-size output compression
> >> since LZ4 is the fastest widely-used decompression solution in
> >> the world and 4k leads to unnoticable read amplification for
> >> the worst case. More compression algorithms and cluster sizes
> >> could be added later, which depends on the real requirement.
> >>
> >> More informations about erofs itself are available at:
> >>  Documentation/filesystems/erofs.txt
> >>  https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei
> >>
> >> erofs-utils (mainly mkfs.erofs now) is available at
> >> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
> >>
> >> Preliminary iomap support has been pending in erofs mailing
> >> list by Chao Yu. The key issue is that current iomap doesn't
> >> support tail-end packing inline data yet, it should be
> >> resolved later.
> >>
> >> Thanks to many contributors in the last year, the code is more
> >> clean and improved. We hope erofs can be used in wider use cases
> >> so let's promote erofs out of staging and enhance it more actively.
> >>
> >> Share comments about erofs! We think erofs is useful to
> >> community as a part of Linux upstream :)
> > 
> > I don't know if this format is easy for the linux-fsdevel people to
> > review, it forces them to look at the in-kernel code, which makes it
> > hard to quote.
> > 
> > Perhaps just make a patch that adds the filesystem to the tree and after
> > it makes it through review, I can delete the staging version?  We've
> > been doing that for wifi drivers that move out of staging as it seems to
> > be a bit easier.
> 
> OK, I will resend the whole patchset later as you suggested, but it will
> lack of information about some original authors and I'd like to know who
> is responsible to merge this kind of request to Linux upstream... maybe Linus?

I don't know who adds new filesystems to the tree these days.  Usually
you need to get some acks from the fsdevel developers first, and then it
can go directly to Linus in one of the merge windows.

> And it could be more consistent to leave staging version for linux-5.3
> because we still use it, but anyway, I will do it now.

Yeah, it's too late for 5.3-rc1, so don't worry.  I'll not delete
anything until it's actually in someone else's tree on its way to Linus.

thanks,

greg k-h
