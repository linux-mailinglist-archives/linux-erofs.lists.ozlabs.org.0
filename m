Return-Path: <linux-erofs+bounces-2646-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FI/M0QQsWmYqQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2646-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 07:48:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92225D042
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 07:48:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1YF2Rsnz30hP;
	Wed, 11 Mar 2026 17:48:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773211713;
	cv=pass; b=HI6XG0tvZIopDNEP61LwsI/JqeBBACo1PYsrr6On92qRx5XwE4w5qIZQYwAsXLPzs+5AV7eNa34ZnCmLPzXVHpOs2xHYoqPKOS/5E0TBTOYKuz56seEVuNq7pXNwjt4kaIUJxq48NCS5jroQa8diwZIbKGA3L2BfqaoGf1xNEKViGMDJAbk0vRb34Vq5eIeGH+KVMbgKAcd5suJXiKkcmVPpEvSlS/TsN2bmPFamMl88+OUUT11Xca3522Ahu1QioIMHxG1w+opCnKKbBeu6egwUrHC8dly8vsp9PT5ymRSJqwCMjt/e7QnE0wKefjdxMnHC1yccxBCAvDRBQgLgtg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773211713; c=relaxed/relaxed;
	bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqguua1qZ/EhmL+glm53gi0gmYr3kdwmrbroxf662wStESOAlWAcZ4nG28AvTnGvVchPAYd1vysuvR2GbZJ9eyHgR7DFGE9HmOTKnKr16FrA+eSnGZbHUmpogDjCZTU1SEEvRzoyiSF754uYaNmM736tQjws8lMwqKOPajqqgYa4PmkqAgbpO/QDHJIMTfTqR+6aX66dTuuo9h9Myjx7Yrl0pnuADtf/KU+JFycf5SeqdOAULisulfcrYDjN0FfEUDAzMf5rmIp3LrVy3gss3z2BYhl+tFnjR/uSmU+wBXsdascko0mPv1lOumb4mUpDaJEr1nh90IXFlubK3Z+QvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cqnHE7ad; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cqnHE7ad;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1YD1Y3vz2xTh
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 17:48:31 +1100 (AEDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-439b873a54bso1088464f8f.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211707; cv=none;
        d=google.com; s=arc-20240605;
        b=kIESwS2k4eKfu9huR7nxIflfjY8TGtNj2f/8F+DHchFjT8vOe0PYwGfBiCwqfChq1K
         LGUOgOAA+TRcfpEvRHo85GJ0wVuQ+WJrkmoWTsyqTQ5a01M01tGm6tXrDJte00vFxGhG
         BNWuvgv+B1f7sn74rgJb0KY8/egERzFkp/wOwslYyl1ndfPgKv19xpzhNk4DboiL/BTX
         OdZ6Uw4tAU1SM70i8aDgUf1y4wxGZQV++o1ueZnBX/oLTCbWLifH7/yOYI5m1HMJKg7U
         R2dp9e34MI26e92mXWywEG3SUMsRAUmXbEy8beq4eb0guEQ/zlQ889pF0oKh25a1pUpr
         HOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
        fh=MYP03lI5zMpn2R++wpv+R4+RrODgstDDHbvPnYP0em4=;
        b=DSomf5COC4GpoUtMXtYBeoEhYbjc64mUkdG19End7q73DeS/vWg5HVIw8bfUAJiPZO
         8fcK0APRZJKJk4689hzbCug5w+BBcVI+ziePTc7f8sgEekm3Jq9zTTYFIDCAst0JTUha
         /odMidBuF3PFlWamoYbNvkBLqNNEONZrL/1x7kPDrrPMTjnXcJ32/5X27Alqo1Wc0S7w
         ljxrb7sHyNNxqlxkCsHP5219lV4F5PoC6mC/3jTsPOMjevg4IdNzI66flV4VHNjDwg/c
         FBlUJyyoJJMD6gS2FpBQLqzyuHWOTLlv4ArfM9LVl38VNc7boeao7h4ayO7uH5vFTUat
         uGTg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773211707; x=1773816507; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
        b=cqnHE7ad8VsEt7LNcggPNN1YMnRY4UVifPh6bCBR4/A+M0/RQkoa7k0u2XWYQK/byq
         IaJqm9KstwFanQ26oEAKd2uQ2li4+v8KTdK/1jHhS30PeowxWjZ3cqCWqzOdqGyq8CDm
         Yw8pqOMC3cPPzc4H54tn3ysO1gbvOHTQn2bjp5FBnqrPZrxERIkiqsluxSCvRtd3KtsN
         uq03mJdSKZSDdJdGyxIQJbm2KTMafnMBspZvt2rk62B2l84u4CIx0EqDw4zOnPMeHAyj
         u3E5CmzHZRhNOvAqT/9uL6Ei3equWUC+PpETyoiSY8Kz57sIRN5/D55XyZlKVrpwu5uc
         rSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211707; x=1773816507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
        b=rX0EUiQrFdZ6cP56KTzrm5TQwfRlvzJLAo7gh1SwTwXJR3ABBg4vHOZb7yBrgS0J//
         GVuCMHiepEE6BtlKEyzh4O2J4mHaT0+L8PGyWUzJFEAC0N+qiHkF6UKi/DBsO+MWynGX
         hfwXM773ZXE1s1ZJ5sC0lj0+QdbUziwbGwoEDzX6lmhuMJzeDwxQA4uCyQyiajYkBTVL
         qCL35uFElObSvondh6Ed/S2irUr+wbiSz/syfjAQ2Sp1JUAjGBatTcDS8Gm3WlWO+QF1
         SknUDx5MLhHJNb5zUwa/2qakfJUy8XL1X/sDW3af3NhJaOrnD4mUuO1gQZhznx2O5Sc5
         spLA==
X-Forwarded-Encrypted: i=1; AJvYcCVr80AnxX/8OdSqj0diU/S25h76xsz792AOjtMkOmPW6x4o/zhrgBsCT6pctsDX+slnDR65/RoQVdr+Pg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3iwzOApeSnlaF9ba2ySeUSUk9QeAhVaG+1eUe9XGbkkbShgCE
	Xm7ScrY5AaGsvp7q8lBDrSM5QmxXD5PaZ8Y1ASj3Gqy8+8YrcGIZ3lKxkfgm+NRGpzo+qfJlZ9r
	urSTMLM8NhfeDwbWdyyiINgumjDkuZ80y5w==
X-Gm-Gg: ATEYQzzIL8RhbhBGjBHDB20nFtqn23rYZ2wo/Mmk6s/jSltTJhPJxJ+CrnD9Snv+WL6
	wM5n+XvM8D0amjdG+J8sGdg/fyQmJUvdZAvYNXqfP7Wevglx7qAM/+gsNZQt3Zfe+cs1Ou9NPNa
	fJmPIIysM0Dhp2DbTNOPV1Jj3KCbXkG1JA4cos3MB3zo8vxX+XT3IhZQfMTaRg1/HKfAV7oYr6u
	Ws2Qb0lQWjuwdHmpa+a8W0s8Leu6bLz1ewgyUSDW3bp59tHjCJTVJBlxRwNuRcYBuu6zE2RoRd2
	YibrQQcn
X-Received: by 2002:a05:6000:2207:b0:437:72ce:8954 with SMTP id
 ffacd0b85a97d-439f82087c9mr1459231f8f.6.1773211707161; Tue, 10 Mar 2026
 23:48:27 -0700 (PDT)
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
References: <1773209614-1961-1-git-send-email-zhiguo.niu@unisoc.com> <c70a77a2-bc29-4767-b4c2-c5ba12dae04e@linux.alibaba.com>
In-Reply-To: <c70a77a2-bc29-4767-b4c2-c5ba12dae04e@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 11 Mar 2026 14:48:16 +0800
X-Gm-Features: AaiRm51dm_GPIPIMS59a0CAhUSzZaJ8nuweZCAN0n-xYvHBbxaJyLH_Fi9wW1Dw
Message-ID: <CAHJ8P3LH3Z9HjdVhhGXB9f8xAdbLgiwSay3e04GDfvGQwwwm=A@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] erofs: fix inline data read failure for
 ztailpacking pclusters
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org, ke.wang@unisoc.com, 
	Hao_hao.Wang@unisoc.com, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: ED92225D042
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhiguo.niu@unisoc.com,m:stable@vger.kernel.org,m:ke.wang@unisoc.com,m:Hao_hao.Wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2646-lists,linux-erofs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[niuzhiguo84@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unisoc.com:email,mail.gmail.com:mid,alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=89 14:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zhiguo,
>
> On 2026/3/11 14:13, Zhiguo Niu wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > [ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]
> >
> > Compressed folios for ztailpacking pclusters must be valid before addin=
g
> > these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
> > may assume they are already valid and then trigger a NULL pointer
> > dereference.
> >
> > It is somewhat hard to reproduce because the inline data is in the same
> > block as the tail of the compressed indexes, which are usually read jus=
t
> > before. However, it may still happen if a fatal signal arrives while
> > read_mapping_folio() is running, as shown below:
> >
> >   erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline da=
ta -4
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000008
> >
> >   ...
> >
> >   pc : z_erofs_decompress_queue+0x4c8/0xa14
> >   lr : z_erofs_decompress_queue+0x160/0xa14
> >   sp : ffffffc08b3eb3a0
> >   x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
> >   x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
> >   x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
> >   x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
> >   x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
> >   x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
> >   x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
> >   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> >   x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
> >   x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
> >   Call trace:
> >    z_erofs_decompress_queue+0x4c8/0xa14
> >    z_erofs_runqueue+0x908/0x97c
> >    z_erofs_read_folio+0x128/0x228
> >    filemap_read_folio+0x68/0x128
> >    filemap_get_pages+0x44c/0x8b4
> >    filemap_read+0x12c/0x5b8
> >    generic_file_read_iter+0x4c/0x15c
> >    do_iter_readv_writev+0x188/0x1e0
> >    vfs_iter_read+0xac/0x1a4
> >    backing_file_read_iter+0x170/0x34c
> >    ovl_read_iter+0xf0/0x140
> >    vfs_read+0x28c/0x344
> >    ksys_read+0x80/0xf0
> >    __arm64_sys_read+0x24/0x34
> >    invoke_syscall+0x60/0x114
> >    el0_svc_common+0x88/0xe4
> >    do_el0_svc+0x24/0x30
> >    el0_svc+0x40/0xa8
> >    el0t_64_sync_handler+0x70/0xbc
> >    el0t_64_sync+0x1bc/0x1c0
> >
> > Fix this by reading the inline data before allocating and adding
> > the pclusters to the I/O chains.
> >
> > Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> > Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/erofs/zdata.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 7116f20..0b3ca62 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -788,6 +788,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_fr=
ontend *fe)
> >       erofs_blk_t blknr =3D erofs_blknr(sb, map->m_pa);
> >       struct z_erofs_pcluster *pcl =3D NULL;
> >       int ret;
> > +     void *mptr =3D NULL;
>
Hi Xiang,
> let's align with the upstream naming and ordering?
>
>         void *ptr =3D NULL;
>         int ret;
OK
>
> >
> >       DBG_BUGON(fe->pcl);
> >       /* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster =
*/
> > @@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct z_erofs_f=
rontend *fe)
> >       } else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> >               DBG_BUGON(1);
> >               return -EFSCORRUPTED;
> > +     } else {
> > +             mptr =3D erofs_read_metabuf(&map->buf, sb, map->m_pa, ERO=
FS_NO_KMAP);
> > +             if (IS_ERR(mptr)) {
> > +                     ret =3D PTR_ERR(mptr);
> > +                     erofs_err(sb, "failed to get inline data %d", ret=
);
>
> Could you retain the upstream error report? like:
>                         erofs_err(sb, "failed to read inline data %pe @ p=
a %llu of nid %llu",
>                                   mptr, map->m_pa, EROFS_I(fe->inode)->ni=
d);
>
> Otherwise it looks good to me.
>
> When you send the next version, please send the patch
> to Greg as well.
got it.
Thanks!
>
> Thanks,
> Gao Xiang
>
> > +                     return ret;
> > +             }
> > +             mptr =3D map->buf.page;
> >       }
> >
> >       if (pcl) {
> > @@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_f=
rontend *fe)
> >               /* bind cache first when cached decompression is preferre=
d */
> >               z_erofs_bind_cache(fe);
> >       } else {
> > -             void *mptr;
> > -
> > -             mptr =3D erofs_read_metabuf(&map->buf, sb, map->m_pa, ERO=
FS_NO_KMAP);
> > -             if (IS_ERR(mptr)) {
> > -                     ret =3D PTR_ERR(mptr);
> > -                     erofs_err(sb, "failed to get inline data %d", ret=
);
> > -                     return ret;
> > -             }
> > -             get_page(map->buf.page);
> > -             WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.pa=
ge);
> > +             get_page((struct page *)mptr);
> > +             WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, mptr);
> >               fe->pcl->pageofs_in =3D map->m_pa & ~PAGE_MASK;
> >               fe->mode =3D Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
> >       }
>

