Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0797DC5B
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 11:18:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X9kG55PSNz2yVj
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 19:18:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726910331;
	cv=none; b=iZtGfEENd36b7sUV/l1QJY5FiqqPzN9U3BKkl1xx9vtjnvxeNXW7G7dflJQKzIq5Q6a+r+XFtLnswsJfefX4NQ3LUfb2xiW8iehwDNd1aPRMr4I5dLCNoYDkid6q9V7ic0wYFxBKg+XeQBVn0njdL0rH1oVZsSsiBc1iYMVXSU5Q1circdgszkjJrpWs3IEDKrziYkxSAW/wBEHJdJKYPV6YKMRw/Yoi+ZjA/xSmLWSVoJmh0zeNKMQQetfvc02aacgALQMmFB2PLdLa5Kpob2j1rupRlTZG4aePlyhm6aB47nVk44i6Kih4jhMA6GOSAqomByX+2AK+YyMaf0bdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726910331; c=relaxed/relaxed;
	bh=mQlfqEKo0HNQmfqcfRxBIAuCZS7UpLwuphyfvK1E0MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuB88xVRcq62WLkG1otc6FonJcwWSpySTnFRYnS8FI3qRbYMmy9XmpifpgAlNq+eCnD6wq8iQk5iqcf1MSulKbUUXEh/H4ZclG8+10hipinP22BimjvzxUhD7evHEALKowvnyDjBSKu23Ult5UmwKLBZvOSZu2Ajj+da9z7tuif4vsNvcZBSUqL16UsA9wKE5LcnTmBskpaudR1ihhRCZ1FWE39qa/tXCOVbqyO7tm8s7XpRppejWzxqsbiqxzsSIOUHXXIeFAC5E02awhIepAUvD+gYMzdtRsA+gxn/dgN7CDPmfmEfce0L4U5INegzr2EV1EITHKY7d2EQZDt7bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hQ1RqOQq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hQ1RqOQq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X9kG313p6z2xmZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 19:18:50 +1000 (AEST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-6d6891012d5so23175537b3.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726910325; x=1727515125; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQlfqEKo0HNQmfqcfRxBIAuCZS7UpLwuphyfvK1E0MU=;
        b=hQ1RqOQquEnX3akKuEy1/JiQ8kOyZnhPr96cmh8QHEKB8JlBtIvUt9StMzlQ/Oi0cH
         KB0LS/y/spe7JK/s7WGNJSXSzd4W7XxZfb62QgfxS8fMAkbGh/+bsR8x5f5Q/Ief71pI
         vkIguRcwFZh76hb3dgG8C8sZgJcIpYF2HfSfbskFISMEIS+tB8qMeChOG8xP0k3DSMuV
         h4YCUedv8KPPpxdZBx0O1SCQriSWuvWF41yP2Cc0NJU4vvvWJ0eKr83b8Wgz/QO7T6tr
         PUEHRlEMeiotpp9W9TWH0RW1sY+yEXsBIDCbW/DpEypzCzUKkuGPpkUwhZMUPMyDPpGx
         wFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726910325; x=1727515125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQlfqEKo0HNQmfqcfRxBIAuCZS7UpLwuphyfvK1E0MU=;
        b=D61CPRUr4F32fluP3rXQ573PM0shrVGoYdtaeCYc9Q8nh6CyhRvNy1BwE2Vd2zdo/U
         Pk2prGgZU9duy+YClfor0S/czqCvcJefU1blKnvE8n3P9GIOHWBMe5pLQXJHDPLVM1zS
         ViSHHQFSPOJeSZwgVYh7rPciy5cWuMnFlLWllwz78gu0IzB3f1crqGuw7TZ7+k5xoTL7
         ZdMqfHGzD1LDasTJxoNiy9mYVO3UYpGgADC8nnAo6wieZ1dU/MOh1CdnpJCVl2qyvErk
         IfKTMOoSTP6bVrdKkKDVZzXHxSuhvP8Nu8ISvUvnMMo+Mh89UkLRyRb7/XJkdCUfcYTd
         Sq3A==
X-Gm-Message-State: AOJu0YwH12wdXypF2+DYm9DRbXx+mZdjN4VUuIF4UUOW15qiVNkBzQYw
	KwWseK4blWQG7xw+y+2cLMHcR+kIlfVoQ0RYP8q1RGav59+hIMxIHjVLTcdndjk9B3cHokmNsQT
	MKD5BpGNR01wNlsfpEadV3O51HFw=
X-Google-Smtp-Source: AGHT+IEH5NeBSIjHHJhC6ua7HRL6Fq8ZDgEnCbyXKlVdFyzkBMNgnnt617vekaPtsDaTmp7zUtq9NMCVx+azm0CohxY=
X-Received: by 2002:a05:690c:668d:b0:63b:d055:6a7f with SMTP id
 00721157ae682-6dff2d2c893mr48269317b3.38.1726910324940; Sat, 21 Sep 2024
 02:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240916135634.98554-1-toolmanp@tlmp.cc> <20240916135634.98554-9-toolmanp@tlmp.cc>
In-Reply-To: <20240916135634.98554-9-toolmanp@tlmp.cc>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Sat, 21 Sep 2024 17:18:29 +0800
Message-ID: <CAJfKizqAN99fGjVY-x7qF4XCdNZ2xLkgw_FGB8nUx53iWDf2gg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/24] erofs: add device data structure in Rust
To: Yiyang Wu <toolmanp@tlmp.cc>
Content-Type: multipart/alternative; boundary="0000000000007a274506229da408"
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000007a274506229da408
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org> =E4=BA=8E2024=E5=
=B9=B49=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80
21:57=E5=86=99=E9=81=93=EF=BC=9A

