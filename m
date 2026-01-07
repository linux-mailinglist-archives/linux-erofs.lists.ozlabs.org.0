Return-Path: <linux-erofs+bounces-1702-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A10BCFE513
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 15:33:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmVrR5tdwz2xbQ;
	Thu, 08 Jan 2026 01:33:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767796391;
	cv=none; b=nFlM6lg+5UO6rrz5UM68pMggMWJSDlag6rkw9j/+/SCDYENaD3XRY2Y5BVY9CKqjU919XI5df0je8vbDOMwy+cfU7bLUfy14eT32foX+YOkrrYl392NY3jSnZ4Tq0d5yTBiCeUNQvFK7WTmXHVvczDxxZZyD+b7/KV6JAgxU64eHXktDH1V2NaoP+48hRsDF/8PHwzIlacJ5IIkSoH0G1cNjwaU3dvf7yQAQ46TFTlgMFu+htPstgoS0sTnz30irGkSkcA7UaMxH6jrCNTzRG3APZfbH1YHbs9u5xjd8uQaKdxlpkXZPbQ03Yf/VJNeOyYmLO6uhxhwxJU7qq31uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767796391; c=relaxed/relaxed;
	bh=Ey6sLjECmZyF17LqZLeyXB6lVFasSr8XhqLf0tOyRQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffi4BdWUoKDBVBp1f5WovXj1kZ00TATK9ZdQvt5fx6MIKUQ4P1XAjurSmlJYMt0wYQRrmmUJUWampdTAMl/1cs/zrzD5J/jHJ/LgXZoMqPb/6X2FiVLBfiAvpnbF5J4Kp9srDDXL6UlG91AoLqOkDX+tx7q0C9n485QgYo/HuY0OU/e3KLAhG46GMWt3EPme8uDC3Kky/T0aU850NEnM55qtMOMCVRfnqWKM8p3fxQrGyOT4Mi5FPZZTDaIx6Q26TXYMKiVulso5CM8GSEXUa53dFYkOPob80Yq33pF5PmeZ553hQVsAqf2id4PFmmBovaWBt1EMsqerwi3tsDd6pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g9DVLYzU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g9DVLYzU; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g9DVLYzU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g9DVLYzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmVrQ3pKMz2xLR
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 01:33:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767796380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ey6sLjECmZyF17LqZLeyXB6lVFasSr8XhqLf0tOyRQc=;
	b=g9DVLYzUMG4tFGD3yMyIAdGoITEN5xfMBIdO37UHOXxbXx6pm69sqzOcozI+Kt97E/d+Gq
	3YtzKlYNgnC+Mu9nATvkCoebCqn3a4hg1Ud4CD6Yo9VNr5cr2h4o3K3sRDxU7QIlzlw442
	OuaiP9a51bvhYliP8+FiIsPubbusUPY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767796380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ey6sLjECmZyF17LqZLeyXB6lVFasSr8XhqLf0tOyRQc=;
	b=g9DVLYzUMG4tFGD3yMyIAdGoITEN5xfMBIdO37UHOXxbXx6pm69sqzOcozI+Kt97E/d+Gq
	3YtzKlYNgnC+Mu9nATvkCoebCqn3a4hg1Ud4CD6Yo9VNr5cr2h4o3K3sRDxU7QIlzlw442
	OuaiP9a51bvhYliP8+FiIsPubbusUPY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-X91F9UToNgGiDt6ubtfB1Q-1; Wed, 07 Jan 2026 09:32:58 -0500
