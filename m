Return-Path: <linux-erofs+bounces-2975-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DMwF8rHwmmIlgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2975-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 18:20:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D236E319E8B
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 18:20:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGxy0KSZz2yng;
	Wed, 25 Mar 2026 04:20:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774372805;
	cv=pass; b=oH7TqvU5Dj75g+q51R8IaZVVwDQ3EXfSkuDsCR2Qovh/6gIsF/VJySE0Lrnqv7jqmmpzksHU+Ex8vnheoSXiwRnLr0QsTXIcRj0aAVxLrnDOlm2qLpsO9zxSHLK/lO1NoUnmi2WGGU8jnyzcu8xeclftwDz8oMQaPf5S2bzB25NEcsQ0GtKqZsJsOAHhsixrGv6c2s648oU6Fem0Vkhqb+ddLM98tavrcW0SAHsZFcizQUKkYthG4YDOE2DMM9CgUK1XkfsuFmVXERqfZhCT82WrD5j1x+aEvepIDAaVtl2ohY01mfUwntcZ5FATL8mNt5/RjNzbG0eBmSilVhiCow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774372805; c=relaxed/relaxed;
	bh=jKnXwt7VyzGcsptJPWmm4sHDDeI6yXx+S5JhNdA9WZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fyXM+cJJW0CvqJSmPXBNH8YG89IBbtyNMI7Yd/yrRPpMpGkA2ZZ6NcITa6glkv2G/oCaMN1njadmGEdHY/4TmBF3hajAGm7WcSFWRqiCngxsyvo2Bob8OcJwMhnHUtbv2k7BtinWD+8/RkER/oTIzwZ3yuHMk2eizSfg8+UHe3rPt8jT1BmzNK5MCbYywAEsj4xoV2rAXolyNygTbfsPN0RvF8ejjKmTyi7qlXfNcuB88ZSqlxIx5tTZE2sHgH6RriPiEfEB9bZnrSio16LtbI0kn53pRck406uMkzpxYGuYgsDvfBJD/V7sjxEf2YvwsfY1FtNBTeiasM2C1wNSbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcNJN5ps; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=udishanarayan646@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZcNJN5ps;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=udishanarayan646@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com [IPv6:2607:f8b0:4864:20::b12b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGxw3HxCz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 04:20:04 +1100 (AEDT)
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-64e8cdafeffso173458d50.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 10:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372801; cv=none;
        d=google.com; s=arc-20240605;
        b=R5K5l7IofO3Q6mwPVA7SJmSV4dDdiAVe9O8dxMwZkP8/TkalyJwWpTiFuu8STjDeDU
         uxSuRtE1iOl/d3fjO+OLC4tQxo57I7FtBmHA5L6inCnaylm0NR+EVhJityEuOkuer/Zq
         XMF5/wap7mQz9TUpbvS2/2N/uocr7zmLL4LjA/W1SHLUeH99aJxlTyHrnFSpksAYs5Uk
         iIedKAdoNDD0Zk+5ceWFHwSiopdcSYcA1pV6QpXcp4FZZjPP0hlLWCtja7WA7RvFBZY/
         I0wcxTYDh3ZEddRG8FNJ/afQAkcS7t7EVKmzACi8fSrMIA22D0sG7x735dDyALQToM1o
         eFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=jKnXwt7VyzGcsptJPWmm4sHDDeI6yXx+S5JhNdA9WZw=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=VWa2WLjdhZB56n8sgHMTIub9bE6U9DdiObypLK7BWSyk50qINtUSRstoO1BOUPNrrk
         U7bAPSnHRcXMZwTU7ANuoPLxmyyh02IQf6jl5KWhQUp4Ry6x1Ilbyh1/JH3GasbioLtT
         TO3Niw+/YWf3smX9caCB9QzCiBDGJ2EffXqgFvHaOLzKZ1lT2KDiE3arX5Yfj71y8g04
         01YSPT7TOWOtrotbnBRKBXgRZkTdYg4ZSDQLTpqv7raeWb4AL1uUoXRjOUeolM6glaeB
         tDmjxg+vhmvEBrG9XMKyBnZYiRIES69dqrzyKn9auzxEm/Chv9CFZGZn+uqCSnmqbTO4
         1gvQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774372801; x=1774977601; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKnXwt7VyzGcsptJPWmm4sHDDeI6yXx+S5JhNdA9WZw=;
        b=ZcNJN5psrN2j9HDKGxRm2re+gClzs2cJCrl8juanOD6nK/Mxtq2Sl4GngCaroSR1y7
         ZT3hi/jvIFBEklG9k9KlSn83qTBtwOnBlp7FMHQb68to3IHJSEHAngMnu7gSNcIx2TF2
         9Uej9lP2+t+jGvlDAcBm+tk1JFDtBBU3QzNFB0DSs7k31F3YHQiIMeNRRWdpQg42DlN2
         k+rFzOxXJxoEjjQ0xCQsQYPbCTDtLVBJ9wo+hrKA8M0K/r4swbX8rs3K0r4G2bE9Q1zZ
         oYmhPYON30MqkBgK2P/JcDeKhrK0h6ZOD1E+BO/m8wjQ0gIMe9vcOyRwHAJ6ayLjAwQR
         sNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372801; x=1774977601;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKnXwt7VyzGcsptJPWmm4sHDDeI6yXx+S5JhNdA9WZw=;
        b=X7z2kefdPSLgj+1G/zIOXGZHUD7MKyxT7woRyHMbnxnEn0wISHVWMznczoLkvXKTMo
         dKzdnC7FZSz5iAEkDJh2NZBiSVB6qXrT7badWs4BET6mDA3BJEJl2MhsT+G3jT09YQAQ
         LIxvOj3+JyoL4na12YY3LeRb0ghoViM7KC/3/m8Im5bruDYLf8Je5/MV8FZiomeszYsf
         O2b1XrF2nvbrSv/BFCV/wUdpIgPUbRTEqZvdRiDGs6qXBcDCKQr2hek1voNfKrowzpAG
         ZXXhHACsQ4NWfvJFpsfz9cBrUbKLoo+D+hEQeKVAGYLo7uTcCI1b0ac3migtIZsxegPl
         kueg==
X-Gm-Message-State: AOJu0YwbKnxvvk6kGx4d9PbJfrFR3NOoUh9flpyXfBroSsrY2Th72uLM
	upHyM5BsV/U0HmQqJPq6dPlJy8+knJJY2oOzVXqfAqUQCPzoMzFZ3aEPTWzRE+9CQGQoSBYqSQH
	492eWQmtG2FBfcq29lA2wCWUz9P3Y295xcG2/
X-Gm-Gg: ATEYQzyuWcznEtvA1bZXlD2TbRMfqUenkW1qrDXAsT99wGzwyaYSlFCdyg/tN1csKqY
	/hXQ3xcomXnCWLcBbqEHukXsNanktlI/WJiyzdTLo42nXDNEgtkvnSxmQnFbm6h1iXOh4DkWkBe
	74T+0YNoTBxbXGz4Z20b6vaPd1bvC4qDTb9bdgvsUO6OgxaHt5Rklf8Uq8BEzJwPQ2mqCmH9KHl
	+i2qhAatkpLUgOzu/bkh/+AKYrMzZHqKlDTG8xRXITcjOVI+Cuf5P526iGVuGwfZuCVN1zLO/AI
	bJFKCLgvNA1Rb9WF
X-Received: by 2002:a53:accb:0:10b0:64e:cb0d:23b5 with SMTP id
 956f58d0204a3-64ed784deb3mr3166427d50.17.1774372800599; Tue, 24 Mar 2026
 10:20:00 -0700 (PDT)
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
References: <CADVXez_zfMSTL4S6O0M6oKj448S+ZH5fEDCd1PeB5=fFuRvVxA@mail.gmail.com>
In-Reply-To: <CADVXez_zfMSTL4S6O0M6oKj448S+ZH5fEDCd1PeB5=fFuRvVxA@mail.gmail.com>
From: Udisha Narayan <udishanarayan646@gmail.com>
Date: Tue, 24 Mar 2026 22:49:48 +0530
X-Gm-Features: AQROBzAG9S5d1Rw9jEahdbjhPe8PwqpU050SHn7cpuco7KEH9rhHE9xQS2hcxhg
Message-ID: <CADVXez-ieBc-qex+hKnjZYwTR6vC1EX6DRpi3esVHKzqKLRFMQ@mail.gmail.com>
Subject: Re: GSoC 2026 Inquiry: Interested in EROFS-utils and File System
 Optimization - Udisha Narayan
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000007a9bf5064dc85cdd"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2975-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[udishanarayan646@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D236E319E8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007a9bf5064dc85cdd
Content-Type: text/plain; charset="UTF-8"

  I'm working on a proposal for multi-threaded decompression. Can you
suggest the same point I should focus on?

On Tue, 24 Mar 2026 at 20:36, Udisha Narayan <udishanarayan646@gmail.com>
wrote:

> *Dear EROFS Team / Gao Xiang,*
>
> I am writing to express my strong interest in contributing to *EROFS
> (Enhanced Read-Only File System)* for GSoC 2026. I am a Computer Science
> student with a deep fascination for *Systems Programming* and *Linux
> Kernel internals*.
>
> *Why I am a strong fit for EROFS:*
>
>    -
>
>    *C Programming & Memory Management:* I am comfortable with low-level C
>    and understanding memory layouts (Pointers, Structs).
>    -
>
>    *Mathematical Foundation:* My background in *Discrete Mathematics*
>    helps me visualize complex data structures like B-Trees and Bitmaps, which
>    are crucial for efficient file system metadata management.
>    -
>
>    *Optimization Logic:* I have experience analyzing code for performance
>    bottlenecks (C/C++), and I am eager to apply this to *EROFS-utils* for
>    better compression or faster read-only access.
>
> *My Goal:* I have already explored the erofs-utils repository and I am
> currently setting up my environment to build and test the tools. I would
> appreciate it if you could point me toward a *"Good First Issue"* or a
> specific area in the 2026 ideas list where I can contribute a small patch
> to demonstrate my skills.
>
> I am ready to dedicate *40-50 hours/week* to ensure a high-quality
> contribution.
>
> *Best regards,* Udisha Narayan [GitHub Link] | [LinkedIn Link]
>

--0000000000007a9bf5064dc85cdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0=C2=A0I&#39;m working on a proposal for multi-thread=
ed decompression. Can you suggest the same point I should focus on?</div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, 24 Mar 2026 at 20:36, Udisha Narayan &lt;<a href=3D=
"mailto:udishanarayan646@gmail.com">udishanarayan646@gmail.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><p><b>Dear EROFS Team / Gao Xiang,</b></p><p>I am writing to express my=
 strong interest in contributing to <b>EROFS (Enhanced Read-Only File Syste=
m)</b> for GSoC 2026. I am a Computer Science student with a deep fascinati=
on for <b>Systems Programming</b> and <b>Linux Kernel internals</b>.</p><p>=
<b>Why I am a strong fit for EROFS:</b></p><ul><li><p><b>C Programming &amp=
; Memory Management:</b> I am comfortable with low-level C and understandin=
g memory layouts (Pointers, Structs).</p></li><li><p><b>Mathematical Founda=
tion:</b> My background in <b>Discrete Mathematics</b> helps me visualize c=
omplex data structures like B-Trees and Bitmaps, which are crucial for effi=
cient file system metadata management.</p></li><li><p><b>Optimization Logic=
:</b> I have experience analyzing code for performance bottlenecks (C/C++),=
 and I am eager to apply this to <b>EROFS-utils</b> for better compression =
or faster read-only access.</p></li></ul><p><b>My Goal:</b>
I have already explored the <code>erofs-utils</code> repository and I am cu=
rrently setting up my environment to build and test the tools. I would appr=
eciate it if you could point me toward a <b>&quot;Good First Issue&quot;</b=
> or a specific area in the 2026 ideas list where I can contribute a small =
patch to demonstrate my skills.</p><p>I am ready to dedicate <b>40-50 hours=
/week</b> to ensure a high-quality contribution.</p><p><b>Best regards,</b>
Udisha Narayan
[GitHub Link] | [LinkedIn Link]</p></div>
</blockquote></div>

--0000000000007a9bf5064dc85cdd--

