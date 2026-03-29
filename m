Return-Path: <linux-erofs+bounces-3072-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wce5Nut4yGl1mgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3072-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 01:57:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47401350628
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 01:57:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjwvW39hFz2xmX;
	Sun, 29 Mar 2026 11:57:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774745831;
	cv=pass; b=R7JLV1NS4UYGnd1uObBpRa7n163D5UDkGWMDCPNdooN85MND+Qy4cP10VYW5XrfSZkJWkwXrsIKJmLON0KmHGK12l5mJStRhPgoUlyzSfvXu+SlNjEtE5ArWkMwiom7fO91TZ4MF4/5Y+zhUWFsqMeL5kkFDpIiUqBumrv3VTPIZ4+ENEnQrkT0g2HKTvAXHcBDgb1+NUCk3UAkNk+aA9CSjAyCgiFTiz4N7BDr3lNWlLwU2bynyYznPllrZ7HqisvTx0lwee0v2zBeqDMCVg3BG7Lpp6k7cs4IzMLmtHHw5bnqbbgmc5wyUooYdxs/8Els52gTd85LiBNo+ab5BNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774745831; c=relaxed/relaxed;
	bh=ygwZmk0oeWUSh8cTUDzNEQysyCcnKD33bnw8kSMRxdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=U73ZP0UE84onxDoTjLhSNczZmZi6UiurJ3erkbyqV3RLqOTwNPrSvvosNWxAU5DNHNVVDutFVHIO23z4gkrwVeicnRLxh2E9EowzavBtFLyCTbGPxHC9TjXNLUb2G7Fo0afVINbvWnMDX8geyxsSavgPbDtFR/ikkQqjFFLHEJMG8wn8zfagzaLNdGOhmofw9p7a0daLhMi9A3tHRt+gJfkkYIT88ZOs4O3RUnYAR6RVCYkbw/CTdrTXYG2J5yOOO9Q8d+U0yXvDzc1+4xT56+/ASp84SKr3JbgPNvKVX1Uru6MaxOyDoMAV4LGSfte7bc/YKA7L1rTp72aaQC0cJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MzyiteVZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MzyiteVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjwvT2bnZz2xSN
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 11:57:08 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43cfbd17589so17756f8f.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 17:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774745820; cv=none;
        d=google.com; s=arc-20240605;
        b=TZzZn7ywkNDM2QJ0dKr2ORoeBuKlmhGjV+ivcDr8MGuJ3ef0RzibRNhx8goWets3kt
         d1DMBaCGMxErGOvyOden5G2WSFCV3whvWlxNGHh28W4nHZA5DJMYJd2z0X01xySuqnp7
         3SMMmRqzoMvfUmDS23UKWmy/LXe62bzoYoWyXlpsK4QltZR21GNZ6bN7QVtaECnleFkY
         AsETtVwePCTJQcW5c7/Y1+9nIFnf5cFS95Qq8vAo9qu9xM/XhhWQ9Ikdmj9pBD8OZ7rN
         SDLbgUjuSxTNkhCzKCYpGQoxhxWVD7vlgjJqWJupm8ObRRBfcCk1EszCFGC537dts+l7
         jgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=ygwZmk0oeWUSh8cTUDzNEQysyCcnKD33bnw8kSMRxdE=;
        fh=N1M3qaoRSFuA5GMoV6erJ9kLURDN3sAKCQF0GAlzOOg=;
        b=L4aGA4mhrILGDAC+D1wwNcJa3apwcvK/CMzrOwcGpEg7y/xTMg3bFeu6n0Xo8sT9bQ
         mbg2GfwAT58Rti3sMUk9nbjh3S9UGHZBzANRS08J4JxylqToxsE8ta2XL/hEWHl6oJu8
         tNhqtQ3FG/CnYz0xKOdExuvJk8BsaFgsPA32r2pqLKKawkoQCRx1n4hlCILxpFsVZU79
         UU+D15QuT6fOSW1rdB2KT79E8GjA1XSV6r/YgvdKImT+4DJ+DgDbjZ5lzNFJco8WFhvt
         pYwrcjpj7azg1Ls+FP+NMQKWOolHUIGsnEaxtPJ2jMa5MeMxvQK11wQ+3as3sO8Bf6Re
         fNxw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774745820; x=1775350620; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygwZmk0oeWUSh8cTUDzNEQysyCcnKD33bnw8kSMRxdE=;
        b=MzyiteVZ8eW33px79BCbHr0osNLdPzd2fmlKMIgYIVxMhlnG7r36Kn+8pJenyXfGFr
         1DXwH6332id6I0GgJOGK1WDaQTA+6gIOcg9IrgKbcHHZ/wXmvU0ruDIcEnRyLFdN1TyU
         Gc8fzvMFTOb+i/DIRWKyXdQT7eF2djZ67EyBUnpBhOwDrhl2SLN7XND8izoJ71weHT2N
         Kil5Tg1WTYsgjPkuuLonLXbSB7As+UFUFVrlmfgEz264PA0YYSXWO/tz0n6nkxahnpSD
         v8A+4a+CsRp1FbaYaV8m5YrrRgzpE6haYSjU9AiTq025l1iNASbA1wYEVtXmoh8puxPd
         HPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774745820; x=1775350620;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygwZmk0oeWUSh8cTUDzNEQysyCcnKD33bnw8kSMRxdE=;
        b=KYlZ2tCXjoamyLuXC3CFvNvgznAqHaxlKUNMMLG9FrwrMolEIYHY6klg6g3dinw8Y7
         l6aEACVYlf196tMBc+blaTjMvkpzoAp3mKJsmbsVzz91NrgdtVgpx5tMJRILYqIN82TP
         nlyFI+wVMLF6uxkPZujqq6vYkRQgWPrR/QplUSEJJfHyfh9EAKOCfmEWNjY7416r67Rb
         Bgr1XOt/yX7+qvTqwRY1KT9TrdFHaKe20Ouqe2kRT39VUNzF1BTg45t0BodEMu2LBGKI
         k5gpGC4WJTs0SymF8DEtJMZXQOgPAX8gUAoZyPgm/haRICjWn5G7mYkvjiZBFtN84Vgj
         TifA==
