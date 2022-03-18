Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A14DD403
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 05:54:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKWs91K0pz30Bm
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 15:54:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1647579293;
	bh=9e2eqajV95ruSVjDJxa6YifW3AZO/9wDm2CSdlwAAiE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SlHnDxnkT7yRUq1nCSgZ721MDzFaPc5iFVA6VvthMtonFHA52EhGTQO1qZtY9giu5
	 eCBwLSK60z9E/hazd2mL/4ZmtOu7nwKOxUyttcswRiBaH1rzXMh9AUK6YYJeUxwmqc
	 b/VVs/aukvUBvjjpn4MumRYifdwRmV/kU0JDU68jye5ZGpOxPhfqvT6nHLPdnz2kGh
	 vYKYlCxssM40tUmViBI7JOqmcRsY1kFkrn8vfq9Bp1g/fvX/rlY9F+UmIXm2syTDx3
	 7lKtecXfFWVEcLswzpHBPO1RRl78iV7Z3zk1XLj2dje09UsyU3/eowKtdUdFhFUFHn
	 JdS/ujB2o7CEA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::e30;
 helo=mail-vs1-xe30.google.com; envelope-from=dvander@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Nbn9jHX1; dkim-atps=neutral
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKWs14CH1z2ywH
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 15:54:43 +1100 (AEDT)
Received: by mail-vs1-xe30.google.com with SMTP id v62so7679973vsv.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 21:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9e2eqajV95ruSVjDJxa6YifW3AZO/9wDm2CSdlwAAiE=;
 b=Ip7xkzVascH10OEAK9VAi7ytjf2nv1gFJvHIDhTMNXSD4ZVMs80MIlcmwPRuMdKTiA
 4kfn4L/KkJcs3QuYkizsbucsQL3nqjC/tB4uVSQVr50onngoQ2qpNZD6xfGZzlOruDg5
 g6O2Zo4+hfsSuwpBkY0DnIgQ2tQ8vqyIj2nyvbrUIzrs/6S91XUXF/Wt4H9xc9ZjxxRR
 VJLSCVevteSDf1LVIRTkv65V3/WYpBLwuSg27OCpWrpy3+FroXcN+jVuWLIiXTQljcfY
 XPCRAeMDwaS8SjbeVHWrecy2xUQQfcPZ01X7vwP37fC9Kv1vmrdXKnoXv3bIpai8rHmk
 /xeQ==
X-Gm-Message-State: AOAM532xED7fKWf3n6F7kFz4dftbXJZBRK8PHrSCLK0CS+DaDofCzQzS
 3OQpnLI8jU34S7VTAo4K1Mbm9Xciy3ph7mqR6Zirfw==
X-Google-Smtp-Source: ABdhPJwFHOKYsTYYQqHovRbNsLi/tJ4rzwGupj1fu+hecRaoDHPcvpq1kIpALXm98ztLZZuBh3cNkjLNfEiyAhbF3ug=
X-Received: by 2002:a05:6102:32c8:b0:322:b329:bda9 with SMTP id
 o8-20020a05610232c800b00322b329bda9mr3526318vss.83.1647579279514; Thu, 17 Mar
 2022 21:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220311041829.3109511-1-dvander@google.com>
 <YirUWDjLn21E382Q@B-P7TQMD6M-0146.local>
 <YjFrSivX//3sGdSr@B-P7TQMD6M-0146.local>
In-Reply-To: <YjFrSivX//3sGdSr@B-P7TQMD6M-0146.local>
Date: Thu, 17 Mar 2022 21:54:28 -0700
Message-ID: <CA+FmFJDnzM6M3X53zksgUCygoYzncrfeYVpmwupCFT5YO-Z1YA@mail.gmail.com>
Subject: Re: [PATCH] erofs: rename ctime to mtime
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000b275af05da76f145"
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000b275af05da76f145
Content-Type: text/plain; charset="UTF-8"

Sorry about this - thank you for updating the patch!

On Tue, Mar 15, 2022 at 9:45 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Hi David,
>
> On Fri, Mar 11, 2022 at 12:47:20PM +0800, Gao Xiang wrote:
> > Hi David,
> >
> > On Fri, Mar 11, 2022 at 04:18:29AM +0000, David Anderson via Linux-erofs
> wrote:
> > > EROFS images should inherit modification time rather than creation
> time,
> > > since users and host tooling have no easy way to control creation time.
> > > To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
> > > renamed to i_mtime and i_mtime_nsec.
> > >
> > > Signed-off-by: David Anderson <dvander@google.com>
> >
> > Thanks for the patch!
> >
> > This patch looks good to me, yet, should we update
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/erofs.rst#n43
> >
> > here as well? (I think "Inode timestamp" might be fine..)
>
> Since another -rc8 is out, would you mind revising the patch with
> the document update... Or would you mind if I could help revise it?
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Gao Xiang
>

--000000000000b275af05da76f145
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry about this - thank you for updating the patch!</div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Mar 15, 2022 at 9:45 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.a=
libaba.com" target=3D"_blank">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi David,<br>
<br>
On Fri, Mar 11, 2022 at 12:47:20PM +0800, Gao Xiang wrote:<br>
&gt; Hi David,<br>
&gt; <br>
&gt; On Fri, Mar 11, 2022 at 04:18:29AM +0000, David Anderson via Linux-ero=
fs wrote:<br>
&gt; &gt; EROFS images should inherit modification time rather than creatio=
n time,<br>
&gt; &gt; since users and host tooling have no easy way to control creation=
 time.<br>
&gt; &gt; To reflect the new timestamp meaning, i_ctime and i_ctime_nsec ar=
e<br>
&gt; &gt; renamed to i_mtime and i_mtime_nsec.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: David Anderson &lt;<a href=3D"mailto:dvander@googl=
e.com" target=3D"_blank">dvander@google.com</a>&gt;<br>
&gt; <br>
&gt; Thanks for the patch!<br>
&gt; <br>
&gt; This patch looks good to me, yet, should we update<br>
&gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/Documentation/filesystems/erofs.rst#n43" rel=3D"noreferrer" ta=
rget=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/Documentation/filesystems/erofs.rst#n43</a><br>
&gt; <br>
&gt; here as well? (I think &quot;Inode timestamp&quot; might be fine..)<br=
>
<br>
Since another -rc8 is out, would you mind revising the patch with<br>
the document update... Or would you mind if I could help revise it?<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Gao Xiang<br>
</blockquote></div>

--000000000000b275af05da76f145--
