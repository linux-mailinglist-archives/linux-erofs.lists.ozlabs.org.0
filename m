Return-Path: <linux-erofs+bounces-2045-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFFED3B1C4
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:43:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvx9M4VPHz2xjb;
	Tue, 20 Jan 2026 03:43:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768841015;
	cv=none; b=cFQ78K4uR4OVaHDdGhaZ1dym9/YQjTb9UgNxg7kNVeQK4rPfuGe/oOEHPTsYzhW4Y1qXDBax8xmDpwwPDgXzk2JIStoJe0T7Bsc3VuD4vaeE045kOcFnxV/uh3zgK/BxCun36h5FCYOV0Z0LGHDZOuHNYVgooQYlBABrn6wLoEipnmxV8/fpIIGfgv41ckzU1tOR+G+1Gajkme78ATn41O3pcntoeegvWVvGTq74PZQar9lPIO97XL8IuFjrGEUU8KvqHLzpypOsRcMTe3WQxuLqotLRY93kLX/IBkdq2Fe3Oz7SvZI2Vqt9WUjJODsokTJBl0XDGV79tCLFy/zQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768841015; c=relaxed/relaxed;
	bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PY3/nscgX4YCGaWFTqF6Iv4YsHCma8FfBILEcwQoZrVhpd6fBd+7jHcapaejeSOdwPrekvSSg5wKN4qgxB3DOcVdvqhFydSMffzJuo+U09qH5xfr7uJBsQraSI7N/5Eug0CT7QiesZYHUBn/PF71UIOmIujEUGC7ep7qlq41vlqIhtF4PmFbbBpGTw1jfD1U2NuDHO8Xwr0s9Ywxu65AJ8eV5Cax/TuO2gOh/J8vo1EOOtf6pbdaYMOmV8unuk9MKG09qsNUolfufDPYSabzUOj/QwNwDWq8tbHQuTN+Z6RZagaeYuph3iTYHThTt8xL+qW+YJmdnJG52zAKYj9Giw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P9fMPhQM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P9fMPhQM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvx9L5HzDz2xS5
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:43:34 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso9321438a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768841011; x=1769445811; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=P9fMPhQMJ3fprjjjwT+dVH37WHuisEZuCLF434LYFill2wTQB5SA6vOA12CGTh7Q9c
         BMginkkSTgDJo+9FxKfl6RV9Ub2jCdORnCvs7Z/Xp+O4aSERNaqUssw3vrPNj/hfVMzx
         R6OHaJmxRDKCE1KJ7JetF8vjisyjOTpgxfVb3qpyj970ehDZG1OXQnCsEM1z+bXOf86D
         EgJ13gzfXE7jvQB04kMUCFD+vnrSw0nDe3IOoCyLYdU+gHo7gF8CyvtrxedBF72stt8o
         iQVIltNJhlbRk8dytK63SfRJIxHmbRO6mvU4vKA+uV/HnYwArTdqbyTPFJ1Utdo3a1LV
         ABYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841011; x=1769445811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=RDrY2zL1xG0wGuPuKl+QaEI7bFn/8GANDeCRID44lgsap9tp+bW0FbIlu3jUm6qKfR
         gK00nSH624b/eBzC6RxnXifMKMkFcGXF08NRBjAZvmldsaPbYDC4xAO+GI2am3vkRLM1
         jRQrnHXJjKiqjbC2RCtl6VSx93iKnx2NabCPqrYKJi4KQ3D3dT4TiFWhFqGpkFJt3qBF
         klgunhlGVhLRWWwTJwAcFmCs+yxP9WPeO7crClgvGR4HWSDTIv7+uJUefn9a+3cHRy8a
         YtvZHeqDbVAqVVul+6xoBxvQ5qzJPkDS8Qk4o3mEMbxKHxLy7QmgQUEZqx4NtSDT/vhw
         uLZg==
X-Forwarded-Encrypted: i=1; AJvYcCUDDKN0ASkyLoNTQu00diXpGaVkvalw1TG+1/9gT5NReXVmvE8CfPV7XwyZ5nI6EXUIv7bVm40tL28dfw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy+IeKE9bfN857FCijy3pysH7XtkBvM389hxqZREPH/TEJr2El5
	CwC2h7+id7tGxKqzuQVG2LkyXP2QD8QQC6ZGZBK5qSqwTE1YtPM4/2z1NTFjRLGXaKJEUJGqJWP
	tri+wwJDVecTH1dQqniTP2u838IbQ+XM=
X-Gm-Gg: AZuq6aJCNzICuAs1ywPGPn2hwu3pbNzHMizBBdn3hn5uiDjIo6uEcOboIXqXpWbqOC7
	aIHS/ew1CPIOPSqqMLtunxVtLbQsBxL8RYRDXgnvNX2VbN+dMpfcp21sNNVgoNjcC1KFFesiHiw
	aGjCHYqe/XC90XYMVhtVEM9rSD8Uvu/Do7vSP5MP3KmA9O5trudQeq171KcxGFNS6TwWCw0Q7Wu
	gcIXUO5iuw2lRvDG3pGcLC6qc+lE+C19qKmjxnv7qBPskKNWhAcyaA7/5JfHUI95skN5G+2+kD8
	Ymn8o6O8kRM9bYrw4dYaealFas8Q51CWZ9erHoS+
X-Received: by 2002:a05:6402:5106:b0:64c:584c:556c with SMTP id
 4fb4d7f45d1cf-654bb6192admr8530585a12.30.1768841011353; Mon, 19 Jan 2026
 08:43:31 -0800 (PST)
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
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:43:19 +0100
X-Gm-Features: AZwV_QgQ6YFmczFqASwqjyOa509PoCTPsOB-sET1G173IBHOd4X5kFjH9N6z5MI
Message-ID: <CAOQ4uxjyTdf21G1Y=_5Eox58drVPA0gAMeSQZxh=T36_yzssNw@mail.gmail.com>
Subject: Re: [PATCH v2 27/31] fuse: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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

On Mon, Jan 19, 2026 at 5:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..df92414e903b200fedb9dc777=
b913dae1e2d0741 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1215,6 +1215,7 @@ static const struct export_operations fuse_export_o=
perations =3D {
>         .fh_to_parent   =3D fuse_fh_to_parent,
>         .encode_fh      =3D fuse_encode_fh,
>         .get_parent     =3D fuse_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  static const struct super_operations fuse_super_operations =3D {
>
> --
> 2.52.0
>