> This patch introduce device data structure in Rust.
> It can later support chunk based block maps.
>
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>  fs/erofs/rust/erofs_sys.rs         |  1 +
>  fs/erofs/rust/erofs_sys/devices.rs | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 fs/erofs/rust/erofs_sys/devices.rs
>
> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> index 8cca2cd9b75f..f1a1e491caec 100644
> --- a/fs/erofs/rust/erofs_sys.rs
> +++ b/fs/erofs/rust/erofs_sys.rs
> @@ -25,6 +25,7 @@
>
>  pub(crate) mod alloc_helper;
>  pub(crate) mod data;
> +pub(crate) mod devices;
>  pub(crate) mod errnos;
>  pub(crate) mod inode;
>  pub(crate) mod superblock;
> diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys=
/
> devices.rs
> new file mode 100644
> index 000000000000..097676ee8720
> --- /dev/null
> +++ b/fs/erofs/rust/erofs_sys/devices.rs
> @@ -0,0 +1,28 @@
> +// Copyright 2024 Yiyang Wu
> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> +
> +use alloc::vec::Vec;
> +
> +/// Device specification.
> +#[derive(Copy, Clone, Debug)]
> +pub(crate) struct DeviceSpec {
> +    pub(crate) tags: [u8; 64],
>

I think we don't need to keep tags in the memory. It's not used in flatdev
mode
or when mount with "-o device". It can be replaced with a string like the C
version,
since it may represent a file path of variable length, or ignore this field
for now.

Thanks,
Jianan


> +    pub(crate) blocks: u32,
> +    pub(crate) mapped_blocks: u32,
> +}
> +
> +/// Device slot.
> +#[derive(Copy, Clone, Debug)]
> +#[repr(C)]
> +pub(crate) struct DeviceSlot {
> +    tags: [u8; 64],
> +    blocks: u32,
> +    mapped_blocks: u32,
> +    reserved: [u8; 56],
> +}
> +
> +/// Device information.
> +pub(crate) struct DeviceInfo {
> +    pub(crate) mask: u16,
> +    pub(crate) specs: Vec<DeviceSpec>,
> +}
> --
> 2.46.0
>
>

