Return-Path: <linux-erofs+bounces-1922-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE07D27F76
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 20:14:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsXjG2tG4z2yFm;
	Fri, 16 Jan 2026 06:14:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768504466;
	cv=pass; b=ABHK3Qhp7Qkqn2HQN5b6rIMJSFav5NNMdehlo+vq6GIUGdRE8K/YbOYofAiZtKPYiP7jAHBH0KRzdNURpt0kl94/Rd2ZrwgnTSDtzLhLwUtjsYK5NQxusmB92Z13Lest0YYtCChi/w5l7HlRoUpQ/MQJ/hP9A24MP+GtPbiVrTto2jd6ht5M3wJ1e7boRuGawNo5cnIaACv5eNQG5OeJSrbsQ5zF9pO+LtZ0BiH5DvHiPM50xj8mizklTHIGOYM5VdCk1ibOKXJdAW5rCA7Dor3Ap5QVjoEuZeWnDfoVHB1imNpOvkP6uKtZfzBUcR/SGqqX5UjwGraHoViFfIETOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768504466; c=relaxed/relaxed;
	bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxo/TThNLgKJVhC66XjKSdCO31hw71ukcsPlsEGxtSzk6O7PeJ6U2kvwnAVbLwceWk/XUGdBHsKnU7/WO5Qxz4HvtePIBqhqLWOd84fFnZqbs1e1piWpCQX3DPIaWtskjg0tMaKtsT8sVhhRcsEmyPS2RyYFQ63O3AZ56cVe7rFzSYO/8zbfg9KDl/4WoGPXLxuBfGD91Kbjshraxqit53YtKYztwRocOvdqTv7XAq6r6Rrk9nFZt2OkAo/rBV1VJ/bvNuJMgxalGcfeuNDiXH0ShUIBrSKun/znr/BaaMBBLh/CF8ccv4+puEKw5rCGMrYknD1eAetMld/r7pfS4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Om4Jxjdb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Om4Jxjdb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsXjF2hN1z2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 06:14:24 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so7306655e9.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 11:14:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768504461; cv=none;
        d=google.com; s=arc-20240605;
        b=Jf1Fc/i5fpHyGzI9n8QO63YiRNTNN4qIpcAu27DgEp9WfGONWee18Vdm558KBTvPpq
         fJSlHo/2XmQd5pR9ncUnvcN8r6JuQFfU6PyxTTF4VFXe0TCYa+MVq8zJd9LAf3IHcx7A
         t7jrWO/4qqWa+Bnng/eCgVtIPLeaWLUr46IKZ7Lj+7GC0WoGBjQrN/vcBvLE5vm3LB5+
         Rk2JS2za4oLFsXtLS0ZV8UDiAiNWTjd9TReYS5XC0GFRnfnaXUVjVWOUEHO11kFjmKf3
         LLY6vz3iovmUJj3I2HdATlCRcLIoT508LauBjWpmU60bRCHYXJ5XCG0q1CXQeE+cNpqs
         tD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        fh=KhquR1o9SXlVihFnRoUHWHiH4JurK7CezIH/kR1Dabc=;
        b=d6i5d2e7/wIiNh2esPwfa4qpPHA2G7jZJ5i8+XCy9D843V6QlpNAWqpE5yCQtvLi08
         iyWZxWyEE5sYszr175jjxLH+bjXdPzSxBUSM1jIrwLVaH1xoXu0p1kcLyEz7umK3WuCP
         mRB7SCfed0qsodJloQgDvlYjl2KeOCqouycms0DjfSDJ4TEGdarjPK3VwuEjyujcU6d9
         xBwCOaCyuMg6ppHz/AogaI2uTWQ2DfmvRF7lEpbpBr2r7vlic38lCwIGzSDue7zQer1B
         N2NwjUocUgsp4gcphCDJ+T4tb8ndKBr+xULoylk03dcZ1PqQPXXxafZaEFd/2dzTpiuj
         URCg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768504461; x=1769109261; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        b=Om4JxjdbIKfuWDg07hXWXwYyutoCfQxGUZXcYmw6N6K0uorFGzFKpeWtRnRw6cx2Vl
         3+qefx+PjmJdcNvZPPKWUIV4tGI3yo7r8XmloRg/u3pQY1wzQ8Myrd91itQzW8HZbU9f
         pSOSTnGO0rfNwSkc/IIdxd9Xxmq2RXxiuueHW3fFyoDI2xr0fC+JXy7nY646Qig1Qb7n
         ADxFd5TPDTxQyWPPNvaAaMtLRRor59qHX6U82eDvfWdL5ZHFAs2+bv8CuR2qZkrlOv8l
         5s3hUBbaM9/ZSr7IS1F2vE3ub2w3KcwGPQeGj+a35puy7VaflDjUADTsiBWWJw8m6ZtO
         PsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768504461; x=1769109261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        b=b7OUJ3lrfrRlgIj3uiZ/wqlic47ZNVtMTEMDNmsVDB5EYOcK0W5xvja7/dkRtYtk/X
         gkGY4A1zsEnfoSodqOs7WN3EhDwBGlmtjcZ6FTOICAjTUXoDn+1NUoYIF/YjPyHDWq8O
         pL4eZpUmBE1RdyxHtjoioNZxcFqxvibg32hKdtJx3eyMVeGM2dP9uaPcTzIIu5TB7Ihk
         FtoIHwxpYAJJq4Fm2vwhAsNgKCYvaMN6Xd37rWOak17MeCilQG5pwIu+dewduNX0FZMw
         I2K0xVqZnNaX3UTvKFC2Zrz4v0PtrughvALFZF17l5GyYlpCY1c1EOdSP+0ByykuMpx+
         OXHg==
