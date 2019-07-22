Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A736F962
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 08:16:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sWbH0jmdzDqSv
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 16:16:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b42; helo=mail-yb1-xb42.google.com;
 envelope-from=amir73il@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GiMkqHsb"; 
 dkim-atps=neutral
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sWbC3W3lzDqS8
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 16:16:37 +1000 (AEST)
Received: by mail-yb1-xb42.google.com with SMTP id a14so14587829ybm.11
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jul 2019 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mRiPNuu0IvHAFpeZVhrWYDUDjsfyID6dmrOBGytJQzY=;
 b=GiMkqHsb2C/Jw1o6Ub4DsiHZBxr6ZPjhjLrbLjNZ2yaaHCKmZJ1LRjvX1tmJbGD7Bi
 pKwqIfw1wbCFqysuExvOaGUzgDUJbvojSqnH4QGcuiaNSlyjpp5RKWyyR1HE1O2WkqZi
 yuolp/P4xNqjATF+LaZi/qhcLf+/MwAI5U2b185js89KVnQ6DBKBKZJAYx134EMcx6zs
 u2SEuK+hLnumxva+59nzjcpPKHmG1e17rGKrQ3hWlJllBtBmp/5XAu3LQAJRwL9QkU9F
 h1YP5naXIsNxpmacnONf4p6UavV3n5TqvxfKBQCc5d9fMO2tL1tdauivTwdVkM8E6QnX
 6NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mRiPNuu0IvHAFpeZVhrWYDUDjsfyID6dmrOBGytJQzY=;
 b=sxaRcLxFcE6UuEUEshOeoEv6mfgvp5GRp/KCKKRg6DoCDm3mUV0pE0fnlurV2oUakl
 wmnc5XcmoQrc3l6T/vrfQ4SNJqv2QD1B+pNNlnHxRjM00jSshkDW5wNqBDYxBDo7P7q0
 VAf6EM3oc4UdKQCGsIp86iG14DwNPwF0Pn30vpmAokSWBtqzkk/i1j2PcSUXviN1GDl6
 Zrb7nehR0lF+KtrwhygvIXhK1/7GkFS3dLO1G3o+79ePrQKC8Ew1WP2VawANdOZJLQYT
 sUTjYsJbTXusxC1JbaogB4VCe+OhSdVIJAVqtEnoOq8q9MewvVkUEANO/QfSbgLZb01p
 8dXg==
X-Gm-Message-State: APjAAAWeukh9hXzRKZuv/jcAighFff4b8fL6jhGUq7p9K5oN/+B0Sop2
 gJQCvBtid2tS4kHPCF6qZN0aOzQiQifR+S6EOhI=
X-Google-Smtp-Source: APXvYqzeP8dnmI9HUYEy65Jb64wblg41vjP3fcITilmmeXiO/XAUwrolXbZVlMRx1aCCChHAkomgV0wUhL20rNsxpvE=
X-Received: by 2002:a25:9a08:: with SMTP id x8mr40685653ybn.439.1563776193646; 
 Sun, 21 Jul 2019 23:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
In-Reply-To: <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jul 2019 09:16:22 +0300
Message-ID: <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
 Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 22, 2019 at 8:02 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Hi Amir,
>
> On 2019/7/22 12:39, Amir Goldstein wrote:
> > On Mon, Jul 22, 2019 at 5:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
> >>
> >> Currently kernel has scattered tagged pointer usages
> >> hacked by hand in plain code, without a unique and
> >> portable functionset to highlight the tagged pointer
> >> itself and wrap these hacked code in order to clean up
> >> all over meaningless magic masks.
> >>
> >> This patch introduces simple generic methods to fold
> >> tags into a pointer integer. Currently it supports
> >> the last n bits of the pointer for tags, which can be
> >> selected by users.
> >>
> >> In addition, it will also be used for the upcoming EROFS
> >> filesystem, which heavily uses tagged pointer pproach
> >>  to reduce extra memory allocation.
> >>
> >> Link: https://en.wikipedia.org/wiki/Tagged_pointer
> >
> > Well, it won't do much good for other kernel users in fs/erofs/ ;-)
>
> Thanks for your reply and interest in this patch.... :)
>
> Sigh... since I'm not sure kernel folks could have some interests in that stuffs.
>
> Actually at the time once I coded EROFS I found tagged pointer had 2 main advantages:
> 1) it saves an extra field;
> 2) it can keep the whole stuff atomicly...
> And I observed the current kernel uses tagged pointer all around but w/o a proper wrapper...
> and EROFS heavily uses tagged pointer... So I made a simple tagged pointer wrapper
> to avoid meaningless magic masks and type casts in the code...
>
> >
> > I think now would be a right time to promote this facility to
> > include/linux as you initially proposed.
> > I don't recall you got any objections. No ACKs either, but I think
> > that was the good kind of silence (?)
>
> Yes, no NAK no ACK...(it seems the ordinary state for all EROFS stuffs... :'( sigh...)
> Therefore I decided to leave it in fs/erofs/ in this series...
>
> >
> > You might want to post the __fdget conversion patch [1] as a
> > bonus patch on top of your series.
>
> I am not sure if another potential users could be quite happy with my ("sane?" or not)
> implementation...

Well, let's ask potential users then.

CC kernel/trace maintainers for RB_PAGE_HEAD/RB_PAGE_UPDATE
and kernel/locking maintainers for RT_MUTEX_HAS_WAITERS

> (Is there some use scenerios in overlayfs and fanotify?...)

We had one in overlayfs once. It is gone now.

>
> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
>
> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
>

Writing example conversion patches to demonstrate cleaner code
and perhaps reduce LOC seems the best way.

Also pointing out that fixing potential bugs in one implementation is preferred
to having to patch all copied implementations.

I wonder if tagptr_unfold_tags() doesn't need READ_ONCE() as per:
1be5d4fa0af3 locking/rtmutex: Use READ_ONCE() in rt_mutex_owner()

rb_list_head() doesn't have READ_ONCE()
Nor does hlist_bl_first() and BPF_MAP_PTR().

Are those all safe due to safe call sites? or potentially broken?

Thanks,
Amir.
