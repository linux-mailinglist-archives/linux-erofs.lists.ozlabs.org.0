Return-Path: <linux-erofs+bounces-1921-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355DD27D08
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 19:54:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsXGK6qc8z2yFm;
	Fri, 16 Jan 2026 05:54:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768503273;
	cv=none; b=D6icR8jUFt9AQ4DzgGplijGlPNOKj+oqB42JMngoIigIVloRviHLCEA0wkVcD87rVJg+NhYox1uBy32iITIgcVhZZJql76U28C7u3t/JUF8WVnMhvsa6HSRhKe09sWS0FWqF11ZoZS705ZOnwwJe4PjW/tIztBukiL439zkZj8L7BfOpfA6QX3JEoUjixPGHOuzNKZZTVd9RvBZo8nt14EBX1cu8qXUo3KvF2QiVINOPMmrXrwuX2jEh90lCiogHgSP/Ymy4HM87SV7pu/ftTsNPmXyVGrCalWHKymnlTfNWpBdzLpw+tuQkQQenj7kZ/r2wUImaT8zoU+hPB7GJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768503273; c=relaxed/relaxed;
	bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7Vcb6Mxhso2glBAydptFivNdXjEvRsKhW1wSWBss8ndCzP1OoK4ALJ9Fywf3PFEYwu9STsR0tNsd6UX+Ip4rS+lGFCswbwnHh4bDADHHv1gfCT8aGmj3tDRpyve8fzUq1qNJDJE1s5hLgw6q9D+EE0sZH3QEY1oR4MYbl6F0C1sPeRAXOrIO92nLsXjUZoIBO2U5a4L2D0pbSZdZkcjlnFSWHxmjQtvmkxEUc2I0/jXGay7ZWE3Sf1E+IVkSZqZAwKW0ChPbJtITrtStsI0HAQdHeRZ3n6/jegCa7gq3A7uEnKXGpWdHTVLpczBml32RoAq7W4YCEROteLj6rskVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MfRv1WUM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MfRv1WUM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsXGJ5NMgz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 05:54:31 +1100 (AEDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so770025f8f.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503269; x=1769108069; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
        b=MfRv1WUMr1fkKKnnjNlTkgJ4h+BlwTwXY6JbUzDg7uQeIGWWdsmxiU9Yf2IwxOvggf
         xSZjsx2tOmvpvQi1UTrs8MkLscAGy2ygthBe/BzD434ThQTxPtY8U7l/A12XyADBHDhh
         Pmyd1EZavbI0t8R5iOqRrKcBgtPQCYEwta0moJ9cVqCuZ7AWvw/lVoBqefhE2GRSrReE
         o0y/k1qcPBrMJolKuMr+9tsfl6DBBfoJozmjj9HKBVfQukTHPP9Vmq/H8E9mDGKwzNQH
         LL9L2EhzlJf1QZysHVb41dxmJBh/UvaqLMdwqYMU62VpwcSs9FlWl2+zSube7Kxz3jIp
         xihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503269; x=1769108069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
        b=o/FfFRXsfTpVDJc7Daxi5gy+h+tvfWRb3ty078Jwx24cqmh/M7++If4bHTVYyozBq8
         WMsBIaD2i2ABgpT26PGwBYs8DCnU9smjupVp5qFSkl/6bwEvnVvGbXxrmleJ/oRgfC0B
         dOKmqdaQcrBFPgy2k+BaHv6kHpU0lFLxy+PSWwj9q0ii8SaXVpoaUKq0oIj8VgYWhI7j
         iq8VHZSm1L5lOtqFbjQ01a42DirzrEaqXOz19jknFJyQkY6WgM+KmbLMwdsxW4K+ZYVr
         p/G4++HPv3SJnyAkZdzMp6l3zP9H6/Ms1FSkgj4oqGXxkBNOVzg2+HClRrhi1dpQ6yQ1
         drjw==
X-Forwarded-Encrypted: i=1; AJvYcCWh1ekjqnRiVsMoNyvKBIFCsWJzBYZdb3ZLnOfFbc/XOvwTG2gQ8VXIR7M0DoousYBzzDozAtbXD4qDLQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyp82UaHMIe+G42h6BtrIO3m822LYRzqE0WYGsBZwoFYNH/ZZO7
	6ZmfKpMcilXuHSERUa2XCPLDY5OBDp4Y4VyEuoI8I4bdcOx4Enkaw+SACmwD+FCLEo3ssv6TOwI
	fAjahrYcLmMlzvt1r6FoHqdTHNsZSTD8=
X-Gm-Gg: AY/fxX6hzgca8r+d00jroYLXE7WhWK2fWkYi6RoU5d7ZorBJ8wLBcqdsmwQjWiiJ/qg
	Gm1xTOVFNPlhY4pcalmxjRNVxoi1grDCsXXB2vONYf2J/bTnsayehWMvxrdwIDPpW3llE3qHd/r
	33qDYTqaHNlgnkNPI1RWcjF47QMpq3CwS5rV/NmParsvMpyfECV6Mu7Aj/SOTc7h8x3Aynh3k81
	MNu+QrkiMwCOq6l0cAXeoNJcGibBbqorAuzdUTQvLgFKHC9TXRmeuAXcJ6yh0nW+KlDD9Mv7jsu
	2h7OWxbBfdiOyhFLG5+7vBcIo2hrfQ==
X-Received: by 2002:a05:6000:2313:b0:432:5c43:76 with SMTP id
 ffacd0b85a97d-43569bc17ebmr434376f8f.39.1768503268480; Thu, 15 Jan 2026
 10:54:28 -0800 (PST)
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
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:54:17 +0100
X-Gm-Features: AZwV_QgNgqINU2MW0ct-_EKOImgQ1uAwJfq7nKBHPoIgHpyzlMCSNbXGV-6zTEg
Message-ID: <CAOQ4uxh4VaVL9PD7-_Op9Xs-z5Qrx8g6x2x5FccujQX-Cw9RqQ@mail.gmail.com>
Subject: Re: [PATCH 26/29] fuse: add EXPORT_OP_STABLE_HANDLES flag to export operations
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

On Thu, Jan 15, 2026 at 6:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..1652a98db639fd75e8201b681=
a29c68b4eab093c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1208,6 +1208,7 @@ static struct dentry *fuse_get_parent(struct dentry=
 *child)
>  /* only for fid encoding; no support for file handle */
>  static const struct export_operations fuse_export_fid_operations =3D {
>         .encode_fh      =3D fuse_encode_fh,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };

These are used when the server declares FUSE_NO_EXPORT_SUPPORT
so do not opt in for NFS export.

The sad thing w.r.t FUSE is that in most likelihood server does not provide
persistent handles also when it does not declare FUSE_NO_EXPORT_SUPPORT
but we are stuck with that.

Thanks,
Amir.

