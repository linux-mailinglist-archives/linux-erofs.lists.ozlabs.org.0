Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B859964E
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 16:22:01 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Dmtt5M1PzDqnV
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2019 00:21:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mit.edu
 (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mit.edu
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Dmtm702FzDqCw
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2019 00:21:51 +1000 (AEST)
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com
 [104.133.0.111] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7MELgVm006640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Aug 2019 10:21:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 7F9C942049E; Thu, 22 Aug 2019 10:21:42 -0400 (EDT)
Date: Thu, 22 Aug 2019 10:21:42 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190822142142.GB2730@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Gao Xiang <hsiangkao@aol.com>, Richard Weinberger <richard@nod.at>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-erofs@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 22, 2019 at 10:33:01AM +0200, Richard Weinberger wrote:
> > super block chksum could be a compatible feature right? which means
> > new kernel can support it (maybe we can add a warning if such image
> > doesn't have a chksum then when mounting) but old kernel doesn't
> > care it.
> 
> Yes. But you need some why to indicate that the chksum field is now
> valid and must be used.
> 
> The features field can be used for that, but you don't use it right now.
> I recommend to check it for being 0, 0 means then "no features".
> If somebody creates in future a erofs with more features this code
> can refuse to mount because it does not support these features.

The whole point of "compat" features is that the kernel can go ahead
and mount the file system even if there is some new "compat" feature
which it doesn't understand.  So the fact that right now erofs doesn't
have any "compat" features means it's not surprising, and perfectly
OK, if it's not referenced by the kernel.

For ext4, we have some more complex feature bitmasks, "compat",
"ro_compat" (OK to mount read-only if there are features you don't
understand) and "incompat" (if there are any bits you don't
understand, fail the mount).  But since erofs is a read-only file
system, things are much simpler.

It might make life easier for other kernel developers if "features"
was named "compat_features" and "requirements" were named
"incompat_features", just because of the long-standing use of that in
ext2, ext3, ext4, ocfs2, etc.  But that naming scheme really is a
legacy of ext2 and its descendents, and there's no real reason why it
has to be that way on other file systems.

Cheers,

						- Ted
