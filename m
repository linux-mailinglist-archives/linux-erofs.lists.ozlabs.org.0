Return-Path: <linux-erofs+bounces-3106-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEREBdEfymmu5QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3106-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 09:01:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375633562AF
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 09:01:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhxN56bZz2xpt;
	Mon, 30 Mar 2026 18:01:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::334" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774854088;
	cv=pass; b=CBxlPH3HiIfgzhSOaRgy1AVf/55aATXNIHAatDk08ieWz7+aChRFTMuS2sXmmwCQSB3B/Xt7E5tdQtKnEi0rkZdPdwz3ux9p23nyPbJx6Gd70u4jEFxfE1/3xwtZrPc7Ax5NCwUnsQWiPKYhtpXKrCdGgYMrzdtGdxPZ6E5adD5MszEeK1FKx6Fphhht+G0A3rt0oLpbfEVqytPmDLkvFvpNl7frxOVFei2ez22dIHxACOyp37knZWeUEyrwd2RrdA/6AwF3VHogeU4bC10KRUSAN27CAdTcEBWst3qzAXSkPIqctIbopZp2U/RJV4baaj47ZMrqrnjxFclGzyM6bQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774854088; c=relaxed/relaxed;
	bh=sppRpCouAGUIZOqQyXhqmWC7IWa8vHh1MtIhDK9b570=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4srs0JyXmFmJ6wESbmeyXeKzOSpq80N4SVo5UMHvcrJuhSYKiaSY/cS51jsvTJ6PXfeVC/jk2hcshkWudDdl11CKlMi2tj1cMMHk4i7UAW+FBUfyC2Hf2YfQOdYyhB+kbo5J0dWrAkQCC7GJBrLDf7exeT6xgROa8/0zKd0tz7Upp2/mXvInxrhyovOyGfHW3f0gUrKOS0KPX+foVM6AJlkhOCGDF+165l1+O148maF69a9PHwRORd3OMQn5jZHltU/ySL5ORgWn+U/eLS9sY3ETeHGU8mr4v2EqfPQssCIiqg9t3n9LAt7mWZ5LmCT+U492r/OY2MIB+hBadLpuQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m72Y4ruF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m72Y4ruF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhxM3J8Lz2xT6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 18:01:27 +1100 (AEDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-486b96760easo44900595e9.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 00:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774854084; cv=none;
        d=google.com; s=arc-20240605;
        b=dRaG8Wu4prdezuTHK1dMIyhaZDhwjQr6815zuBBgqEW10Lwt8D5MGaI0bFln4c1v7v
         Gc8yCXsEb+YCivg/RaHHrZRjhCrsTbo6+UGRCwlxt6+8M80EKyFdxBt2m3E3KZXJbY65
         /vOXoBlyDiCK1t+8pNmZ5DyiSy9hf15zzuEfsowx6ww9Xv/hp7osemolpmb70XWnr313
         vDUwD0FH3YkCzGUEvW2ONZqleIG19rie0LI0TzWRHHGDs7sW3U+1F2HPFfB1ObdroM79
         Q4UK3nevGO1Iq8qS+VJFOk7Z/7Gdty0vIdEcxUFjIXTdz7DCERK+zoStG97JnLrfHAck
         LdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sppRpCouAGUIZOqQyXhqmWC7IWa8vHh1MtIhDK9b570=;
        fh=9Wn/3jJ7cxXJ0f0APmYc1WKS3OekWYAY1EBckSr/YzQ=;
        b=R6jV1O8fHWcQEj1q308cKJ3BCtZTkVeuWKUdX+UWYS4/A8eqEcopD+IRz9acqd0r/U
         xotW4frYnqwXoTa1cwsW5uqcfSkGQIkyVY2FQD5iCiMIS1yDOI6ZtYPUpA5mKd6Vmpjs
         t22VkoU85aIkkAyQXodx7R+2NQNe3MGxD/Qc6cnlzlxzulplLi/CmhAmzBm7kmJrs+TC
         YhujJNptZ5oeyyUSy0pQDkdNOLkpWWZ42l8fPdlxXJ4mbcxAiDo1w1AZPybj59UdGX5Q
         lNwzFYnuULY8QeCmiYcpETOR6cXa2VkNl2GczPm9jPyzS7acI6YLAdCR/SZChCa6LUol
         d4Sg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774854084; x=1775458884; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sppRpCouAGUIZOqQyXhqmWC7IWa8vHh1MtIhDK9b570=;
        b=m72Y4ruF47lhdWxI3Bq6HlfrlH8CXHfG1CGHL6v1daHROv5aENUpozZbraniMfDVN/
         W9T/XejQGeG68DLCYSoD60h2fLMgqZPj3CokoMNtS/d0FHtGv/Ojku1c/GKETxWtvFKQ
         qz0FUJZN1Fvarn+low27QZvNgg5v0LQXJjdqdXwxbUFel5vxgUfOFgXNSE1Ci44abqJD
         BQ9wN+wkfsuEfsz1Q07G4ZoPN5QTYyl5UkShXQ5xxqP0PfhjSWzT2kox04IaZWFPXHyj
         Slw0g4qIT6rlRrbTKgBK1rEFgi6WMEdeugcPY1T9WYSApPJbszfQ89YKkPqjt6xtPboy
         njvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774854084; x=1775458884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sppRpCouAGUIZOqQyXhqmWC7IWa8vHh1MtIhDK9b570=;
        b=gVSnOPrxcPfuRh72g23QEr5jMj1ivzSmRis/e60wLwkkzQM4g2ixsI7RhQqsibxslj
         ykCUJpmPUlxsniplxRGaUL2JyD3PUyzJSq4X/QR9NntCbxxRQq9raWMTDZOLm7HZCtgl
         HwSlPMyEO7LVlgG0O8Psz/sW8n6L2f3yQCRFv/B+7gM3YOLi5w3fGxGSp9FGUXTFO/fJ
         vwm0CUoEKL/Ytfr55+JWJYN7t3mtSIMUp+YxZORmTRnYVGgZadHXu9RReTJCn7/7tVMd
         HKN9KYNnYoD8gEyyKWNPDoSJYnv7jNEYAFT21tQ4Hk1afGuNZ8GAm22pywIXwkwQS7Ag
         C+Fg==
X-Gm-Message-State: AOJu0YwStGGcG/bWztfY0LslkiqMn2HMoH3cn/5qo9N6zqHS73BMN4bH
	jF2y/FLyABsVf7NlUUHP2ameg/it3huXKezjZmDWSOvg+J4EJU+viNphWG5x4u5uCtlZJofp+Vj
	yDscqRULEwckTtMudG83iZKAZo9197pM=
X-Gm-Gg: ATEYQzww3LHv3uoemXEpwiM+HFoHGRgBIPKwz/Tc774jpv6UUlLSanrZkYhKgsZdIS5
	53XJTRi+Xz8Gv3eT1b40P2zzAg7ewuPzA29UJy3cCds6SckxmtQVkSbLQNSVYFOgrbeYOhATLcI
	nZcb1uEnQQwH0NCME1i66ffFXXy7LBymGe+DeZbGt+zVqxQG4iJEGJKKCYuHyiIq9qOk6/SELBs
	Z4hL2h06mhtCqHccQl4iZNhecklkXz/dDDmIS/+IHoRPapS7ChYFh2FHPA27nRpCSdGh6gUEFSC
	qy5rmWbOyR1QjBBxsnHo/RRxAY6K4oPSuCA2Zupc
X-Received: by 2002:a05:600c:1f13:b0:487:169:9f64 with SMTP id
 5b1f17b1804b1-48727d73709mr186563405e9.12.1774854083891; Mon, 30 Mar 2026
 00:01:23 -0700 (PDT)
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
References: <20260330052840.12730-1-aghi.saksham5@gmail.com> <20260330052840.12730-2-aghi.saksham5@gmail.com>
In-Reply-To: <20260330052840.12730-2-aghi.saksham5@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Mon, 30 Mar 2026 12:31:05 +0530
X-Gm-Features: AQROBzBuPUNAGP7R4z_1-YTKhlu8TbvQ7JoZNy-RBD87gpfpTY7juLyma8yG5Bg
Message-ID: <CAMhhD9jVBbB92+eAn_mAwp-yAXamRh=Z2H=XiGiS+4kdfdmRNw@mail.gmail.com>
Subject: Re: [PATCH 2/4] erofs-utils: fix typos and enhance installation guide
To: Saksham <aghi.saksham5@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3106-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MAILSPIKE_FAIL(0.00)[2404:9400:21b9:f100::1:query timed out];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 375633562AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Saksham,

This patch is exactly the same as [PATCH 2/3] you sent, You have sent
this same patch 3 times already. Please don't send repeated patches
again and again.

Thanks,
Ajay Rajera


On Mon, 30 Mar 2026 at 10:59, Saksham <aghi.saksham5@gmail.com> wrote:
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

