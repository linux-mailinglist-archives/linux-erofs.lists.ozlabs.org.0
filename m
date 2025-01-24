Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543FA1BC00
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 19:22:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737742919;
	bh=LXZkbsZymQDEeD5R6N901lei4FIsTKs9xGaTy0mc5JE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PbJrUduq0EB5/UPc8V8DwM9v6yIf97lp24TDGU1f2ihXGd26f+K7vmN+8/48D6tj1
	 QN+6FAtM8VtdcjGtAruQtrnCBgnfQx+EdHY5PXuzJZo3Jz/+TMatLUI7yhYnlOFhwo
	 xepa0XGo0y6V40ZIoRx7p5y0BETXIq93LhwDE0P+FTkJbGk3FTNpD9tV7PLGsjlR4x
	 VAo1wZuxtM00Lpu9SfVXz2mZsfWNBGMgJqEf09jUGgTtVaeiYBA2k2Tubq+kshuoyC
	 1mBuj50S4o5gy26pzbynx47lsPDFp+as35kc8EKR4Ypqf2bT0g8kPFffUJRquR0h+g
	 PG8QxQvWtteGg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfmP32ngBz30Tx
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 05:21:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737742917;
	cv=none; b=Dy0BkosFt+woGC3ffxpcHYDUBTLLLfaKSxOsiMR+CSc53/Y5XCKyRm/QpAAAUxdXqvR53OWuLvuepj81PCgnW72fu3Q3uJg0vKwLXCYe12oDWHd8hQi0f8HogzvugoE58u+ES0rLu7zrvCuG5iAa9jYM36PgDRLLk4FZTfLsMMCv8x9TdLFy5eFSDWps1i7sAO5xV5e4wnsMS4/MzcJycbH36IJNgBLc9hRHWVS071v2KOlev1kdV3x6rc91LyeNvYLaTSKZOubGQzaoVSRDn28+/rF3fjmRwkkDmZ+Pe46dtC+v63rs0GONTnMVi4TBsiSgBpdAdfXLrM0d0ESGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737742917; c=relaxed/relaxed;
	bh=LXZkbsZymQDEeD5R6N901lei4FIsTKs9xGaTy0mc5JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAHm90q4va0nVsbpHKuLixA6/TSOMvAkhG7kvBmf0ZmhpSVnwhRAIC3jFDCRj2FhsKTOf4woAHaYyIH/jxk/CF0isiNQrVZUVLAHCclva/P06oU7bUNbxYRMtw93803L+XbsRyjGssIZgHvzUDVkiiAtl2kO8mWXui+F1O/HDcHmE7XRFpNZpkBHsBjhkHBhaihONW0cZa8WakYSASZvXr7SM4UHewCxb6vD3KlnqAaL6lGLwEsWnHN5hgcSjaKXx9y4sMn+b4HgvxecWwku5EeBxzC3vFmzl9/n5p6I4DbTels0u/A52k4wLpRgO5uU+/98fcJv4Npvx2c4UKMLBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com; spf=pass (client-ip=209.85.218.53; helo=mail-ej1-f53.google.com; envelope-from=marc.c.dionne@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.218.53; helo=mail-ej1-f53.google.com; envelope-from=marc.c.dionne@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfmNz3j2Fz2yMF
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 05:21:54 +1100 (AEDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa67ac42819so385781266b.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 10:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737742910; x=1738347710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXZkbsZymQDEeD5R6N901lei4FIsTKs9xGaTy0mc5JE=;
        b=AwltgeT5cY+eGfdCp6sgZc6wz+ZCXE0UC6gP0mD+BUGcQ4E2k51mXtfFkdzmF941bb
         +kgszNxEy7JhEBmurt+OfGoUSQeUM5KC0adWaG2NDEsCnuvy/71MiGgtKuXWxC7eisJi
         6Sc31ZtNoRhtDNyQASJe8U6FPjJpB9n/QGNnj3ShoMYsIiRzQ3XP9Gb/lTsINXa3a+M+
         di17GCg9E2i+cgy4+RusRkPW0qAY6vcapwbTh6Ir7dwEfvgpS/hIInuiehf2eHaFsEer
         N5sJHUrUmCGkz80eha3yLG3jurBXYSkN+BfhyZmmbckUQsbES8jhKtLKo8Ytv8HYDMl7
         elxw==
X-Forwarded-Encrypted: i=1; AJvYcCVRcitXSBZDQjoe4MUgjDQOitzQNg2I6tTMW8nIT5uO/Y6O2dyeCe2ipbF/YwsLFTRRheVd+kEFxJdtYQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFPZnW41LvfDh1dEOX3xt31t5xGMEhXsxzbI5KSfyqEUERDbV9
	OidD4BpmQ34PIaVTDa3fCXrg2Rpz/GU/OgtvC9bN7jSkwaa7cT5G/ngcI/ove9M=
X-Gm-Gg: ASbGncuu19qdZ+ldu7c6yXQNBxYQNkeuUsGQMnSfI3nCEfB4POH86dKc1sqaqIcNoR4
	MR816Tp3xw3M7B2G3T5bEgn16Fcgdcx89OpwuCWG3Afaq4CVQw3NYpbsxkmOKTLrO/qF2Ls2ep1
	vquMsw6LnH16IlNF5efCYY+fmM4D9muPBsJrMbzVkdA3YE9aiOIKwdaXzBr4uTb2iPXf3iSySmW
	2UI7l2QvyUjkAJEZjfMvJLUjv5mWpmMaDGspAgxrcSnMuGa3qbQMzl9bCqal26pexZEh18yP8ut
	XHCnUdFDHIIEF/AYUyYMzCoXpKc7jdn0/HmPrSulFkW/f4ei
X-Google-Smtp-Source: AGHT+IHmt4zDhNTiSpU5/xoTLBci0ZbP0QPlHDCWA8BsBagxmBiere3xgdiF+YC6Up4udB7pmoEt2g==
X-Received: by 2002:a17:906:780c:b0:ab3:ae1d:8abf with SMTP id a640c23a62f3a-ab3ae1da1acmr2026149966b.56.1737742909724;
        Fri, 24 Jan 2025 10:21:49 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbf43sm161892166b.154.2025.01.24.10.21.47
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 10:21:48 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so427800266b.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 10:21:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW92Eq7MYKYhrKeuqLZK0b70MNLbp2D9Mwe4mzE4KZRCILCWoQX9/6t1qZWRDQTlmp23xVsgZTH+4zYYQ==@lists.ozlabs.org
X-Received: by 2002:a17:907:7d9f:b0:aae:df74:acd1 with SMTP id
 a640c23a62f3a-ab38b0b9b7dmr3175435766b.11.1737742907278; Fri, 24 Jan 2025
 10:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com>
 <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
In-Reply-To: <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
Date: Fri, 24 Jan 2025 14:21:35 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com>
X-Gm-Features: AWEUYZlb36GF3Tcj0JvJQORKz4x4XpHrlQbMsxXnEx1A7tVtE0HWDV4nwAVkVJo
Message-ID: <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only
 use one work item
To: Ihor Solodrai <ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.3 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
From: Marc Dionne via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Marc Dionne <marc.dionne@auristor.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, bpf <bpf@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 24, 2025 at 2:00=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Monday, December 16th, 2024 at 12:41 PM, David Howells <dhowells@redha=
t.com> wrote:
>
> > Change the way netfslib collects read results to do all the collection =
for
> > a particular read request using a single work item that walks along the
> > subrequest queue as subrequests make progress or complete, unlocking fo=
lios
> > progressively rather than doing the unlock in parallel as parallel requ=
ests
> > come in.
> >
> > The code is remodelled to be more like the write-side code, though only
> > using a single stream. This makes it more directly comparable and thus
> > easier to duplicate fixes between the two sides.
> >
> > This has a number of advantages:
> >
> > (1) It's simpler. There doesn't need to be a complex donation mechanism
> > to handle mismatches between the size and alignment of subrequests and
> > folios. The collector unlocks folios as the subrequests covering each
> > complete.
> >
> > (2) It should cause less scheduler overhead as there's a single work it=
em
> > in play unlocking pages in parallel when a read gets split up into a
> > lot of subrequests instead of one per subrequest.
> >
> > Whilst the parallellism is nice in theory, in practice, the vast
> > majority of loads are sequential reads of the whole file, so
> > committing a bunch of threads to unlocking folios out of order doesn't
> > help in those cases.
> >
> > (3) It should make it easier to implement content decryption. A folio
> > cannot be decrypted until all the requests that contribute to it have
> > completed - and, again, most loads are sequential and so, most of the
> > time, we want to begin decryption sequentially (though it's great if
> > the decryption can happen in parallel).
> >
> > There is a disadvantage in that we're losing the ability to decrypt and
> > unlock things on an as-things-arrive basis which may affect some
> > applications.
> >
> > Signed-off-by: David Howells dhowells@redhat.com
> >
> > cc: Jeff Layton jlayton@kernel.org
> >
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> > fs/9p/vfs_addr.c | 3 +-
> > fs/afs/dir.c | 8 +-
> > fs/ceph/addr.c | 9 +-
> > fs/netfs/buffered_read.c | 160 ++++----
> > fs/netfs/direct_read.c | 60 +--
> > fs/netfs/internal.h | 21 +-
> > fs/netfs/main.c | 2 +-
> > fs/netfs/objects.c | 34 +-
> > fs/netfs/read_collect.c | 716 ++++++++++++++++++++---------------
> > fs/netfs/read_pgpriv2.c | 203 ++++------
> > fs/netfs/read_retry.c | 207 +++++-----
> > fs/netfs/read_single.c | 37 +-
> > fs/netfs/write_collect.c | 4 +-
> > fs/netfs/write_issue.c | 2 +-
> > fs/netfs/write_retry.c | 14 +-
> > fs/smb/client/cifssmb.c | 2 +
> > fs/smb/client/smb2pdu.c | 5 +-
> > include/linux/netfs.h | 16 +-
> > include/trace/events/netfs.h | 79 +---
> > 19 files changed, 819 insertions(+), 763 deletions(-)
>
> Hello David.
>
> After recent merge from upstream BPF CI started consistently failing
> with a task hanging in v9fs_evict_inode. I bisected the failure to
> commit e2d46f2ec332, pointing to this patch.
>
> Reverting the patch seems to have helped:
> https://github.com/kernel-patches/vmtest/actions/runs/12952856569
>
> Could you please investigate?
>
> Examples of failed jobs:
>   * https://github.com/kernel-patches/bpf/actions/runs/12941732247
>   * https://github.com/kernel-patches/bpf/actions/runs/12933849075
>
> A log snippet:
>
>     2025-01-24T02:15:03.9009694Z [  246.932163] INFO: task ip:1055 blocke=
d for more than 122 seconds.
>     2025-01-24T02:15:03.9013633Z [  246.932709]       Tainted: G         =
  OE      6.13.0-g2bcb9cf535b8-dirty #149
>     2025-01-24T02:15:03.9018791Z [  246.933249] "echo 0 > /proc/sys/kerne=
l/hung_task_timeout_secs" disables this message.
>     2025-01-24T02:15:03.9025896Z [  246.933802] task:ip              stat=
e:D stack:0     pid:1055  tgid:1055  ppid:1054   flags:0x00004002
>     2025-01-24T02:15:03.9028228Z [  246.934564] Call Trace:
>     2025-01-24T02:15:03.9029758Z [  246.934764]  <TASK>
>     2025-01-24T02:15:03.9032572Z [  246.934937]  __schedule+0xa91/0xe80
>     2025-01-24T02:15:03.9035126Z [  246.935224]  schedule+0x41/0xb0
>     2025-01-24T02:15:03.9037992Z [  246.935459]  v9fs_evict_inode+0xfe/0x=
170
>     2025-01-24T02:15:03.9041469Z [  246.935748]  ? __pfx_var_wake_functio=
n+0x10/0x10
>     2025-01-24T02:15:03.9043837Z [  246.936101]  evict+0x1ef/0x360
>     2025-01-24T02:15:03.9046624Z [  246.936340]  __dentry_kill+0xb0/0x220
>     2025-01-24T02:15:03.9048855Z [  246.936610]  ? dput+0x3a/0x1d0
>     2025-01-24T02:15:03.9051128Z [  246.936838]  dput+0x114/0x1d0
>     2025-01-24T02:15:03.9053548Z [  246.937069]  __fput+0x136/0x2b0
>     2025-01-24T02:15:03.9056154Z [  246.937305]  task_work_run+0x89/0xc0
>     2025-01-24T02:15:03.9058593Z [  246.937571]  do_exit+0x2c6/0x9c0
>     2025-01-24T02:15:03.9061349Z [  246.937816]  do_group_exit+0xa4/0xb0
>     2025-01-24T02:15:03.9064401Z [  246.938090]  __x64_sys_exit_group+0x1=
7/0x20
>     2025-01-24T02:15:03.9067235Z [  246.938390]  x64_sys_call+0x21a0/0x21=
a0
>     2025-01-24T02:15:03.9069924Z [  246.938672]  do_syscall_64+0x79/0x120
>     2025-01-24T02:15:03.9072746Z [  246.938941]  ? clear_bhb_loop+0x25/0x=
80
>     2025-01-24T02:15:03.9075581Z [  246.939230]  ? clear_bhb_loop+0x25/0x=
80
>     2025-01-24T02:15:03.9079275Z [  246.939510]  entry_SYSCALL_64_after_h=
wframe+0x76/0x7e
>     2025-01-24T02:15:03.9081976Z [  246.939875] RIP: 0033:0x7fb86f66f21d
>     2025-01-24T02:15:03.9087533Z [  246.940153] RSP: 002b:00007ffdb3cf93f=
8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
>     2025-01-24T02:15:03.9092590Z [  246.940689] RAX: ffffffffffffffda RBX=
: 00007fb86f785fa8 RCX: 00007fb86f66f21d
>     2025-01-24T02:15:03.9097722Z [  246.941201] RDX: 00000000000000e7 RSI=
: ffffffffffffff80 RDI: 0000000000000000
>     2025-01-24T02:15:03.9102762Z [  246.941705] RBP: 00007ffdb3cf9450 R08=
: 00007ffdb3cf93a0 R09: 0000000000000000
>     2025-01-24T02:15:03.9107940Z [  246.942215] R10: 00007ffdb3cf92ff R11=
: 0000000000000202 R12: 0000000000000001
>     2025-01-24T02:15:03.9113002Z [  246.942723] R13: 0000000000000000 R14=
: 0000000000000000 R15: 00007fb86f785fc0
>     2025-01-24T02:15:03.9114614Z [  246.943244]  </TASK>

That looks very similar to something I saw in afs testing, with a
similar stack but in afs_evict_inode where it hung waiting in
netfs_wait_for_outstanding_io.

David pointed to this bit where there's a double get in
netfs_retry_read_subrequests, since netfs_reissue_read already takes
care of getting a ref on the subrequest:

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 2290af0d51ac..53d62e31a4cc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct
netfs_io_request *rreq)
                                __clear_bit(NETFS_SREQ_BOUNDARY,
&subreq->flags);
                        }

-                       netfs_get_subrequest(subreq,
netfs_sreq_trace_get_resubmit);
                        netfs_reissue_read(rreq, subreq);
                        if (subreq =3D=3D to)
                                break;

That seems to help for my afs test case, I suspect it might help in
your case as well.

Marc
