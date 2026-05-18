Return-Path: <linux-erofs+bounces-3419-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMDBGb6/Cmrb7AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3419-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 09:29:02 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282956785A
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 09:29:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJqDW3rD1z3c4V;
	Mon, 18 May 2026 17:28:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779089339;
	cv=pass; b=hGeZV6+xmaMhB3987bpIy2YTS0OEFfqJS9CR43R7V6VK0I0CeA+tYj+fLOnjk//Mp8H5l1baOO6GKakOy6vAgwn/KErWRvG7PVzOVzzW+UXcb3fz1KKZ+Z8A9Fw3SGZ81oVpuROIV2+EAfn50N9nwXExHV2iVQlNo7VQpPIzXrmteeyHqlv2+Mb4ml4E29DpGWC25mDyTXiDI8LnP97iCiY+QTvIIAeWlGjWd4FyM2YavnUlzblOJE4PywXb9H4mfRkFXaMtUI5pOChP0HIOsfOZjamvIsUIs/G58kc5HR9GCwqhm2mJmIcPD7nUa73ih8Hv5EDvHF8+zfHiBr5kMg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779089339; c=relaxed/relaxed;
	bh=wyYUA5OKTXxwotr87wMoor3EvZNaBbns1Q46YfLG3I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNkGO4wq6iyApwp8VAFp8EGeuEs9/De2ZE4BOqu08QlnxwV7xt8gpQlx87WkKO051l56YBt5s6R79pD6osxe71Ja5v/IIk3OBd6Fit3Qhu9n3dZb/cNaQIV1W/59yRRfPXFRrYY6tV+31lFv7DeFYjv+DR8An6Y622pn33CXvi3eIH3L8GTqfaEg3+5PwpUVGUCpyp0Z2uxXcLUL/+IBzun6aegpd/p/uppHYoG0WHVy9PbRMqRyBFqLmpzOicpR7xYEbdSxOqCJJfg8c2uPvyqGuv01xpdYMFT7OeoikP9ieUgLmkHskJEinGDD9OXPy5tEJmmAXTmfINj4m9gLNg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Nfh1b0bf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Nfh1b0bf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJqDT6w3tz2yDs
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 17:28:57 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-48962cd0864so2946885e9.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 00:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779089334; cv=none;
        d=google.com; s=arc-20240605;
        b=gPMhNpqL9eyLoSoHvgNMV9/r4GBgkrfVMq2YeeKIn0Wx7Llk91LUoaNTdq9lYNB7B0
         cGZBHm/Qa66FeVw3o5HYxKErlfmI9IQTocBxV8sDJfPJpfMmCRJCBSENdioLYIuDcRW5
         My2kHRyvPBhyulBI00RRWrzuv2gMLYwNNpkc4LaD1bLmb2FKSBPDnPD3JTVPMfasKeqH
         VfxuWsIwnQrjqkYC82rt9ePoI2UtRrgdl79uFECbh9RhzE0RDq+d8lJfiMOeP3yoKDMR
         mkYIbGd1qZfwSL7pKQBf8evU65kyQmKnWgCT/wz1PSw5OKVRJh/QzLqdL52U8A1/itj5
         SbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wyYUA5OKTXxwotr87wMoor3EvZNaBbns1Q46YfLG3I8=;
        fh=XEtco3AirI83Sz1wT0+R6OJnMj77cu/nl2oLOfziyYM=;
        b=KbF5q7JulExMnIjM/1XjESCm+9ZUaLBJjDJmlZBLm/kPm4e19caAHNEOC6RjB7Qi6M
         TW/Uou39/7gAOZ2s+oJN0jroEpQTuP+ika4BCyfAKzoZAGxBEIw0tSWEsYwIvbuURRUB
         xh5b+KZQBG+mOyA6l8AhIMNvlOLdBJWWwaNOHi8iYHgEaBL0XIbkHBPbFMnsNf4erCee
         J8ixLbTGyB5/py3M17WJ22nIQDP+VKye/9KioQuM+24CKEZj/+jKpUNPAG2gA4M+4bmC
         PV582wJneHoRMO23K2z4Va5P01h2vTeQ+GJVqw0s0S3YJgjpwGRyq7femIWnmbd6DGck
         FUlg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779089334; x=1779694134; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyYUA5OKTXxwotr87wMoor3EvZNaBbns1Q46YfLG3I8=;
        b=Nfh1b0bfT/Q6o9VndQ5hJMyc6eu0cUw7rpu75suF0KanK31OmBk78x0G0I0UxbZG9q
         K/rs/8xuHV8poTvH8NZyQcydFqRVJofHxDzFlKnccNICl2Nz6TSZOz3eh10XLcMQ4JUX
         7LHwN6Q+RiM5CNn9v+SKDZ/amL/9edYm8vbYW0xDJ7zVFmBqsU4khuTkAb45QGjl9b+/
         7KIkQ7JaBMvi9j/WMpX3Q+GeM5S0teiXFj5raGYePAo6zVL3v/dBW7Scugth36XWQogW
         TlNtPgsYuJc6+cOAzQvBhsYYlDzK1pBC4rRoEu1qOtoMMoAuD2Or9VvC0OLdAtjhHWns
         hUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089334; x=1779694134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyYUA5OKTXxwotr87wMoor3EvZNaBbns1Q46YfLG3I8=;
        b=dSKXpxTB6TJj1kjgLyOCQNoZ1JIpaDtQFuBtACo7eC95wbDXsRdh+R1Ez/pNgzJohS
         lDXxd71eLqOVKUpc8DfR4H0GGGo/dFA9Y/TW1CAdC7jzpo8/ZgqMAbEt8IIbM7SW/3qV
         NQFPLDnEfs11N2QWNo4tpTMTH+C1UfSft8JM0ob/a3JJJG4R52Z7l8TD1ulNXzrLxwxS
         ysi0KzesJgXyZyj9KpY7W6F9cj8pbT0KuGGspUjPk5gacj5lxJjaAyk07j5ibhkfbGRa
         9JEOqYJJyAKe6hKP5TgvilIDvKpqfebBFiltrSRwnVhAXYrVcbkrfjX7zP5yh+tVAQnR
         9fYw==
