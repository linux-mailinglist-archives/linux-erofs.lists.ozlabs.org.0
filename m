Return-Path: <linux-erofs+bounces-1462-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B839EC95A44
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 04:24:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKTlw3T59z2ypW;
	Mon, 01 Dec 2025 14:24:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::130"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764559468;
	cv=none; b=Hw8K3zO/FLS1Nb4Wjh6w9D9riL8tpXt2HtuVMNnp/cPeMBIoQvMa2yO48qBZwJDCvFcr9LWU79nBvArKNtg6OsJ6lmHpwyjqGWYipAGIf14VMJy1hCo/VKkrdkmx6Kpe5lW6JudviqwSFemp6nci3iTxv5dMuGOvrVGBqkK7hNmtcaYuLyls71I0vi3xY9OJ88lrtJH1uBvKVVMEgQTB6ggl5MypnAUU0/gXE7cOO/gWQCc1lKi2+8YItiooBi1UQpvvsxXC2J41xZko1Dps/GPDIZBCd8wq/Gm+a1ky+0dFPT3GSwf0EmwbzN8FSg+VbwGXvmSk2X4w3M1+AykYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764559468; c=relaxed/relaxed;
	bh=XaG9kzPDsHc+ptfgC3+RGWq5pqvaUU3p5PoWL5IKK8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKe/w4zRm9sY59svNcTA/lhgqKtMp1CX4h/x9gRVN00KyRc3qJeWpkAJzp49A4hzl8S6SPZ1/RlbkQzbBdQ+ovnRH5FjsRfkJN0KbiJHfJqRBTWr85Rcgz+YbpTP4Lzt3k8mo4fimsAlSt9gXk1iYFkQsXCEkFmOMA0LyKMpfhC74P/7dlhnrALnumR6KQo7BWl9cKtZDTiXCkt1KZJrtPktHrPn01hU4lIHE/1btrHFqOhDOr1camX8ZOWvbda4tQBZwcQavGQLhMr+mpwZF70CUYQIFH2Ae9lLLpEsnxzBj1Qj0gVaUn/kLxAxXZAIuKYiP8Zooo/c92nWNhOnGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ipty8TmN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ipty8TmN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKTlt31d2z2yG3
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 14:24:25 +1100 (AEDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-59578e38613so2353898e87.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Nov 2025 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764559461; x=1765164261; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XaG9kzPDsHc+ptfgC3+RGWq5pqvaUU3p5PoWL5IKK8Y=;
        b=Ipty8TmN/5NaXp4a/pt4EfHN5ST2oYggmmbGd4cR5NzNBoBD0dLK6lBky+J0yNwnlg
         8cd2QA7MpaRiFc/FaEdE4rTJ+j0YjAPdnFSjeZGWZiXo4t6S24Kbdo3WNQm3LCvGVKau
         8dCwFP3Z/LVgtMHKRMnuIM7w1LmB33r6glQNBcIep4ZDRDb/KvoeCfA0JGy4viCleZEA
         GAZeZ2DWbhkRUwbL9FatA5bmLORN83VXk5ZrIg2g2cavZt7CHFQIfj6SjlQIfN+RB9Rw
         5Y0mDvEhQPbhCZZbx7TsytIbjGWoEm/1az4ywGvghRNdKaUupkVjChnZu52uya+I0pPh
         DOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764559461; x=1765164261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaG9kzPDsHc+ptfgC3+RGWq5pqvaUU3p5PoWL5IKK8Y=;
        b=EwyoyCzIOBnr5BxMvg7+0f7MQxEUIaZ/Qno94NvJGc3yVdyMs/0MK5FaPoveuacJhb
         ZrAqh7BW9FaatC9I5t8/4lJgx5SZbZNgtd7ZvCLl0cve40fZADbp/tqOcuB0/qx9TOJm
         IMrTRFcJ7/OC8XV+6XgbLwFvCBSTee0T/Q7qDVKW7AqAbyeW5I1J3G5pWSjbMt3uhrux
         OXUlgEYyOrZsIYKgGVJtVFuHSB+H9mgDXC36yCePZpIUIsFCZb9hY5EHTGgHq+PryHv3
         RkKCw2ZfevC3ccVFRb8dgnqkz1Np6xDJztDGcE6LPBNfM2GiPpBLjTV3Q8JaB6817m3B
         XzQg==
X-Gm-Message-State: AOJu0YxK52ht5K2GyNMH2QggwaWSp+f4gOeJOoO9c4zzzGXslkZ3V1H0
	Lv44BR7TU4q1RGfb+1rQCljLXYHF4FkbXEnp6Exh2Ig5P4aTAEMrifBmsQPM6TvXIn+U+b1X7e9
	wOAgIZAGsFOzg014fiwVrqXlbuOFSAA8=
X-Gm-Gg: ASbGncsKw1nKqAqmcwJDzDFIunApPHaqh55kIBe+DCEdY75ZcVZkRMp99aTOwrh0w0T
	xkiY0/RoKMvvl2cQ7KqJzbDNj+Lt7auICvpv6/gduAJ33vG5Ajfr9eoROLZIxTAaXPARd2ZS3nn
	loHTDjmeZYj8IYx1WF0W/7+pyjXcnATfWBu2E9q+pnuonnoUXRL7DpQTakhXx7+nkXv3Gq4ci6/
	BEAAXV6nks938Y+DfkRXBY0G+iB34Ocib7ffMJ1pBY+4vqFwz+fnzhB3t2qUO5R9QEAJLhkSQA+
	xg8A
X-Google-Smtp-Source: AGHT+IGy/vgkR3RirOFkj6XmpOMCLcyMTabqgM4hBqXwq43Jxt/UWrqruBfqiOk4QqdfSJpCujSyhHdS+AhLbzEK8wA=
X-Received: by 2002:a05:6512:ac4:b0:594:5236:282d with SMTP id
 2adb3069b0e04-596b4e4b778mr8446115e87.4.1764559460463; Sun, 30 Nov 2025
 19:24:20 -0800 (PST)
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
References: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
From: Yue Hu <zbestahu@gmail.com>
Date: Mon, 1 Dec 2025 11:24:08 +0800
X-Gm-Features: AWmQ_bnSkPENCtVZMIz79l83bps9u887KasFDQByjeIh0CGze7bKvFFMYgNsfEs
Message-ID: <CAKC7Hs9_SoHOcbG+jEDRkN6d1ezQUWDEX3WdL=qvSYbcap4POg@mail.gmail.com>
Subject: Re: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000d379dc0644db8385"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--000000000000d379dc0644db8385
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Yue Hu <zbestahu@gmail.com>

On Mon, Dec 1, 2025 at 10:38=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com>
wrote:

> Switch to the permissive MIT license to make the EROFS on-disk format
> more interoperable across various use cases.
>
> It was previously recommended by the Composefs folks, for example:
> https://github.com/composefs/composefs/pull/216#discussion_r1356409501
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 3d5738f80072..e24268acdd62 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> +/* SPDX-License-Identifier: MIT */
>  /*
>   * EROFS (Enhanced ROM File System) on-disk format definition
>   *
> --
> 2.43.5
>
>
>

--000000000000d379dc0644db8385
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Yue Hu &lt;<a href=3D"mailto:zbestahu@gmail.com"=
>zbestahu@gmail.com</a>&gt;</div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 1, 2025 at 10:=
38=E2=80=AFAM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">=
hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Switch to the permissive MIT license to make the=
 EROFS on-disk format<br>
more interoperable across various use cases.<br>
<br>
It was previously recommended by the Composefs folks, for example:<br>
<a href=3D"https://github.com/composefs/composefs/pull/216#discussion_r1356=
409501" rel=3D"noreferrer" target=3D"_blank">https://github.com/composefs/c=
omposefs/pull/216#discussion_r1356409501</a><br>
<br>
Signed-off-by: Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com"=
 target=3D"_blank">hsiangkao@linux.alibaba.com</a>&gt;<br>
---<br>
=C2=A0fs/erofs/erofs_fs.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h<br>
index 3d5738f80072..e24268acdd62 100644<br>
--- a/fs/erofs/erofs_fs.h<br>
+++ b/fs/erofs/erofs_fs.h<br>
@@ -1,4 +1,4 @@<br>
-/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */<br>
+/* SPDX-License-Identifier: MIT */<br>
=C2=A0/*<br>
=C2=A0 * EROFS (Enhanced ROM File System) on-disk format definition<br>
=C2=A0 *<br>
-- <br>
2.43.5<br>
<br>
<br>
</blockquote></div>

--000000000000d379dc0644db8385--