X-MC-Unique: X91F9UToNgGiDt6ubtfB1Q-1
X-Mimecast-MFC-AGG-ID: X91F9UToNgGiDt6ubtfB1Q_1767796376
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59b3b255ee8so2346855e87.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 06:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796375; x=1768401175;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ7Tvk+jfBLrINloRAmrmHd+axqfdv1XIyOCIBd2Vd4=;
        b=wyf7eET8g02+J+c9cSqfMPUHrfsiT3uOw0YzCKX1VQ/auTKYUbQl/Oma+WICtLPYXx
         doMguk3gSMh+1yHkKCWqsj9RGt8Mvc+Iu1lFjUplkGg1a35OV0Jx3jfqwB6EnYq2ksmz
         53PnoAcN+BadHgYoSQTbFGk/Izhg98MRcfOZzQcL3aZVe9AuNubUFmLsCTTxQFvYNtX9
         JJhH88dim6DmHpDjCq2dUzAciPfl3iwlXBfHC5GNnzCNpghR2kXlKz+uAY+n5kAfGl4b
         uW7eIIpoFud43OsIaG/rbyChBEas7UNLNKjaGKF5lgDbfgYSWQVq4JYn+M/lCFUJy0KY
         fvRg==
X-Forwarded-Encrypted: i=1; AJvYcCVnSsxi7NdT8qnWZuebMe5GZcOpH+oN4LE5VL7b2ledbJFcQVzHRgn2p6AW8tM1uGwB0t2n6bHlF9OohA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynnQ0MqqbLvRY9SlBIwFT5p8CAZps4uTsJyCiM/zz/vTsuvzr1
	vmW1tQvoZ1F6owNcFGKfEGm6d48EHmxH3/AvcnCBsLT34afqEaqGddo3tnjaitsdJA9j1jE3A3y
	h4FFjQwSrmdiC2DrGEiB6f2yNv6luCFEuqfbIPwVlhg0MOHyx2QhZFLV4gD0R1WNJgwKa72qsKA
	==
X-Gm-Gg: AY/fxX46R+mGxg8JVzxwg4SC8o1vHOQy1ZZFyc0NYkW71Macb4xSLhZtAjmtJek5Fzt
	vsUBV8tX9fbc3/dYmx5E5s7YSqOtWw/R3sxMaSXBDjBwnq9AV94TGXFWOH3qrdofI+dy8TNbqRX
	YnVPWYBxU9jJ/SDIt8Z00oBYbAFKHzbaOYjObdDvsLTugyKXQsRm2mhNYcVzDqTsFD4ru+TBdtt
	81o7UMulBKYAJ82vKhNQX42VaHGUI+ICgD3sVGogF01k7UUKV2bn0O/7RUVF5iAcRNUAjtlbx4W
	9S7+5qrwvNb/LWb8NvABGBjvK3eW17kh3d5uQMtf3jf6YitL4oh2BHt9zqbnvVyFPii0iKa2uJ8
	+r+S/s4HxA69kEnP/cSI/MV6R5n0l5j8xIaOcRtYZGTlqXr/OMg==
X-Received: by 2002:a05:6512:1584:b0:595:7e2d:9889 with SMTP id 2adb3069b0e04-59b6ef239bfmr608035e87.1.1767796375046;
        Wed, 07 Jan 2026 06:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtXm8onTnrNt0hjPFspKf/dNpqVUyzW76wjDYiEENse9MSnI5knSD9dudvYlcaNyf5heesBw==
X-Received: by 2002:a05:6512:1584:b0:595:7e2d:9889 with SMTP id 2adb3069b0e04-59b6ef239bfmr608027e87.1.1767796374366;
        Wed, 07 Jan 2026 06:32:54 -0800 (PST)
