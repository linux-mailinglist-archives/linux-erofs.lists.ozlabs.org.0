Return-Path: <linux-erofs+bounces-3741-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mP8bJKjCOmpnGAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3741-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 19:30:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B066B90F2
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 19:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dQHLX6J6;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3741-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3741-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glBsc55wjz2yQG;
	Wed, 24 Jun 2026 03:30:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782235812;
	cv=pass; b=lpqQrNXG2W6AlLP1kL0SYT9HCzvkYMl9oB19t+4L5ntrVv0YEhVdpAqjP/NhtppM6c98d3GCpcsMRC9+N7UQyiy2ySnkLw3xCGS6CgLVXD20q3oh3L5jB+T2SQf+70Uf+kTx467gfqUtFDyFNeycGu5zVe8Xft7NZBVhMwNPZt0e4X4nh3C28VUpNtofF82HFxts27MIscWVVjZfNSszM50R7bmRkNusJfuSIBndXxK0zwMQCwIYext3rndAlSNq5E8IpoDi4R+9Wq4ErMoFuh/5iOASMkaosbVz9czTT3wkYxTBUa3p7mdwN32xYAVz0SJin9XuvzRYiYUOAEesUg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782235812; c=relaxed/relaxed;
	bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcAwq2RUJaaC2Rip1UyZG6nyBSSDhXxou+5Vb8njO1/tNx0VB2ZwvzJ3pH/w6IAyLQobF8OlU/ISsuBaA+i2vRV183geY/FEJbJhBEw1BX6KsFm1tY9EDDq/FZKMFT7aeLGhyLnNGNOEGcEIlQ8fpeVeu7X++Ugu5Ss6s0Kf4jXJ9lpkMehJ64DvFuMFT3zbEC8su6qxzGXuGblkHZQHkQXcp0h41traHjCnq97fCMLHYA3gf6jrdG5lTFzpfV20Fpai5uDf+uh+HVPd7vLQAuSJO6YUQHIGTBhxL3KVnSkXsHEetkR29gpaEfjdB++Xcgx4UDHYejK93DkVtAGfmA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dQHLX6J6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=joannelkoong@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glBsb1jLMz2xnQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 03:30:10 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-462bb734793so107632f8f.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 10:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235807; cv=none;
        d=google.com; s=arc-20240605;
        b=Bayy7PJDrpH2gxYkcJACIGjq/Zpcwu4CuLD1q1cAnRktTs7+3abBkfa3HdKk1hSnrm
         deNsIpqfu8u1HBAl9VelZoxYehysTOvWPShSeaJZfwXV5H5a0no6THS8G+9G12vH9swh
         g6jLAenkzLX+0IfwbuzATRkYXsr097LlrAFNtoIDUdxXVMpfSaQLcHmyqrwxN863bDo1
         umj1WpLPEnW6lqNejVwsA09H6Vx+t1mIC+uZVsq8u7NCWdV5fKqwhSVt9xTSTZPQMfq9
         YEGloR/P2UxLSAJhwOb8rZvbFP+MRfiAiG3AN4ugJBiv9PnnMjQFqWpIgsKpr5Thnep5
         14Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
        fh=XvvJ/oqTgoygMBZIhsLQv4RurDdtFt8/zWx35R/ns74=;
        b=WdXlHUwaenfbk2zXcDwODJcJ+ZaQeuE7DpVfgRiRBdv2ytta4IFrBpVBFQ9vNramMi
         uuRtxXdI0pMKB06u2PXACH9U18QItKcEkZ4iZb4MCwSPT1TZiOgOLtQhMRP5Hcafo8gU
         p8MPH+PdQiTKoQvYT1MM5mdkN0X50KrBiVjMQm9rPXpBYupfPxd2C0AHbeAo47yS+a9U
         zHhKAGQQVqfIYM/ahwZbgKa88K0JtghLrIiemH+XkLo17UbCylv9Va0+3PM1afuiRv+P
         9ak+j5afKGA2WwsRUKvu2XMFVwx/WU13uFmGXcqRWDjS7Z/Jn/oY3L7Ek+Y6QNAwu8li
         5k8Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235807; x=1782840607; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
        b=dQHLX6J6NWKlxfteGykQxWoU4TnacR4kaHudkLEzo5KiyJMTqrc+Eqe2ap4YkjfxG/
         572JRPkUOb6lGD7QNVdll3gOWSXtE+CNdcbvfnrXHH4ZdSwczI+lvO4CnzWwXWdJN3vA
         8ABt1k4GauFr4arvcOmbv7b6Ry3IehCPWmhqDrUOmESGSVlPcdm9kfsJJiORhKW3raQw
         PvuEcgKP0TVpKxac3RIae561ZOojceTcTHabp/NLK23Lr662tmana22gk8tsbZ8wPbVR
         9V8QKW66z4YQe4XCl44OiQCYwcmoRCy6m2uR3QoSaZ872v4gtPvpcWfCaOeomWiboe6o
         1itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235807; x=1782840607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
        b=LIa7h5KnZ50F5qnZoFzTfsxa91S3FTW8BVjbiyLYmc1YGwMoHOQ0UhE1MUKxAo7e9T
         iRZZnTDXoL2cqhgKRBY3dy7QFR9acu6XIhLmmWmuAk5xNFzZXg5Q3xGvFavPGG1mCXGz
         P0irD9qNFJ4rSRrFx2tPcwn7BhI4gkiRnxSdxw7j3RiwiC9xQg/ae7KyEMERcywT9++v
         ZEbFYjLTH+yrvxvgZeJ/wiANXbmfiwZNwza5iJQZY0c9ymoL8xvwt83XSQKIf2yKWr0P
         KfOXUWpPZTVGDGEko+vs0ejnvYe9+kCkv+Jrs/L19Yg8dKe0GQpgxtNXugdNsS0gfb2T
         1HnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdLfQ2iYijRII78M295QKQ8Z9d+BeMo2n8vH2DyeN7FmJioF7SzMxIoF5TdvVVfeGyUScbEvdAmwgaBw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSlTtWK530tvbUPET3eW4gN71uuXghAtKaTmxR4JJobpICWqQ0
	PCc4xKJ25lLTkz4jWjg23PpQCYpxwlWHR5w1QfU4W3loLm50UWClqfRmPv68DzE3UjI8Wx01qTZ
	m3Dm4Ky24DKRiBJN4lb2CiFCqk8rSjVU=
