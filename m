Return-Path: <linux-erofs+bounces-1933-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DAD2967D
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 01:25:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsgcQ31mgz2yFW;
	Fri, 16 Jan 2026 11:25:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768523142;
	cv=none; b=nnIymFucr45Us4bSrMd3IK4KRqKBfx8+q7DHOgTMXCWghKfkNZyuVLOJ4SzW8t8/Wrzca5fCCFhviSmd+lD1dGYIe9vuQ3JjohLWAMZLuq24/Lw5WDF+ooWo3SagnnCVIoJ9uvoR/gbJPhLtfTb3vAx0Aue1HNYY4+S7nmxDG+98bR+Ve0h2odd3ctnB+rp9ji2skW8wSoI7YXrZjn2JCYPHbGPzZ+mDCV/m818hlOJfMUGk8dBNC10b2D4G8+QWX9nXBfMHDzRz48CnRQkdr2Iv7J5aPc//1iJDdNo7Z60GhVxOWr2lOf/1Jxa7b/OkNgy4A4HlfGBdVsnaTorM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768523142; c=relaxed/relaxed;
	bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3jrJGPCu/A5VmQCxuzSY0ZV49vTZJTBaXb1BYacAEsjeCUz80hA5Q6Ha8t5GJUkBhYijBiLfscLlbEFjLIJgBsU0JPuNGfZgDm8iP2N6m6znnNPHrPMoOKXMKdHn0VhGo/pyygVhEEkMqs4OAw+fyiO9yVofgiVZJi3tCB1+pP+lzFVa1N5ILZkRI1sXgQQIwimJQM30L0YPXH+EXLw/YC+9aECHWQqeDgZEXn4+m48p+v8vJriND8gswaiFDErdfjyIK78sIEzEdDN0cHYszNfv3ZHVLd5I3g+tTe/8+mkFEmwaQPyRDQoGLRz8O0J0IxH/sqVcVdqovA4pDtLiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VfmNI9e+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VfmNI9e+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsgcN6Sbcz2xqj
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 11:25:40 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b870cbd1e52so217861766b.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768523135; x=1769127935; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
        b=VfmNI9e+0ACa9GX9iXOsvz7Zi2PyJiUqGy1N6q1IHXW07rlzETK2BXPgGpESD4iC1X
         pjAtPa5rfV1Tt+cLOcFyx5rXUHn894ZSL3/o/BrRx8xA+Jk8ryaEcqH7EEu4WSIPFNwN
         iISAHFnLf7XjgF63AhBTDR0KCLs3IaeDLg8+j6bkdcYBvuU14g6uCFggOHKCHmbN6OYN
         urS3+B/0KnHo4z7kn8B8UyVKoASXTV/LhR1zFDxDLtQz7YM2uQUmAbe4SjFWq0PoPYQ5
         cjVeezxUwkyOMyrI5/1aoMLjme/1HrDbmYGmdQ1zg8+i7urrZ71E+AwrV/3yO98ENFTs
         DAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768523135; x=1769127935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
        b=WKFGcoZFLz6W9vDGSIOJ9I6J82x6vCACbr3GDto3jlqEuY5RcS4QMMEtlLt1IxXHeT
         Hkm3uqq/xZ4T8i4CJr0wIPJ+3hvYhqdVVr2rzPfomUp04NjPbqqpgki1z2I+HpgclC+9
         vo5nTls6Jd7rTej4vN3+UIF0GENt6I1QzSzn+FQumR72ZVXAJiEOaPwuxf9kqznWlY9y
         gKheCoBDpZEn8nQgcuXjlw5y2oGzwaHHkl4xdl0ts1VBJIeoZheywMGyLe7yYodE7kmT
         jgShbhBqh/D6KUFgBWjYNi/nD/GqIzg6CDtEF1uCkElhKQ44wD6IU5k6se7MyX6LEIvz
         dFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO5UG5DxO/TSjXhlH8FGSBLhstrRqVthFVh+Gv7UhSLgN/ECM3sjaZkk+rY0NeGyM5Di3jDbDZq0Gb2w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAXGx0sCJle/yffN2WxuoLafMivjD1UzPJfaiS81ibYvFa/3JY
	WYbqYjTd5SCkeT+5roRuFUAWC3mvILdouh3YbUMUTREpoL+okfz6fFr1
X-Gm-Gg: AY/fxX5P3qKpI1STZ59F4tgt/t88l0bhAur4HnzcT48+pP8P240stoNRiGOFB7f+3G3
	kKeb2vaEM4uyfmEc7p2ojZGtkurmMU+OBB2AUAgQRmCrkR9Mb1awjN6AN7RCLtnMS/kG3tHsYjp
	hX48Hin0Q//A0FSv+zisiWzusHMkJGP3c9Z5rc5nMiiIPXCohSFug3znxnFBcm6doYKM7w0xVFT
	wcOW4w9KazTy+wCg8xCkCDg4b9UuKEVbfeV8Fl7O3utQtoHvhHdxwbg+4jwfOl6Y2CdhFgSnydI
	IxR3sKyGIYBQ0CHSq44qePt/DBR+UjIap14ZuwGoZV+Lvi3fBJqNiu2OYL8ZCfLJYrv829tjorF
	xX7ui9aeBlXs1Wb6rUUrQZmWkl/+0WvyPIox37EjGaPZT1lJg9+FaZ5MX8mvg73n7qinNP+n9rH
	CW1JtwOvzDD7ugTVGJRNxh6laiP/JOUaKf8x4p3RwaC/2A7pBmUF6F
