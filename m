Return-Path: <linux-erofs+bounces-2727-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIcgIce1t2l0UgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2727-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:48:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18100295CD6
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:48:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ6dv3SmKz2xln;
	Mon, 16 Mar 2026 18:48:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773647299;
	cv=pass; b=OjPd/0PA6EN2oM99VNlqZpTid54ODFPqd1mxpiloI0V17WsueVfonyh3K838nXgf3uTwJ3IG12T9UQmfPrE3oIeziJWq4RQJiHETBpbDl7LD/Kl2HY4b6MeRNNckHtA2XmXvUbVlksAl3lnh/wGh0ZuhGfK4AkfGOCriMarGDbmMVTsDNpz3nwr4TYXflAgzJZeRTIwl/U95aQbt3wXfe5UkrUuP6JmiH6u/bEHZtRqzd5QM1tkL2a9Vh9ofJsG6y7JGFs1zFq03rF58VestJC0AEG6K6OFMf1y7xgyiP4j5abygJhXhyk19mnY2i1HWnbJKEmCDN5kGTUxL51850g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773647299; c=relaxed/relaxed;
	bh=KLhd5zK+ceMCTMzOGYmBX0snSwCOmSgBk+vqxzZ9VsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gip4O09DcDDbkmhTeyWLqXOWWi8Ryzg2hoaehygjAq8v+YhjrySP9cr0BZALQp/OEC0ZLky9rVwWVUMmKPmKpfIGpkRU2iOoMnzc8aVTnP1xd2t0MVLLTdN1wt00b6/7dA4YqA5WGx9nEIF3mBxDoYeno+SSkEtNOsSHsFzLZNlICEQrEZiz3/4HkAo6Vyusx+aK9YbpwffPXtpfDyeVd/vT8otHxLO+oh4RASoMRmIz+n8L2L6gTKgUItX4D8aQvTzJFDY29/UmIGcWdhIhWB5eWmMekpW4jedKoJftvZJx/uHwlY9JchhM/i9cVH9NXFc5k/ttydYmYigZZMmtxw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CQnuZkw7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CQnuZkw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ6dt41vzz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 18:48:17 +1100 (AEDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-899ffee2b55so2215436d6.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 00:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773647295; cv=none;
        d=google.com; s=arc-20240605;
        b=cDSkdi6jdCK8DUoG0pFt15pxu8bn73aOoO7PwVBXAQcoi66uJS8kZ7vjld96AEaamm
         pEHYO70l3s8/rVbnGYvNYYimiLS27RnLw99fsWqkdaN7t3r39P0Hc3JyOPxlLK/RdnhF
         NG6h6BLS7gAoyD05TJ0sikmvt2RnYvqAuUsrNZQ0Ml4JQlRQNHn/CXHoqFsD7XRig5bR
         WGh6BsDNpLVmjbvB7zHQRr8mNyiFrF4DdBFu1HzHpWX5fP++f+1Fn0b4+LmKpH4rOC50
         xDT/v+7cvq6AIv0vAIVeu7CZ08JDYtVVTReLy7nLjjHkkFRkL5vmgY0cCpYh1pLtyZVN
         tZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KLhd5zK+ceMCTMzOGYmBX0snSwCOmSgBk+vqxzZ9VsU=;
        fh=+B5NJMHgZVlSETmvknNIc/yWRJuXFX3qfkrcJIg5vdE=;
        b=d1VrhGUytVgV+Dz+3cBAO+L8+gg+fwanFp9e5zKYPjOxvSOHOqk0ECtUc1hys5d80e
         cgQyrhOxH6uFE1Jjv6U8SxFGfecJq/T7i6FG7Ljerq8ElfjjPos8HtCDHu1S2LkSLBXL
         sdkPyTNqCVB6vVzxs1nfv4h7fdD7awrc/2/FiYpWLtP7V5AGjxWtXwray8kkt1EXVZCJ
         6J0uaoHjegdyw8IbrCQSdno7Iv/jm430m7n+D0umSnH8Kk5Pmd83ab3AVVbk2d8OJys4
         /rjQw2jwin0NYlvlPkXIjlMb/vXc9x2Nk/w+aR+fJDaxZsIVzO4PadipmxCXUPizPA3W
         /B7w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773647295; x=1774252095; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLhd5zK+ceMCTMzOGYmBX0snSwCOmSgBk+vqxzZ9VsU=;
        b=CQnuZkw7qIZ/j0WpjJf7MgLMjdu1C1PhJRFi/Xy6NuUKjMLvuRTn62Nos7NahNhJKB
         fk9EkrKcuby3MPHzXxmRJMHjYwWl3RfSqErUO/ehsXsdnvM18yFA6vc+cuk6V5kHp8l1
         rupGj++N6jIQNRE0uk9sSyUTW1F7oNtHw8dr65WQfSY89FyqOM/o95dLjqdvzwE5PHON
         mwMnYPIWdcY5U1bzdfhJCZkwOJYmt7eTWkDxR+QXfhhrR3XOkdVQD+uU6KmvpAe3LhOV
         M4yeQOv53lcJTiWhC+7tBR402zZTP+cZbG6ZDNTcVQCtbSm2Ecb7u1kNvRvYEXnetxC+
         GSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773647295; x=1774252095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLhd5zK+ceMCTMzOGYmBX0snSwCOmSgBk+vqxzZ9VsU=;
        b=RKxcSRMuvZH4kGBRSS+J5YIfKu0R9krgYzOgcC3b1UzHYBRuyXAuk6eaLXclLWM55a
         4ckpGFtSwwvuLkrJZv00ioA+aZtC8ocu5/qnZj3dGM/ADcn2sod5Ww8VWlUJMiNK0tPS
         XPQrRV5UtyraGMilF3Vv8d31T3ZRCquq6oDhRjmsKuAi6yGOTLEdGBIJizgxgQdB+o53
         JM22eMvECWPBfEnkv1XCXgPEuGUeNYXeJbDCw0797b0YHJTB9tTu0XVQ4kMidxbc4irY
         Th9GOcls8CyrDQx7U2lAX2Ki5Wng9Baosk45uU9TprPU9Usslnuhl2c7Pj2nOAz4FL1U
         ejbQ==
X-Gm-Message-State: AOJu0Yx9AAPAdU5wJ/MevuM7Qxm7efAWO/cI9ZljLSDqDRY/nPear5/m
	YEg+wJO2lX0bB0fIsihuDUrrg0UWzrfz+CyrLgwvVD0Bt/EX4rZx3QoUdUb3G6VOylc3Zhx/cEk
	P05Nc2rZZeJEHYBXWhftK+Kz9NCM4Ap483vsSujg=
X-Gm-Gg: ATEYQzwIHhMJ/ycHjHOUWCK7EvQsTwfEG8hECscRocShBVlpVigysp1CmKg0d3aOIUG
	Mo94LZMa27oEj1jfREj+hesRGhoctqTk9MRe/87oo/SrghTrUnPtFgUScB1L0tl7PIcHuBRUpH0
	sDs55rkdGcR6tncBMuc5D/iibQnYBzhXvXdRZSt7gdZOad2mitXCjI9KkK+DkV2TVNDoEmf4SGy
	cCMC6ApuS2lHhFBMOsZOu7i4HUiigcy/9CNj1KZuTuTALRfL3p8QgpfwYP9+SMXeTyBBT8DcMZh
	qsMMBY7zT7axVK3EH8tpKN9/i8q9AhV/LFJyXxCWBogavNN+3c/JnkV0txfueDnuHLhH
X-Received: by 2002:a05:6214:601c:b0:89a:6263:feae with SMTP id
 6a1803df08f44-89a81cce148mr119864596d6.2.1773647294725; Mon, 16 Mar 2026
 00:48:14 -0700 (PDT)
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
References: <20260316065119.21726-1-singhutkal015@gmail.com> <7de7aecd-1ffe-4879-b251-fa201b836655@linux.alibaba.com>
In-Reply-To: <7de7aecd-1ffe-4879-b251-fa201b836655@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 16 Mar 2026 13:18:06 +0530
X-Gm-Features: AaiRm52uZGVqUz2YOqp840RBmD4Y5N7ESo_S3qEgp7wwIUB65FzwFmelRFmDbI4
Message-ID: <CAGSu4WOuKRftMqvv9+kmDN=zcXw2Q7RWU7233RjbCTix=6oOSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] erofs-utils: lib/tar: fix PAX header parsing issues
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@foxmail.com
Content-Type: multipart/alternative; boundary="000000000000f58234064d1f70c6"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2727-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,foxmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 18100295CD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000f58234064d1f70c6
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