X-Gm-Gg: AfdE7ckUctFH3vKe8v2pUQSF+ZvArkp9CsM8WOihsK1MTffKjy47ishyiH7uuTZ1w4v
	dtaqBTwRpg5udTvaKJsaGoanuV44zw6BwS1RRcrEC6rfRPYctWRaEkQLH/siq7faKJI2ZQmwqyR
	aVrA6vNQDX0zTtrC4INhF1F75Bp07/gj3HBHtd1Dd8A6B07sO7PwohMDIyVyC1ZRDBbKS5+MaNU
	FcI/daRcXFOtqv1uU74Wnvxc5wJqPlTtrQ2/AcGTGOBPg8vjr4umbwOK5xA/jhVZg2jNqjr3Feh
	6soUvmb2yZCisH18JfMK3JaPwXVhwdjo/2H7RiRTWK1mRmVFdS7D
X-Received: by 2002:a05:6000:22c6:b0:460:3233:beed with SMTP id
 ffacd0b85a97d-4666348bb1dmr24453136f8f.41.1782235807180; Tue, 23 Jun 2026
 10:30:07 -0700 (PDT)
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
References: <20260623135208.1812933-1-hch@lst.de> <20260623135208.1812933-3-hch@lst.de>
In-Reply-To: <20260623135208.1812933-3-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Jun 2026 10:29:54 -0700
X-Gm-Features: AVVi8Ccm_eFaYYj-vQlgAXEMOrnUjeoeLhiRjoMn01eUhrTiB_xWHROB6LeYb7s
Message-ID: <CAJnrk1agx-qUizNzCnzvZ6Marf7u-K4EtKOak4c2MQN1sJfgNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3741-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lst.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63B066B90F2

On Tue, Jun 23, 2026 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.
>
> So instead of adding more checks move over to a model where a bio only
> spans a single iomap.  Change ->submit_read to be called after each
> iteration, and pass a force argument to indicate that the bio must
> be submitted set on the last iteration.  Switch the bio based users
> to always submit, while keeping the single submit for fuse.
>
> Fixes: dfeab2e95a75 ("erofs: add multiple device support")
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exfat/iomap.c       |  4 ++--
>  fs/fuse/file.c         |  6 +++++-
>  fs/iomap/bio.c         | 11 +++++++----
>  fs/iomap/buffered-io.c | 23 +++++++++++++++--------
>  fs/ntfs/aops.c         |  4 ++--
>  fs/ntfs3/inode.c       |  4 ++--
>  fs/xfs/xfs_aops.c      |  5 +++--
>  include/linux/iomap.h  |  5 +++--
>  8 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 0f31e35567b4..f71aaaf60301 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -79,7 +79,8 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend=
 *ioend)
>  }
>
>  void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
> -               struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io)
> +               struct iomap_read_folio_ctx *ctx, bool force,

nit: might simplify things to drop the unused force arg

> +               bio_end_io_t end_io)
>  {
>         struct bio *bio =3D ctx->read_ctx;
>
> @@ -87,13 +88,15 @@ void iomap_bio_submit_read_endio(const struct iomap_i=
ter *iter,
>         if (iter->iomap.flags & IOMAP_F_INTEGRITY)
>                 fs_bio_integrity_alloc(bio);
>         submit_bio(bio);
> +
> +       ctx->read_ctx =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
>
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d4806dc46d4..06a216d37548 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
>
> @@ -642,12 +649,12 @@ void iomap_read_folio(const struct iomap_ops *ops,
>                 fsverity_readahead(ctx->vi, folio->index,
>                                    folio_nr_pages(folio));
>
> -       while ((ret =3D iomap_iter(&iter, ops)) > 0)
> +       while ((ret =3D iomap_iter(&iter, ops)) > 0) {
> +               iomap_submit_read(&iter, ctx, false);
>                 iter.status =3D iomap_read_folio_iter(&iter, ctx,
>                                 &bytes_submitted);

should the submit_read happen after the iomap_read_folio_iter() /
iomap_readahead_iter() instaed of before? From what I see, it looks
like iomap_submit_read() would hold the iter state of the next
mapping. It seems like in iomap_bio_submit_read_endio(), the
iter->iomap.flags would be the next extent's flags instead of the one
that needs to be submitted?

Thanks,
Joanne