X-Received: by 2002:a05:600d:8445:10b0:480:1a22:fce8 with SMTP id 5b1f17b1804b1-4801e3494acmr11682565e9.26.1768516821247;
        Thu, 15 Jan 2026 14:40:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm1443737f8f.27.2026.01.15.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:40:20 -0800 (PST)
Date: Thu, 15 Jan 2026 22:40:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Dave Chinner" <david@fromorbit.com>, "Amir Goldstein"
 <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, "Olga
 Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom
 Talpey" <tom@talpey.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Theodore Tso" <tytso@mit.edu>, "Andreas
 Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>, "Gao Xiang"
 <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>, "Yue Hu"
 <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, "Sandeep
 Dhavale" <dhavale@google.com>, "Hongbo Li" <lihongbo22@huawei.com>,
 "Chunhai Guo" <guochunhai@vivo.com>, "Carlos Maiolino" <cem@kernel.org>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Luis de Bethencourt"
 <luisbg@kernel.org>, "Salah Triki" <salah.triki@gmail.com>, "Phillip
 Lougher" <phillip@squashfs.org.uk>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>, "Ronnie Sahlberg"
 <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>, "Miklos Szeredi"
 <miklos@szeredi.hu>, "Mike Marshall" <hubcap@omnibond.com>, "Martin
 Brandenburg" <martin@omnibond.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel
 Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, "Ryusuke
 Konishi" <konishi.ryusuke@gmail.com>, "Trond Myklebust"
 <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp"
 <shaggy@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Richard
 Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>, "Andreas
 Gruenbacher" <agruenba@redhat.com>, "OGAWA Hirofumi"
 <hirofumi@mail.parknet.co.jp>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <20260115224018.2988ca25@pumpkin>
In-Reply-To: <06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
	<CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
	<d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
	<CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
	<4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
	<aWlXfBImnC_jhTw4@dread.disaster.area>
	<06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, 15 Jan 2026 16:37:27 -0500
"Chuck Lever" <cel@kernel.org> wrote:

> On Thu, Jan 15, 2026, at 4:09 PM, Dave Chinner wrote:
> > On Thu, Jan 15, 2026 at 02:37:09PM -0500, Chuck Lever wrote: =20
> >> On 1/15/26 2:14 PM, Amir Goldstein wrote: =20
> >> > On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org>=
 wrote: =20
> >> >>
> >> >>
> >> >>
> >> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote: =20
> >> >>> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote: =20
> >> >>>>
> >> >>>> In recent years, a number of filesystems that can't present stable
> >> >>>> filehandles have grown struct export_operations. They've mostly d=
one
> >> >>>> this for local use-cases (enabling open_by_handle_at() and the li=
ke).
> >> >>>> Unfortunately, having export_operations is generally sufficient t=
o make
> >> >>>> a filesystem be considered exportable via nfsd, but that requires=
 that
> >> >>>> the server present stable filehandles. =20
> >> >>>
> >> >>> Where does the term "stable file handles" come from? and what does=
 it mean?
> >> >>> Why not "persistent handles", which is described in NFS and SMB sp=
ecs?
> >> >>>
> >> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> >> >>> by both Christoph and Christian:
> >> >>>
> >> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-1=
2018e93c00c@brauner/
> >> >>>
> >> >>> Am I missing anything? =20
> >> >>
> >> >> PERSISTENT generally implies that the file handle is saved on
> >> >> persistent storage. This is not true of tmpfs. =20
> >> >=20
> >> > That's one way of interpreting "persistent".
> >> > Another way is "continuing to exist or occur over a prolonged period=
."
> >> > which works well for tmpfs that is mounted for a long time. =20
> >>=20
> >> I think we can be a lot more precise about the guarantee: The file
> >> handle does not change for the life of the inode it represents. It =20
> >
> > <pedantic mode engaged>
> >
> > File handles most definitely change over the life of a /physical/
> > inode. Unlinking a file does not require ending the life of the
> > physical object that provides the persistent data store for the
> > file.
> >
> > e.g. XFS dynamically allocates physical inodes might in a life cycle
> > that looks somewhat life this:
> >
> > 	allocate physical inode
> > 	insert record into allocated inode index
> > 	mark inode as free
> >
> > 	while (don't need to free physical inode) {
> > 		...
> > 		allocate inode for a new file
> > 		update persistent inode metadata to generate new filehandle
> > 		mark inode in use
> > 		...
> > 		unlink file
> > 		mark inode free
> > 	}
> >
> > 	remove inode from allocated inode index
> > 	free physical inode
> >
> > i.e. a free inode is still an -allocated, indexed inode- in the
> > filesystem, and until we physically remove it from the filesystem
> > the inode life cycle has not ended.
> >
> > IOWs, the physical (persistent) inode lifetime can span the lifetime
> > of -many- files. However, the filesystem guarantees that the handle
> > generated for that inode is different for each file it represents
> > over the whole inode life time.
> >
> > Hence I think that file handle stability/persistence needs to be
> > defined in terms of -file lifetimes-, not the lifetimes of the
> > filesystem objects implement the file's persistent data store. =20
>=20
> Fair enough, "inode" is the wrong term to use here.

Usually there is 'generation number' changes when the inode is used for
a new file.
IIRC the original nfs file handle was the major/minor for the disk partitio=
n,
the index into the 'on-disk inode table' (the inode number) and the
'generation number' (but I'm sure the length was a power of 2...).

It's not surprising Unix uses inode number and file handles.
K&R would have used RSM-11/M where 'file directory lookup' was a userspace
operation and the kernel only supported 'open by file handle'.
Although that got lost between there and ntfs.
(Windows IO is definitely based on RSM-11/M though.)

	David



