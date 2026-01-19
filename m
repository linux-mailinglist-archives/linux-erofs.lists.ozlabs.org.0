Return-Path: <linux-erofs+bounces-2043-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F7D3B1A1
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:41:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvx733dwNz2xSZ;
	Tue, 20 Jan 2026 03:41:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840895;
	cv=pass; b=HJGkq/JSf8Y4Fup2Yt1jOY0oxjWVDJm5j5+g2s9peq0UQvCdenxPq9vP3CyCbe57umZrRV0G/oYKwf3Iz1KpNeK6m6tLJIULx8t+DdToIqU4hy1d1wJPuq7gKZ42GZv/Tw+IwvKlJ5D3FVXHUFNqlnfIvyNDToN22MzoUDQU5RGgJj3R2OXtblXiE3h3pW5IU17ieh4XQzwe6yMkCLwFBoRgo91cTTX2LQ6S5LsZer0eka6gPDGdl8zQO/SvIWxlNH0CYukRVi/gGuQrDoqimCUnRMdCxpSv+fCXRrupwRywfqT9b5yAhUOsKZq260BEqUjr9LmYr+lSIXfvJM2VVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840895; c=relaxed/relaxed;
	bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AT0Cwj7ziK0J9omIHYRbXgXJeALfU89tjQJJxcFfifC4Jc9HbpHyuquvw1lShO6Z2BokpyECqXmnb5/9OwgcmXwXYLBMWxPmkExwxq+WONyr6/qDbLzlH+/3H483Z8S7URICVlsnkaazmEjQ7vHMAtsl9BrpXmlZA9hRnut3Eleyr0GVPyB1uHFVFqE1Efax5bMl82DJqwx47C+iJo9BampJjDxffAtprYu1ahnCIm+5Vf+6U+z61K+c+Kdn04o+1sDcTfDbQ4zxJcSMzKAzS1TJWxIgxC4Gb3cWcroJA2iag/GT/NhDieV5EFuxKNWayLw5Us5wLb3Utbo0pkjz3A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aw8KAud+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aw8KAud+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvx7235C0z2xS5
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:41:34 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6536e4d25e1so6711404a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 08:41:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768840890; cv=none;
        d=google.com; s=arc-20240605;
        b=GgCysIf8cV1sxChKEp9sV2/OQMoA+sEMGYrOhVkriusMdzW2osUoB9j3wIa3FoJBK2
         oq0vNuAgwaFFzchZbp0YTV3KARe/86Wg4joyEo8SUSdQCbiNbkD6FewxVrZ4sFxCmSa6
         YXUOc4b17ZgA3dvyoHhsOdMUEWnzGaQaOZKuFjzAnVyGR5jtMsg4+eWLPtOMcPUln4sA
         CorQ1ER089ChtbIx5Q1I0Ta69GAbMz86mkoOBgMttPwJs3x/Sk4m48B1OBrqnWdevIXN
         NxPW+ucRDCcyL+ctkZOtDnxi2Xoz2dnKqEI1zcFnQ5WyG+YnIVndp5tRTZjfmGqpRAge
         3O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        fh=9Io9rpE++0E/IRcZD7bFc+j2oTK41RRxrbFNg+756Zc=;
        b=goJeM+v08bI3ZZ1cxNmQnbHfm/xDp+8jNnZHn7NAjYXiS6HqiPLFM7CC6hrfzih06c
         pnLaYzV2GaU5vWQGyrbHJt0YV+yfpY7zG9UzieSufzNeNGm4g3mxLG6kSJbKgwuLE+ut
         gBmRh7ImLpXnrQKgQLKCUb8az5VqJGZeReRS5fgAsts4lVNgD9bmSMkq0GDII6zUnWxq
         NzXue5KTGk+BFhrl5pch9b6c1VfWd7IZjRwCAOp8E4zX/F+PM3ZjolPJdd9P53RrJvU5
         j2laB7GedJ1SVYeip1xHk868K3gAQ2YINHRST5q8OaCExwvdukT3apDIgY5dvg/dy1da
         qmbQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840890; x=1769445690; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        b=aw8KAud+BnNDa3H3e8n02RTm2MD+q9m2OZ48sYwrqesQU3xMGWyjKTCN+E1MRKIr7s
         8avy6x7PMVRl3eHw+/BjK/lPjjOBSSg4aRq9brG2NrUzCWP5yhd51UBCDjljc97N58gj
         lYWXKl9keSnJaWiX569Qn7148AItDMgxAJO2fKYhK00WyHbpN/iZnWXO7TdOIc+GLOsq
         XMF9ekQdu1qJN3E2pSYcS2zHWucRkvVcgFySJyL8DvCNsqXyo/T61+Ckap9TqGq/V6XR
         GmIMQMZHIewG281by9ishWfHA5W0jaNvVCgaaAf+ZVjTs6RGgpztqJrqDcPAAtra1PPr
         3HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840890; x=1769445690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        b=r9KaK46JtcVllMBgfJkeFh+dBC1jlD0FPopLS6U5rnjWi2dzIVbfb+jOe9f0/LMK0t
         5R+8bxWi3MNKNshZpO0mRu7aLF2xUyQ5Yl+gyRPA6TmfkPtdoXYTnmFa/sFbQwMsOH84
         fMHbCyEhvNLLqtVPsxFS7VjEy/6RpLZRPu3UT9uSOMYwn7pEOREWmzMslqMunjM0x5A4
         SwFPTEotugZ87l7WNjwtJUbYpKfNgqXQen90FG7Y5sE7MDI66SgxAFXBNOkn+gEzuluD
         hWhA9/5rrKSX4G4rO7b+r3YqtpSGR3MuMUYzbySU0EwwJBOLvrggMT9CirE4wzHx97Ra
         DAsg==
