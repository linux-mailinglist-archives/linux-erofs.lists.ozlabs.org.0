Return-Path: <linux-erofs+bounces-2970-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JKkHqiswmkyggQAu9opvQ
	(envelope-from <linux-erofs+bounces-2970-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 16:24:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6048317F37
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 16:24:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgDNM0Ttmz2ynP;
	Wed, 25 Mar 2026 02:24:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774365858;
	cv=pass; b=VRWE/o90umEKyfoMbYSzIMDixxU0wblAJpNbc+tpyl377JEQ4QSvm7FYD8C2GDNshV9d2DfDWBAo0h0qdMzLtXrn9b4E61C0OlxOB8B4czSNwDWY+cjnFmhoOAhsbZI4vgLfJl3viCrRSJMCSW9qO2FNYVSZDsPsL81D5gjM3ICL8Ae61HaSYgQvnwgnGoKkmRiCwxFEqHUYLQPQKGCLMKYLQ23hW0n7Pt2Aqeb4/iiNqqs7ThSA0qvYlvuqVOdVbTCrHBt2i+9TXnINpoMZkBRxu0uBaNNgxuRrzyBN/mi8SYmqG7tXXS8Va3q0znltahHulPIKyCCZ3ZOMTAWpLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774365858; c=relaxed/relaxed;
	bh=EbSqxU+R2qh5QmMbZkbmTf03IMfbrlKyPwd2sYZyFQI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iKSoGY4SdEudUPNUHuJ7ta1aaNUkvcjJJ/9bZrOB4X5Yq20pHGTNOVVThc9syapjQwkg2kbOz3FbYXVW2+wn41RsAPMsu2MotlxJQ/ANO8lNYdQ7wL/WXcgbtWXGvbcyozFR1bqCUgm3R0ZtfnghQyNrWz8dn1ITQuBDcoEkfwiLzEugU/lalSS5oeeAFBCQ4Wt9/GmNkxUaITS7oKI5XlGv63lPvgRr9GvqNn4jEDN1Oz8OwwmRXdJUQOjPGHZ0h1VdTI5lBhjoxtM2OD9mkEubximPelpeTzDxJ10pHBbgEYt/XLAJxe0YmRXrD3lL0lSaAvMmnCcFq9/TjcurcQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WtSoJJfH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=gautamharsh031@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WtSoJJfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=gautamharsh031@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgDNL0TCmz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 02:24:17 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso8987724eec.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 08:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774365855; cv=none;
        d=google.com; s=arc-20240605;
        b=Ue8NLffd8ck4xlpIdY+bcw5j9dRmM5S8NrnTSOgzLYDldyy0hJsxLhvsTD+LIZkA2M
         vwK8Ujzp+5KjKZ62o2P+E4I8D3xfvkr5BhXJ9tMzD8w/FnlZQmELAh7YuBKaSOcDr4xm
         vudLIdAX9eBc5ztwZ85iIg04pV55pQDsrd/jTFRDO3btZYL7DvloZjgP31CJpKO1+fyb
         Y27bz/CHLMp+nH9jHWNipqY7WlTot39nG23OSRiUdylgC48zcvCw9hINMll/wq4TO2Xb
         qyUTTKn78w7Nimv0fXk3Nuq7omxBaFlP958Dlws64U88hdTZXLUAVnet+R3xjChIoXFw
         rhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EbSqxU+R2qh5QmMbZkbmTf03IMfbrlKyPwd2sYZyFQI=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=lsJPLlUtOsir77frty5GImCUyV/FPdXyTBGLCEA7FAYvBiqKGntHt86mykUBlVIwlT
         ba3Veimm5tLKHfmQHKpBMtx0d/qWEoLIUFN7U4PTqxUkDx+fzzCWHfh+B2+MfgRQVuVB
         WzYp7glFPME28hUyA4sasRZ4oZhQJ9mH5JPAjlCvxPjb3M5/UZAUnCD+Z51GUVo9NWJ0
         Dv5vT9kDkLA4rntQLUEVH00pnGa0ax3oWq2Asu2T0RpfnmVF3XE4Bqt9uIf4SiMg/AF5
         LW2ogQqjKmjfbP/+tzLlqPIPobn9yMrENmHlTMqEfeWF3/Em4vUIioAi8fTQmD6PFBEk
         qr9g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774365855; x=1774970655; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EbSqxU+R2qh5QmMbZkbmTf03IMfbrlKyPwd2sYZyFQI=;
        b=WtSoJJfHfYgK+xPVx/dvh5cCp4HX3C7TYEQgxvtAe8A5JibpYck6nivWysWwgbJSUm
         vC+46aZnRHC/ux6B1oGxQ+kvjhuB2uQXH7MgbaAKxXE/6GMLA+Yv+RAgJS1U2bWTkJLn
         HIiDYQNN3cywIqP4JQX07L46zfGeXDP0IJPHg902Zwq7R4KX754f7Xqcww8NYiDtuJzR
         nQElzLwL6me+1QR2HK5tS/QAd+mNHVdjg+aUYNCO17EPMDxFNvcV1nv6ct/+GINF9/uh
         Jc4V7fGy16fd7lI/Oz8eLEBbXc3AxTRcXuhoG3X9wvKEZs5QByPBE0bY/SmIWpg5oM++
         KB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365855; x=1774970655;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbSqxU+R2qh5QmMbZkbmTf03IMfbrlKyPwd2sYZyFQI=;
        b=BjV/5tuCQrzzoqGwbtvnSjRiHcoQUI+E3i92L86odcB1YTxh81Bnb0y3uHh/FVU+w1
         ZrcIZJ7Zzb8bpJ0hIibEiSSpnfO5X4aX8FdlmLEJ7CnCevH9jt3kiWgXIxOgrjokH82d
         nXWw++ceun5Tqqs1uvWU23KJMo80NfsX1SeFziQg6bfuDU5Vz7KgeegXsko01dzBYd2X
         OKKTcYu+xRYjzrqTMyZSG1oPPaPWs29OQnnAw5pQvzGGpkRPN4w11PxQwQRcN2jVcq9P
         V8j+p/pR5EzA385rehszdRvvAgFy2lM1P+dNFMM6KTvK2yQ0vCe8xDyffXl+N7owEURj
         sRoA==
X-Gm-Message-State: AOJu0YwXqtQTn98C2tWBrDG+aGpchIkHULHIZPKdtCq3t4IpH8/bcSnY
	D8UafcyS2KU40wUOmOyH71HznYRXBLgRCi08EEipef1qthv++EES9YrH7H0ye1ZxlmDQbNA08qL
	BPqVQNgJLk+VxwJxoYW4RHuX/+A1zCK7txg==
X-Gm-Gg: ATEYQzxahknmja2AAZProv7qSJi8DmaOB3delEMCFCK2BXQxZXK8qg1Zryzme4N/CVa
	3wNn8vfXPAmA2ohqojmD4+sc6tv6WGL+dcHu2UHGwU+080yjOcIGBiLfPNFDqtX0rIYovQRdADT
	DTM6t2hHbxPlZRjTvPoL2ZT9YeXnbVvYdUSkFAUvTOoOULPIRtI/EINGs1HnCj81pcZZFN/Ha8m
	7a63DHwF1zeWWM8JoctUTojfc2Eq5seaswLmbBhCr20or/2RVvWANwvv0P0MaHCJq8uSqQkcPDk
	rqa36s4ZlmhVPFMp31wFxWZUgR9ZMA8dooIdMJ4=
X-Received: by 2002:a05:7300:5707:b0:2c0:d690:7b9 with SMTP id
 5a478bee46e88-2c10970eb6dmr8549582eec.22.1774365854986; Tue, 24 Mar 2026
 08:24:14 -0700 (PDT)
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
From: Harsh Gautam <gautamharsh031@gmail.com>
Date: Tue, 24 Mar 2026 20:54:01 +0530
X-Gm-Features: AQROBzDeJia_wE9azoo2cIybi290c-fDcxeLQKecNH2VkU3s8yBFA3uUnd9KpoI
Message-ID: <CAMHw8-K37PPi+OO60pY+cy4Zwj4H87Dv-v_oN4iTmnKrbrPANA@mail.gmail.com>
Subject: Subject: GSoC 2026 Inquiry: Multi-threaded decompression in
 erofs-utils (Harsh)
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000007cf3bb064dc6be87"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2970-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautamharsh031@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B6048317F37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007cf3bb064dc6be87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi EROFS Team,
I am Harsh, a CS student interested in contributing to EROFS for GSoC 2026.
I=E2=80=99ve been looking at the roadmap and the "Multi-threaded decompress=
ion"
project for erofs-utils caught my attention.
I have a strong foundation in Data Structures and Algorithms and experience
with C/C++. I am interested in how EROFS handles read-only data and would
like to help improve decompression performance by leveraging
multi-threading in the userspace tools. I understand that this involves
managing thread safety and efficient data buffering.
My Background:
Proficient in C++ and Python.
Solid understanding of multi-threading concepts (mutexes, semaphores, and
concurrency).
Comfortable working in a Linux environment and using Git for version
control.
I=E2=80=99ve cloned the erofs-utils repository and am currently looking thr=
ough the
existing decompression logic to understand the current sequential flow. Do
you have any recommended "warm-up" tasks or specific areas in the code I
should focus on first?
Attached is my CV for your review.
Best regards,
Harsh

--0000000000007cf3bb064dc6be87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi EROFS Team,<div dir=3D"auto">I am Harsh, a CS student =
interested in contributing to EROFS for GSoC 2026. I=E2=80=99ve been lookin=
g at the roadmap and the &quot;Multi-threaded decompression&quot; project f=
or erofs-utils caught my attention.</div><div dir=3D"auto">I have a strong =
foundation in Data Structures and Algorithms and experience with C/C++. I a=
m interested in how EROFS handles read-only data and would like to help imp=
rove decompression performance by leveraging multi-threading in the userspa=
ce tools. I understand that this involves managing thread safety and effici=
ent data buffering.</div><div dir=3D"auto">My Background:</div><div dir=3D"=
auto">Proficient in C++ and Python.</div><div dir=3D"auto">Solid understand=
ing of multi-threading concepts (mutexes, semaphores, and concurrency).</di=
v><div dir=3D"auto">Comfortable working in a Linux environment and using Gi=
t for version control.</div><div dir=3D"auto">I=E2=80=99ve cloned the erofs=
-utils repository and am currently looking through the existing decompressi=
on logic to understand the current sequential flow. Do you have any recomme=
nded &quot;warm-up&quot; tasks or specific areas in the code I should focus=
 on first?</div><div dir=3D"auto">Attached is my CV for your review.</div><=
div dir=3D"auto">Best regards,</div><div dir=3D"auto">Harsh</div></div>

--0000000000007cf3bb064dc6be87--

