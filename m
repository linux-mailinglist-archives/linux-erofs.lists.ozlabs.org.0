Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2DE4D5815
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 03:23:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KF8q63rr0z3096
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 13:22:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KF8pz3lL0z2yHp
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 13:22:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V6rDUt7_1646965356; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6rDUt7_1646965356) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 10:22:37 +0800
Date: Fri, 11 Mar 2022 10:22:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use mtime to seed ctimes
Message-ID: <Yiqyawmy5fcjNbU/@B-P7TQMD6M-0146.local>
References: <20220301041139.2272220-1-dvander@google.com>
 <Yh2u2Iab7BjUg3ZH@B-P7TQMD6M-0146.local>
 <CA+FmFJAxEkGZZjjuoSthFbdBXy5uSmk=JkNYw6FU-Ls7SUecTw@mail.gmail.com>
 <Yh24oH+pOWGbx70g@B-P7TQMD6M-0146.local>
 <YiA8tH3fdQQqI/Jf@B-P7TQMD6M-0146.local>
 <CA+FmFJB=TKb7ZOpa38k9OBeX3+2nVFYpKx==Tk+6oP78CAvE+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+FmFJB=TKb7ZOpa38k9OBeX3+2nVFYpKx==Tk+6oP78CAvE+g@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 10, 2022 at 01:58:33PM -0800, David Anderson wrote:
> Sorry for not replying sooner, things got very busy - I am working on
> this now and will hopefully have something tested + uploaded by EOD.

Yeah, ok. I think it's not urgent to us on the kernel side anyway since
it's always compatible with old kernels and mtime == ctime == atime as
always, we could also clarify later if it doesn't catch the next merge
window.. We could delay it to the next release..

Thanks,
Gao Xiang

> 
> Best,
> 
> -David
> 
> On Wed, Mar 2, 2022 at 7:57 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > Hi David,
> >
> > On Tue, Mar 01, 2022 at 02:09:36PM +0800, Gao Xiang wrote:
> > > On Mon, Feb 28, 2022 at 10:02:02PM -0800, David Anderson wrote:
> > > > On Mon, Feb 28, 2022 at 9:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > >
> > > > > Yeah, I agree I should think more when I planned to store `ctime' at the
> > > > > first time [my original thought was to keep metadata time (including
> > > > > uid, gid, etc..), so I selected `ctime' instead of `mtime'].
> > > > >
> > > > > Should we change what's described in 'Documentation/filesystems/erofs.rst'
> > > > > and even rename i_ctime to i_mtime?
> > > >
> > > > That's a good idea, I'll repost with a patch to rename to mtime.
> > > > Initially I figured it was ok, but the "ctime" name would cause
> > > > problems if EROFS ever stores both timestamps.
> > >
> > > Yeah, I recommend that we could use mtime from now on, but in case that
> > > users are confused, we may need add a compatible feature to indicate that.
> >
> > Would you mind sending a kernel patch to rename them recently if
> > you have some free slot?
> >
> > We're in 5.17-rc7 cycle.. I think we have to prepare patches for
> > 5.18 now so we can use new timestamp behavior from 5.18..
> >
> > Thanks,
> > Gao Xiang
> >
