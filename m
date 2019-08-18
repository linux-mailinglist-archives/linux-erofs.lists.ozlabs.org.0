Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8329185A
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 19:29:56 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BPFY6lvVzDr9y
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 03:29:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FekiGl/L"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BPFN19QtzDr8v
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 03:29:43 +1000 (AEST)
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 480E22146E;
 Sun, 18 Aug 2019 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566149381;
 bh=PgJleJMkSwlg249xRQ3F/CLBlnJ55j1fqyWspV/sxSo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FekiGl/L6shXdxivYe+rkyONVdHXfQ6Afmbfr/fNBY+CHkNu25IEPWPt56UlqUHno
 bFpMcqrtl7K2u7xAZD9UH+7fT8gKqlVaSimOuXQXrY2NSWuSlGZnV8E0f/h03HFPB1
 o0+oYsbdFDrx6uD30QvqnfFZ6AXv0QVAO+i0O/fc=
Date: Sun, 18 Aug 2019 10:29:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818172938.GA14413@sol.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
 Chao Yu <yuchao0@huawei.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Darrick <darrick.wong@oracle.com>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
References: <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818162201.GA16269@infradead.org>
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
 Darrick <darrick.wong@oracle.com>, Richard Weinberger <richard@nod.at>,
 torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 09:22:01AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 18, 2019 at 09:16:38AM -0700, Eric Biggers wrote:
> > Ted's observation was about maliciously-crafted filesystems, though, so
> > integrity-only features such as metadata checksums are irrelevant.  Also the
> > filesystem version is irrelevant; anything accepted by the kernel code (even if
> 
> I think allowing users to mount file systems (any of ours) without
> privilege is a rather bad idea.  But that doesn't mean we should not be
> as robust as we can.  Optionally disabling support for legacy formats
> at compile and/or runtime is something we should actively look into as
> well.
> 
> > it's legacy/deprecated) is open attack surface.
> > 
> > I personally consider it *mandatory* that we deal with this stuff.  But I can
> > understand that we don't do a good job at it, so we shouldn't hold a new
> > filesystem to an unfairly high standard relative to other filesystems...
> 
> I very much disagree.  We can't really force anyone to fix up old file
> systems.  But we can very much hold new ones to (slightly) higher
> standards.  Thats the only way to get the average quality up.  Some as
> for things like code style - we can't magically fix up all old stuff,
> but we can and usually do hold new code to higher standards.  (Often not
> to standards as high as I'd personally prefer, btw).

Not sure what you're even disagreeing with, as I *do* expect new filesystems to
be held to a high standard, and to be written with the assumption that the
on-disk data may be corrupted or malicious.  We just can't expect the bar to be
so high (e.g. no bugs) that it's never been attained by *any* filesystem even
after years/decades of active development.  If the developers were careful, the
code generally looks robust, and they are willing to address such bugs as they
are found, realistically that's as good as we can expect to get...

- Eric
