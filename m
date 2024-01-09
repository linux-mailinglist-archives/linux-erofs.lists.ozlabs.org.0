Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A59828ABE
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 18:12:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8ct91jSKz3bpN
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 04:12:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.182; helo=mail-lj1-f182.google.com; envelope-from=marc.c.dionne@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8ct45sgxz30fD
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 04:11:56 +1100 (AEDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd0db24e03so35436111fa.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jan 2024 09:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820312; x=1705425112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74pgZ+nMyMyCi7Q0sf1ChPH+6TyfRgWiK4L8xKykjS8=;
        b=k6rC6NtLVPirh6l++0L3fbpy7f7uAKydgV2aFcWmuG7bsGtjCIUaVl5Kz+VJttmlc0
         mYfEVe+JxUpQjQY3iN/4x11+2IqszVOW8QpJLiWBk4clqUKBtyWR//F+qscmhv881nUq
         JJm20ySnrSfdZmr1FWDkO8UWtCowhmqchiHYXeu+telUmONaxGG+7WngMK69Nh5vAsn2
         2zeDFz1blcbrfDidZf5SF8uZL1WvthNHZ8FEX6YGLaU1SzDtmrOiDVatfH/pCY4b+6ve
         XpzDPaNyVwmyI5rLfXt6+WIJ2pMt5h/7jeXSvSO+G0c13cL4PlvDw2Gi3dHRMtzbnNyg
         7o3A==
X-Gm-Message-State: AOJu0Yw9EWd46xmGTOME+hKpqZMFDxIwC8CGn5PwLJio86j3tkoxEYOx
	ZC1Q56G0sjAFgEqKFS3gQwCtUDbJiYA0ZQ==
X-Google-Smtp-Source: AGHT+IFj0nsinViuEfC4BOPQKR0FW1CZUY2YFKIGx7osSlA78ED5hoFy68F4vVP67TqkpetWBRsctQ==
X-Received: by 2002:a2e:a99d:0:b0:2cd:4f2e:f980 with SMTP id x29-20020a2ea99d000000b002cd4f2ef980mr1265278ljq.72.1704820311698;
        Tue, 09 Jan 2024 09:11:51 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b00557b0f8d906sm1150679edw.70.2024.01.09.09.11.51
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:11:51 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a294295dda3so364442266b.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jan 2024 09:11:51 -0800 (PST)
X-Received: by 2002:a17:907:1c19:b0:a27:5397:74ed with SMTP id
 nc25-20020a1709071c1900b00a27539774edmr523050ejc.175.1704820311478; Tue, 09
 Jan 2024 09:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20240109112029.1572463-1-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 9 Jan 2024 13:11:39 -0400
X-Gmail-Original-Message-ID: <CAB9dFdt0haftd1LPo=_GmtcZvFR84w81eaARfUKW2KMSM5gxqg@mail.gmail.com>
Message-ID: <CAB9dFdt0haftd1LPo=_GmtcZvFR84w81eaARfUKW2KMSM5gxqg@mail.gmail.com>
Subject: Re: [PATCH 0/6] netfs, cachefiles: More additional patches
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jan 9, 2024 at 7:20=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Christian, Jeff, Gao,
>
> Here are some additional patches for my netfs-lib tree:
>
>  (1) Mark netfs_unbuffered_write_iter_locked() static as it's only used i=
n
>      the file in which it is defined.
>
>  (2) Display a counter for DIO writes in /proc/fs/netfs/stats.
>
>  (3) Fix the interaction between write-streaming (dirty data in
>      non-uptodate pages) and the culling of a cache file trying to write
>      that to the cache.
>
>  (4) Fix the loop that unmarks folios after writing to the cache.  The
>      xarray iterator only advances the index by 1, so if we unmarked a
>      multipage folio and that got split before we advance to the next
>      folio, we see a repeat of a fragment of the folio.
>
>  (5) Fix a mixup with signed/unsigned offsets when prepping for writing t=
o
>      the cache that leads to missing error detection.
>
>  (6) Fix a wrong ifdef hiding a wait.
>
> David
>
> The netfslib postings:
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.=
com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.=
com/ # v2
> Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.=
com/ # v3
> Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.c=
om/ # v4
> Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.=
com/ # v5
> Link: https://lore.kernel.org/r/20240103145935.384404-1-dhowells@redhat.c=
om/ # added patches
>
> David Howells (6):
>   netfs: Mark netfs_unbuffered_write_iter_locked() static
>   netfs: Count DIO writes
>   netfs: Fix interaction between write-streaming and cachefiles culling
>   netfs: Fix the loop that unmarks folios after writing to the cache
>   cachefiles: Fix signed/unsigned mixup
>   netfs: Fix wrong #ifdef hiding wait
>
>  fs/cachefiles/io.c            | 18 +++++++++---------
>  fs/netfs/buffered_write.c     | 27 ++++++++++++++++++++++-----
>  fs/netfs/direct_write.c       |  5 +++--
>  fs/netfs/fscache_stats.c      |  9 ++++++---
>  fs/netfs/internal.h           |  8 ++------
>  fs/netfs/io.c                 |  2 +-
>  fs/netfs/stats.c              | 13 +++++++++----
>  include/linux/fscache-cache.h |  3 +++
>  include/linux/netfs.h         |  1 +
>  9 files changed, 56 insertions(+), 30 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-cachefs@redhat.com" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-cachefs+unsubscribe@redhat.com.

This passes our kafs tests where a few of the issues fixed here had been se=
en.
I made the framework use 9p and no related issues were seen there either.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc
