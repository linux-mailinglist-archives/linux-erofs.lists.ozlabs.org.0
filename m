Return-Path: <linux-erofs+bounces-3365-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIyQCdu68Wl1kAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3365-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Apr 2026 10:01:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1B490E1E
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Apr 2026 10:01:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g58rW2zKHz2ySf;
	Wed, 29 Apr 2026 18:01:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::333" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777449675;
	cv=pass; b=KV+ZJTuOLkRLJCJE5FNrn2R2+oqlLrDYgd4oSi6Aw5uiFXVyswpWKUgNe0UcKrIRqw+4Eo4Z5Ycdn920OpgTOif7/pE55sbh7bso9keHHxPghJ1FtdHPeUiJiNso0SPj2gT4ZUlVo9Ksm/kQOv0QyX/Z7ocWZmYxYB5xIShWMb6bAHCh3JF0J7utPLQoBalzQUYC4L0DmA23X3C9N/laRY1fsJblpYPpuv5OR+Ne8JceQz7WpRzgZ3TjblVivhiBXOW2qei6zXUTpjkw9VLqswDZqSSLR9XnTL6ZwJXs7emBUYxUS7gxjr7X63lFH3WX9OCI6m6AsMNXD6XgTZFo1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777449675; c=relaxed/relaxed;
	bh=i1HkGv08ixkw/NtnH/a+YIiHYWuD41eetNV6JArImdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcKfQtGotvz65ZU/AN9GJT0Dc3QhTA+kjHbmPrxr8AtKymjvQIrtKhpURzp6gvjMlmLUTaUSGuWwqsfdt7IH3FXy75Y0dzJLOKBEIzRce8K45vYHvoDwV4rYuP0LkV0oGJQeiSWHAM8Kfkq6UQZ+L957S6UCZy6we/PQJxaiur/vURdLXtbM6G/xSqGNFy2VekdDiTl1bCqHi7ubDWpUQheK4OLVUOV8C/C8jhjuEkTzXGiMKRfMwqNMUq75rLvmMNuRY8bUk1r8trZXgBdA3EHc3PVv1xs/Wm95KpbBi+lz/Y3gHmCVO4hNkQXhX5HuKXcs6aZS+obDCl9OMuNh/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dsIQwHfl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dsIQwHfl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g58rQ2dt6z2ySW
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Apr 2026 18:01:09 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-48962cd0864so13945755e9.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Apr 2026 01:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777449666; cv=none;
        d=google.com; s=arc-20240605;
        b=FU1dNZ4LkZmJbunkEeNVmqMQYQM5iZmbVMVMDKZnaBFNLsh1g0ija0IyxXC1hU6Qns
         DNKC56MkUqAXeh+Wcr82KIO61uJ++hoVJmB+IMpmC7vfkijdCcFg9OZzpPdipLnYrQV0
         a+9O+PEgmDdyP2W5JctYjCW+gxY2qzYQx16Ae0Vnsdx5JCqY7rTJG38aKiCNNjW7F3H0
         Ne37/sl6nVcYWuA4YYVbJpAFEoHvv/aLU6EoPDnCMvSVldUxoKW4V87qDY1+gOtAfdy+
         3Y7HhipWQJ0/IQLu3eHKZrHw4/+dJO6+wPEoCwvsBY2V8crsrxM0iqWd1/gRQv0cIE4t
         Fhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1HkGv08ixkw/NtnH/a+YIiHYWuD41eetNV6JArImdM=;
        fh=vncB/LX0K2R1jgcpedCt5Hlx81V8Ss4RygwjSGPeAsE=;
        b=IQ+/G1/eE0zKCWJ3eKD4r2dBfBTmMEe/QIXMZk6hoopz1uZR8y6U5U7RBP745+6VOn
         MW8RZt0iSEE3CVDZF5oUwPV09m2PKq3c9mvb5PpW1nxTm48XivXjCQR7DMqYEYWSRgrY
         tD4+Kgw7s39pHz5sCJtkeKEf/5Smo0Fun/Ezt2LEkITORlojgkKPgGrzO5bxAuLnuwqQ
         WscVqCmVGi3lwcvm1Gu0gCLPy61F7eTHva/9Z9PDrvvCZMyLx6JaR10vYGaIjizApkZn
         onK0gzdBhMuRx+sKO5bYOBhpDwK9d2eJapnuUSJ5tdOhRt8aeACVPtkCH7mcFFB5arnH
         HMXQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777449666; x=1778054466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1HkGv08ixkw/NtnH/a+YIiHYWuD41eetNV6JArImdM=;
        b=dsIQwHflOyt+6sJ3Kb8iiL68E0zarffG4AsvIS4pvZwfs4NMZtSHunasDFdxDRR2zi
         p5hLE4ao9sEFFGrrmDZNNolrtTHmO0wEbYzc9213IYskuC6FyjlrjmUUTphWu2U1YTet
         pryfw9Vn62oumnI6Wm6sz8ufYUKOUQ3/yvr56a+qb9jH+BnHaeu/TkSukTgQFZRp0whj
         dtTU4l00xKm6KjLwD4Om8q+lBd7S8mXYn7ApeKfitfXlJAbPlU0YoNZ/e839nuzjR1Sb
         4w0TS92Sz5iLhw47x5pirfS5dQR2tyC56DEQLf6Ytz6qTmT7z0KjRUiSauuaW1xefxbS
         OUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777449666; x=1778054466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1HkGv08ixkw/NtnH/a+YIiHYWuD41eetNV6JArImdM=;
        b=cBeIE5iUyCg6L5VmrxxY2SZpxCMSZcIE33YsCWWDn0MY2ihclAhsc9+Fsgc8mSSZ/F
         D9e6u7a4dkBEKNArExB4e7PO4TTx2wwway+qxKfdZcMe3xmSsRFWb8YQteCdc60ah1Cu
         imik8qb18xiuI/S/4lOqSAXKPuFNsBEFb851eKy5TRYVOzhfR8vPjMyYBHb+Ev0dp12a
         iJvXhmaS5stTGHBK8nNNctHml1wHnranmMU2IqUzxuq+a32pPDgYit6HUprsxr2TA3lp
         Frx3xjphhGP86j7W4TZ1mPTQ4qDazRwWv40Bg7j+RHzbajht+gAt5d5wcLi/W05mualu
         urMg==
X-Forwarded-Encrypted: i=1; AFNElJ+kdj76p2yH1i8SM+OdbQzQ3u5w8h8mrw2q6xTpotQPrriT3qEnOfroac80Mq9Z6RhG74F6V/uen1rLWw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydYSjbsJyaIoDMQ2jjJr1zMMYSJt23FJctzryvfZM4kF66yq6P
	vkID4+gqNwHuq3OvbQa+j4rRwwptNCgWkkH7jqutoPs+jXylLcMzngT67ORMJ7GlPtc/3dlpNEW
	FohSnzZGLfhacn7WwVhEctW+03EtFCFQ=
X-Gm-Gg: AeBDievt+2TLz3/Ug5yz2JRRenANNcCAf9CUSA3qmkrcSEmEsxBIkqTspWAG2vN7WaY
	C3NK270NTQ3NS70+aE5jD7T7AFDFPTxkgmpgpl2pXzKI/HsSS4DUoViJB+7sIo9mI738gAnJCiq
	4qo+g/9z+KVR7buLyCSTKudisqB20FzWU6gJbLxe38i3LWBnCeSBXUzWUsQ3Mz9KLxc3aCYLA2y
	0gVfQAvRZxkYvIlKoG46gTM9DI65icaoRwdZ+qdPHLwuQR0UA50oMH3ds2XBaRUoIZJZIuW4K+r
	m4k0CxbO4whL4bS2POA=
X-Received: by 2002:a05:600c:1d1c:b0:486:fc61:541d with SMTP id
 5b1f17b1804b1-48a76f612b1mr64267715e9.2.1777449665542; Wed, 29 Apr 2026
 01:01:05 -0700 (PDT)
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
In-Reply-To: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 29 Apr 2026 16:00:53 +0800
X-Gm-Features: AVHnY4IachfcyydJSm9-L7_wLKWLfNNiO5uSMQ6WowBPtvNl5INastPneA0OMf8
Message-ID: <CAHJ8P3LZk0jETzbetQzvbxx8XL-6nSVd6pUBK-SVOUK4gKPe_Q@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: also handle last compacted 2B pack in z_erofs_drop_inline_pcluster
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: hsiangkao@linux.alibaba.com, ke.wang@unisoc.com, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 41E1B490E1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhiguo.niu@unisoc.com,m:hsiangkao@linux.alibaba.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RSPAMD_URIBL_FAIL(0.00)[unisoc.com:query timed out];
	ASN_FAIL(0.00)[117.38.213.112.asn.rspamd.com:query timed out];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3365-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[zhiguo.niu.unisoc.com:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,unisoc.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

version:
erofs-utils: 1.8.3
lz4:1.10.0
Android:17

cmd:
mkfs.erofs -z lz4hc,9 --compress-hints
./output/META/erofs_default_compress_hints.txt -d9 -b 4096
--mount-point product --fs-config-file
./output/META/product_filesystem_config.txt --file-contexts
./output/META/framework_file_contexts.bin -T 1230768000 -U
ad34a95d-293d-5e91-9234-c253209e9c71 -E dedupe,ztailpacking
./output/PRODUCT/tmp ./output/PRODUCT2/ 1>mkfs.log 2>&1
./fsck.erofs --extract -d9 output/PRODUCT/2sofiximage

error case:
mkfs 2 source files: libmsc.so.salsa, libmsc.so

erofs: failed to full decompress -3066 in[4096, 0] out[6121]
dump extent:
1192:  7765862.. 7770924 |    5062 :    9687040..   9691136 |    4096
1193:  7770924.. 7777021 |    6097 :    9691136..   9695232 |    4096
1194:  7777021.. 7784118 |    7097 :    9695232..   9699328 |    4096
1195:  7784118.. 7789918 |    5800 :    9699328..   9703424 |    4096
1196:  7789918.. 7797526 |    7608 :    9703424..   9707520 |    4096
1197:  7797526.. 7803647 |    6121 :    9707520..   9711616 |    4096
1198:  7803647.. 7806972 |    3325 :    9711616..   9715712 |    4096
mkfs debug log:
compacted_2b=3D1904  compacted_4b_initial=3D2 compacted_4b_end=3D0
write di_clusterof=3D2815 type=3D1 di_u.blkaddr=3D2371 d1=3D0 clusterofs=3D=
2815
//last pcluster
last 8 bytes in compacted pack:
6bfe0016 00000938
after drop inline operation:
0bfe0016 00000938

good case :
mkfs 1 source file:libmsc.so.salsa
dump extent:
1192:  7765862.. 7770924 |    5062 :    4886528..   4890624 |    4096
1193:  7770924.. 7777021 |    6097 :    4890624..   4894720 |    4096
1194:  7777021.. 7784118 |    7097 :    4894720..   4898816 |    4096
1195:  7784118.. 7789918 |    5800 :    4898816..   4902912 |    4096
1196:  7789918.. 7797526 |    7608 :    4902912..   4907008 |    4096
1197:  7797526.. 7805695 |    8169 :    4907008..   4911104 |    4096
1198:  7805695.. 7806972 |    1277 :    4911104..   4915200 |    4096
mkfs debug log:
compacted_2b=3D1904  compacted_4b_initial=3D0 compacted_4b_end=3D2
write di_clusterof=3D2815 type=3D1 di_u.blkaddr=3D1199 d1=3D0 clusterofs=3D=
2815
//last pcluster
last 8 bytes in compacted pack:
1aff2001 000004ae
after drop inline operation:
0aff2001 000004ae

Zhiguo Niu <zhiguo.niu@unisoc.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=B8=89 16:00=E5=86=99=E9=81=93=EF=BC=9A
>
> With ztailpacking enabled, the current process assumes that a compacted_4=
b_end
> always exists in the compacted pack. However, in some specific files, the
> compacted pack may not have a compacted_4b_end. This leads to an incorrec=
t
> modification of the last compacted_2B entry, resulting in incorrect modif=
ication
> of its clusterofs. In subsequent fsck operations, incorrect parameters wi=
ll
> affect the decompression of the penultimate pcluster.
>
> This patch determines whether the last entry of the current compacted pac=
k
> belongs to compacted 2B or 4B and then updates the correct bits according=
ly.
>
> Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression a=
pproach")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  lib/compress.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/lib/compress.c b/lib/compress.c
> index 62d2672..0eb464b 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1223,19 +1223,35 @@ void z_erofs_drop_inline_pcluster(struct erofs_in=
ode *inode)
>
>                 di->di_advise =3D cpu_to_le16(type);
>         } else if (inode->datalayout =3D=3D EROFS_INODE_COMPRESSED_COMPAC=
T) {
> -               /* handle the last compacted 4B pack */
> +               /* handle the last compacted pack */
>                 unsigned int eofs, base, pos, v, lo;
>                 u8 *out;
> -
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
> +               unsigned int compacted_4b_initial, compacted_2b, compacte=
d_4b_end;
> +               unsigned int totalidx =3D BLK_ROUND_UP(sbi, inode->i_size=
);
> +               const erofs_off_t ebase =3D sizeof(struct z_erofs_map_hea=
der) +
> +                       round_up(erofs_iloc(inode) + inode->inode_isize +
> +                                       inode->xattr_isize, 8);
> +
> +               compacted_4b_initial =3D ((32 - ebase % 32) / 4) & 7;
> +               compacted_2b =3D 0;
> +               if ((le16_to_cpu(h->h_advise) & Z_EROFS_ADVISE_COMPACTED_=
2B) &&
> +                       compacted_4b_initial < totalidx)
> +                       compacted_2b =3D rounddown(totalidx - compacted_4=
b_initial, 16);
> +               compacted_4b_end =3D totalidx - compacted_4b_initial - co=
mpacted_2b;
> +               if (!compacted_2b || compacted_4b_end) {
> +                       eofs =3D inode->extent_isize - (4 << (totalidx & =
1));
> +                       base =3D round_down(eofs, 8);
> +                       pos =3D 16 /* encodebits */ * ((eofs - base) / 4)=
;
> +                       out =3D inode->compressmeta + base;
> +                       lo =3D erofs_blkoff(sbi, get_unaligned_le32(out +=
 pos / 8));
> +                       v =3D (type << sbi->blkszbits) | lo;
> +                       out[pos / 8] =3D v & 0xff;
> +                       out[pos / 8 + 1] =3D v >> 8;
> +               } else {
> +                       eofs =3D inode->extent_isize - (4 + 1);
> +                       out =3D inode->compressmeta + eofs;
> +                       *out =3D (*out & 0x3f) | (type << 6);
> +               }
>         } else {
>                 DBG_BUGON(1);
>                 return;
> --
> 1.9.1
>

