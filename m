Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72C7E2EC4
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Nov 2023 22:15:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lI6vEV0l;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SPPK24Dggz3bYx
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 08:15:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lI6vEV0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=pavel.otchertsov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SPPJs6Pjkz2xQG
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Nov 2023 08:15:39 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-280260db156so4602227a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Nov 2023 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699305335; x=1699910135; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7r1X1SaQd5eHEJpl3I3x05O/4xUJPQ0nfL+t6tL/ss=;
        b=lI6vEV0lzHAf0IF0h3S9axPWprxTRtUD5QdFo5O90yzSQffTlIlZJhfHEgbIMx3Koo
         3yMCue8+dNThHQfuWqBVgQDwhq7MLyl0OR/M008RpqFofuYzWtvROmn1HRLnPVtbX38x
         pi6F7ETRGnPWuwPffVeN+WXFrBUPkml6iPi/rHa395MGZhXGn0axIaTTmVmqYJ7Jt3ew
         2OS+4G/KOEpGP1j9+xOEu5DzPY5lfdF3oBMkS3lhmK11hxHCy5n0HGgqodf8iGvMFhJI
         RiGD5/JQmKdqZ6MU5sIMOQWV2ttFWbobINr7SyBfKVL0gJq86oE8salNldfLaHArDrvb
         BFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305335; x=1699910135;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7r1X1SaQd5eHEJpl3I3x05O/4xUJPQ0nfL+t6tL/ss=;
        b=dvQnIQnVyrcrGiFAKNaLyqLQS8ffraYet7ii9vEpIU0VFB0kfcnL32+AgnnSaNCqzZ
         6qQdbiu5pJKCvV+72SXM1kgUkyguUGnv+yRACPehsmxcdMt42nKrC2qkZNT0bBHR8h3s
         Q1g6U+enQM3mMTu72jjtwyck/O2C7Tz+bAXC9ZidoZ1Q95XA+p962c7XFMyAvgX0OKTo
         QF/ISpOuN7kCstPW/THWIZNYxghps3XlE3RvGCsYJ8m5DDDlcvucvInQ4AzSUdGaQGt5
         WFvV/+xH6yGgdjNaoyhdgHHZUbf0EgIMteVqHgkf+vlZvnW49bkCpMb/JD7C7pds2Ed+
         XJgg==
X-Gm-Message-State: AOJu0Yy6MeW5o7SyNGoKBnxSB3NYKbFp0xTvf9pAzNYkxI+DyI4pPTKm
	yA85IGM+mlPaRPiK1RflMcH2a/09ldYFLJKaiRY/4JXTN91llQ4=
X-Google-Smtp-Source: AGHT+IGFD2IyOiYgbBqJgrCW3PQNSTjkD+AX3lGDgJHoI2e2HhFLjdB114yUFGQl5y4ZbFmNDaHFvDP+1zoGUK6BD/k=
X-Received: by 2002:a17:90b:3107:b0:27d:348:94a8 with SMTP id
 gc7-20020a17090b310700b0027d034894a8mr28434848pjb.6.1699305335201; Mon, 06
 Nov 2023 13:15:35 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?0J/QsNCy0LXQuyDQntGC0YfQtdGA0YbQvtCy?= <pavel.otchertsov@gmail.com>
Date: Tue, 7 Nov 2023 03:15:24 +0600
Message-ID: <CAAxnTOGTD2NkKnBphZ+vEr7NVnWvT0u02E+c8pN8ZVFcXp5uhg@mail.gmail.com>
Subject: Feature Request: Add --offset option to mkfs.erofs
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000dea8fb0609825a7f"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000dea8fb0609825a7f
Content-Type: text/plain; charset="UTF-8"

Dear EROFS Developers,

I hope this message finds you well. I am reaching out to propose a feature
addition to the `erofs-utils` that I believe could benefit many users,
including myself.

As you know, `mksquashfs` offers an `-offset` option which allows users to
specify an offset in the file where the filesystem will begin.
This feature is particularly useful for embedding the SquashFS image into
firmware images or other specific scenarios where filesystems must coexist
with different data structures in a single image.

