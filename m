Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E05A1BC97
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 20:07:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfnPv6C54z30Tx
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 06:07:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737745665;
	cv=none; b=UL8C/wGPuSs1KxbZa8GQr10Yu8bCJtJBmcINomHumY+t8W1xeeOPDnKYAnWfQ1hMO3ZfxjIHiX288O14itwZFd6yXIEObZlxC4URsXZjFFpKSmYM2aLnfKBHcwYLE/BOf7m4cIukCiZuxYjHUYZnk1IdcIhbhnxClvlpeGj7VXy4ni6OkqEniz/XWm7vhD/02aAmNdGQhjFhdX/HStu6FC3UoHjVZX9d3lD4ZYZkqynPN2xOF4K76K3iy0E/M79NDiS1QehFaDjp1bDtc4JqCCYmMAVPNJ5Lt1HVVvj8ixiHhX2Sg8f7qWftlqYX0dPlFB2jugmCTTQZuwSvo9Ue0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737745665; c=relaxed/relaxed;
	bh=M64ccCiSMLIZYqvDwKn2KQG8TzxywkOKAzy05Y8MZaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaMxyjoVQVDqBFAzry8D1q7YhsjpUrRgt5xEP2XLwgzXe8IA8zVO6A2KlsvJCO8+hUrMsTHWGqVb0l1v7A/3jEWvf55BsdKJRtNbUkagSU5G5r8nN8waH6QgBQu7a5YjpWkJxKoFBfGpTYVj6Am99SynqfsTBSOF5CvfWDLfD/iZwFRoppWIIn3NquqeDl9Hr0bBUd8cHP1j/D701pdHmR3UhC7i+mA6uv0shnJFy22skrLh32fJVLfPkhDmo4u0I2Y/Peh5DQFnBhZWNuaXNJ6TlCW+EtAgsiSLL5sCktX7Rw7CaapfUhnsSiLzv7bZ+RMQq6qemlAouGhieWKaiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bddeLaMy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=marc.c.dionne@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bddeLaMy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=marc.c.dionne@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfnPq5NbCz2yGT
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 06:07:43 +1100 (AEDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso517052766b.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737745658; x=1738350458; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M64ccCiSMLIZYqvDwKn2KQG8TzxywkOKAzy05Y8MZaw=;
        b=bddeLaMyGrFZnKXCRczGHQPqiMRm5YKX1OXhcShInEzaJV3FUU5hYyDva1TVVpbC3c
         KQkHOe4eLqVSaJwwuJG/wipByGDGEU601BYc5FDEXz0SkqP5vB5FGr7Y5IcwgMfuAI0z
         KZafr3y79wxZHBa2plztG6QTJpBfj9W4HvAk+daIDlPTn+R58U4f/ZFbT7L1Ci39z5h4
         KTGgNsLodNui5EFBB2TUSSkmhZ86Dy/2AxT6rjKxf2Nrq3TkqVKQsEy3tyKhABfKeAXV
         iSJHqeIkcyOWAAp0hLfontIuKHzOj7n24iV/IXykNgDRjpntC3P8eRoJHDTxICeXfJNt
         uQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737745658; x=1738350458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M64ccCiSMLIZYqvDwKn2KQG8TzxywkOKAzy05Y8MZaw=;
        b=R4EJbEWBEvTeyRX5kLmzVvTMlGRO/0aKcXtCrqoZII0kQ/UHh5y6epAc28Xg8VSNX+
         ynoiPs7ktP2NXonQCLbhbVQk7L1CquRFx+uNgZgbi0JyH5M4IpEQ5buyImTv++PFsNcG
         p2HO57s4QCkCMBDstEiOu/oghawKjXzq8bL4JlJ2p9irfeRvw22DMKLGtstwAoiaMreo
         pgNXOFeN1SqpxJgTxR2+akS5p4QEbto6y3/1aokWzvAhtXgLRQ2tqVUqNXwv0d/UtECC
         xY8SC89cJOUwK9N2jyK14roRIZLTQftR9XjYhaxlnM0oFeFXERh6GxzaFrplsP5TfJ8v
         62og==
X-Forwarded-Encrypted: i=1; AJvYcCWNqO4j+T7LzLw8/u4mhvBtXgBPWvBGcSc+lzCukvO5US3gmGR/7LMh1jUVoM3uNG1qWVpWRfKL4L6n7Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwKcbuKRwU9Bn0z7V/ZnBbkBb/12tz8365+tlcpy0nPm1rP20M8
	mAUTcbR4UX+bEfVNEvA/qN/tjL1Ax7NvaOc1GpigH3Kbhm3oF+US/K3PaKzc64n/6kvlhvEY2bn
	HbFsK2qx7F4pFFjEdx5m+gZH3WjY=
X-Gm-Gg: ASbGncvuOrrZQ5u1j0tmKi9OKCCf0oDpJhvmq2zHel3oRiTsz9TonH2SM8+iiEF/roG
	CtpqgX3Qwa550uknd14z2SMny3kiGEIfZDf5KRPJhxCkXPTr178BWC3mcN/w=
X-Google-Smtp-Source: AGHT+IHVokvHgS4VPbH29H+qihMfYRv5DXmUYISCN+1KE4QC6a2L3CH+v4Rg2tloe5yQ1DMWw4vIjjDbAzeSubHjNHs=
X-Received: by 2002:a17:907:1c2a:b0:aac:832:9bf7 with SMTP id
 a640c23a62f3a-ab38b27be47mr2790084466b.24.1737745658104; Fri, 24 Jan 2025
 11:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com>
 <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
 <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com> <GHG6tQSGPRj9L93-skG-HGz4vGtXUxy6ibsUTKloUKncNmy8A7xgte0MEiI0iZJ7jD-SSrZiK2oswgvJCRan_0ZMi6xDlP11SHDi1Utf7mI=@pm.me>
In-Reply-To: <GHG6tQSGPRj9L93-skG-HGz4vGtXUxy6ibsUTKloUKncNmy8A7xgte0MEiI0iZJ7jD-SSrZiK2oswgvJCRan_0ZMi6xDlP11SHDi1Utf7mI=@pm.me>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Fri, 24 Jan 2025 15:07:26 -0400
X-Gm-Features: AWEUYZm1VpljAqRhQQ6dX7tl5sygVWqfg2AdWCAk6rSkUpuGiA6tuCJB2vasH_k
Message-ID: <CAB9dFds_bPG1vThvOxhKcoFbUPGURYRHrY_zubPrAqpQrgHA7A@mail.gmail.com>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only
 use one work item
To: Ihor Solodrai <ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, bpf <bpf@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 24, 2025 at 2:46=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Friday, January 24th, 2025 at 10:21 AM, Marc Dionne <marc.dionne@auris=
tor.com> wrote:
>
> >
> > [...]
> >
> > > A log snippet:
> > >
> > > 2025-01-24T02:15:03.9009694Z [ 246.932163] INFO: task ip:1055 blocked=
 for more than 122 seconds.
> > > 2025-01-24T02:15:03.9013633Z [ 246.932709] Tainted: G OE 6.13.0-g2bcb=
9cf535b8-dirty #149
> > > 2025-01-24T02:15:03.9018791Z [ 246.933249] "echo 0 > /proc/sys/kernel=
/hung_task_timeout_secs" disables this message.
> > > 2025-01-24T02:15:03.9025896Z [ 246.933802] task:ip state:D stack:0 pi=
d:1055 tgid:1055 ppid:1054 flags:0x00004002
> > > 2025-01-24T02:15:03.9028228Z [ 246.934564] Call Trace:
> > > 2025-01-24T02:15:03.9029758Z [ 246.934764] <TASK>
> > > 2025-01-24T02:15:03.9032572Z [ 246.934937] __schedule+0xa91/0xe80
> > > 2025-01-24T02:15:03.9035126Z [ 246.935224] schedule+0x41/0xb0
> > > 2025-01-24T02:15:03.9037992Z [ 246.935459] v9fs_evict_inode+0xfe/0x17=
0
> > > 2025-01-24T02:15:03.9041469Z [ 246.935748] ? __pfx_var_wake_function+=
0x10/0x10
> > > 2025-01-24T02:15:03.9043837Z [ 246.936101] evict+0x1ef/0x360
> > > 2025-01-24T02:15:03.9046624Z [ 246.936340] __dentry_kill+0xb0/0x220
> > > 2025-01-24T02:15:03.9048855Z [ 246.936610] ? dput+0x3a/0x1d0
> > > 2025-01-24T02:15:03.9051128Z [ 246.936838] dput+0x114/0x1d0
> > > 2025-01-24T02:15:03.9053548Z [ 246.937069] __fput+0x136/0x2b0
> > > 2025-01-24T02:15:03.9056154Z [ 246.937305] task_work_run+0x89/0xc0
> > > 2025-01-24T02:15:03.9058593Z [ 246.937571] do_exit+0x2c6/0x9c0
> > > 2025-01-24T02:15:03.9061349Z [ 246.937816] do_group_exit+0xa4/0xb0
> > > 2025-01-24T02:15:03.9064401Z [ 246.938090] __x64_sys_exit_group+0x17/=
0x20
> > > 2025-01-24T02:15:03.9067235Z [ 246.938390] x64_sys_call+0x21a0/0x21a0
> > > 2025-01-24T02:15:03.9069924Z [ 246.938672] do_syscall_64+0x79/0x120
> > > 2025-01-24T02:15:03.9072746Z [ 246.938941] ? clear_bhb_loop+0x25/0x80
> > > 2025-01-24T02:15:03.9075581Z [ 246.939230] ? clear_bhb_loop+0x25/0x80
> > > 2025-01-24T02:15:03.9079275Z [ 246.939510] entry_SYSCALL_64_after_hwf=
rame+0x76/0x7e
> > > 2025-01-24T02:15:03.9081976Z [ 246.939875] RIP: 0033:0x7fb86f66f21d
> > > 2025-01-24T02:15:03.9087533Z [ 246.940153] RSP: 002b:00007ffdb3cf93f8=
 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> > > 2025-01-24T02:15:03.9092590Z [ 246.940689] RAX: ffffffffffffffda RBX:=
 00007fb86f785fa8 RCX: 00007fb86f66f21d
> > > 2025-01-24T02:15:03.9097722Z [ 246.941201] RDX: 00000000000000e7 RSI:=
 ffffffffffffff80 RDI: 0000000000000000
> > > 2025-01-24T02:15:03.9102762Z [ 246.941705] RBP: 00007ffdb3cf9450 R08:=
 00007ffdb3cf93a0 R09: 0000000000000000
> > > 2025-01-24T02:15:03.9107940Z [ 246.942215] R10: 00007ffdb3cf92ff R11:=
 0000000000000202 R12: 0000000000000001
> > > 2025-01-24T02:15:03.9113002Z [ 246.942723] R13: 0000000000000000 R14:=
 0000000000000000 R15: 00007fb86f785fc0
> > > 2025-01-24T02:15:03.9114614Z [ 246.943244] </TASK>
> >
> >
> > That looks very similar to something I saw in afs testing, with a
> > similar stack but in afs_evict_inode where it hung waiting in
> > netfs_wait_for_outstanding_io.
> >
> > David pointed to this bit where there's a double get in
> > netfs_retry_read_subrequests, since netfs_reissue_read already takes
> > care of getting a ref on the subrequest:
> >
> > diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> > index 2290af0d51ac..53d62e31a4cc 100644
> > --- a/fs/netfs/read_retry.c
> > +++ b/fs/netfs/read_retry.c
> > @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct
> > netfs_io_request *rreq)
> > __clear_bit(NETFS_SREQ_BOUNDARY,
> > &subreq->flags);
> >
> > }
> >
> > - netfs_get_subrequest(subreq,
> > netfs_sreq_trace_get_resubmit);
> > netfs_reissue_read(rreq, subreq);
> > if (subreq =3D=3D to)
> > break;
> >
> > That seems to help for my afs test case, I suspect it might help in
> > your case as well.
>
> Hi Marc. Thank you for the suggestion.
>
> I've just tried this diff on top of bpf-next (d0d106a2bd21):
>
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 2290af0d51ac..53d62e31a4cc 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct netfs=
_io_request *rreq)
>                                 __clear_bit(NETFS_SREQ_BOUNDARY, &subreq-=
>flags);
>                         }
>
> -                       netfs_get_subrequest(subreq, netfs_sreq_trace_get=
_resubmit);
>                         netfs_reissue_read(rreq, subreq);
>                         if (subreq =3D=3D to)
>                                 break;
>
>
> and I'm getting a hung task with the same stack
>
> [  184.362292] INFO: task modprobe:2527 blocked for more than 20 seconds.
> [  184.363173]       Tainted: G           OE      6.13.0-gd0d106a2bd21-di=
rty #1
> [  184.363651] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  184.364142] task:modprobe        state:D stack:0     pid:2527  tgid:25=
27  ppid:2134   flags:0x00000002
> [  184.364743] Call Trace:
> [  184.364907]  <TASK>
> [  184.365057]  __schedule+0xa91/0xe80
> [  184.365311]  schedule+0x41/0xb0
> [  184.365525]  v9fs_evict_inode+0xfe/0x170
> [  184.365782]  ? __pfx_var_wake_function+0x10/0x10
> [  184.366082]  evict+0x1ef/0x360
> [  184.366312]  __dentry_kill+0xb0/0x220
> [  184.366561]  ? dput+0x3a/0x1d0
> [  184.366765]  dput+0x114/0x1d0
> [  184.366962]  __fput+0x136/0x2b0
> [  184.367172]  __x64_sys_close+0x9e/0xd0
> [  184.367443]  do_syscall_64+0x79/0x120
> [  184.367685]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  184.368005] RIP: 0033:0x7f4c6fc7f60b
> [  184.368249] RSP: 002b:00007ffc7582beb8 EFLAGS: 00000297 ORIG_RAX: 0000=
000000000003
> [  184.368733] RAX: ffffffffffffffda RBX: 0000555e18cff7a0 RCX: 00007f4c6=
fc7f60b
> [  184.369176] RDX: 00007f4c6fd64ee0 RSI: 0000000000000001 RDI: 000000000=
0000000
> [  184.369634] RBP: 00007ffc7582bee0 R08: 0000000000000000 R09: 000000000=
0000007
> [  184.370078] R10: 0000555e18cff980 R11: 0000000000000297 R12: 000000000=
0000000
> [  184.370544] R13: 00007f4c6fd65030 R14: 0000555e18cff980 R15: 0000555e1=
8d7b750
> [  184.371004]  </TASK>
> [  184.371151]
> [  184.371151] Showing all locks held in the system:
> [  184.371560] 1 lock held by khungtaskd/32:
> [  184.371816]  #0: ffffffff83195d90 (rcu_read_lock){....}-{1:3}, at: deb=
ug_show_all_locks+0x2e/0x180
> [  184.372397] 2 locks held by kworker/u8:21/2134:
> [  184.372695]  #0: ffff9a5300104d48 ((wq_completion)events_unbound){+.+.=
}-{0:0}, at: process_scheduled_works+0x23a/0x600
> [  184.373376]  #1: ffff9e9882187e20 ((work_completion)(&sub_info->work))=
{+.+.}-{0:0}, at: process_scheduled_works+0x25a/0x600
> [  184.374075]
> [  184.374182] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> So this appears to be something different.
>
> >
> > Marc

Looks like there may be a similar issue with the
netfs_get_subrequest() at line 196, which also precedes a call to
netfs_reissue_read.  Might be worth trying with that removed as well.

Marc