X-Forwarded-Encrypted: i=1; AJvYcCX2/6yhY8AQFeYnF9eFoVe0SSZxXOE7GHIoe4MPjADqqpb/6gTCh0t0QGPpbhcCP1c3y0tLC2uTqIYaOw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwsdKlTMiqKuRBch/A6GZtlkkL9LkvZznzAEUFJxq+3mBYyJWcr
	yipDVol1E3t1NKyIW1I8o0vEuIdqdnn8tJaNA2Q+Qg61AJuYqPDUCn8gdPQ/rKsAnpPdlH/a3pb
	bS6jJ5dPQif9qZLJx9wLpLbDx88ETF3E=
X-Gm-Gg: ATEYQzy58xYegYc3IwbYR85A0+7llD8EnGBm5oQPe1kQAF9vgBJIehmolr/02H/PPMy
	c3wleN3aceTbxwJTIPPe80PsnM+DtDSjZ/mYZhcSk+C2huYCAIwUC9ShWl+bwdlmVX/W1U5i+rZ
	qcwcflFMl2GhKKqujvHr/uTCq+T8Arx/HvAtwjJnrPEpQ2E2O27Uwtwj+UxaVyzpGR1XYhQ2ybK
	hX6ev8cRVTDEM1EkEfuKwWRE8v7wUduotmiBSfa7G5NrDdBiMxCUu8KhXl4V17Z9h0Fyq83iP8f
	yCqot1AcUMg9NtM1LksCRWfNQyyN79Pr4Ynd/OSE
X-Received: by 2002:a05:6000:40db:b0:43c:fbcd:4b65 with SMTP id
 ffacd0b85a97d-43cfbcd5421mr271797f8f.50.1774745819861; Sat, 28 Mar 2026
 17:56:59 -0700 (PDT)
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
References: <20260328201555.5192-1-aghi.saksham5@gmail.com>
In-Reply-To: <20260328201555.5192-1-aghi.saksham5@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sun, 29 Mar 2026 06:26:50 +0530
X-Gm-Features: AQROBzBnFGdj3jGPt3BI7uUqqqfDFgFUcfc7D-parD8TlEe9XptNtk94kcitpOg
Message-ID: <CAMhhD9gRZTgxOqVJ0np9JO4kUuNBao2e2WEMmhfGCjwzdogqiw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix typos and enhance installation guide
To: Saksham <aghi.saksham5@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3072-lists,linux-erofs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,install.md:url]
X-Rspamd-Queue-Id: 47401350628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
The two "plusters" -> "pclusters" typo fixes are correct.
But for the INSTALL.md changes, there are few concerns:

- The Quick Start section only covers Debian/Ubuntu and mixes required
  and optional deps (e.g. libselinux1-dev is off by default). It also
  duplicates the existing build instructions already in the file.

- The multithreading section is already documented in the README
  (lines 91-93), so adding it to INSTALL.md feels redundant.

