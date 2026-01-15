Return-Path: <linux-erofs+bounces-1918-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23296D2762C
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 19:22:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsWY13SXRz2yFm;
	Fri, 16 Jan 2026 05:22:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768501333;
	cv=none; b=NM9DkVSbKjH7ouKCu4LZlAcNl3PLT3IKZBtTJLDp93d47eI+qYLQsIGEiqyTaUoMQ7ajFakVRIMyIoUHjIKCp3ZZSjJqMO8ts6ueb9pBUURep8haixMo3Te48SVX3/jduGqllA46fZzqTBemhh2IrS9afs2RkRnM7Ruzrn6Q2jf7x3y4etYBP6ojkQPPZaXUxlngyCSjKTkdb1zPupteLYpSi3aDyYv9yqIkavzl45D1TNLiT7eg4YLhaEPKJCa3fs6L3Wz8q2vN40bKDE6V0BpNdygtF5C7xA3e/HJ6aEHV/fgnhul9Pwrm9sj+j+srcHZMpv3npnEM6IQbTGIY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768501333; c=relaxed/relaxed;
	bh=d7IY8l2+i1WeuEXvkGd5lYKI5+uHV9G4YufUEOTseco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSURCha7DV6rUlH2s6XMSylRnIT06FG03ZF3ii2dzYke/aGBAs4NdwCr3hSb7uTWHYf/mb+lGA8mi4FIHl9pC+ZbMQjwqsBMA3KK8vUzSGUIDpPjboAY8sr+r4fPo6t4Qs4HGROJwgEaqPpi4QFkNTDLrcBGp3gcT1kcJmjViUrvg7BU8RPompY6y5FWPZlfyi0XB+ulafUogAw9L1C1QMNnW8jR6To1ttP1oIdBLBXBNExGFk/yiyNd8jGbmeGZBxi3q9omsoeN7hYgZqlJDDOEn3uKljP82W17KKCG+xshk+U1OjYHNCMYlq7FwUdyMNTXMvFNEsBkTE7scv3HHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KzTIKDnQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KzTIKDnQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsWY01ypYz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 05:22:11 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-653781de668so1818663a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501328; x=1769106128; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7IY8l2+i1WeuEXvkGd5lYKI5+uHV9G4YufUEOTseco=;
        b=KzTIKDnQhrCE6PiJa13e4wmypOFT2jLv3LcQUEzjfyh3f3tCvcFuf+3rdmHqEs1Wsy
         qZox4bcb6QrkUyGX9TWRGHjXZ0Oep9TKdBcpw3Gz0j1BhScg3JPYnQDwlX02MwrrXPGm
         datEMAHbcmkIECdvUZgjaEVLyDnoeecu/Ik09Nqk4sGOrLPT+Ubkvs6lurTKI79+0Ter
         cIVML1nQ9tslqa8UYAp5jhvOJ0LZ8Oj0bFdg+QtqwdpgLnLagU6GruxGOrmH3uy9VkXs
         cJJ+/zA4pulWNhnXr9tuoXcMCXAR2O+axGmF/yRoDfyAOozu8wvFMsMp8iqeyOZFacfO
         wm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501328; x=1769106128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7IY8l2+i1WeuEXvkGd5lYKI5+uHV9G4YufUEOTseco=;
        b=E+lhwUrcV5MZFGgyQ5mM+VB8nYwQm/SFGC1BhPYAlCA5uN0AfULQPUAl727HGsuVUJ
         iMqQ1kB6KvGg32944NZaN4gG3hkNKlj1UQzg+JpwcwxkTLRehM40MCoFidiJ7FXxeSa0
         327TZFgdutitcqPmVLMhFUL8lccPTL5JjfPe3Zqo0lYWBPNLPUwyWILGI+jTbk6rm+DV
         8hw6rWH9nM64BVcKUzHeMVXoJjQYlgtfAW17ffumyW4BtkRe7grmQzKHNe6QFWbt3DXx
         +e0STQhp2wwftuV1nBxpDZbZ1zGOHAyYhlS0MMev2lY9mTpESHZmjxppPiKLmsQDuTKw
         0/fg==
X-Forwarded-Encrypted: i=1; AJvYcCV9zYZRPetK8NPJwDIvqE+VX9zYtvEZXo6wyHlMt94jiht9OPa9qT6ynegZgu4Lyzxszfrt+yLVWRla5Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxV6ON8QHFIuyYMSBIDeKQp2A3BNk7yHJOHh+yVN8jF35TJOuNV
	clAwj+kgOGgfLoQsqtBht8fjqjXVSZ46ymyioQ50BmJRbK/uf8bO82Cq/7GJHcnt3AH5OeYlq4A
	IeY5GpXHfxzI+vYXjHwAvT1rKy+aBFh4=
X-Gm-Gg: AY/fxX7WQyaoh987vOpizvQv95B8/WWBAgDJIQkUSIgeDLZ3pWBBsK+sir3BE4+fBoF
	MRNLrmZNxnppKeullK21TB4eNQXTrps1ZXR9EiN2kx3SDaSWYIqOUI5vBwSZSldFzFjGtQZoW1E
	PuggXfy4+XKmnDMVosfdlrbjZ4YBQGO1NddkVZg0Qv7W6OhpWFbeMtnovruxiLKW+Y2cAV0VHy0
	TPv6t0dshAkwSDRHkCM8UY3+EJH4n7sPMJZRuU14YG5RiXV6LwOBQX5CKeK7CS0BbppmivUfvkX
	/DJcFpx6StpERTfprp43QJ/rom5XfQ==
X-Received: by 2002:a05:6402:2812:b0:64b:3f56:55c9 with SMTP id
 4fb4d7f45d1cf-65452cca336mr319308a12.26.1768501327990; Thu, 15 Jan 2026
 10:22:07 -0800 (PST)
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
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-16-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-16-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:21:56 +0100
X-Gm-Features: AZwV_Qjyapjv6JnFBHXmI5sSMthIqKsr1O8J34VK_oMMrDctP8UVkm6G-xvI8HQ
Message-ID: <CAOQ4uxhnxipJcjznEoa_D2R91NDZRgT_TTouGA4PGJO-7R9spw@mail.gmail.com>
Subject: Re: [PATCH 16/29] ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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

On Thu, Jan 15, 2026 at 6:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to i=
ndicate
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/overlayfs/export.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..17c92a228120e1803135cc2b4=
fe4180f5e343f88 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -865,9 +865,11 @@ const struct export_operations ovl_export_operations=
 =3D {
>         .fh_to_parent   =3D ovl_fh_to_parent,
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  /* encode_fh() encodes non-decodable file handles with nfs_export=3Doff =
*/
>  const struct export_operations ovl_export_fid_operations =3D {
>         .encode_fh      =3D ovl_encode_fh,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>

Actually, see comment above:
/* encode_fh() encodes non-decodable file handles with nfs_export=3Doff */

That's the variant of export_ops when overlayfs cannot be nfs exported
because its encoded file handles can change after copyup+reboot.

Thanks,
Amir.

