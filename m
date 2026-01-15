Return-Path: <linux-erofs+bounces-1926-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F8D281B7
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 20:32:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsY5T3WDkz2yFm;
	Fri, 16 Jan 2026 06:31:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768505517;
	cv=none; b=ieXulQWbdaEFM0g03ix+Dj/VtJHsTGVZt/aeJKkFnS2+lwcVypqAwjtvNptwU6HSGBGiVo7YEZ+Z1UgSpWm1BwfyZZG3TJ8AA/YDEcIi811Kpi00d/4b5TSE8irK1sOp89JJWPbh9yk1Zg9TiO6ZZqyHe0F6EsxDaDuPn3XsSBIdDxer7H2eLHvdEktBP/Hzfl8bhR9OSuUkqc9lmk5ycBZo+Zv4OhjcgjLXD6DG5xZw4ceblwKIEvirZkrQZsD8BC8lDTObFwvAL/YxnO5bRSAk3WTAvAr3i87ZWW+nVcm0nEXWtq5YqP07mJeqSMtFhG1rXxV7bPhACVZI8ngz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768505517; c=relaxed/relaxed;
	bh=JqDSb07Y8F9mJCkqUS0QQHnJ5q+4REJWbBlGem8BlhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbvDr9Fu95N8AadNyDGEI9MVjoB6ybcvw2rnEO37CKuC9oJlRzc/j0akwc+QuR3xUbUb2h3JYM3bul2DZxkDL3X9k71IncZltN2ECTjCE+oG3V8dpSc9Qz2Tm1vUy5fOjkmIixf+42EEYeRo+4c9UxPhubj3IoMGFNsye9ElNFxNjdHjcLdiYDq0xYxkjUaOTdWwBTSUXNxxLtvZj/bEmrg8N/D6+uI6GqTniGHNy8jTiJduJipjpzKXDjoS5tdXKtQynlTm4B6ZpoCt+JO51xR8yfjouxJSYF3TthxKt3VXVPO09796kWJpGKTSMVlBXg9WqPSEYPAuWWc7NjiieQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Me3V2gke; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Me3V2gke;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsY5S1lPtz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 06:31:55 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b871b6e0c70so198310466b.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505512; x=1769110312; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqDSb07Y8F9mJCkqUS0QQHnJ5q+4REJWbBlGem8BlhI=;
        b=Me3V2gkeK0u0oxjRuCZZrR1OLBXX3DoybGWZiIV8GqG/71TmXwGB3GMkMQP6Krs7Ka
         7O0IgcYmu6lKWA4Oct+Nbp4Lp3dYcYsUniYf87UKiCH0stq/k0+a6ad3chiZipfveGf+
         l27f9+8KFWwP5B8WF2yMjmkcaPkoGn+gxXIQbr58vb1OZDcwOU4wwf1FDHYMWskb3/Zn
         nBnlODCm4fmZjzR9pG21Iqywqnnfv5HQlI9DnE4j5EeDNJv2usM8YG0vEAPC0Du0lVS9
         Ke/ndLrp46OsFyoWQFq0vgy0r0eAk+1vwuQ60/AepxDRGrt8Oz4bimeK0rvIHDDLX3Rh
         ns9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505512; x=1769110312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqDSb07Y8F9mJCkqUS0QQHnJ5q+4REJWbBlGem8BlhI=;
        b=LpPHl7t66DBb6PlEotUVG6xUgKl7OkCVTumFK6iB6iZAESXfxxvCrd82N7XBJ8qgfP
         XECPafHgRbCGZuxWDe4zcjdidUCsGe0dy6Mq39wAgUsOMrJQ+JqYsLLjuHRpbmAnmGFC
         yiDbSmwcaLUN36xM82OiO4KDunipIRYxEDdVgUJyNPLFS3On2nXBp4i7PeO0Jw7GASbs
         PcgBHecImTm76NRADr3exMIi7ZJ+B53wyH4ejUjsxUUzRkTubRetsfB5YJDieYmRqayF
         lvZXJ8i17/VFexcxTk3e5yWSCtBZZRSE1wMBxVVZ2xT26t7XYeeu7+W9NxZIhR38yY2O
         hRqw==