It is better to split the typo fixes into their own patch so
they can be applied independently of the INSTALL.md additions.

Thanks,
Ajay Rajera

On Sun, 29 Mar 2026 at 01:46, Saksham <aghi.saksham5@gmail.com> wrote:
>
> This patch addresses several issues in the README and docs/INSTALL.md
> to improve the overall documentation quality and provide a better
> experience for new users and developers.
>
> First, multiple instances of "plusters" were found in the README file.
> These were typos for "pclusters" (physical clusters), which is a key
> concept in EROFS for block-level compression and data management.
> Correcting these ensures technical accuracy and avoids confusion
> for users trying to understand the filesystem's behavior, especially
> regarding the "big pcluster" feature introduced in Linux 5.13.
>
> Specifically:
> - Fixed "big plusters" to "big pclusters" in the section describing
>   high-compression image generation.
> - Fixed "4k plusters" to "4k pclusters" in the compression hints
>   example section.
>
> Second, the installation documentation in docs/INSTALL.md was updated
> to provide a more streamlined onboarding process. A "Quick Start"
> section was added at the top, listing all common prerequisites for
> Debian-based systems (Ubuntu, etc.). This allows users to quickly
> get all necessary libraries (lz4, xz, uuid, fuse, etc.) and build
> the project with a single set of commands.
>
> Third, a new section was added to docs/INSTALL.md regarding
> multithreading support. While multithreading is enabled by default
> in mkfs.erofs if the compiler and environment support it, it was
> not explicitly documented in the INSTALL guide. The new section
> explains how to explicitly enable it with --enable-multithreading
> or disable it with --disable-multithreading, providing users with
> more control over their build configuration.
>
> These changes ensure that the documentation remains up-to-date
> with the latest features of erofs-utils and provides clear
> instructions for both new and experienced users.
> ---
>  README          |  4 ++--
>  docs/INSTALL.md | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/README b/README
> index 1ca376f..6f9e761 100644
> --- a/README
> +++ b/README
> @@ -122,7 +122,7 @@ images.  Users may prefer smaller images for archiving purposes, even if
>  random performance is compromised with those configurations, and even
>  worse when using 4KiB blocks.
>
> -In order to fulfill users' needs, big plusters has been introduced
> +In order to fulfill users' needs, big pclusters has been introduced
>  since Linux 5.13, in which each physical clusters will be more than one
>  blocks.
>
> @@ -159,7 +159,7 @@ write a compress-hints file like below:
>  and specify with `--compress-hints=` so that ".so" files will use
>  "lz4hc,12" compression with 4k pclusters, ".txt" files will use
>  "lzma,9" compression with 32k pclusters, files  under "/sbin" will use
> -the default "lzma" compression with 4k plusters and other files will
> +the default "lzma" compression with 4k pclusters and other files will
>  use "lzma" compression with 16k pclusters.
>
>  Note that the largest pcluster size should be specified with the "-C"
> diff --git a/docs/INSTALL.md b/docs/INSTALL.md
> index 2e818da..d96b15c 100644
> --- a/docs/INSTALL.md
> +++ b/docs/INSTALL.md
> @@ -4,6 +4,26 @@ source.
>  See the [README](../README) file in the top level directory about
>  the brief overview of erofs-utils.
>
> +## Quick Start
> +
> +For those who want a quick build, ensure that the following prerequisites are
> +installed (on Debian/Ubuntu):
> +
> +``` sh
> +$ sudo apt-get install autoconf automake libtool pkg-config uuid-dev \
> +                       liblz4-dev liblzma-dev libfuse-dev zlib1g-dev \
> +                       libselinux1-dev libzstd-dev
> +```
> +
> +Then, run the following commands to build and install:
> +
> +``` sh
> +$ ./autogen.sh
> +$ ./configure
> +$ make
> +# make install
> +```
> +
>  ## Dependencies & build
>
>  LZ4 1.9.3+ for LZ4(HC) enabled [^1].
> @@ -45,6 +65,18 @@ $ make
>  Additionally, you could specify liblzma target paths with
>  `--with-liblzma-incdir` and `--with-liblzma-libdir` manually.
>
> +## How to build with multithreading
> +
> +To enable multithreading support for mkfs.erofs, use the following:
> +
> +``` sh
> +$ ./configure --enable-multithreading
> +$ make
> +```
> +
> +Note that multithreading is enabled by default if the compiler supports it.
> +To disable it explicitly, use `--disable-multithreading`.
> +
>  ## How to build erofsfuse
>
>  It's disabled by default as an experimental feature for now due
> --
> 2.53.0
>
>

