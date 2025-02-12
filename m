Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD1A32A66
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 16:46:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtN2x3J2Fz3blB
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 02:46:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a35"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739375192;
	cv=none; b=Dd8/mpAdtArqCk0nnZ4NmWaccoFSgep4vd+e0+7eJ9r/rrqLTw3DRRzfkRm5ATnT/FCsWNdnjBNtgl15FltqAqeS4+KblcJnFPVJmbzQQHCIumDGpYgbsA72Lj4mSwqY6KHW0JAHtgQLBV3m0Fn2lPjEFtM//OtX09IesC7rvn3n4rgiIZzx+71dC4cPdgLFiMABjcWpjZEgFV1aRTiKBHffkikiVjz/J9hSkVpq6xN4Tmk44S5FywcdbBMtCmw8gHp3fXgAl12RrRSMynMeX+knW9D0KalZdulRDx1XGgMuS1wEdYs8+QMYjDjdvmDVYSn0CU0x7R7ILFwwB1ku5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739375192; c=relaxed/relaxed;
	bh=BKRx6rA6j8Lll2ToKch4l26Y6wZ1aehzxdgKxHRJqkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRTJwf1RrHnjcjGcrWsZcUFvrBqLi3ivIOADXB6n5LLT+6KKfWfAS1FvI/6Jz4SMuBvxER5UxMXpCTE75MFaKx0Oe7YWWla2dUJIufYDChaUzvkxKiEfGD0QibopvpQClxzhvBJnP0TXe0hWPA+Hq1/vPVwlarevGkInWxnOWCOJWzW+7N/+XKItUY7hoFdHjn2tGY55/6ySjMb7r1WN2+1QXDF+xaIDj31dKbPHxzpyGvlVaoHznUDEEDVvgw0Awqm21bOaXCfKaiAJPtoSJJZ+g38A2zkDmKdbzSlAg+1p0jPgvuFN7ZSqlnjsgzMFx5U6rvtwEwu3UoxTDkKrkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cOY6DAOv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cOY6DAOv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtN2v2rX0z2yDD
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 02:46:30 +1100 (AEDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso4149349e0c.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739375188; x=1739979988; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKRx6rA6j8Lll2ToKch4l26Y6wZ1aehzxdgKxHRJqkM=;
        b=cOY6DAOvzJlMicgt1LlmXi2be+oXLnGW0/46joib4gmdQHXRVT5M8CvV6KzpkD3tlA
         GvgjvnwvF69iVSHyYI9qW8raXmKw7z+yUJHPYtRhSKRfgcxOpWDAnZQ1Mtt5Z+X+9ZqD
         GhShvjwFdIrUJfS/O1EomTzQJVhmpq0yEeCd9tPbZPxmCICyZpLIFt6BsIrog4lRT1kU
         nXUOHQ6q/V/lcRr6bNa+WVrFQJ9CPKIYPE4IVPj6MFgbIZpLYQGJGfjhW80RnI9gCzM4
         9WmRCUF5ncYo5jIVqTUJYOClo8lNyiw9ee51d5zlXjW6dyhol8KqHq5qg+BwWab2OSwP
         YzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375188; x=1739979988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKRx6rA6j8Lll2ToKch4l26Y6wZ1aehzxdgKxHRJqkM=;
        b=V0b1kXZRcgtwTcR5NnkeIUm2BMPx1AsBZcF5ohz/VbchVthGsxaA/2ScM/InHpySsT
         YmN5i8dYPIvbrZPjWNgahKyc9jLthCvwbhSBZhm/pKhXvgALxz6ti18ppJ7hfv084wtP
         GerP8b3Xm4/HhqF6Pc4J3lz4+0uMCweaK8ACaCaKyj14VUFdIQGpwXqqDvMxYdWECYfK
         bW7KaXs2/8bVzenxDm1Ttc24ewNzrKn/M8LLZr8MFiBXj1VOQCHFCzK606eOCDb6AjfD
         eE/qlYe41tpAwzTRedpUHYFVXB2yRYYGGoUeMTGt9ZF3r5JckqznRnypOlna6iHZvPJb
         RxsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTqHOw77J/2zA68nIV0Hm6/qNHMBcWTTyC2JDwvgvHvaCbVe/pFvyHFXrpmP/ihSIlg63Ynl40y2wkvw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwS1gG9ZVOYP8nxsjwFowHKp9yBTSoeNTg2QpN4WgpMkcmjPslH
	SeY9qtFl08WA2oqngLMYa8j4jqmTrR8Io3ekym3OlMyXYn8kiWQAPfNcLm7AiRX3UW0TglGWyyO
	W1mZmlpdkGb/TYFRvMcl+mwLOqoM=
X-Gm-Gg: ASbGncuYMWV1whfGHf3dsFmuWcOldJSY+u3EY9uUhS6Pz963PzWLb4BKG747YOr/+am
	QMvVC1N2f0XKw79dkl/lrxopD+y3YDPQie+Lk+jC23lc4onO4B63/Y2MASEyW3BmbDDJ1Ugv0O8
	vrEtQ1tDLhFtKBxXTyqr6o9AJ4lk3Z
X-Google-Smtp-Source: AGHT+IFUXaj7pTxF+MMgx2A3vgbdnaaqDBZCKi1lpvLbMUVAg6VzSFiet0KiSGrIxW7sDjggSm+oP6QQxJUntUpYnuM=
X-Received: by 2002:a05:6122:658b:b0:520:42d3:91ca with SMTP id
 71dfb90a1353d-52067b20b17mr3010344e0c.1.1739375188096; Wed, 12 Feb 2025
 07:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
 <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com> <e16c4550-2a42-40d9-a57a-9be488f89381@linux.alibaba.com>
In-Reply-To: <e16c4550-2a42-40d9-a57a-9be488f89381@linux.alibaba.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Wed, 12 Feb 2025 07:46:16 -0800
X-Gm-Features: AWEUYZkYSt-qan01dEQcZ8ZySJsluC3srYsglELxaBdiBlDAXSsTROq9M9DPYKs
Message-ID: <CABMsoEE1mi2RaUgNU7Q-DxbmMZ-i2hWODJrX1NfxyNKDRv517w@mail.gmail.com>
Subject: Re: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="00000000000037c400062df3d80e"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, Tom Rini <trini@konsulko.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000037c400062df3d80e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, looks good.

Jonathan

On Wed, Feb 12, 2025, 7:33=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.co=
m> wrote:

>
>
> On 2025/2/12 22:17, Jonathan Bar Or wrote:
> > This is good, but may I suggest using __builtin_add_overflow instead?
>
> They are just the same.
>
> erofs-utils follows the kernel style, mostly the kernel doesn't
> directly use __builtin_add_overflow, instead it has a wrapper
> check_add_overflow().
>
> I could use __builtin_add_overflow for u-boot only.
>
> Thanks,
> Gao Xiang
>
> >
> > Jonathan
> >
>

--00000000000037c400062df3d80e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Got it, looks good.</p>
<p dir=3D"ltr">Jonathan</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Feb 12, 2025, 7:33=E2=80=AFAM Gao Xiang &lt;<a href=
=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 2025/2/12 22:17, Jonathan Bar Or wrote:<br>
&gt; This is good, but may I suggest using __builtin_add_overflow instead?<=
br>
<br>
They are just the same.<br>
<br>
erofs-utils follows the kernel style, mostly the kernel doesn&#39;t<br>
directly use __builtin_add_overflow, instead it has a wrapper<br>
check_add_overflow().<br>
<br>
I could use __builtin_add_overflow for u-boot only.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Jonathan<br>
&gt; <br>
</blockquote></div>

--00000000000037c400062df3d80e--