X-Forwarded-Encrypted: i=1; AFNElJ8UeB7anQBwH+BfVjr2PhiE6uPOT4myLU+KJeqboOuT7+Xsra6oXhzbxqUdmt+4GKMnYfEZP1lfmc6I/g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1faD0Z1lXIWO7v31/aTtGL6xbILsjaPeDhKP1Lt24GpUEnUja
	rPopPDM382wLj04XgyAbYwmrdQQaX6OZ5fRvYZK5mG9Ec0wIplFxoDcwtfnkk7PR86hPt1qvMdE
	YIkZtRO1I1oQ8iGq6et75qajOKgdizBw=
X-Gm-Gg: Acq92OFTi/geR2I0wo5zCjtmDoKj+DVq+RMs9UR7VI6KR207EdfogdEdtesAKzOs/I8
	KRMB1OmDhi2zlRe0MlzupQKg8n11x3rf2tJ0oNMPFQlMd2uMHwOfdXwABofogUDESh/HX8Jqx2P
	+u84nqg7Yr4p1nRHnhEgPRCkGsc68c/7oaIgES2QJWBevrGMpJ6YMgJnGlrItgxP0PndDsYcCZY
	qhYwqIb23ymv1vqf+GdbhW649XNlAIG+BrWMceiYNFHTurJtkY1z6HANhwiEdv284uDKqEs+Pmf
	JjvQDZTczwmA+dZbzSoy49RIiu7qsA==
X-Received: by 2002:a05:600c:4692:b0:48a:52ce:a4d3 with SMTP id
 5b1f17b1804b1-48fe63262famr117722565e9.8.1779089333844; Mon, 18 May 2026
 00:28:53 -0700 (PDT)
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
References: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com>
 <e4701c42-1ed5-40a6-8f5d-927c40e3856b@linux.alibaba.com> <CAHJ8P3KB02f2dTWrMXtyBMQwfqmFEeOwa4SW8CKL-rKrE=Dg=w@mail.gmail.com>
 <91d164b2-adac-4f17-970b-698e500f84a2@linux.alibaba.com>
In-Reply-To: <91d164b2-adac-4f17-970b-698e500f84a2@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 18 May 2026 15:28:42 +0800
X-Gm-Features: AVHnY4I8m4p-8yROkrRbioEOK0dF0fvqMmDZSvzl0vfr9Y2iQ8wpTWyjNKGpsmo
Message-ID: <CAHJ8P3JUbP3woSH9sN8HKH4CVuX3iAdqK_iV6HeqtVD2DiHqoA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: also handle last compacted 2B pack in z_erofs_drop_inline_pcluster
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, ke.wang@unisoc.com, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 9282956785A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3419-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhiguo.niu@unisoc.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.959];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=B8=80 12:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zhiguo,
>
> On 2026/5/11 15:54, Zhiguo Niu wrote:
> > Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=
=8811=E6=97=A5=E5=91=A8=E4=B8=80 12:01=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi Zhiguo,
> >>
> >> On 2026/4/29 15:59, Zhiguo Niu wrote:
> >>> With ztailpacking enabled, the current process assumes that a compact=
ed_4b_end
> >>> always exists in the compacted pack. However, in some specific files,=
 the
