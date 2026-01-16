Return-Path: <linux-erofs+bounces-1959-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 54683D32D50
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 15:47:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt2kP2XVmz2xm3;
	Sat, 17 Jan 2026 01:47:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768574829;
	cv=pass; b=kGUlS9JhR6L0Ox3qjnQqrUMSaRIkYcTvsnEBSadrUwMgA3kOHdkVn+Ch/BG6FZ7Ame4ismgjITZVju0YgmP5RvPaW4n+jD8R6PSeWlwjQYxC17nyUu7tFn1eeW+lzAMs45ETfHWlr9/nQqjLpUvpIxeu1qvtouPR0+OlP79mlG3D+mqoQcUvKsQ5JCgxamTytlHllZstte7K8tfwPSuqUA8DABH6burfzETjN2c06EUlrpPRgd69sboM0/udpCaeCRjCCILz6sDfAHNZLYVItAnV8aVxEzvDyeO/BXR7V57WAs0dEYGEwkRGpAksahkEQ2YKP4+BbZ6rBV2cMfFTkg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768574829; c=relaxed/relaxed;
	bh=rWCEzzwQTN3Jcqg8Pr6svjg3sqJRK7qADI0E/O11arI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQr5+Ff7a8tQcKRERqnQ60PYoUtjGsqczcFJH09kbPsUJbUtoJ9hNDb11TyxyvhgdISwdiQm4YHDJqcgTpgR8P3aqPiydIw2lwxI6/tmO9PC31tvciod+/NtlMDpQz/wOtrNafXBs3QhRYxzQuqMSTMsMTG/dVw8y5ff+2YeepCHvxegYFg/138gH7rEhn+h7H6mXpMaOUHsHyagPtGe+2X8Y6PkbqB2mcQQTi4Ww1Gy0k/Aiu+zuKLfuB2yER13+ICjfWo0SGEaldYtnkLd3kaf46h6yLIeksNgnU4xnYZviRwbrQMcn//QDnU/OWt603Q3AaJcQppDLRcwIiUH1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LRlXIrjk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LRlXIrjk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt2kM3S0kz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 01:47:06 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b870cbd1e52so306870866b.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 06:47:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768574823; cv=none;
        d=google.com; s=arc-20240605;
        b=FQuOCTWFSVwcMm5nMM1hnqmT7q8rKvrpNIj2LrvAWeKDzuCEk6O1YDUBPf1eNdqmN+
         If9t90FMQOUfjRYCQDoJhDildQ8oD1qE4R2IxwluydQqui3oCA4WjQmNOUJXLEEEFt2a
         5VLkUUN69Go4AZGvyPR8belg1sVdm00XJNVCkKbg3TLhjNYmmKRMt3vUC7FaVv3GpeoF
         wYAnF87CzzkEXi6lfY1tJv6acuB5P5VuNt1FtIe3cZi+WoE1MQSXjQafTwNW29D4LDK4
         j75Gq7WILaNn1y6JRYwVPL8mwKpZg1k1wiu86leVllKMcC65WeOjy0NKb7KmUwLMyW1R
         ApOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWCEzzwQTN3Jcqg8Pr6svjg3sqJRK7qADI0E/O11arI=;
        fh=dnuoMiXck1OKHZ+R6RRvpiwYBe/H/eZ9KwRIVFzKAfk=;
        b=kN7i8zeKYca8mPr4scbs0rL5qI8m7tx1IigAcKRzARLACeQe91D2t1q0yXsHA5vpZU
         afLRvNqAamhnMTHl6zdICTnxtd03HjihIO9TE+3PdXy/Cyu/rcD18OMtCgJqYp/+bz5X
         6mvU5ShtspkU+tWmPr/DoR8E5dfCZ9jcnAi5vdMoFPOKxlIIMIa2YKNNYpSc4qciEJmW
         naCtxEpSEWPgJyMizHHE/so0DV045NfX9F/S2LVE7ajjSNLlZpAQplz5uwohIw1XzOF0
         SRV5ZzEYMj0874fEo9sFBalUGDsJyWvmLYYT/vKhb94ZFuKfmsgIkJcQ3yJNz+GMok1g
         az8Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768574823; x=1769179623; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWCEzzwQTN3Jcqg8Pr6svjg3sqJRK7qADI0E/O11arI=;
        b=LRlXIrjkLSHMd+uOtWy/+mKk+o89vDhjMyBxLTk58eKdAWNT6dpaPopru84QMclURj
         CTZsAkxDg18Ap3Kz5jppq2rv7/C0KR3XrriigzwyWC+45AhBZXWp3aO7B/viAMaU4fAA
         EmyQnyECecPEHV4DfIKmh6gk6jIKL8oox7wZfshlIF9xn1gkYvvDWp6MzrJcrqhUHw5S
         pbby/MTkflspQ2WnTy3daLMX9oORIbxrmubSAv0d1cutv5RNg9XXqXWtnW1G/4UGML9b
         auZ8etLVtC8CMHYftIOFFE2UKbnrZL376e56TLsnAYj14Jv9f0Ap/FKsA79FVtc46N+c
         biKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768574823; x=1769179623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWCEzzwQTN3Jcqg8Pr6svjg3sqJRK7qADI0E/O11arI=;
        b=Ei1C8bI5gx5y7F2T+vVN1VfWBUDNobHUpBiu1YfCE2vXwDpMK0KRLiE7Ac7phdfHiC
         4vkzLRPHADq+5YzzSvd9jaxhZQz4nngFVOYs9g0o1rROr2Bg+t3gweZBwP3PencZEgq6
         ay9uf7MrRtbmi9DMUZEZ4ADRyirUZFptQwzouVpE82RGMQmKrxpaSf7RIaxg2VlYXFCp
         T3+iC8WDR2QjGe3C6FO/u79cBVq30DYuGXyLtzN2aUFpyMvIO3b700Mps/8SP1BQSa5j
         hGvtx+eS8H+Wm/VvHyT6y/buNTUm4l431V9DMUs+1/rZdmb5MDXm+2/al+CXH+/AzDO7
         HlOw==
