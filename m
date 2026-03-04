Return-Path: <linux-erofs+bounces-2488-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPz6J+ydp2n2igAAu9opvQ
	(envelope-from <linux-erofs+bounces-2488-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 03:50:20 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C51FA0CF
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 03:50:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQcbX5pLyz30FP;
	Wed, 04 Mar 2026 13:50:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772592616;
	cv=pass; b=R+RuTjK8mzkF7Gwp0BmyTzW743K4RazqPra17yp5ByYodKzFfS9tQAtVHubj2gtNtYba4pbtBdBL2urtxZxsThb8B2oOPHjtBQlyz/ujoaeyNEzo14GqmuPtyU8EwuqqtfBaeX/oj1qlbOFmmDH3iZ1sCVZvzyC1BqKANZqOi6CcD9mqkzgnvh49iqjEfcPOhRm78rx18csJKtiVOouXe3QIVPsCuu/hKUuBcXJbj+6vHTVFr+qY+FGCfFpBPs9WnpaZx7+UgeIbKn+OX5KHTVwCoQ8nSXRi37rwcPmRLMhMSZ9ZypKc6tUojj5NJa0/NmfuD46oFcvPXLlO/OP0Hg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772592616; c=relaxed/relaxed;
	bh=VMS3yZACMoc6Ovy7t9DIpxOnN3D670B8KKxmw89ySuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOKkMpgZxe1CBqNIp/Y22sLy3NQIYfRJUw0CUeeTHSeiCaZ/CzyV0/RIBFKPGfqF8Nkn+zmVog1FwgDc/6YVk6TV5cc4ak4rA/ejpkHRUFebH+h7hAaYTXJWMogQ2T/F9oZDayVjvXe56v258QWQMIFkabTGmhWtOcnuOcStNPVzoIkJzZxUHM+92Zm+sttkeGmsl0zILE+BFJpqgPv6vi/bYDMPBUana516JGggyI8xw/tTbeQ3VKnee437eySf9vfGGMl1wxP3F4cXFcem/hH4RNb5y8nZOj9KjMQSMJr74tnaK8FWLwEnHcO23ThefIWSLCYpLgtFuehfIbvTxw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i9HHHGfU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i9HHHGfU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQcbX0pTFz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 13:50:15 +1100 (AEDT)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-64ad79df972so5987256d50.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 18:50:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772592614; cv=none;
        d=google.com; s=arc-20240605;
        b=dG+ym68GlNsM4YgO3upODdYJ8mb6XlOs6pj9EEtCMDah/1z2L2bB80OSD3JrHOOa9S
         la4kDzSt59XioKVtJk0eSqLAYL1EiQQqEtXqhSUHgZK7+WJF3fbXZ1zLiQxGxXrLSTyO
         LE7gw/Y6URXv1devec8rL2fsQ7yhqcpuQaEfb7SrUcqX3fXN6PhKGYTY4LkG0UPb5tzU
         HyuFLzTAztosG73OijE55Ka5ajOed/aoHtqD2blXir5Tztf0NiAdl3Qi+ufeBvelVa5R
         JldSHZgj9vHl1l1ceWdYoGiJujia2dVAlJTRDoi4kB+3VIsyt4vZsS2plCmrHtTGCgNY
         E5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMS3yZACMoc6Ovy7t9DIpxOnN3D670B8KKxmw89ySuw=;
        fh=xs+n7fxHVYdDfw3RXhkLeqdkcsYeY2wi7NkIWKsHiSQ=;
        b=g/4nwZwdmZmBxNVCPpagtrbsIgumIX0725L3t0CGlNfyJJwTdCpcTvjRrILlD3cARI
         PhidNauslMO/D48iagWnVVzsvdEj+kZzlRcpa8eZib4FoZfTo0RrQ2+E3rUJxkb0SyKJ
         giBE/kbNqYcZpurmSiWcvjq2BP58YqrgOmR8kEq5VywXbEO3MA60OLGKgb528oGcoYuP
         1W1ogciNJlCIz3mWS/zK6aCwYhFRwaILkqkSNFxyieYcvTua8HduMyVmMEy5gT6Q/+1v
         mkn4osicyUj10YOHmmVwYFd2+S40pCGGaqz5//Dr1ZMgEuExt3KSAcc1MB1yCWsREKyv
         G0xg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772592614; x=1773197414; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMS3yZACMoc6Ovy7t9DIpxOnN3D670B8KKxmw89ySuw=;
        b=i9HHHGfU4trpH9NkYZ+r5ahs6QMjn1i5JtmiamQ0phKN3CZIVNISEtWjWzkZZHtO23
         p2S4vl4KUi6YbwrSX30brlMNU9LN9/qCCwJbA+7yMYwxT0FcJhZdrONoTyGq9W2ceOj4
         BHrXg+Gpa7UJsDGRRxQ+ewsxZTuadwgPb3dr90cKa4qP3hk4IcCngQlgtHgQ2RiGqIL9
         pblwOWPe06CJSKXX/Hibvb9ZNUHnG05h3fpxOlALm9SJNif6JWnF77Wswk4ovYmdUNYj
         ecE2VB8r4YF2GGcTPz3quAeU5NmPhDObbN+ReoqSFFhxEfntr/wcsvTJ/axzjb0wGPch
         l7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772592614; x=1773197414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMS3yZACMoc6Ovy7t9DIpxOnN3D670B8KKxmw89ySuw=;
        b=ejLm1MAzeCtq3ZDdJedLPt/iWzSge0AHwcbQrCVAcZMbs5Tx5FM6aNq272umSiNAST
         cgVnrHJAyUqMeKowEeD7+9lHDa1JdUpf4q9Flbf+z/ZTkYXA2suw70OUy37ZvSuXKrQz
         +/M3T69Tp76Lu480AJDL1skLe4RgnTGix4Os7aF+p5mAkJMrxZQvNVjiiGulXLqWTbUt
         KXS5D/j7W0OcOyeWdPJejMPvrFZ889hH2RyW2LvRzrZGBui7VamCA8L4wOk19cV1HFw2
         zfMoDwJmK6taCayGvBb3qLS+xBxeQZwNRNol8WAI7/y+zdTjTr0HvyqxIux3Av/hEzfs
         eMsw==
X-Gm-Message-State: AOJu0Yz18/MN4clcS2XY5kMx3Ybrzj5KhlIGgTcbyLChlSnkC+tEGaxe
	3y1HDQhiyvnqsHo7Q7mTfFzW/ZgAcOSOPqV/mpYJqaSjYknRd1hejq6PkHCKdQ/9q8aROkGRqdh
	SfFL/CxppxP/4IcEFeNNmqa6HHMo8FVvgAZywynhY3g==
X-Gm-Gg: ATEYQzzTeIPzVdd3f/6P8faPjRBnnfKhnqPEeLli110fvcOoqLRC/ro3AxibuAbsKTb
	F+K/mIy62MEUmNznlpWCRQNOQwId9pWY41BovO3OtVO7kILYy4QtyQNe+IVLr6TPNhvF+EJT8MT
	NFekU4MjcNNi1jYAklb58MjhAev4ga4zQ+S9R3IMnHQn+yEyYKStQWjx4ru8XET27Y5hrg9MzD/
	p9G2fsdFzGI/9YkurgmH70Wg+/SIDnssEAtzhFtcN3IQYQPWz0DDnSP9wgE6VrbefGl
X-Received: by 2002:a05:690e:11c8:b0:64c:2581:eed6 with SMTP id
 956f58d0204a3-64cf9bc975cmr482679d50.69.1772592613675; Tue, 03 Mar 2026
 18:50:13 -0800 (PST)
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
References: <20260304024735.78595-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260304024735.78595-1-nithurshen.dev@gmail.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Wed, 4 Mar 2026 08:20:02 +0530
X-Gm-Features: AaiRm50Laduf5dB8sMXvZJ28PKSSpCdqnphFgXbfYw9NzLlwKGmFpXRFGG7Lxfk
Message-ID: <CANRYsKhwa1JvJuVySYgfjeULWp3PRsxc90xPwM4qknJCRoC2wg@mail.gmail.com>
Subject: Re: [PATCH] fsck.erofs: introduce rw-semaphore metadata cache PoC
To: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: xiang@kernel.org, Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B11C51FA0CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2488-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi Xiang,

Following up on our discussion regarding the multi-threaded fsck
pipeline and the need to cache metadata to reduce bottlenecking, I
noticed your TODO in lib/data.c about introducing a metabox cache.
I have put together this PoC. To ensure it remains highly concurrent
and thread-safe for the upcoming worker threads extracting pclusters,
I modeled it directly after the bucketed, erofs_rwsem_t approach used
in lib/fragments.c.

Testing on an LZ4HC 4K EROFS image of the Linux 6.7 source tree showed
a significant drop in I/O overhead:
Baseline Extraction: 1.538s
With Meta Cache PoC: 1.090s (~29% reduction)

Currently, the cache grows without bounds for the PoC. Before turning
this into a formal patch, I plan to add an LRU eviction policy to keep
the memory footprint bound on large images.

I would love your thoughts on this approach and if it aligns with your
vision for the metadata caching prerequisite.

Regards,
Nithurshen

On Wed, Mar 4, 2026 at 8:17=E2=80=AFAM Nithurshen <nithurshen.dev@gmail.com=
> wrote:
>
> This PoC introduces a thread-safe metadata cache to reduce redundant I/O
> and decompression overhead during fsck extraction. It directly addresses
> the TODO in erofs_bread by modeling a bucketed, rw-semaphore protected
> cache after the existing fragment cache implementation.
>
> Baseline (LZ4HC 4K pclusters, Linux 6.7 tree):
> Extraction time: 1.538s
>
> With Meta Cache PoC:
> Extraction time: 1.090s (~29% reduction)
>
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>  lib/data.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 3 deletions(-)
>
> diff --git a/lib/data.c b/lib/data.c
> index 6fd1389..bcd8d17 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -9,6 +9,35 @@
>  #include "erofs/trace.h"
>  #include "erofs/decompress.h"
>  #include "liberofs_fragments.h"
> +#include "erofs/lock.h"
> +
> +#define META_HASHSIZE          65536
> +#define META_HASH(c)           ((c) & (META_HASHSIZE - 1))
> +
> +struct erofs_meta_bucket {
> +       struct list_head hash;
> +       erofs_rwsem_t lock;
> +};
> +
> +struct erofs_meta_item {
> +       struct list_head list;
> +       u64 key;
> +       char *data;
> +       int length;
> +};
> +
> +static struct erofs_meta_bucket meta_bks[META_HASHSIZE];
> +static bool meta_cache_inited =3D false;
> +
> +static void erofs_meta_cache_init(void)
> +{
> +       int i;
> +       for (i =3D 0; i < META_HASHSIZE; ++i) {
> +               init_list_head(&meta_bks[i].hash);
> +               erofs_init_rwsem(&meta_bks[i].lock);
> +       }
> +       meta_cache_inited =3D true;
> +}
>
>  void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_k=
map)
>  {
> @@ -500,7 +529,56 @@ static void *erofs_read_metadata_bdi(struct erofs_sb=
_info *sbi,
>  void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
>                           erofs_off_t *offset, int *lengthp)
>  {
> +       u64 key =3D nid ? nid : *offset;
> +       struct erofs_meta_bucket *bk;
> +       struct erofs_meta_item *item;
> +       void *buffer =3D NULL;
> +
> +       if (__erofs_unlikely(!meta_cache_inited))
> +               erofs_meta_cache_init();
> +
> +       bk =3D &meta_bks[META_HASH(key)];
> +
> +       erofs_down_read(&bk->lock);
> +       list_for_each_entry(item, &bk->hash, list) {
> +               if (item->key =3D=3D key) {
> +                       buffer =3D malloc(item->length);
> +                       if (buffer) {
> +                               memcpy(buffer, item->data, item->length);
> +                               *lengthp =3D item->length;
> +                               *offset =3D round_up(*offset, 4);
> +                               *offset +=3D sizeof(__le16) + item->lengt=
h;
> +                       }
> +                       break;
> +               }
> +       }
> +       erofs_up_read(&bk->lock);
> +
> +       if (buffer)
> +               return buffer;
> +
>         if (nid)
> -               return erofs_read_metadata_nid(sbi, nid, offset, lengthp)=
;
> -       return erofs_read_metadata_bdi(sbi, offset, lengthp);
> -}
> +               buffer =3D erofs_read_metadata_nid(sbi, nid, offset, leng=
thp);
> +       else
> +               buffer =3D erofs_read_metadata_bdi(sbi, offset, lengthp);
> +
> +       if (IS_ERR(buffer))
> +               return buffer;
> +
> +       item =3D malloc(sizeof(*item));
> +       if (item) {
> +               item->key =3D key;
> +               item->length =3D *lengthp;
> +               item->data =3D malloc(*lengthp);
> +               if (item->data) {
> +                       memcpy(item->data, buffer, *lengthp);
> +                       erofs_down_write(&bk->lock);
> +                       list_add_tail(&item->list, &bk->hash);
> +                       erofs_up_write(&bk->lock);
> +               } else {
> +                       free(item);
> +               }
> +       }
> +
> +       return buffer;
> +}
> \ No newline at end of file
> --
> 2.51.0
>

