Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A070586
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 18:35:18 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45snJz1VGCzDqVP
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2019 02:35:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=qppi=vt=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45snJt0xzMzDqV4
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 02:35:09 +1000 (AEST)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 441972190F;
 Mon, 22 Jul 2019 16:35:05 +0000 (UTC)
Date: Mon, 22 Jul 2019 12:35:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
Message-ID: <20190722123502.328cecb6@gandalf.local.home>
In-Reply-To: <0c2cdd4f-8fe7-6084-9c2d-c2e475e6806e@aol.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
 <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
 <20190722104048.463397a0@gandalf.local.home>
 <0c2cdd4f-8fe7-6084-9c2d-c2e475e6806e@aol.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 22 Jul 2019 23:33:53 +0800
Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Steven,
> 
> On 2019/7/22 ????10:40, Steven Rostedt wrote:
> >>> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
> >>>
> >>> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
> >>>    
> >> Writing example conversion patches to demonstrate cleaner code
> >> and perhaps reduce LOC seems the best way.  
> > Yes, I would be more interested in seeing patches that clean up the
> > code than just talking about it.
> >   
> 
> I guess that is related to me, though I didn't plan to promote
> a generic tagged pointer implementation in this series...

I don't expect you to either.

> 
> I try to describe what erofs met and my own implementation,
> assume that we have 3 tagged pointers, a, b, c, and one
> potential user only (no need to ACCESS_ONCE).
> 
> One way is
> 
> #define A_MASK		1
> #define B_MASK		1
> #define C_MASK		3
> 
> /* now we have 3 mask there, A, B, C is simple,
>    the real name could be long... */
> 
> void *a;
> void *b;
> void *c;		/* and some pointers */
> 
> In order to decode the tag, we have to
> 	((unsigned long)a & A_MASK)
> 
> to decode the ptr, we have to
> 	((unsigned long)a & ~A_MASK)
> 
> In order to fold the tagged pointer...
> 	(void *)((unsigned long)a | tag)

And you need a way to clear the flag.

> 
> You can see the only meaning of these masks is the bitlength of tags,
> but there are many masks (or we have to do open-coded a & 3,
> if bitlength is changed, we have to fix them all)...
> 
> therefore my approach is
> 
> typedef tagptr1_t ta;	/* tagptr type a with 1-bit tag */
> typedef tagptr1_t tb;	/* tagptr type b with 1-bit tag */
> typedef tagptr2_t tc;	/* tagptr type c with 2-bit tag */
> 
> and ta a; tb b; tc c;
> 
> the type will represent its bitlength of tags and we can use ta, tb, tc
> to avoid masks or open-coded bitlength.
> 
> In order to decode the tag, we can
> 	tagptr_unfold_tags(a)
> 
> In order to decode the ptr, we can
> 	tagptr_unfold_ptr(a)
> 
> In order to fold the tagged pointer...
> 	a = tagptr_fold(ta, ptr, tag)
> 
> 
> ACCESS_ONCE stuff is another thing... If my approach seems cleaner,
> we could move to include/linux later after EROFS stuffs is done...
> Or I could use a better tagptr approach later if any...

Looking at the ring buffer code, it may be a bit too complex to try to
use a generic infrastructure. Look at rb_head_page_set(), where it does
a cmpxchg to set or clear the flags and then tests the previous flags
to know what actions need to be done.

The ring buffer tag code was added in 2009, the rtmutex tag code was
added in 2006. It's been 10 years before we needed another tag
operation. I'm not sure we benefit from making this generic.

-- Steve

