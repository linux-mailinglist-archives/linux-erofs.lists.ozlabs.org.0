Return-Path: <linux-erofs+bounces-2861-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA80GBcqvGn4twIAu9opvQ
	(envelope-from <linux-erofs+bounces-2861-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 17:53:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 799792CF2D4
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 17:53:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcBbl6Swtz2ynn;
	Fri, 20 Mar 2026 03:53:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::433" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773939219;
	cv=pass; b=Y8xIMX3xVAeeiHCvetkrMsM7ep/YgNxjnUdyqAotYj6wHPhJrdAs/jQx5jZLNDtTCZQbrTepq+H+ntu02wA4JVxQJ/APkTRuquiSpBTxJJNuVmwdT/w4RSEsVA+r/qaq4P6P6riuY4sGtEIGl3bGNUKEtHRG/R/IG9hYTlUdCg7vvdOq28fRFFOmhcw9/ReDZ/L0GFGcbQRZe9nElKjX2+9WOMzNv68i/uFU247UDBkBgccbbyLUidB0D6iqEonKmGwx1vwtZw8G/ucVT1Fmj092LCkfQ5dXf+KOkVJ6shOITTNNsPu9WhQzC8MwGj3oBcmp81hKMc/As58uBZmsXA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773939219; c=relaxed/relaxed;
	bh=5F1Cl0Dke/IKR+/LkGtxgPMOGU7Snd1nn1rocMdpWlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L84nN4Xg2thuAmYqM7qH3ADb+k5O5KUHLE0g8M0nQ1+/giNInlcTrhtMn7mINRLF/0Ib/whN9nB4pv38lss4x9x2qiJkOpBH7poSaWU6hQj/2J5EkkMRfiHyIa3RSmgMsk47gnLw/WUaLMOLcmCl8IW3Bq3HIz4Z9XguVZQLlr3QY+Yadl5+A/LNnp3kGYzZqfGgzOEtcDryuI+1bZVKY9U7hfY4Ol0YCF4vv8PPJj+2jg/8mabRycFJSUV9S0JB8KPxAktjTDltPe0cLvfO0HjJupSLdbFlZDmRmIKNGiJlZHOzfU5ZtOoZRhFtpK0z5L6kpEFkfzk7v/JbM10mzA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cT4jSI2e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cT4jSI2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcBbk3mKLz2yng
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 03:53:37 +1100 (AEDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso907967f8f.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 09:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773939214; cv=none;
        d=google.com; s=arc-20240605;
        b=JDQUsu0DoouWmda3AQVbM7R6sBN0SUKlncW5dPM3SG2iuXfCBCvx1PI6JI27xZFVsh
         0DnwHrKqLzR1ExQRpYHiShVvZ4OGbuFu6sglHMvmFgGfUKJ+Z0VSBbdmv996AOlhdusO
         bsRvCWal3gU2zpYxiNlLSksL1hSBiAME8bQojyErQTh4bJkqzrUTP41kbwo6D/I1H9lO
         KzJmtAnu9/2wqZZAFzhH3ozJnkGqKIrF3ascPG18IEQPDCTmLgD/IMWvvfz2KXMpXHYz
         32AVKvjfUrNSUp5MSFoHcRACynCCICj8RyTw0RUT2MG7CUGFPL9DrRieslDfSNdzSja9
         ZzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5F1Cl0Dke/IKR+/LkGtxgPMOGU7Snd1nn1rocMdpWlo=;
        fh=h6uq7XjWFSBY/jwInOiPeoemBJWA2pJ/g0xZ2uxEeMY=;
        b=TsjRwgTlXcNsKqNnFs9BGmeiXq8/bmzJJnorkCnZb1IX/Q96tpPwA+JQ2Ug3kOGumF
         SkV0CAWXkDeuJ327EevWihMCvGy2powJS09pnwk2QndRMep1Uz+7r9SYLQKOYZ4T1px/
         hPhjtgNrWCc7sehEgfHsra/qwvgMd0DH+gofb7GAWYMk1FTEnudB/ehy05zJ3sZI9MwF
         wgIDVIT99MT3l7OmvFB4ZNMbAAjgt4Uh3GvmVdTTsX4ZdgoWJg3sgHdSnYoNxnYX/7SC
         Q05uwPKeQTvAGUO7XoJJrVVIoGTt8ob+t+DulBOyGTpibS6EGMe1hptJz/J9nS0QtfHr
         YBig==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773939214; x=1774544014; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F1Cl0Dke/IKR+/LkGtxgPMOGU7Snd1nn1rocMdpWlo=;
        b=cT4jSI2e8otsK9Y3G1McYfK44WXEA8oaHImrV2qzZyoynSe/bMjg6XXvXjAL6AGly8
         oMyOrY0soTnQeW2yptq+c1UZpa2sEJSUeY0x1ka9dmkzAiEdTXukKYoa+6+H9dzhAGld
         gn+HE+4qNnIJWlS2RNfpOSIKRBX8etZk2Q2WMq8E9KevHaCC5sC1YgyJ4cp8HPprXTuk
         1Oq2Bis3GfpTRztDu64yJ9Zw9Zkz0SpEDAPY9uanvEL6/qkiDcJ91jXkLvppsuxAIZDN
         d6c5hZvJpCAZXYuLG7wwFVB2iVuHAViPXsns8LfL0TmtWCbIVou2eQt67N4I8V1Uj1Qo
         6SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939214; x=1774544014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5F1Cl0Dke/IKR+/LkGtxgPMOGU7Snd1nn1rocMdpWlo=;
        b=JC4Pe/oUTd5QMkBJs8aTGe6N3sfPdC6LJCIvO3Crs64elfnlCJYhkah15xsylkaSDc
         8gm0ce+VPx8MymVQcEBbQ2R8dBMpHWVX0s4x/mhy2JjVcxOHzSpKRuL1EabOZV0GiKfE
         DXeYITbkqKsxSnPuerrIqu+IUgR4l+NWRjC4Flco7znizHecqh2X6rksYdf62u8iQOsQ
         xOgPyHodA2+C6oYQuLlAcyia4GMPb3po8kx3IyWob63Ji64MOyAuwZa6BGgXXaNn/Ds8
         QYxqrg2MlJ3i9AttUgpIPSP+GM8V/b1XQHInySuRrpT5WKO2HDrhvJsQDdV3u7sNb8x4
         WNMg==
X-Gm-Message-State: AOJu0YxNNeQ/CGTFbIYozPkmcA0O/Lqc7AM8naAU+ZfbdQbfg/TGd70m
	tkGFMLrwVLZV9x2Xw/pKQkaiQtHgUt+tm3ALHUlIGtkM0SsUQRGNFtY2FrvH53Dl3h0OAfv8amq
	XHIzET+hPRYlnaOAmirhkUCZP3SGMXGQ=
X-Gm-Gg: ATEYQzwmd4M30MvZYuWIQ/cP0m7a5x+n9upW5KyBMOP6uaR5+6SxxQ86PulSoZ6JN4g
	rLRFegSWhCI6zMWC3Vdb7RfX2eMkosaGSjGYEn2WIctqOs5mmx/z8J5RKi9aNevHeUm9ksNVajT
	r2CIrM5Rkf31o/fJUHve0pprxgRmmyeqDFNvF+WsW+5n0aVacwaFm/1QMho7VQATydGbcRKJBne
	iZZB/NgE6J/4MGGwoWyGEzka73AMa2ZHTjXlc0l88qSGQE+skuRdTi+qw27HIMgLnMP4QkMlHxw
	TScDNwVe4Eu9nrm4yrjv8kuik0NxhlxYI8b0Rm9r3g==
X-Received: by 2002:a05:6000:1861:b0:43b:4396:6738 with SMTP id
 ffacd0b85a97d-43b6427b2c2mr34217f8f.50.1773939214178; Thu, 19 Mar 2026
 09:53:34 -0700 (PDT)
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
References: <20260319133948.396-1-newajay.11r@gmail.com> <20260319133948.396-2-newajay.11r@gmail.com>
 <dc88120d-eb36-46e7-a642-78e626c97ccf@linux.alibaba.com>
In-Reply-To: <dc88120d-eb36-46e7-a642-78e626c97ccf@linux.alibaba.com>
From: Ajay <newajay.11r@gmail.com>
Date: Thu, 19 Mar 2026 22:23:22 +0530
X-Gm-Features: AaiRm52Jz4ee8Fu-mvtDRBb11UMvFgkicnG_a2y7fZDl7SPUevfxrZB6h1Yzs4M
Message-ID: <CAMhhD9gzXxKt1joVcCPy1OTe-=RHLS+w5u+Tk9usCQfEe6OVdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] erofs-utils: lib: fix meta_blkaddr handling for
 48-bit layout
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2861-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 799792CF2D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, I looked into the history of this FIXME (which was introduced in
your commit 6eae70b1 "erofs-utils: mkfs: enable directory data in the
metadata zone"). The reason sbi->meta_blkaddr must not be eagerly set
to 0 in lib/metabox.c for 48-bit layouts is due to how the relative
NID offset math works in memory before erofs_metazone_flush() resolves
the absolute block address. In erofs_fixup_meta_blkaddr(), meta_offset
is set to -bsz to avoid NID 0. To compensate, sbi->meta_blkaddr must
remain EROFS_META_NEW_ADDR (which equates to -1 block). Later, in
erofs_metazone_flush(), when the absolute metazone start block is
allocated, it does: sbi->meta_blkaddr +=3D meta_blkaddr;
Since sbi->meta_blkaddr is -1 block, -1 + meta_blkaddr equals
meta_blkaddr - 1. This correctly offsets the -bsz byte offset so that
NID math (addr =3D meta_blkaddr * bsz + (nid << 5)) calculates the
correct actual block address without wasting space!
If we were to eagerly set sbi->meta_blkaddr =3D 0 in metabox.c, the
flush would set it to exactly meta_blkaddr, breaking the -bsz tracking
and causing the DBG_BUGON(sbi->meta_blkaddr !=3D -1) assertion in
erofs_fixup_meta_blkaddr() to trip.
Since EROFS 48-bit layouts don't use the legacy meta_blkaddr field
anyway, leaving the in-memory variable as EROFS_META_NEW_ADDR is
mathematically required for the mkfs flush logic, while the on-disk
superblock value is correctly hardcoded to 0 in lib/super.c.
Because of this, the FIXME comment in metabox.c is actually outdated,
which is why the patch just removes the comment itself.

Let me know if this makes sense to you.
Thanks, Ajay Rajera.

On Thu, 19 Mar 2026 at 19:15, Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:
>
>
>
> On 2026/3/19 21:39, Ajay Rajera wrote:
> > Fix the FIXME in metabox.c by properly handling meta_blkaddr for 48-bit=
 layouts. In erofs_writesb(), set meta_blkaddr to 0 on-disk when 48-bit lay=
out is enabled since meta_blkaddr is encoded differently in that mode. Remo=
ve the now-resolved FIXME comment in metabox.c as the issue is addressed in=
 super.c.
> >
> > Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> > ---
> >   lib/metabox.c | 1 -
> >   lib/super.c   | 2 +-
> >   2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/lib/metabox.c b/lib/metabox.c
> > index d6abd51..077f88b 100644
> > --- a/lib/metabox.c
> > +++ b/lib/metabox.c
> > @@ -62,7 +62,6 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
> >               if (ret)
> >                       goto err_free;
> >               sbi->m2gr =3D m2gr;
> > -             /* FIXME: sbi->meta_blkaddr should be 0 for 48-bit layout=
s */
>
> I don't think it's a valid patch, I need to find more clue why
> it was a FIXME.
>
> >               sbi->meta_blkaddr =3D EROFS_META_NEW_ADDR;
> >       }
> >
> > diff --git a/lib/super.c b/lib/super.c
> > index 088c9a0..99d2a24 100644
> > --- a/lib/super.c
> > +++ b/lib/super.c
> > @@ -209,7 +209,7 @@ int erofs_writesb(struct erofs_sb_info *sbi)
> >               .epoch     =3D cpu_to_le64(sbi->epoch),
> >               .build_time =3D cpu_to_le64(sbi->build_time),
> >               .fixed_nsec =3D cpu_to_le32(sbi->fixed_nsec),
> > -             .meta_blkaddr  =3D cpu_to_le32(sbi->meta_blkaddr),
> > +             .meta_blkaddr  =3D cpu_to_le32(erofs_sb_has_48bit(sbi) ? =
0 : sbi->meta_blkaddr),
> >               .xattr_blkaddr =3D cpu_to_le32(sbi->xattr_blkaddr),
> >               .xattr_prefix_count =3D sbi->xattr_prefix_count,
> >               .xattr_prefix_start =3D cpu_to_le32(sbi->xattr_prefix_sta=
rt),
>

