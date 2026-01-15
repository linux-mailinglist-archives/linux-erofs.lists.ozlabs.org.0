Return-Path: <linux-erofs+bounces-1924-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD007D2809C
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 20:23:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsXvw3JWgz2yFm;
	Fri, 16 Jan 2026 06:23:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768505020;
	cv=none; b=f/ho2z3SP812GnoaUTQ3HixgohjQWuFBOHSpNjEJyoUD+1aASKjbfQmfv9Z3CkdJ21D3g1dQxeG/2XneW9a+EC4fo3zBaPcRKSKXjqhsAgh5XxL5GBI8hSs6flHdi4pvpEuQIvFrOzUjrspWAiOrSI4SVre7QWSaAFZdQBplX9oyxvTPUhwMnbiyPioFXAe7c1XoijbWoaP0W237VQtiudSMHweOh7OsgwURGyfmDIhIcq3RD6wQuUDwCU1pYp7/9qxBJYE9FvI1/8tbLSFluVPRBUt7SE4UiYDr+cVuCT5RyETLlOjp1MwzATzW6vceZfvrkNAqYrX2LThwukArOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768505020; c=relaxed/relaxed;
	bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muME0Gkn45SmYbKRWLI+p3A8EtX2S8sB7uaCjxwx+11rccNEpNQFO5AE/KTuJveuXlGIczJed4sMaz7JOmcL2pETEvNXVvesyMlltlZ88EHXAiTbeHi+zEeilVzXIj32RovgRraDNoMEDBZ2bvkSKDR3z7l34zYJTBAE1+Db+sfPFxLDmDuqaMqUOYjFrdCU4ybLM3ZXZ+FDokyRIc1BOOPLH0CRKhppLlSk1OOPS+v6mtM7Zxs9bHov81rbYBPgwsQ9SSKjzrL11hVOCJcwZB6ZA/s0mAF0WiO9oOUI52oPINYePCXEIneVYYuSg6FhhehQTKeyNba0JteNx2brXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iUyP+PSK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iUyP+PSK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsXvt2kThz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 06:23:37 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-b8707005183so212245366b.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505009; x=1769109809; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
        b=iUyP+PSKjhClRXYr+GcqNEeeEMpQMgXOvjzt5LjZ3R8Hj5tcTA7zX3lBEhIKmb2Lv+
         JUU9ZdrnRJ6baLkMncRXl3/vBvRX5mqmXIOrgYdV5M3I1sNxx5wDF8II3/bCXngSJR6h
         dNMwQkveKT8/EhR0xJuC4fodGM4zDR8cF0g54U7/Hn/4MKvOMmT5gypJArIxzG7fJ7YM
         jHBEiOmrKo8yQ55uzQHlZlJUTzTznvFLG94f+VGjT2NCxbHbnCkJcjbzvSzpHKAQIa09
         tCG5zm1MyuzoKM63CBs3AG9FHmyc4n3YXmSiqLO9Zn8hPgXHDQ/eKDVYW7wjH2ktVWIu
         eZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505009; x=1769109809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
        b=PnLJ6ICMjDW41/sTSyVe/4lluD0he8plTKREpFA7uidDGxlZ9CTEEaMKWH4wy/EOMo
         FiDa+Ng+Kdzm9sai8lUB/8xVLOGGb/38gvgOx8mYBrGH0usJ/drNNbOpwRgF+hDhnfmz
         o4uRPnn7GecxaefS7N4IDPyXQ6QEvmn1bL5nGe/x24FKqYGvVatrDghQVMXqEDDjnnqe
         I5iaD1BdHW01qAlycIRD/GRofY6noG1dGZp6oli6pVZX2iHQPNHtECMfv05tW7tMR+uG
         eJd9sthx0nQ+UxbaXpkpm31AqBCM8Sd+g8flm+/YzpAAsATW76DUUym2u0L2gSgdEX1b
         TdbA==
X-Forwarded-Encrypted: i=1; AJvYcCXNxZvhYlrderk/UxGPy06JAoyUGWDS3dG2s8S92VL1HwqLwjxz/AEdoWm+XdrsjrGIKCbxxayNBP7P4A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8hf/LNQihbSU30RPzEODJ1JbfJKfEe+00/P3VaXrGRFYRc8Tp
	e5+Wvv5ALxhotEhJd0yNf3iUHS55yyaZrIkotQyrX0QyAYl+Ok/PiM1UnI8taC74ovfOhVEL6xa
	LZZm9rviYo8rZgWBw3wajAX1SK3kkTdE=
X-Gm-Gg: AY/fxX4vMQ3O8OKQolMFbYBkRsxZ5DOwrn9DMewhJz8Pw0yz/CKjant1fiHe1OTMeXr
	pr7MKpIOJTfDudK6MRtwv335grKqeioeDT1Fzneuo15EPfTj+IjrAQg7zRxI0wV8Xar2AFkW8CS
	gmei3Aof5zPUimMyZJsFnKb7XhCjLsr2sKUOVk35M7R/rO//GhKi1MXu5doUmts0v4MPkxiCYPC
	xNsYDaYOoUA5VBYXSZhO7NCH87uvMrxBwBy2HVpg3FyAZMid1583zh1bOu8lur7PNirICdlPKn4
	0E3Y85oZFbE+EhQB9/EmhjxwZ2wbtg==
X-Received: by 2002:a17:907:3e97:b0:b73:7c3e:e17c with SMTP id
 a640c23a62f3a-b879327e30bmr63085666b.44.1768505008810; Thu, 15 Jan 2026
 11:23:28 -0800 (PST)
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
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:23:17 +0100
X-Gm-Features: AZwV_Qj21qC7f0_83CWGwxMbCuhLisWPoHuSIOsZGqfnrVByhBJVGvUqJqXdQ-8
Message-ID: <CAOQ4uxg304=s1Uoeayy3rm1e154Nf7ScOgseJHThw4uQjKwk0A@mail.gmail.com>
Subject: Re: [PATCH 29/29] nfsd: only allow filesystems that set EXPORT_OP_STABLE_HANDLES
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

On Thu, Jan 15, 2026 at 6:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Some filesystems have grown export operations in order to provide
> filehandles for local usage. Some of these filesystems are unsuitable
> for use with nfsd, since their filehandles are not persistent across
> reboots.
>
> In __fh_verify, check whether EXPORT_OP_STABLE_HANDLES is set
> and return nfserr_stale if it isn't.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsfh.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..da9d5fb2e6613c2707195da2e=
8678b3fcb3d444d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -334,6 +334,10 @@ __fh_verify(struct svc_rqst *rqstp,
>         dentry =3D fhp->fh_dentry;
>         exp =3D fhp->fh_export;
>
> +       error =3D nfserr_stale;
> +       if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES=
))
> +               goto out;
> +
>         trace_nfsd_fh_verify(rqstp, fhp, type, access);
>

IDGI. Don't you want  to deny the export of those fs in check_export()?
By the same logic that check_export() checks for can_decode_fh()
not for can_encode_fh().

Thanks,
Amir.

