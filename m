Return-Path: <linux-erofs+bounces-3077-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDZEFU0myWm/vAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3077-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 15:17:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDA352246
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 15:16:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkFK36rWJz2yYs;
	Mon, 30 Mar 2026 00:16:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1235" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774790215;
	cv=pass; b=fxM6C3/9M1JprkBE8OXwL7EP463LXgXAbIKpiTXtfwCNYscuLg2ZXOKrEv8o8157/Vsm6c69eqBVjCCceGVp+qOyGenFaNfYoBfFYZEoDUxl+qDcWy8vvdfCYigxkBFoJ/fToVgTe8ewuAkD7VX6BrggiIKRL6hAjDqcqU4HxWBcvvdd2p/mwo5hG5tEDyG7rFnZnqyOablAomgdcIE/FQCBv9JGX3PXqwi+eOHkZLI/V2MjShDKfhYCTKH3Q9YtHiDtwdfr+zd8PZB07LOUXAephu2Je7SD15ZoC2o/LMcy4nGnJTC53Mb6CtvsQpBIiyq9aCP60EV9KsYWnp4Vqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774790215; c=relaxed/relaxed;
	bh=1umTYBm1Ns6EWRiwwCodC1z6JM6H4tY6pujQsMsG+l8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i2r0h5o9puRChhV5izGP+aTCxjkuGDqIdBTj/Sl3kyVp0tB7j79EWuU6KvWvnmoZoxT00LCb2wS3YFUie12GvSFcA1xEedruoX4WaMZp+MvR3bxsAW9PBDDf4flsSqI53w4SkpcDFOree6QXG+c/d7QaDP3fXYgg/e0QqFNNzU1/EYpo0ookkOVTNSw6IVXk1fAqv+PRhFU7IKWuajLqay6BTkxC8vF+xVWFRp0dpp97g/FRS5EowAXPl25Q9CN0QAAr9csmCETM7DxxQ+3G3JN4SBp0x2pJf+AgQxwaxAi9mShAgcGlrM2G9ijR8BOydUgXJN6sz8/aEaRmH0Upog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bFM05mcM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bFM05mcM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkFK264Sqz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 00:16:54 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-12a71ade78cso4111079c88.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 06:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774790212; cv=none;
        d=google.com; s=arc-20240605;
        b=hCq9oXL5x8tK7zYZ20J4bKUFZqtkAVwZXfImuopnbi0yHfgCgU6EX3P3RB8QG0BB0A
         JTmkVjdUl/JtIVteomWSj71tSNlT+qtSfaiDszmcwQNJ5pT2zig/R0FsqhamnRaZJYCy
         rXU72iF3hplyHgY7vv7G9wz7xPPdHRfH9wl86ngSgLWYIoKsyh7efkhvDhmIrNtPP+CC
         HD/sPf2/psoWAmu0BKY5QEUsGTk57D0z85OGebI3XZ9PtEQTqOEvImJyRJx0Ln8iyI/i
         5qNuBV4FA4UYnobru9N5GotayUacDMJXnBAWKBI1/reqgNA7M8o/I1WNaFd68zrr1xX3
         vmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1umTYBm1Ns6EWRiwwCodC1z6JM6H4tY6pujQsMsG+l8=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=TRgDZnZv+3xFyuK8ypCp4EHS/IhBKuQzDEmAm/MST38bUZUh4atupTKCCSucrX5I96
         EFqRgiyLwiKA5K/4lMY6rXXOM7/6/QIDwQlyLYT4BLKfomToIHeMr/OvFfCyG3nCa0Zu
         jiCedQvIQoFNiWEK2YPtVUqelGE8QwMWekD1LntbMUIOLdVjoS7uWjQVNISBR/edKj8M
         3hQ/U/WpUp6DOXGS21zCgV9BE5tiOuut3xMiRFFau95/WkX519kCsgD1tvRGtGKsmNVY
         GHVzaFictemCPqQJfbzKdjG+1vev5RhHPxRo5q/K65MMzyshAHocKG9QYcFCkLix2Z1S
         CVmg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774790212; x=1775395012; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1umTYBm1Ns6EWRiwwCodC1z6JM6H4tY6pujQsMsG+l8=;
        b=bFM05mcMSiEs3aGdJcHwLemRGYixgOyUKzwErwu3nZImbDGw9w8vuijTN4USk8evkC
         O1EWQKBEpEGRvENHbBVq+OIP5baHhCmm6tzKqjq6sAgmfTybpJf0V0LIKsHNk8pNav7h
         1IyQ2U7Gg4aZW3D+Y3tdt+8mHOfa1EnS0T1DaX5sG8uoExEXHCoEoX70cazAukrqmTI9
         Fa9jQvTKflSY/9Z9u6WXSYQbSoG24VgmYRW89yhuSoGFjx1n0bqb8ytY07EW5gEbW4aV
         u7ZbquE2Lh9bC3E2y6s7cSe/Hf42+cmNQU6+I2H3q88V4APhqvJAIkdfNEEI7bapibHo
         ajeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774790212; x=1775395012;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1umTYBm1Ns6EWRiwwCodC1z6JM6H4tY6pujQsMsG+l8=;
        b=s0Wp62N0xmnTsensYXKp8Adw7AhVy3n+zjuwL27Jjn8T29xXRPovS5ZZiqgCsP74zX
         WRWru1topIZ28yhzIUQVtYtdXhrPcTmY93302aYFGF8ILzTEz3xDQuRk5bEsftQ7Jqlx
         BpJW47kI3TS8bxDuX1MZj4s2vbK8/XiM9+a2wSmKsYyLWgyKbTNntwd4rRmlL96iG25j
         1Sg1uQ2u4cJvRig5+41YBhOjgmO10GcO6e5vrWF8aByzE2mc6hrNxRkCFajcjHO6sE4T
         9dZ7qg9BuBysC/wYgzjBWFEQ0zpJwe+d+rt5cHX5YdMFtNmS2mr9ThhSmw7mHK4F/m/5
         trWA==
