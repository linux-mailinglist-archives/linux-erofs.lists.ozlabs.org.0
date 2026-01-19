Return-Path: <linux-erofs+bounces-2044-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FFD3B1BD
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:43:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvx8w3Khyz2xjb;
	Tue, 20 Jan 2026 03:43:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840992;
	cv=none; b=VJdyU4OC9jArI9Gli3n7pU9QJ1ydhXlLn56WX8FfqMA+vyRi7oARcfmBuizZayjbUUeGE1f8+PsXAGW+561BC1TjD98kDjtOyF0f6QajpVRa6JmMEVvKR7Ixu7m+vVmdFbxsRrGNx4VhvmD/Z1XybYsrZmtDJ9use+JQ+IDfZupbRMCrWupVdAKObCZ4VLYFlQTFnAEXugHaVt9ZTWO98l/Kwrl+/43GdRJwYo+VL7FCovkq/zKBV5FmzT84Q8kPfx5tP2JeTqpM167lROHfbRN0v4iYJpjrt2Ac/o21v3W9fU4V4pMPWnR9tlGKsXwpmiDuPABTjImtXNTYtrGVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840992; c=relaxed/relaxed;
	bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCiq0x4C1tB8lcfY96UuDgyBSD2Yp7HhnSzr2+0vrOokvjxo6yTMS3RT7KNsrThCeYQ5w0a5BniRxbJbxF8AqnNcaUsjl3cAi2Eqgt97Demp9fV+jMkoV+Z9ggZnAFxRJGXSbd49bggB605oAXFk7fJFSzzfNI1H9WL04gWq8HI0L8P/S9c3g4zSaZ3kfnL72c3urZJ1QqRMOqEOnSSlBuuCHmAgRmTpXZQt0yN1sBRSDAXm3BaO9zWgysfyg1HvoXx7cGWZ4Ur/lXEjfLiy8t+HTC4hoMgCvI9T9U2OZJY2oL29hY61xKL4VvbT3s+eTnqwJJBbyLXd/bdRfkLnaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xq15BkGt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xq15BkGt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvx8v3WF4z2xS5
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:43:10 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso6787837a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840987; x=1769445787; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=Xq15BkGtdJSdsZnrlnNGgA8b/ZeuBShIF4CSDHqZoXChRgGwKgG+w0/U7vCgUkHfx4
         Yyi+8rCU503sMwS0OVUtazWyUZ0UF6EVqCBGQ8opVF2d1KXNVqfZIvv/2/8G98GNzZjd
         QcoNrbZvoeZ7odxLRja52r3ZwJ3m4TpXRwPlmSHCyLJmw9lh2J7Vp7d1ibcDEyC2uBhG
         Exq8vrsJR6DLWl+jg3Ec7nY47oea8Pw5SCwa6UCr8CVbQSAPsQ4Ptyghi/4KksbMffE4
         Lcsd9TtRZ7fDz9F9JSgH67pUpCbxLHEH+8STxz35z0BCAaYeYlGLuaq4v2sNeG/0UCd7
         Q+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840987; x=1769445787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=kA39fz5+YX08f4unIBK/iCZaZadGK2CvD71rPI1x14TrZascJorIHgTVSYGkpVaz8+
         AbTj3iNyZoduyejlAsJmyHhbktw+5Kem5q2uncRSBG3ldqZ01m8tMvhAESI1ZpHF3GM6
         pLO0jQvnAEj+mO0qmVAphC1OOHVOLLcSOoc07Ra7lMj5N5TNhP52z5ebWmFIhTx2wrXd
         VrMB3atManR1DSkmlRY37gIUp3bX0QpeJgfVGLRLA6eNa93KqYe7wes6j0CvxaKdlBZ3
         yLGPFlbt+BW7Zy5wjabSHBWrmtAiIknQ0LKHxJ3TGsC6WvkvRnngHXuo8pwMCI5L8Hcr
         4yNg==
X-Forwarded-Encrypted: i=1; AJvYcCXydq5qeN8+pfrf6ZtKu2PVINxvm93JFAHzy7i6eZClWSWnVdCY0aSMWFfXyZ1Ucl15TfkPUpG0bABvFQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynIAFpMEqb2SFOM7HzfuKL2mk8OdGIF+fGgB6+wPf8JhlfMNwh
	4QGMzo8EMM0/oFuJI6GaoR4Z8P0/tY/pYJhGu1NECVBf7Issc9kW9vP8CwZg2YQvu2s2lwyjHBs
	yVlZ+aGqa7xwgfK+Fh4z9Ao6vICMuXkE=
X-Gm-Gg: AZuq6aIAqLxbGCG3fkchGcWwmP0nL89E2klOZCZpVjNBptKyRY9Tr5srdbqg6lgrgNM
	q2GzlHt0/ClP5ih4kAzanaAMCE5zZrhaREX+7MFCqY5XrKSOM8w1AnKhTivbckGJY6DuaySSKHV
	kr/ynXy4E+7n6Ifu2M81jn/6NHN14qSwNpvQC/37U6EgiCG/ERsYx64NzYpvqeCsiGKvTNlvviO
	WysgC8zFIZ5SVVQYyZYv/t9xc+3oRAntm5wKr0DijIysqpdvt9KB3ib4KGXhlEa3fkL/QGD2rOx
	4Tmm6wblJ9gPrWWkQPlaB3pbWtnshA==
X-Received: by 2002:a05:6402:4304:b0:649:b200:afe9 with SMTP id
 4fb4d7f45d1cf-65452cca909mr8384256a12.27.1768840987066; Mon, 19 Jan 2026
 08:43:07 -0800 (PST)
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
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:42:54 +0100
X-Gm-Features: AZwV_QiQ9eetgKyRnXUMiKJDXK2vIOYhTLzpDlKP7IN3cG_hSRVA59Z6sNZRsnw
Message-ID: <CAOQ4uxgXovX-rPuAE55D8x4jbNOQdAKJH3O5gpHJDMsT7kNGgw@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 5:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to
> indicate that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..18c6aee9dd23bb450dadbe8ee=
f9360ea268241ff 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -865,6 +865,7 @@ const struct export_operations ovl_export_operations =
=3D {
>         .fh_to_parent   =3D ovl_fh_to_parent,
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  /* encode_fh() encodes non-decodable file handles with nfs_export=3Doff =
*/
>
> --
> 2.52.0
>