X-Forwarded-Encrypted: i=1; AJvYcCWgwWvoSqAjkHW26XlLv4cH/Y/eJTmT/C30EiKruLFPkWUxferQoc373L+UCAAmkC9VSHi2SSZUC1NFmw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwW8vHB8WXnBFmBd5k88Q6YNkAFe7BJwK65Z5IkIpmnWF0QzosQ
	iHeWfURGThyDyusl6ne8Xw7XNHL0g1J7AeIt184R7FabCtY3ZH2dBrOL/ygcQzGpOrWEDEt2BGT
	ECtgPF3wNUtTvp9hZruaaVD5E5FiHCFQ=
X-Gm-Gg: AY/fxX6n8wOkpTkVXIERxHxEsUE/YolkdQQgVkFZLmQff2HwpH9pCj8XtIYrp8x+XIk
	Er7oRWfcKDAsGqfgPIOVUUzcDsjLh3sOImgEhMrrYpZD0Ce/paOs8pzEfYfPTpYurKgh42RwYWm
	C7WGBfxrbSD+6p6POPg5nTzPG7AddbN5tf9CaMh3bDg/Nb6JvWoP83jVtxClOMx4jxoRLCTVWWa
	x89PvS0nPinWwIkMnELI0xJDG/06VzEoI25mghMP++eLtqMiIxgjIpI01kLdI1TvjjbaF815GoB
	+vhG/YeCiVO+LPWlfpXdct8M1FS7Uw==
X-Received: by 2002:a17:906:7305:b0:b72:a899:169f with SMTP id
 a640c23a62f3a-b8792d6cf8amr335795366b.4.1768574823087; Fri, 16 Jan 2026
 06:47:03 -0800 (PST)
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
 <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org> <CAOQ4uxg304=s1Uoeayy3rm1e154Nf7ScOgseJHThw4uQjKwk0A@mail.gmail.com>
 <8e4c3df4828351c677186bf018061f2b1fd1b48e.camel@kernel.org>
In-Reply-To: <8e4c3df4828351c677186bf018061f2b1fd1b48e.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 15:46:50 +0100
X-Gm-Features: AZwV_QiRcITYtWxbtRpeIxfeQr9ho0AGFQM_8wESdHA53c49E-5t7eaX1T9rC3o
Message-ID: <CAOQ4uxhkZNueydP0tTCAj6tuzKWPTYB7=JR_hb4gaavSKQ8C2w@mail.gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 16, 2026 at 1:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2026-01-15 at 20:23 +0100, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 6:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > Some filesystems have grown export operations in order to provide
> > > filehandles for local usage. Some of these filesystems are unsuitable
> > > for use with nfsd, since their filehandles are not persistent across
> > > reboots.
> > >
> > > In __fh_verify, check whether EXPORT_OP_STABLE_HANDLES is set
> > > and return nfserr_stale if it isn't.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfsfh.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..da9d5fb2e6613c2707195=
da2e8678b3fcb3d444d 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -334,6 +334,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > >         dentry =3D fhp->fh_dentry;
> > >         exp =3D fhp->fh_export;
> > >
> > > +       error =3D nfserr_stale;
> > > +       if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_STABLE_HAN=
DLES))
> > > +               goto out;
> > > +
> > >         trace_nfsd_fh_verify(rqstp, fhp, type, access);
> > >
> >
> > IDGI. Don't you want  to deny the export of those fs in check_export()?
> > By the same logic that check_export() checks for can_decode_fh()
> > not for can_encode_fh().
> >
>
> It certainly won't hurt to add a check for this to check_export(), and
> I've gone ahead and done so. To be clear, doing that won't prevent the
> filesystem from being exported, but you will get a warning like this
> when you try:
>
>     exportfs: /sys/fs/cgroup does not support NFS export
>
> That export will still show up in mountd though, so this is just a
> warning. Trying to mount it though will fail.
>

Oh, I did not know. What an odd user experience.
Anyway, better than no warning at all.

Thanks,
Amir.

