Return-Path: <linux-erofs+bounces-1774-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66ED07336
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 06:27:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnVdq1krBz2xJ6;
	Fri, 09 Jan 2026 16:27:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767936447;
	cv=none; b=A01Ktf3cUHVDuXaO5Mod7kZ3lNZMu6Mqx0KSgPBhEu6pvYfPxiLSJyqMgEv+1IQnIPBGfElPWWiSS7r8A2MuDaPXll7GkknbVHh0z6sE6qQFTGgSv31UAynRmZzDRaizdOa1Nr1bPsQi5aRtGljkdrec659J8NkZ15PTyEab1K6H7MdLoKU9v1buHnc12VG6e2ZK15HATRZS91AxSQiUbf/op8ucPyZS8VUmp9Ddcpog2Iy2bvU22Kpdm8q0kCWCPOvQ6ZX72dVQ1n/BOJCpVCjsTI5i7NtdC1az9QM5+2ABAHkls2blhUu8Qekiw1uWqw/R8tc3jBC/MGev5iBbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767936447; c=relaxed/relaxed;
	bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI2g53qNHEPC7yMxupgW7Ef7VIgWucm+B5GSwSNmnhcW7cYHP65PW/dCvoi/V0W4YjU43sAeWMdm13HwievkL08n2SU0yZ2kyKoWzuughctjp9ovUmPGhwThWFk73+szlrmYbMjb6fbNBQR8lnjRYzo5cUHUWsXic3lHx01+S9PKMUIQONhdZRW8nqXBxdtyGFOfKAbSOBbmmhCYTydziZlx7S/03oCHdABRvbjN4EUzfsLTHjpLnsbLNLXsHQpxn2y/EjT4XLB7PlztaAftZCDzVrTKMxDb27JJ9zrCAKCnR+ddHgvk1KmH74giEReHYYwTcOmxwKWo7uUJRyNoiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KDPgmGGE; dkim-atps=neutral; spf=pass (client-ip=209.85.208.175; helo=mail-lj1-f175.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KDPgmGGE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.175; helo=mail-lj1-f175.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnVdn0rl3z2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 16:27:24 +1100 (AEDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-382fea4a160so23998001fa.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 21:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767936380; x=1768541180; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
        b=KDPgmGGE0e2CilbFUUkwG4CITlhjXY3md/+mU4sQ7DPkcXmVeSKuwYflFgIT4X+A62
         bBCatxxdCZ4umdtXRftV/N82k/0+UJFZhxbrCS3eMbssNfj/GjDlLHujOby4t/S/kKBZ
         3L+MaFS2EwcbnSVBnBob01WCkzPpo7pJX9Pz7oin2STB9qVFqWu7YaQRJn60xyGJc8rM
         TmUERxjveSS9XA2YmzKU2qmi0/Lv6JkSyPA3Lx1eXW8Cri1r8OSnIlSHsiG5PuOUNj/k
         y2Dnubi7/fwcioFh0FsXdUs7rqrVrJcEHUAcoQ8kZeJeRUtFsv7Hb5TEOYvs0GgxYy+H
         FENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767936380; x=1768541180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
        b=D1a74+If8wU4v45xloZss/RIuzXZ0mIdMux/6rpRcaxmxTKeW00K7c/4QYseAjTqQy
         /lVcjm/cRHH60EbLb06Uwcz7MM8FH6j8i8HNDai5Y6qU/xCu4rCJUmMt4MJoWYqV0bAE
         qi1jR+FqMHFP+IiMWnmJfnb0fgdktUKggvrYfeq2C3fltM8Y/OD373BgHzmt7GygO2t8
         KPVbkoTmKBuNVEjZZWK0lalg0jTpW7TJq9Hs3JGjPbjpBsbfkB2aOlCzJxVoYOrh0Hmv
         8GyIVJ6j+4UiNyIagdPkPUSz6+lU4zVh4Eg7Q2/fYTbAtGa0HP26Hep7ElBnQo/ynyjv
         1uIw==
X-Forwarded-Encrypted: i=1; AJvYcCV1PhQI4Lh0S+A/prGc8qXU1Wy1dZ0tvDQ4YQKIYRnRMhUh9S0M/MvyzovCUZson7s+UhgEj+hpKygXSg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhAbSDiJv7jhUwuoAOId66rELdsJ5YTalSIEkzfpmSyMQtcoSy
	mESA/rqVLC+Ee97xl+/qrdmSG5vJQyvWyOBGlBn9H3zwzJxhRIL2yKlPuXoI7Os/Z6KvzPACxZw
	groZBxY9BDaS53SotdYRENRGyJJgc/K8=
X-Gm-Gg: AY/fxX51nYG+MnvG+/5umr5vgxLmJZ2MmhsnmSEnrBgi49E6RgPstW0SS86HR0y63Ys
	eVuCppGwEXMrPuzqbaapBjqxcWA6AnACYsk/S1i2PGeb9t6Y3LDl4GMkIWZ7qaNVHwxaC0cH7ae
	9VSt2O6cCO34uenhcI6bfWwNcob+tz8YnAtINf0kOm+Bm/eqC859bpJ4IhgsyE8Dnso/mfiHLnP
	XMjhmiBiAgewrzS/5mfolitgVVguE4clWbNL+46qsvAVRcok2X/3pRMlcSC6O0AeeHIFugo
X-Google-Smtp-Source: AGHT+IFacKbx/HloTRDyL3KNE+dISSFeSIeO5gnLVmi9ry+Gc3uB4ma+c7Q9oZoxnNZINjg1j054MzA1urN4ujLkRdE=
X-Received: by 2002:a05:651c:419b:b0:378:e3f9:2d26 with SMTP id
 38308e7fff4ca-382ff823bdamr21702801fa.39.1767936379607; Thu, 08 Jan 2026
 21:26:19 -0800 (PST)
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
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 9 Jan 2026 14:26:03 +0900
X-Gm-Features: AQt7F2pmUKGJKWpVwxhIrI-U32G4ALuqYGKPCGsBpfUc51GGTfk1sxJMQ_5a6zs
Message-ID: <CAKFNMok9FG=hhzr8YrHYws5z3jTWOf2TXtFWvSfYbNy6+XLHxw@mail.gmail.com>
Subject: Re: [PATCH 13/24] nilfs2: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 9, 2026 at 2:15=E2=80=AFAM Jeff Layton wrote:
>
> Add the setlease file_operation to nilfs_file_operations and
> nilfs_dir_operations, pointing to generic_setlease.  A future patch
> will change the default behavior to reject lease attempts with -EINVAL
> when there is no setlease file operation defined. Add generic_setlease
> to retain the ability to set leases on this filesystem.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good, Thanks!

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Ryusuke Konishi

> ---
>  fs/nilfs2/dir.c  | 3 ++-
>  fs/nilfs2/file.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index 6ca3d74be1e16d5bc577e2520f1e841287a2511f..b243199036dfa1ab2299efaaa=
5bdf5da2d159ff2 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -30,6 +30,7 @@
>   */
>
>  #include <linux/pagemap.h>
> +#include <linux/filelock.h>
>  #include "nilfs.h"
>  #include "page.h"
>
> @@ -661,5 +662,5 @@ const struct file_operations nilfs_dir_operations =3D=
 {
>         .compat_ioctl   =3D nilfs_compat_ioctl,
>  #endif /* CONFIG_COMPAT */
>         .fsync          =3D nilfs_sync_file,
> -
> +       .setlease       =3D generic_setlease,
>  };
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 1b8d754db44d44d25dcd13f008d266ec83c74d3f..f93b68c4877c5ed369e90b723=
517e117142335de 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/fs.h>
> +#include <linux/filelock.h>
>  #include <linux/mm.h>
>  #include <linux/writeback.h>
>  #include "nilfs.h"
> @@ -150,6 +151,7 @@ const struct file_operations nilfs_file_operations =
=3D {
>         .fsync          =3D nilfs_sync_file,
>         .splice_read    =3D filemap_splice_read,
>         .splice_write   =3D iter_file_splice_write,
> +       .setlease       =3D generic_setlease,
>  };
>
>  const struct inode_operations nilfs_file_inode_operations =3D {
>
> --
> 2.52.0
>