Thanks for the review.

I have prepared minimal reproducible tar test cases for both
issues. I will include them in the commit messages in
compressed base64 format and send v3 shortly.

Thanks,
Utkal

On Mon, 16 Mar 2026 at 13:05, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/3/16 14:51, Utkal Singh wrote:
> > These two patches fix input validation bugs in the PAX extended
> > header parser in lib/tar.c that can trigger crashes on malformed
> > or crafted tar archives.
> >
> > Patch 1 skips PAX entries with empty path= value to avoid
> > out-of-bounds access on zero-length strings.
> >
> > Patch 2 rejects negative size= values to prevent heap corruption
> > from incorrect allocation sizes in subsequent operations.
>
> Do you have any testcases or reproduciable tar? You can list them
> in the compressed-base64 format in the commit message.
>

--000000000000f58234064d1f70c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao,<br><br>Thanks for the review.<br><br>I have prepar=
ed minimal reproducible tar test cases for both<br>issues. I will include t=
hem in the commit messages in<br>compressed base64 format and send v3 short=
ly.<br><br>Thanks,<br>Utkal</div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 16 Mar 2026 at 13:=
05, Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@=
linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><br>
<br>
On 2026/3/16 14:51, Utkal Singh wrote:<br>
&gt; These two patches fix input validation bugs in the PAX extended<br>
&gt; header parser in lib/tar.c that can trigger crashes on malformed<br>
&gt; or crafted tar archives.<br>
&gt; <br>
&gt; Patch 1 skips PAX entries with empty path=3D value to avoid<br>
&gt; out-of-bounds access on zero-length strings.<br>
&gt; <br>
&gt; Patch 2 rejects negative size=3D values to prevent heap corruption<br>
&gt; from incorrect allocation sizes in subsequent operations.<br>
<br>
Do you have any testcases or reproduciable tar? You can list them<br>
in the compressed-base64 format in the commit message.<br>
</blockquote></div>

--000000000000f58234064d1f70c6--