X-Forwarded-Encrypted: i=1; AJvYcCUlYjr8EANlXR0Bd348RREAbsQtc8NOCn0RAMMpMioTz0d/J+A5R5tqFEbbFFJ0B5OO+Fhzdsp8rWGeiA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZpfO2lK+v21sCHR4XR36/fyXy4WQfFtqT+fjXv8B0fYd732rc
	7Bb3jMksfirX4CRFKgnotPtnW8YYm5mAiFfHfkG6Z3mvv3p2qRlBEJJ4b83yp8L1CURxvWNG9VQ
	eQykaHawLP8vYrR721nb5zP9tt0NgKMY=
X-Gm-Gg: AZuq6aIIAUHLeoFIZhosUiujeuXaJBnZYqqPhc+bM9UTNhN3wTUtTPDmyvhmPbYbmq6
	a9tINPGCwsxC7kK+2TXDHcj3u8HdObj/wP4/2ShAtxHZ01R7iVoxl8SDS+0NRzH7wurPoVt2vdI
	MJQLgzEbnrzhce9Wxr0/NbzHCITlwy6XhT8MCenU2iwTQ+V0UY93mxlFEa2rpxIsANtxKAJyUcI
	FDgA3JxwyRAHEdGHJnDxDXsg4mrwEIby6sJHLKlVWwhlWaU34ykNZ7kAninuzrk5MA9jhiBEJ0E
	ydgTKYMOhjI37ZGJVRiKaY6L85vwbw==
X-Received: by 2002:a05:6402:518b:b0:64e:f6e1:e517 with SMTP id
 4fb4d7f45d1cf-65452cd98e9mr9387079a12.32.1768840889299; Mon, 19 Jan 2026
 08:41:29 -0800 (PST)
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
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:41:16 +0100
X-Gm-Features: AZwV_QgHvJ6NvIXON-eIYvnT5PkMvN0FHfW-0LujoZ3K-fhpCrZ1N6375iX4_4Y
Message-ID: <CAOQ4uxjX8EcG5XssJ91u8Kn0gY9Rb0qCwnte_7j6Q6knvZ1shw@mail.gmail.com>
Subject: Re: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> At one time, nfsd could take the presence of struct export_operations to
> be an indicator that a filesystem was exportable via NFS. Since then, a
> lot of filesystems have grown export operations in order to provide
> filehandle support. Some of those (e.g. kernfs, pidfs, and nsfs) are not
> suitable for export via NFS since they lack filehandles that are
> stable across reboot.
>
> Add a new EXPORT_OP_STABLE_HANDLES flag that indicates that the
> filesystem supports perisistent filehandles,