Currently, `mkfs.erofs` does not seem to support an equivalent option,
which limits its utility in scenarios similar to those where `mksquashfs`
is used.
The addition of an `--offset` option to `mkfs.erofs` could provide users
with the flexibility to specify the starting offset of the filesystem
within an image file.

The syntax for this could be as straightforward as:

```sh
Copy code
mkfs.erofs --offset=<offset-in-bytes> <destination-img> <source-directory>
```

This feature would align EROFS's functionality more closely with SquashFS,
potentially broadening its use cases and adoption.

Currently, I can achieve a similar result by first creating an image file
with the desired offset using `truncate`, and then concatenating the
filesystem image to the offset image using `cat`, like so:

```sh
truncate -s <offset-in-bytes> image_with_offset.img
cat erofs.img >> image_with_offset.img
```

However, this method is more cumbersome and less efficient than having an
integrated option in `mkfs.erofs`.
Implementing an `--offset` option would streamline the process and offer a
more elegant and direct approach.

I understand that such features require time and resources to implement,
and I appreciate the effort that goes into maintaining and improving
open-source software.
I believe this feature could enhance EROFS's utility for many users and
look forward to any possibility of its inclusion in future releases.

Thank you for your consideration and for the work you do to develop and
maintain EROFS. Please let me know if I can provide further information or
assist in any way.

Best regards,
Pavel Otchertsov <pavel.otchertsov@gmail.com>

--000000000000dea8fb0609825a7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear EROFS Developers,<br><br>I hope this message finds yo=
u well. I am reaching out to propose a feature addition to the `erofs-utils=
` that I believe could benefit many users, including myself.<br><br>As you =
know, `mksquashfs` offers an `-offset` option which allows users to specify=
 an offset in the file where the filesystem will begin.<div>This feature is=
 particularly useful for embedding the SquashFS image into firmware images =
or other specific scenarios where filesystems must coexist with different d=
ata structures in a single image.<br><br>Currently, `mkfs.erofs` does not s=
eem to support an equivalent option, which limits its utility in scenarios =
similar to those where `mksquashfs` is used.</div><div>The addition of an `=
--offset` option to `mkfs.erofs` could provide users with the flexibility t=
o specify the starting offset of the filesystem within an image file.<br><b=
r>The syntax for this could be as straightforward as:</div><div><br>```sh<b=
r>Copy code<br>mkfs.erofs --offset=3D&lt;offset-in-bytes&gt; &lt;destinatio=
n-img&gt; &lt;source-directory&gt;</div><div>```</div><div><br>This feature=
 would align EROFS&#39;s functionality more closely with SquashFS, potentia=
lly broadening its use cases and adoption.<br><br>Currently, I can achieve =
a similar result by first creating an image file with the desired offset us=
ing `truncate`, and then concatenating the filesystem image to the offset i=
mage using `cat`, like so:<br><br>```sh<br>truncate -s &lt;offset-in-bytes&=
gt; image_with_offset.img<br>cat erofs.img &gt;&gt; image_with_offset.img<b=
r>```</div><div><br></div><div>However, this method is more cumbersome and =
less efficient than having an integrated option in `mkfs.erofs`.</div><div>=
Implementing an `--offset` option would streamline the process and offer a =
more elegant and direct approach.<br><br>I understand that such features re=
quire time and resources to implement, and I appreciate the effort that goe=
s into maintaining and improving open-source software.</div><div>I believe =
this feature could enhance EROFS&#39;s utility for many users and look forw=
ard to any possibility of its inclusion in future releases.<br><br>Thank yo=
u for your consideration and for the work you do to develop and maintain ER=
OFS. Please let me know if I can provide further information or assist in a=
ny way.<br><br>Best regards,<br>Pavel Otchertsov &lt;<a href=3D"mailto:pave=
l.otchertsov@gmail.com">pavel.otchertsov@gmail.com</a>&gt;</div></div>

--000000000000dea8fb0609825a7f--