X-Gm-Message-State: AOJu0YyYusUwKtG4gVpM2rGlfyMgm6KwD74PSSkUEFAzaYZs+jsVdKda
	fv3uTpD1ky8w+XFlbyjf/NlLUmq59RvaopvyC2no/myE77LzvQQRX3jyCcynzVR4euOv/O0G/nv
	xGrjH6ljSxXhkQ41PZazGhUFq0kMprGKSXEtK
X-Gm-Gg: ATEYQzznP0niI7khG1FeQB/Th4fMWCmQePEGITTyesZ2+tsAW3v7qw+XwU/K23fl3Bi
	axOPLqu2I7Lo4ne+IK7Y2JXikd1CFu4H6yYFLySXCtCtdJnbQAKS96qPRET4INl9+v95QM4sR4g
	81LpuUOzB2aPTXKWjN8N7NiQ+qeHHjGdDEYTSWBir1dl+hL8sTEkuI++cjx4/gH8ejHUsewPBDv
	EBgrTwfhj5Wr6fDiuM6Se1CUXAkFFz6E9ylpW92LoxzA2UTuMYMhUUYlfJx/DUmzXBPDN2rpbeO
	SY9tZuho
X-Received: by 2002:a05:7022:4183:b0:128:e6d0:d7c3 with SMTP id
 a92af1059eb24-12ab28dc3dbmr4147385c88.20.1774790211719; Sun, 29 Mar 2026
 06:16:51 -0700 (PDT)
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
From: Deepak Pathik <deepakpathik2005@gmail.com>
Date: Sun, 29 Mar 2026 18:46:40 +0530
X-Gm-Features: AQROBzD5xynxqWtU1fxsl4CAtsMPI6VFZPdcZGhZXcDVGxZSPd_R86UjmZ_k0mw
Message-ID: <CAHf8aCXHHLFCghBEy4hF+DoDpYed0yOafvKbdbmDgfjRC2Lfww@mail.gmail.com>
Subject: =?UTF-8?Q?=5BGSoC_2026=5D_Multi=2Dthreaded_decompression_for_fsck=2Eer?=
	=?UTF-8?Q?ofs_=E2=80=94_design_question_on_z=5Ferofs=5Fdecompress=28=29_parallelism?=
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000001ed961064e298cd4"
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
	TAGGED_FROM(0.00)[bounces-3077-lists,linux-erofs=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 88EDA352246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001ed961064e298cd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm Deepak Pathik, a second-year B.Tech student applying for the GSoC 2026
project on multi-threaded decompression support in fsck.erofs.

While reading through the source, I traced the decompression path in
erofs_verify_inode_data() and noticed that z_erofs_decompress() operates on
a locally scoped struct z_erofs_decompress_req with its own input and
output buffers =E2=80=94 no shared mutable state between calls. My plan is =
to wire
the existing erofs_workqueue (already used in lib/compress.c for
mkfs.erofs) into the fsck extraction path at the pcluster level, with
pwrite() for position-based output writes to avoid ordering locks.

One thing I wanted to confirm before finalizing my proposal: for
LZMA-compressed images, are pclusters in fsck.erofs always fixed-size and
independently decompressible at the userspace level, or are there cases
where a pcluster depends on the state left by a previous one? I want to
make sure I'm not understating the LZMA case in my design.

I've drafted a proposal and would be happy to share it for early feedback
if that's useful.

Thanks,
Deepak Pathik
https://github.com/deepakpathik
deepakpathik2005@gmail.com

--0000000000001ed961064e298cd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I&#39;m Deepak Pathik, a second-year B.Tech stu=
dent applying for the GSoC 2026 project on multi-threaded decompression sup=
port in fsck.erofs.<br><br>While reading through the source, I traced the d=
ecompression path in erofs_verify_inode_data() and noticed that z_erofs_dec=
ompress() operates on a locally scoped struct z_erofs_decompress_req with i=
ts own input and output buffers =E2=80=94 no shared mutable state between c=
alls. My plan is to wire the existing erofs_workqueue (already used in lib/=
compress.c for mkfs.erofs) into the fsck extraction path at the pcluster le=
vel, with pwrite() for position-based output writes to avoid ordering locks=
.<br><br>One thing I wanted to confirm before finalizing my proposal: for L=
ZMA-compressed images, are pclusters in fsck.erofs always fixed-size and in=
dependently decompressible at the userspace level, or are there cases where=
 a pcluster depends on the state left by a previous one? I want to make sur=
e I&#39;m not understating the LZMA case in my design.<br><br>I&#39;ve draf=
ted a proposal and would be happy to share it for early feedback if that&#3=
9;s useful.<br><br>Thanks,<br>Deepak Pathik<br><a href=3D"https://github.co=
m/deepakpathik">https://github.com/deepakpathik</a><br><a href=3D"mailto:de=
epakpathik2005@gmail.com">deepakpathik2005@gmail.com</a><br></div>

--0000000000001ed961064e298cd4--