> >>> compacted pack may not have a compacted_4b_end. This leads to an inco=
rrect
> >>> modification of the last compacted_2B entry, resulting in incorrect m=
odification
> >>> of its clusterofs. In subsequent fsck operations, incorrect parameter=
s will
> >>> affect the decompression of the penultimate pcluster.
> >>>
> >>> This patch determines whether the last entry of the current compacted=
 pack
> >>> belongs to compacted 2B or 4B and then updates the correct bits accor=
dingly.
> >>>
> >>> Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compressi=
on approach")
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>
> >> Sorry for late response.
> >>
> >> I do think the issue is valid, but either the previous
> >> solution or the proposed one is ugly.
> >
> > Hi Xiang,
> > Yes it would be ideal if the same piece of common code could cover
> > both scenarios.
> > But I haven't figured it out yet, so I'll distinguish them like this fo=
r now. ^^
> > thanks!
> >>
> Could you confirm if the following diff fixes the issue?
Hi Xiang,
Just confirming a few minor issues=EF=BC=9A
>
>
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 9f3d0f9c35bc..0e4c2a9b53c7 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -218,6 +218,11 @@ typedef int64_t         s64;
>   #define get_unaligned(ptr)    __get_unaligned_t(typeof(*(ptr)), (ptr))
>   #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val)=
, (ptr))
>
> +static inline u32 get_unaligned_le16(const void *p)
> +{
> +       return le32_to_cpu(__get_unaligned_t(__le16, p));
> +}
> +
>   static inline u32 get_unaligned_le32(const void *p)
>   {
>         return le32_to_cpu(__get_unaligned_t(__le32, p));
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 450e2647cca7..2cc9cc8009aa 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -210,6 +210,12 @@ struct erofs_diskbuf;
>   #define EROFS_INODE_DATA_SOURCE_RESVSP                3
>   #define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB  4
>
> +enum erofs_idata_type {
> +       EROFS_IDATA_TYPE_RAW,
> +       EROFS_IDATA_TYPE_COMPRESSED_DEFAULT,
> +       EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B,
> +};
> +
>   #define EROFS_I_BLKADDR_DEV_ID_BIT            48
>
>   struct erofs_inode {
> @@ -262,7 +268,7 @@ struct erofs_inode {
>         unsigned short idata_size;
>         char datasource;
>         bool in_metabox;
> -       bool compressed_idata;
> +       char idata_type;
>         bool lazy_tailblock;
>         bool opaque;
>         /* OVL: non-merge dir that may contain whiteout entries */
> diff --git a/lib/compress.c b/lib/compress.c
> index 62d2672cb665..e171aee48c0b 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -483,7 +483,7 @@ static int z_erofs_fill_inline_data(struct erofs_inod=
e *inode, void *data,
>   {
>         inode->z_advise |=3D Z_EROFS_ADVISE_INLINE_PCLUSTER;
>         inode->idata_size =3D len;
> -       inode->compressed_idata =3D !raw;
> +       inode->idata_type =3D EROFS_IDATA_TYPE_COMPRESSED_DEFAULT;
>
>         inode->idata =3D malloc(inode->idata_size);
>         if (!inode->idata)
> @@ -980,7 +980,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_=
inode *inode,
>                                               &dummy_head, big_pcluster);
>                 compacted_2b -=3D 16;
>         }
> -       DBG_BUGON(compacted_2b);
> +       if (!compacted_4b_end && inode->idata_size)
> +               inode->idata_type =3D EROFS_IDATA_TYPE_COMPRESSED_END_OF_=
2B;
if  compacted_2b && compacted_4b_end both are zero,  should not set this???
>
>         /* generate compacted_4b_end */
>         while (compacted_4b_end > 1) {
> @@ -1210,10 +1211,12 @@ void z_erofs_drop_inline_pcluster(struct erofs_in=
ode *inode)
>
>         h->h_advise =3D cpu_to_le16(le16_to_cpu(h->h_advise) &
>                                   ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
> +       DBG_BUGON(inode->idata_size !=3D le16_to_cpu(h->h_idata_size));
>         h->h_idata_size =3D 0;
> +
>         if (!inode->eof_tailraw)
>                 return;
> -       DBG_BUGON(inode->compressed_idata !=3D true);
> +       DBG_BUGON(inode->idata_type !=3D EROFS_IDATA_TYPE_RAW);
 DBG_BUGON(inode->idata_type !=3D EROFS_IDATA_TYPE_COMPRESSED_DEFAULT); ???
>
>         /* patch the EOF lcluster to uncompressed type first */
>         if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_FULL) {
> @@ -1224,18 +1227,26 @@ void z_erofs_drop_inline_pcluster(struct erofs_in=
ode *inode)
>                 di->di_advise =3D cpu_to_le16(type);
>         } else if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_COMPAC=
T) {
>                 /* handle the last compacted 4B pack */
> -               unsigned int eofs, base, pos, v, lo;
> +               unsigned int lclusterbits =3D inode->z_lclusterbits;
> +               unsigned int lobits, eofs, base, pos, v;
>                 u8 *out;
>
> -               eofs =3D inode->extent_isize -
> -                       (4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
> -               base =3D round_down(eofs, 8);
> -               pos =3D 16 /* encodebits */ * ((eofs - base) / 4);
> -               out =3D inode->compressmeta + base;
> -               lo =3D erofs_blkoff(sbi, get_unaligned_le32(out + pos / 8=
));
> -               v =3D (type << sbi->blkszbits) | lo;
> -               out[pos / 8] =3D v & 0xff;
> -               out[pos / 8 + 1] =3D v >> 8;
> +               lobits =3D max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT)=
 + 1U);
> +
> +               if (inode->idata_type =3D=3D EROFS_IDATA_TYPE_COMPRESSED_=
DEFAULT) {
> +                       eofs =3D inode->extent_isize -
> +                               (4 << (BLK_ROUND_UP(sbi, inode->i_size) &=
 1));
> +                       base =3D round_down(eofs, 8);
> +                       pos =3D 16 /* encodebits */ * ((eofs - base) / 4)=
;
> +                       out =3D inode->compressmeta + base + pos / 8;
> +               } else {
> +                       out =3D inode->compressmeta + inode->extent_isize=
 - 4 - 2;
> +                       lobits =3D 16 - 14 /* encodebits */ + lobits;
if  compacted 2B, lobits=3D2+12=3D14, but encodebis =3D14, clusterofbits
should be 12??
Or is there something I'm misunderstanding?

> +               }
> +               v =3D (get_unaligned_le16(out) & (BIT(lobits) - 1)) |
> +                       (type << lobits);
> +               *out =3D v & 0xff;
> +               *(out + 1) =3D v >> 8;
>         } else {
>                 DBG_BUGON(1);
>                 return;
> @@ -1244,7 +1255,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inod=
e *inode)
>         /* replace idata with prepared uncompressed data */
>         inode->idata =3D inode->eof_tailraw;
>         inode->idata_size =3D inode->eof_tailrawsize;
> -       inode->compressed_idata =3D false;
> +       inode->idata_type =3D EROFS_IDATA_TYPE_RAW;
>         inode->eof_tailraw =3D NULL;
>   }
>
> diff --git a/lib/inode.c b/lib/inode.c
> index 735319e1d3bf..c225faa121e7 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1043,7 +1043,7 @@ noinline:
>                 if (is_inode_layout_compression(inode)) {
>                         DBG_BUGON(!params->ztailpacking);
>                         erofs_dbg("Inline %scompressed data (%u bytes) to=
 %s",
> -                                 inode->compressed_idata ? "" : "un",
> +                                 inode->idata_type =3D=3D EROFS_IDATA_TY=
PE_RAW ? "un": "",
>                                   inode->idata_size, inode->i_srcpath);
>                         erofs_sb_set_ztailpacking(sbi);
>                 } else {
> @@ -1149,7 +1149,8 @@ static int erofs_write_tail_end(struct erofs_import=
er *im,
>                 pos =3D erofs_btell(bh, true) - erofs_blksiz(sbi);
>
>                 /* 0'ed data should be padded at head for 0padding conver=
sion */
> -               h0 =3D erofs_sb_has_lz4_0padding(sbi) && inode->compresse=
d_idata;
> +               h0 =3D erofs_sb_has_lz4_0padding(sbi) &&
> +                       inode->idata_type !=3D EROFS_IDATA_TYPE_RAW;
>                 DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));
>
>                 iov[h0] =3D (struct iovec) { .iov_base =3D inode->idata,
>
>
>