--0000000000007a274506229da408
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Yiyang Wu via Linux-erofs &lt;<a href=
=3D"mailto:linux-erofs@lists.ozlabs.org">linux-erofs@lists.ozlabs.org</a>&g=
t; =E4=BA=8E2024=E5=B9=B49=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 21:57=E5=
=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This patch introduce device data structure in Rust.<br>
It can later support chunk based block maps.<br>
<br>
Signed-off-by: Yiyang Wu &lt;<a href=3D"mailto:toolmanp@tlmp.cc" target=3D"=
_blank">toolmanp@tlmp.cc</a>&gt;<br>
---<br>
=C2=A0fs/erofs/rust/<a href=3D"http://erofs_sys.rs" rel=3D"noreferrer" targ=
et=3D"_blank">erofs_sys.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +=
<br>
=C2=A0fs/erofs/rust/erofs_sys/<a href=3D"http://devices.rs" rel=3D"noreferr=
er" target=3D"_blank">devices.rs</a> | 28 ++++++++++++++++++++++++++++<br>
=C2=A02 files changed, 29 insertions(+)<br>
=C2=A0create mode 100644 fs/erofs/rust/erofs_sys/<a href=3D"http://devices.=
rs" rel=3D"noreferrer" target=3D"_blank">devices.rs</a><br>
<br>
diff --git a/fs/erofs/rust/<a href=3D"http://erofs_sys.rs" rel=3D"noreferre=
r" target=3D"_blank">erofs_sys.rs</a> b/fs/erofs/rust/<a href=3D"http://ero=
fs_sys.rs" rel=3D"noreferrer" target=3D"_blank">erofs_sys.rs</a><br>
index 8cca2cd9b75f..f1a1e491caec 100644<br>
--- a/fs/erofs/rust/<a href=3D"http://erofs_sys.rs" rel=3D"noreferrer" targ=
et=3D"_blank">erofs_sys.rs</a><br>
+++ b/fs/erofs/rust/<a href=3D"http://erofs_sys.rs" rel=3D"noreferrer" targ=
et=3D"_blank">erofs_sys.rs</a><br>
@@ -25,6 +25,7 @@<br>
<br>
=C2=A0pub(crate) mod alloc_helper;<br>
=C2=A0pub(crate) mod data;<br>
+pub(crate) mod devices;<br>
=C2=A0pub(crate) mod errnos;<br>
=C2=A0pub(crate) mod inode;<br>
=C2=A0pub(crate) mod superblock;<br>
diff --git a/fs/erofs/rust/erofs_sys/<a href=3D"http://devices.rs" rel=3D"n=
oreferrer" target=3D"_blank">devices.rs</a> b/fs/erofs/rust/erofs_sys/<a hr=
ef=3D"http://devices.rs" rel=3D"noreferrer" target=3D"_blank">devices.rs</a=
><br>
new file mode 100644<br>
index 000000000000..097676ee8720<br>
--- /dev/null<br>
+++ b/fs/erofs/rust/erofs_sys/<a href=3D"http://devices.rs" rel=3D"noreferr=
er" target=3D"_blank">devices.rs</a><br>
@@ -0,0 +1,28 @@<br>
+// Copyright 2024 Yiyang Wu<br>
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later<br>
+<br>
+use alloc::vec::Vec;<br>
+<br>
+/// Device specification.<br>
+#[derive(Copy, Clone, Debug)]<br>
+pub(crate) struct DeviceSpec {<br>
+=C2=A0 =C2=A0 pub(crate) tags: [u8; 64],<br></blockquote><div><br></div><d=
iv>I think we don&#39;t need to keep tags in the memory. It&#39;s not used =
in flatdev mode <br>or when mount with &quot;-o device&quot;. It can be rep=
laced with a string like the C version, <br>since it may represent a file p=
ath of variable length, or ignore this field for now.<br></div><div><br></d=
iv><div>Thanks,</div><div>Jianan</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 pub(crate) blocks: u32,<br>
+=C2=A0 =C2=A0 pub(crate) mapped_blocks: u32,<br>
+}<br>
+<br>
+/// Device slot.<br>
+#[derive(Copy, Clone, Debug)]<br>
+#[repr(C)]<br>
+pub(crate) struct DeviceSlot {<br>
+=C2=A0 =C2=A0 tags: [u8; 64],<br>
+=C2=A0 =C2=A0 blocks: u32,<br>
+=C2=A0 =C2=A0 mapped_blocks: u32,<br>
+=C2=A0 =C2=A0 reserved: [u8; 56],<br>
+}<br>
+<br>
+/// Device information.<br>
+pub(crate) struct DeviceInfo {<br>
+=C2=A0 =C2=A0 pub(crate) mask: u16,<br>
+=C2=A0 =C2=A0 pub(crate) specs: Vec&lt;DeviceSpec&gt;,<br>
+}<br>
-- <br>
2.46.0<br>
<br>
</blockquote></div></div>

--0000000000007a274506229da408--
