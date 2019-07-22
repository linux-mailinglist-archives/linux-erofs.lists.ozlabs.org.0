Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756970286
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 16:41:06 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sknB4mv1zDqD0
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2019 00:41:02 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45skn225K6zDqCR
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 00:40:53 +1000 (AEST)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A5BD32190D;
 Mon, 22 Jul 2019 14:40:49 +0000 (UTC)
Date: Mon, 22 Jul 2019 10:40:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
Message-ID: <20190722104048.463397a0@gandalf.local.home>
In-Reply-To: <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
 <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
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
 Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 22 Jul 2019 09:16:22 +0300
Amir Goldstein <amir73il@gmail.com> wrote:

> CC kernel/trace maintainers for RB_PAGE_HEAD/RB_PAGE_UPDATE
> and kernel/locking maintainers for RT_MUTEX_HAS_WAITERS

Interesting.

> 
> > (Is there some use scenerios in overlayfs and fanotify?...)  
> 
> We had one in overlayfs once. It is gone now.
> 
> >
> > and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
> >
> > Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
> >  
> 
> Writing example conversion patches to demonstrate cleaner code
> and perhaps reduce LOC seems the best way.

Yes, I would be more interested in seeing patches that clean up the
code than just talking about it.

> 
> Also pointing out that fixing potential bugs in one implementation is preferred
> to having to patch all copied implementations.
> 
> I wonder if tagptr_unfold_tags() doesn't need READ_ONCE() as per:
> 1be5d4fa0af3 locking/rtmutex: Use READ_ONCE() in rt_mutex_owner()
> 
> rb_list_head() doesn't have READ_ONCE()

Hmm, even if the compiler decided to reread the data, it would still
need to clear the extra bits wouldn't it? Or am I missing something?

-- Steve

> Nor does hlist_bl_first() and BPF_MAP_PTR().
> 
> Are those all safe due to safe call sites? or potentially broken?

