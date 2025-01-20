Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D60A16F7F
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 16:45:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcF694Q39z30J8
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 02:45:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737387919;
	cv=none; b=X1VIzFKOC3/xd8kNoS6L0T4X78+XCfKy1R5ZjUsCybJ1h3Ae7/pfn2K1fjUALZVVvjA2XJ+sg7p4zD2RKULJk705f7FsbrgNaKEZia25p5iBImIV36aagO3N8AZt77Vk+oaX0tOoD8tzFurz/sRMC6K7ll50d65n77eJ70jBSi9YHXsHrnbpVimY58hMp87HzHwSzJ7BoEhQNEJl1TLrJzGJhZPaJz6sLJEwWBvFQpblVpqQ8o3El2u/4ij/63hd2ETGxdK6OWqGNwN0s+3I/c5MqvlkkGJTPkBSDzG+/fyYoIX6dlPgl98V/1amYTuXxR8GMUh0pLjE2TGgWddxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737387919; c=relaxed/relaxed;
	bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QChuYsMtEIHFSdTyG1nfKfBueDzJs8YBk+ox2DcYpqNjkJ+xADnrH7z6M89m9fYP5cflb9xAV+x/mH08vvrEYcI+t3jupGcSsaWkG3y5di0mbZiAQDnyB5UDOtRV/LSoDefF7R0u63NYjUwFIFpZx2KJlvIOAc9qh/Lyzq0aE8poTE1RmTY3n8d40xa0fw+NNUYpVT/uQHz8qwSSxiNv7KMJ6Mq9Z30w1tvkfUb+nV1+IfjU2mG8aUjR8Tal8aEpmxzGBADIezfaCsinX0Fj3l5JajZjDAbtcZrMV6OzPgKmSGIg1MYZaDXSCsqvpXXRcE39T5AMg3sDLnS+euX+mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEVoNbcM; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XESA4bXx; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEVoNbcM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XESA4bXx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcF670D9hz2yvk
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2025 02:45:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
	b=SEVoNbcM7P+atvX8ZABpCkGKNZ34/pnJ0jl/2ui4+by9mzNgWYtDrRW4tzKQaUHYqs630w
	PJotek0dejVkbYDDBlU4UafKTGDOr6JwepTdsbch4SFczyPIumsi8JtVNAEpkkTfg9wtZu
	9ycoIpMXQbJOwRbSE87bAwIxgra0JF4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
	b=XESA4bXxJ/hlfzjUXlXmEnVu7RpJQveeMmiEhXU2bQ8KONPOqWhKSawxZKUA4Y6tXe4s2n
	hbcKzawlrbMv+//0I0TZvdvdh7p/tpuMHST7NltyKunpQEYTbrxn23m+WMu7Z+fqPgHs+b
	aJnIlol6fz5ZQ8u4zLsd99UclYA2Xwg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-4W8_tw2TP0WULzeTYGj6Uw-1; Mon, 20 Jan 2025 10:45:12 -0500
X-MC-Unique: 4W8_tw2TP0WULzeTYGj6Uw-1
X-Mimecast-MFC-AGG-ID: 4W8_tw2TP0WULzeTYGj6Uw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166f9f52fbso142664825ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 07:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387911; x=1737992711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
        b=MGILB3tL2YTHo22kuZW1vqdLacS5dYlgyCBljkKaNInmS+KbA5ReBJNnB2w5qeCMvQ
         c2y6ucRh9pxZv2vEgJOdURRvA79JQjGwV0rHEOY8hoWAK+76cJJzhVDax9ykcyqC9rOH
         p30pcvUAGe5VaCGFA4Kxb8i+Eevp9fWh/y/0ap3RLVyrknM1s7NS+Ydy3abEHzDv4p1O
         FgYzw3qhx/NrMKirj4OYKIkDZwsqFd+uSUvp0W7x427X9/4HdVUXEv21JtE8edqqZ0ib
         edP5qjfKMGrCBt8pvMIz6Bdd7ElzGC7jRSv7r+ps9gWCb61lLzTJYQZYUUkfBnkgZB3i
         tmLw==
X-Forwarded-Encrypted: i=1; AJvYcCVPZISEEjyH1nmo9T/Pr+gdA0o6VxGDaZVQv0fEG3ZprVqizAQ1QLoUqLF9Q0QDvSu7stgh14BTouXseQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxuq+0QZEyipE4tDKi+k9m51ZKvPd0YCVKZ62Zn2pAVc42jDYwK
	ILdYgF6coCulV8oh2AbH7VedJD6FdFsw3Tl3utguzWp8rE1s9yTdblPxW5jaKvU2vwbXtYPYxOd
	xiHbh5t8Tt261x9fQd46KqyzFNzHquZUM6mRdxh1ydG52CkFthTHHvTyLTxXSoNNcmXmMMz4uLF
	8F1KVBq33zEvSd59HC0JzKbARrm7dLwXKsP1pRDcf4T/pq
X-Gm-Gg: ASbGnctcTkKtZYVTYhZvbKCzvC9VQXW3r2dTd/1aZZdU/3Tb6xUTf5g7VUJqEhTJUCz
	qICxxhiBiFSxP8OfnUTphEZH0R9GlAlrXoiZ+wpzq5ytqBVEWbQ==
X-Received: by 2002:a17:902:d50e:b0:210:f706:dc4b with SMTP id d9443c01a7336-21c355b641dmr185100425ad.13.1737387910846;
        Mon, 20 Jan 2025 07:45:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuQe5UfQ3x73vBIKz+Vas2Vh1EUeCLsJdDGZT/xsX13VrNUtSO8YwlyHZngSzILoKv0/LIxcX/SpneTI4V0bM=
X-Received: by 2002:a17:902:d50e:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-21c355b641dmr185100145ad.13.1737387910533; Mon, 20 Jan 2025
 07:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20250116043226.GA23137@lst.de> <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com> <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
In-Reply-To: <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 20 Jan 2025 16:44:59 +0100
X-Gm-Features: AbW1kvbnR4jxYY1OmmWJQiLZ57eqMNbLkpoGBmLc4oA3QTE98Cmi7zx5BVBckp0
Message-ID: <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
To: Christian Brauner <brauner@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aS88DMGlMFBH62SirfL-Ze5GwUudeFqwRoRO0v4yaqE_1737387912
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 20, 2025 at 4:25=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> > On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrot=
e:
> > > Well, if you can fix it to start with 1 we could start out with 1
> > > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > > because it initialize the lock in the slab init_once callback and
> > > the count on every initialization.
> >
> > Sure, can you add the below patch before the lockref_init conversion?
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > gfs2: Prepare for converting to lockref_init
> >
> > First, move initializing the glock lockref spin lock from
> > gfs2_init_glock_once() to gfs2_glock_get().
> >
> > Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> > common case.  Compensate for that in gfs2_quota_init() by adjusting the
> > count back down to 0; this case occurs only when mounting the filesyste=
m
> > rw.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
>
> Can you send this as a proper separae patch, please?

Do you want this particular version which applies before Christoph's
patches or something that applies on top of Christoph's patches?

Thanks,
Andreas

