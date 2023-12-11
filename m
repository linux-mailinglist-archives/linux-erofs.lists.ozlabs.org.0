Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7480CB53
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Dec 2023 14:46:58 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KAKGMVM+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlQUe2d7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Spjht5Y0Pz30g2
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 00:46:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KAKGMVM+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlQUe2d7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=ecurtin@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Spjhk0htCz2yyT
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 00:46:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702302399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IFsLeKW3DW6BmxUhVRH0V3zQ/xj1O1MUYot7lQD78gA=;
	b=KAKGMVM+aaLG+Z/tHzo+nAYkQtFNFw0TxP/umL9W6adG//OUMcBdyHs2PIVSG91lOJyYnC
	EX6+zj706+EN2ZaBUzp7AHjDp7wXeE8pKM0/4Kohj8mjKmie+5VdQ29ubSrgDKzy/CW7go
	gl3hmagqCN9uFy1SSt+Vd8B/hFRb5Hw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702302400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IFsLeKW3DW6BmxUhVRH0V3zQ/xj1O1MUYot7lQD78gA=;
	b=WlQUe2d7PLz03wTJDIjO4Q9r0kzAaUdCrVteOfqiC7pezBLRmZzdqfIlf/q7zhNp78Ol1g
	y4Hxte0cMZq5KCDrRldAK8GAa1pgL5E/iL6kOLIp64oT5wSHJxa6KrRySaiZk0EnBVEZw1
	Cie7Rq2jcdHyIEgVX3H3tTXXzgyQtOU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-XYkcpqrROce6byiizW7D9g-1; Mon, 11 Dec 2023 08:46:36 -0500
X-MC-Unique: XYkcpqrROce6byiizW7D9g-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c66a69ec8eso3967622a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Dec 2023 05:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302395; x=1702907195;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFsLeKW3DW6BmxUhVRH0V3zQ/xj1O1MUYot7lQD78gA=;
        b=RJwOSc0agHcZ9Ul5inbDYpDRbUxv24Ew5i+wRpOED5TqubF6zpavZGvSnQSXoxxRCW
         0t7D+X0hk/umRcTZXDFXYg63fwQXq7gHFC3rtJeNvrbwovvYlJhB2PWyNT4Qs9dU9Sgn
         5fYLUOLx7p4OtOIjSOAIzpTF65j6DNtMHX4k5UC9n0fNVL0d1oi7rNO3/W5xWVxCCUK2
         9GEkdGLSp75WpBTltJ71wwqeTTtjmEI5ygKuD69h4MQLfqTP7jjCNC9u83W9DiYW2KCo
         xSTtSFckWkpi8DQjDK5PFnPQuNtBD//b/pFd9XhJbovZEmygJ+n4XoVbGVQtxEV3vGiW
         Gn1A==
X-Gm-Message-State: AOJu0YzjmEz+erJz/mm0tBQz5ojzZnUpIdoF4pbRvRVWQ9tg4peGw1ox
	sDDr8SAEFlCfUU9SCCat1b+XHmyaFMhJKy2ifKWFW0jAD8taCpB1+KdbpLHqW7287ZXu6EqdUDY
	uBnG2eo5kAow1EkRkLN+uSusmEDOVDQnTHLrHYeQG
X-Received: by 2002:a05:6a20:1604:b0:190:3b35:5999 with SMTP id l4-20020a056a20160400b001903b355999mr6160570pzj.9.1702302395309;
        Mon, 11 Dec 2023 05:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz/VpW74q862C/8B1Zq9q8sq1pAy3bkDkccmDflRYHJXOso3iqCrr4R+jnoGZVXq44EchwL0IzwxnZXOgg+J8=
X-Received: by 2002:a05:6a20:1604:b0:190:3b35:5999 with SMTP id
 l4-20020a056a20160400b001903b355999mr6160548pzj.9.1702302394991; Mon, 11 Dec
 2023 05:46:34 -0800 (PST)
MIME-Version: 1.0
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 11 Dec 2023 13:45:58 +0000
Message-ID: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
Subject: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Colin Walters <walters@redhat.com>, Lokesh Mandvekar <lmandvek@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, Brian Masney <bmasney@redhat.com>, Daniel Walsh <dwalsh@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, Pavol Brilla <pbrilla@redhat.com>, Eric Chanudet <echanude@redhat.com>, Alexander Larsson <alexl@redhat.com>, Lennart Poettering <lennart@poettering.net>, Neal Gompa <neal@gompa.dev>, Douglas Landgraf <dlandgra@redhat.com>, Luca Boccassi <bluca@debian.org>, =?UTF-8?B?UGV0ciDFoGFiYXRh?= <psabata@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi All,

We have recently been working on something called initoverlayfs, which
we sent an RFC email to the systemd and dracut mailing lists to gather
feedback. This is an exploratory email as we are unsure if a solution
like this fits in userspace or kernelspace and we would like to gather
feedback from the community.

To describe this briefly, the idea is to use erofs+overlayfs as an
initial filesystem rather than an initramfs. The benefits are, we can
start userspace significantly faster as we do not have to unpack,
decompress and populate a tmpfs upfront, instead we can rely on
transparent decompression like lz4hc instead. What we believe is the
greater benefit, is that we can have less fear of initial filesystem
bloat, as when you are using transparent decompression you only pay
for decompressing the bytes you actually use.

We implemented the first version of this, by creating a small
initramfs that only contains storage drivers, udev and a couple of 100
lines of C code, just enough userspace to mount an erofs with
transient overlay. Then we build a second initramfs which has all the
contents of a normal everyday initramfs with all the bells and
whistles and convert this into an erofs.

Then at boot time you basically transition to this erofs+overlayfs in
userspace and everything works as normal as it would in a traditional
initramfs.

The current implementation looks like this:

```
From the filesystem perspective (roughly):

fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs

From the process perspective (roughly):

fw -> bootloader -> kernel -> storage-init   -> init ----------------->
```

But we have been asking the question whether we should be implementing
this in kernelspace so it looks more like:

```
From the filesystem perspective (roughly):

fw -> bootloader -> kernel -> initoverlayfs -> rootfs

From the process perspective (roughly):

fw -> bootloader -> kernel -> init ----------------->
```

The kind of questions we are asking are: Would it be possible to
implement this in kernelspace so we could just mount the initial
filesystem data as an erofs+overlayfs filesystem without unpacking,
decompressing, copying the data to a tmpfs, etc.? Could we memmap the
initramfs buffer and mount it like an erofs? What other considerations
should be taken into account?

Echo'ing Lennart we must also "keep in mind from the beginning how
authentication of every component of your process shall work" as
that's essential to a couple of different Linux distributions today.

We kept this email short because we want people to read it and avoid
duplicating information from elsewhere. The effort is described from
different perspectives in the systemd/dracut RFC email and github
README.md if you'd like to learn more, it's worth reading the
discussion in the systemd mailing list:

https://marc.info/?l=systemd-devel&m=170214639006704&w=2

https://github.com/containers/initoverlayfs/blob/main/README.md

We also received feedback informally in the community that it would be
nice if we could optionally use btrfs as an alternative.

Is mise le meas/Regards,

Eric Curtin