persistent still here?
"...are stable across the lifetime of a file"?

> a requirement for nfs
> export. While in there, switch to the BIT() macro for defining these
> flags.

Maybe you want to move that cleanup to patch 1 along with the
export.rst sync? not a must.

>
> For now, the flag is not checked anywhere. That will come later after
> we've added it to the existing filesystems that need to remain
> exportable.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  7 +++++++
>  include/linux/exportfs.h                    | 16 +++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/=
filesystems/nfs/exporting.rst
> index 0583a0516b1e3a3e6a10af95ff88506cf02f7df4..0c29ee44e3484cef84d2d3d47=
819acf172d275a3 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -244,3 +244,10 @@ following flags are defined:
>      nfsd. A case in point is reexport of NFS itself, which can't be done
>      safely without coordinating the grace period handling. Other cluster=
ed
>      and networked filesystems can be problematic here as well.
> +
> +  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that a=
re
> +    stable across the lifetime of a file. This is a hard requirement for=
 export
> +    via nfsd. Any filesystem that is eligible to be exported via nfsd mu=
st
> +    indicate this guarantee by setting this flag. Most disk-based filesy=
stems
> +    can do this naturally. Pseudofilesystems that are for local reportin=
g and
> +    control (e.g. kernfs, pidfs, nsfs) usually can't support this.
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index f0cf2714ec52dd942b8f1c455a25702bd7e412b3..c4e0f083290e7e341342cf0b4=
5b58fddda3af65e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -3,6 +3,7 @@
>  #define LINUX_EXPORTFS_H 1
>
>  #include <linux/types.h>
> +#include <linux/bits.h>
>  #include <linux/path.h>
>
>  struct dentry;
> @@ -277,15 +278,16 @@ struct export_operations {
>                              int nr_iomaps, struct iattr *iattr);
>         int (*permission)(struct handle_to_path_ctx *ctx, unsigned int of=
lags);
>         struct file * (*open)(const struct path *path, unsigned int oflag=
s);
> -#define        EXPORT_OP_NOWCC                 (0x1) /* don't collect v3=
 wcc data */
> -#define        EXPORT_OP_NOSUBTREECHK          (0x2) /* no subtree check=
ing */
> -#define        EXPORT_OP_CLOSE_BEFORE_UNLINK   (0x4) /* close files befo=
re unlink */
> -#define EXPORT_OP_REMOTE_FS            (0x8) /* Filesystem is remote */
> -#define EXPORT_OP_NOATOMIC_ATTR                (0x10) /* Filesystem cann=
ot supply
> +#define EXPORT_OP_NOWCC                        BIT(0) /* don't collect v=
3 wcc data */
> +#define EXPORT_OP_NOSUBTREECHK         BIT(1) /* no subtree checking */
> +#define EXPORT_OP_CLOSE_BEFORE_UNLINK  BIT(2) /* close files before unli=
nk */
> +#define EXPORT_OP_REMOTE_FS            BIT(3) /* Filesystem is remote */
> +#define EXPORT_OP_NOATOMIC_ATTR                BIT(4) /* Filesystem cann=
ot supply
>                                                   atomic attribute update=
s
>                                                 */
> -#define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on=
 close */
> -#define EXPORT_OP_NOLOCKS              (0x40) /* no file locking support=
 */
> +#define EXPORT_OP_FLUSH_ON_CLOSE       BIT(5) /* fs flushes file data on=
 close */
> +#define EXPORT_OP_NOLOCKS              BIT(6) /* no file locking support=
 */
> +#define EXPORT_OP_STABLE_HANDLES       BIT(7) /* fhs are stable across r=
eboot */
>         unsigned long   flags;
>  };
>
>
> --
> 2.52.0
>

