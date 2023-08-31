Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325678E97C
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 11:34:04 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=bggoKpyh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rbww92q5gz30fF
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 19:34:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=bggoKpyh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=daan.j.demeyer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rbww55F0zz2xjw
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 19:33:55 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5654051b27fso492666a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693474430; x=1694079230; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EmRkytoPf6VSmePcIhOH4M8AeHVJLU+nnd218jpJ1BA=;
        b=bggoKpyhSy0meQLoMUsy5ftC6xyWF0L5gWMO5EyTeiqkliW/0c5L1KFiTMHVQKOlKo
         qCeXMgwcOTRdnxJuLyEFOL1dGwKd+zgNzSEs+dgvxVAh/YwEimz/tRruYxacMlINNqzU
         0TTYhxqL1mQhDzXPpXHhsitOowA8S2Wckp/cLm8WHttgt5EdIQuK8Aw2feBdutk/17kp
         p7d2N7o7ePlzjS820C9Br64Rpud/rFg4LsZe4IkzZCL6YrPcLYdd8rk/v46vrq3uH6X2
         /KVMBz1chy7nlYArRErmGKaKYgZlxzjTBV7Luia+qxULE98g7KhQv5lgrKvVNALp25wr
         PKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693474430; x=1694079230;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmRkytoPf6VSmePcIhOH4M8AeHVJLU+nnd218jpJ1BA=;
        b=e98GsN3milUpYqtxuxoVWrooGfvOwQqTmVsPQAHyrcz6bFxgmKWiABYp82nWHyHF/D
         Bey200vuFTzCeeNXDekVyJB83srWG87rEz3u4WS020ipu71KxomlhkvQeW4/R8kr7O2a
         6cGoqwnz77mPB0SQ3XHnLm7FYFuWB1gpo641qGMwSYUpPQ1jkZZjjKI86mdz4GgKTkRA
         t3rSpvXWvZyQMXDTZKZMs6pCcD3KMIP1T6kd+lGWCum+VLlgL7Rpor8gEHuQu4V4lap5
         Y+jmkfTTC+R/SGQWdSp3/ZEBRP7GbF//ANAiHZCuDxA0JXdeGiwetaaIAGLTM5w7DUeN
         AZuQ==
X-Gm-Message-State: AOJu0YzOJzFjqlSWGOAbc25mFIHQbFOWQsANAN9MTBfb29INIJPR4C8x
	nWZDgkstREdXrQyFPnzyJxUkO+kClPyuFOPF07217bS5EIYGiaoJ
X-Google-Smtp-Source: AGHT+IF4G1UNCk87B4seTdAg0W7GMy44Cy6rFQsVReZvcKAIA8/t1VqTRK1ee9d6B+KOyUBzx2IVafgQZV546O4uuyc=
X-Received: by 2002:a17:90a:f18f:b0:26b:4e59:57e7 with SMTP id
 bv15-20020a17090af18f00b0026b4e5957e7mr4401639pjb.43.1693474430444; Thu, 31
 Aug 2023 02:33:50 -0700 (PDT)
MIME-Version: 1.0
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 31 Aug 2023 11:33:39 +0200
Message-ID: <CAO8sHcmZZORnrJXA=QzmGkYNkNWn7M+amAK_DZ19-WL4kLUvpw@mail.gmail.com>
Subject: Optimizing write_uncompressed_file_from_fd()
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000dce762060434bd6a"
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

--000000000000dce762060434bd6a
Content-Type: text/plain; charset="UTF-8"

Hi,

For hacking on systemd, we build disk images using mkosi, and use an erofs
filesystem for the /usr directory. When hacking on systemd, we would like
to be able to rebuild the disk image as fast as possible. One part of
rebuilding the image that takes a while is generating the erofs filesystem.
I had a look at the mkfs source code for erofs and noticed that in
write_uncompressed_file_from_fd(), there is no usage of FICLONERANGE or
copy_file_range() to speed up copying data from the filesystem to the erofs
filesystem. Would it be possible to use either of these to make copying
data in mkfs.erofs faster when the data does not need to be compressed?

Cheers,

Daan De Meyer

--000000000000dce762060434bd6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>For hacking on systemd, =
we build disk images using mkosi, and use an erofs filesystem for the /usr =
directory. When hacking on systemd, we would like to be able to rebuild the=
 disk image as fast as possible. One part of rebuilding the image that take=
s a while is generating the erofs filesystem. I had a look at the mkfs sour=
ce code for erofs and noticed that in <br>write_uncompressed_file_from_fd()=
, there is no usage of FICLONERANGE or copy_file_range() to speed up copyin=
g data from the filesystem to the erofs filesystem. Would it be possible to=
 use either of these to make copying data in mkfs.erofs faster when the dat=
a does not need to be compressed?</div><div><br></div><div>Cheers,</div><di=
v><br></div><div>Daan De Meyer<br></div></div>

--000000000000dce762060434bd6a--