X-Forwarded-Encrypted: i=1; AJvYcCVOEDXvsI3/RxQBlVPBjDka8L81YhjctJlESATVeQyw/DD8XQNYyJzldVE2/yeZpm4kHSA/ItvlRgJ7KA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaZHZZR7eCndYEerNLhX/rKLh4vRbyv2gwKzI3r1/dJPw+xvav
	6bgqG+BmvVR+nwPtCGljc5LvFunhVD7KKIYXEaVJCLIULBfdhNx1Pb0HYm39l3LN0kBQ0Nmgole
	OCnUr+Y8meA462y0bUkDmD+Tfbtcl514=
X-Gm-Gg: AY/fxX7aL/kaQLTqWwTLZwNnayzMfa3N+0+qGpNQrfFn5d8OmPnq9dYLcwkU1A8NMQ4
	06OAAGpSiKO+bU3mi/UcffsCuaePcP+J2Ek+u/X1h7TaJIDSpR/iFoLS1dGfmTMRODLo3G5/zQe
	LwJ7yz8u9zUAY/EANjWi8GjBBq+z4n2ny6OA7/bos+eCiOMs5C0PlYRzCXLpENYTLSCn2Q6OnVw
	zPrjTbYOSj44s7A2kbTJnxgaYX/8jKbEmljhJnIaJkLkrt3ffBrXIIwINe/GMKH4itpvv0pHtJO
	ENJirHy4VWXsAHdssk7U0tgBQLEo8g==
X-Received: by 2002:a17:907:3c87:b0:b87:442:e9b6 with SMTP id
 a640c23a62f3a-b879690c54amr11543766b.17.1768505511676; Thu, 15 Jan 2026
 11:31:51 -0800 (PST)
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
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com> <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:31:40 +0100
X-Gm-Features: AZwV_QhvHAFd_rX2K5lnQvHY5zGWrCY2L2ECA3-jgjFMNT8gFVUBrqM9bcPeRhY
Message-ID: <CAOQ4uxhnSPoqwws7XW4JU=jjgZJoFgCjcWwbfPaprDCZq=wnKQ@mail.gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 15, 2026 at 8:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> >
> >
> > On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> > > On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > >>
> > >> In recent years, a number of filesystems that can't present stable
> > >> filehandles have grown struct export_operations. They've mostly done
> > >> this for local use-cases (enabling open_by_handle_at() and the like)=
.
> > >> Unfortunately, having export_operations is generally sufficient to m=
ake
> > >> a filesystem be considered exportable via nfsd, but that requires th=
at
> > >> the server present stable filehandles.
> > >
> > > Where does the term "stable file handles" come from? and what does it=
 mean?
> > > Why not "persistent handles", which is described in NFS and SMB specs=
?
> > >
> > > Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> > > by both Christoph and Christian:
> > >
> > > https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-1201=
8e93c00c@brauner/
> > >
> > > Am I missing anything?
> >
> > PERSISTENT generally implies that the file handle is saved on
> > persistent storage. This is not true of tmpfs.
>
> That's one way of interpreting "persistent".
> Another way is "continuing to exist or occur over a prolonged period."
> which works well for tmpfs that is mounted for a long time.
>
> But I am confused, because I went looking for where Jeff said that
> you suggested stable file handles and this is what I found that you wrote=
:
>
> "tmpfs filehandles align quite well with the traditional definition
>  of persistent filehandles. tmpfs filehandles live as long as tmpfs files=
 do,
>  and that is all that is required to be considered "persistent".
>
> >
> > The use of "stable" means that the file handle is stable for
> > the life of the file. This /is/ true of tmpfs.
>
> I can live with STABLE_HANDLES I don't mind as much,
> I understand what it means, but the definition above is invented,
> whereas the term persistent handles is well known and well defined.
>

And also forgot to mention - STABLE HANDLES is very lexicographically
close to STALE HANDLES :-/

Thanks,
Amir.