X-Forwarded-Encrypted: i=1; AJvYcCUUqKWGVGReERbj/7pmIdzbumlkuNU6CLx6XZKcshsJCLBKCVtZloQBNJmhi28roevIBD8zd+PEJ9bPXg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSBvGnm9GeuPu+ErrtgRJCULTH4X/v1f2jBUCDxPX61kyjMc3R
	gpocD3enzkyiiHPbNNWoDmlMKXbGqJqY+OTnA+Ns7fQkF01v+98uxiS7GcmamCf16UTO06S223x
	YgZE/CQkMmNUVsbs3PdTLJa0JI/tkkmY=
X-Gm-Gg: AY/fxX7YnU7kGC4VIUblV79UqBLCYt/d11+iRvv5obznOE8CJd5ZbXb053aD6Yl8ZTe
	FwGzeHjhuWS4lIt6E8443jRR9mj1AhyeuJi8bFmyDHPCH6yXdv5gSYtn9mgpNVfb1IY1kLXrCTT
	FFTESHLOd7Q5oBq4q6f0vAVhxgt0hnIG7hEtMEEUeqp6CVbJNmGDo+zNV197BaQebpXJyN2IQ6K
	OnfbtO9+3PcJsKTqIY6HnIT8EfNjOnA6Cvexw8HZqUFft+US8xD+lrcFeNein2PlkyYl+Ul7lGP
	7n2Ycynwnz037e4WtzAzqqMq860VBg==
X-Received: by 2002:a05:600c:5487:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4801e30d482mr9929055e9.13.1768504460920; Thu, 15 Jan 2026
 11:14:20 -0800 (PST)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com> <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
In-Reply-To: <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:14:09 +0100
X-Gm-Features: AZwV_QgZJLcC_-bQ-_VIrtnGFnLgmiVjy_ytBB44u2cGVyBOwKNqVyWt_Jfm7Ds
Message-ID: <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> In recent years, a number of filesystems that can't present stable
> >> filehandles have grown struct export_operations. They've mostly done
> >> this for local use-cases (enabling open_by_handle_at() and the like).
> >> Unfortunately, having export_operations is generally sufficient to mak=
e
> >> a filesystem be considered exportable via nfsd, but that requires that
> >> the server present stable filehandles.
> >
> > Where does the term "stable file handles" come from? and what does it m=
ean?
> > Why not "persistent handles", which is described in NFS and SMB specs?
> >
> > Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> > by both Christoph and Christian:
> >
> > https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e=
93c00c@brauner/
> >
> > Am I missing anything?
>
> PERSISTENT generally implies that the file handle is saved on
> persistent storage. This is not true of tmpfs.

That's one way of interpreting "persistent".
Another way is "continuing to exist or occur over a prolonged period."
which works well for tmpfs that is mounted for a long time.

But I am confused, because I went looking for where Jeff said that
you suggested stable file handles and this is what I found that you wrote:

"tmpfs filehandles align quite well with the traditional definition
 of persistent filehandles. tmpfs filehandles live as long as tmpfs files d=
o,
 and that is all that is required to be considered "persistent".

>
> The use of "stable" means that the file handle is stable for
> the life of the file. This /is/ true of tmpfs.

I can live with STABLE_HANDLES I don't mind as much,
I understand what it means, but the definition above is invented,
whereas the term persistent handles is well known and well defined.

Thanks,
Amir.