Received: from [192.168.68.112] (c-85-226-160-236.bbcust.telenor.se. [85.226.160.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6bebfa94sm943327e87.55.2026.01.07.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:32:53 -0800 (PST)
Message-ID: <e12f06601c7449922c1219a35b84f708133e6216.camel@redhat.com>
Subject: Re: [PATCH] erofs: don't bother with s_stack_depth increasing for
 now
From: Alexander Larsson <alexl@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Goldstein
 <amir73il@gmail.com>,  Christian Brauner	 <brauner@kernel.org>, Miklos
 Szeredi <mszeredi@redhat.com>
Date: Wed, 07 Jan 2026 15:32:53 +0100
In-Reply-To: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
References: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RFmGK8Ofrd_3legHqy23FgVMYmSlxcvTrtjfDrzfAto_1767796376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, 2026-01-01 at 04:42 +0800, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs
> stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid
> kernel
> stack overflow, but it breaks composefs mounts, which need
> erofs+ovl^2
> sometimes (and such setups are already used in production for quite
> long
> time) since `s_stack_depth` can be 3 (i.e.,
> FILESYSTEM_MAX_STACK_DEPTH
> needs to change from 2 to 3).
>=20
> After a long discussion on GitHub issues [1] about possible
> solutions,
> it seems there is no need to support nesting file-backed mounts as
> one
> conclusion (especially when increasing FILESYSTEM_MAX_STACK_DEPTH to
> 3).
> So let's disallow this right now, since there is always a way to use
> loopback devices as a fallback.
>=20
> Then, I started to wonder about an alternative EROFS quick fix to
> address the composefs mounts directly for this cycle: since EROFS is
> the
> only fs to support file-backed mounts and other stacked fses will
> just
> bump up `FILESYSTEM_MAX_STACK_DEPTH`, just check that `s_stack_depth`
> !=3D 0 and the backing inode is not from EROFS instead.
>=20
> At least it works for all known file-backed mount use cases
> (composefs,
> containerd, and Android APEX for some Android vendors), and the fix
> is
> self-contained.
>=20
> Let's defer increasing FILESYSTEM_MAX_STACK_DEPTH for now.
>=20
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-
> backed mounts")
> Closes:
> https://github.com/coreos/fedora-coreos-tracker/issues/2087=C2=A0[1]
> Closes:
> https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1wtYN=3Dz0QXwC=
pec9sXtg@mail.gmail.com
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Acked-by: Alexander Larsson <alexl@redhat.com>

> =C2=A0fs/erofs/super.c | 18 ++++++++++++------
> =C2=A01 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..0cf41ed7ced8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct
> super_block *sb, struct fs_context *fc)
> =C2=A0=09=09 * fs contexts (including its own) due to self-
> controlled RO
> =C2=A0=09=09 * accesses/contexts and no side-effect changes that
> need to
> =C2=A0=09=09 * context save & restore so it can reuse the
> current thread
> -=09=09 * context.=C2=A0 However, it still needs to bump
> `s_stack_depth` to
> -=09=09 * avoid kernel stack overflow from nested
> filesystems.
> +=09=09 * context.
> +=09=09 * However, we still need to prevent kernel stack
> overflow due
> +=09=09 * to filesystem nesting: just ensure that
> s_stack_depth is 0
> +=09=09 * to disallow mounting EROFS on stacked
> filesystems.
> +=09=09 * Note: s_stack_depth is not incremented here for
> now, since
> +=09=09 * EROFS is the only fs supporting file-backed
> mounts for now.
> +=09=09 * It MUST change if another fs plans to support
> them, which
> +=09=09 * may also require adjusting
> FILESYSTEM_MAX_STACK_DEPTH.
> =C2=A0=09=09 */
> =C2=A0=09=09if (erofs_is_fileio_mode(sbi)) {
> -=09=09=09sb->s_stack_depth =3D
> -=09=09=09=09file_inode(sbi->dif0.file)->i_sb-
> >s_stack_depth + 1;
> -=09=09=09if (sb->s_stack_depth >
> FILESYSTEM_MAX_STACK_DEPTH) {
> -=09=09=09=09erofs_err(sb, "maximum fs stacking
> depth exceeded");
> +=09=09=09inode =3D file_inode(sbi->dif0.file);
> +=09=09=09if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> +=09=09=09=C2=A0=C2=A0=C2=A0 inode->i_sb->s_stack_depth) {
> +=09=09=09=09erofs_err(sb, "file-backed mounts
> cannot be applied to stacked fses");
> =C2=A0=09=09=09=09return -ENOTBLK;
> =C2=A0=09=09=09}
> =C2=A0=09=09}

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an all-American dishevelled card sharp searching for his wife's
true=20
killer. She's a scantily clad insomniac bounty hunter with an
incredible=20
destiny. They fight crime!=20


