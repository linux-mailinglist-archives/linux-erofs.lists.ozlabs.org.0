Return-Path: <linux-erofs+bounces-3104-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CuIEvMbymlR5QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3104-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 08:45:07 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B61D3560E2
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 08:45:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhZQ6QP6z2xpt;
	Mon, 30 Mar 2026 17:45:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::331" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774853102;
	cv=pass; b=Btsu+FQU6WPnBXf2JIWLMoRDAs8HFvxNeamKFywRGdFbpBF3xDnQXKvRxXKDhiLQ4NBCYjt6kjnQYBe+ibT1IEw2OEkEEgEtgVHLhyNSUqnWpSwXkZp+XgD3vELhhXtlc+2WzGmutmkxDGnXcN7wletYyY5xXE30gKoLR68vL7IfDiyIJv+er6vSGRDKZQA0PzmlCJfQFMR+rLphDW49DPMRktSg5k/+zpJkIWk6w0Dop4rxqWJgmjs59aNz2FizgA0OuYT/yvCofYbsX7AwMuAOa2cIiMSVuwwHF9Vm9/2cJXhcqX2GtIpQ7qup+/cEjsx6gsPque4eSKGUUR9SCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774853102; c=relaxed/relaxed;
	bh=a96MoiXGVi1nWQGSf0NykpdjOyEhXqCN2xxJgvuS1P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK7QTL8peFqwQS/oPBM4BtvS4oD/4eadrvs1CNALpq4wLqORzabwpm4JYXwJOSa7F1HOyZJ1GJUpTU8016eJFLBPhaqPn50JZd4tZegXrd87LJsCZ75dCvaVZBxcnH6UvrTaxSLqlb4ZgfcgC0aO1QsGHyv3BrYUaeJaiXI/gNte0v8qIsGkjjc6EU3xINbw24qfHc4Aj3Z4Ygl3hMojoPlo78SVsKDSzNpj3iRi9y0q4KRXI8/hI7I1kmYU8nNFWCfAESSGQIQ5Ho3nyQDRVNET1ZnR49SUvwGsTMyoG1ItKWqpLr5jKcP/tOpxMqE94wrgeBB7VBkHfREY44Vq4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GmzW/g9n; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GmzW/g9n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhZP108Mz2xT6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 17:45:00 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-48704db565eso54079475e9.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 23:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774853097; cv=none;
        d=google.com; s=arc-20240605;
        b=Zw9r/Q1GoclXFLrRkdtKN1gWAUxkllyzfi3haWuFIqs1nEdrJf5rlEPdV6HY/aAeRs
         Gb9y6E9ht8NVcLyp3Pbf/LkxWtK/sbUxBeGrWc0aBk2bvuwFt5/U2Hm5K/iJHo5bLa/m
         5W2vTu68v9PpO+lErmsKoW1BtO/zkkFQIRPjF86YRGfz6WgJBAtlGU10D6Zwgf60vNT4
         yaxDV9MugGzJnAxR2f6DAENZlz8y4J0Yz+mPuTZhA//twOI6zTEiIR3HaqN62C2MDv+3
         LYZUYkoT4KanC4pVyibKCZLo7/JjSG6YeR5hcYZjo/ncpcAxDpUR7dWmjkBOnIKRW4fg
         t68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a96MoiXGVi1nWQGSf0NykpdjOyEhXqCN2xxJgvuS1P4=;
        fh=9Wn/3jJ7cxXJ0f0APmYc1WKS3OekWYAY1EBckSr/YzQ=;
        b=CaYMtxbAdYT1UcsSyHKTVLljtk+P/imDf3qzXPCm7Kmq71PDkAg51TPzLvBM8bdo1O
         yUROFxw74cYiqXIPB2f5gqz7uRxlwUsjjKvoOUXDV8VqUZSgwGEUYUH68dLpKit8pYZT
         TMVEA03ZWCMoYgODLujmVqrkhLFbSns5U+vCvOTBq1VnoB91ZvzyvksmNhIP3rA55pX5
         YxiXbQ+zWJ0H6513vcuEF7uOydf+b25lc5Rm0PtZ+0NFn+LhM8mOsWDf+9MKrxY2WIJg
         sNKMaMnLnutWjJHVa8mvrfQOjVko+DFsHm9qISvXnFq4m9lYNV0Jsu5EJByfRuXq44JM
         APuA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774853097; x=1775457897; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a96MoiXGVi1nWQGSf0NykpdjOyEhXqCN2xxJgvuS1P4=;
        b=GmzW/g9nYY3w/749Tnt0DTGWUhj/uDAeUCi+5fyTYWGF21aeOMKv0kNefwS8wGcOmW
         M6ZNrGnX7Byk4CC1ftMOlswU2yvI6R/GHcBPNx5sgxFiJdmlR60B9IpsPoL7fjB7Lv5k
         LmDGG6JJVuIXBPUHPRJ+U8PADfon096AoUKjsufFlOGbHhKn+nns7usas0zqNYWQt/jz
         hxrFbrEkCgfTti0SEj/alz9OjgwI+RnNgTnKvINsfePAJu24j0n01Q0mJQxitsQ7sZoj
         QYNLfP0eMwz65mCcn6B7zeUaVdK+fssJvnFjZ5YM+vQw9o93jWvTt3dWLpeiIuLGHtWh
         r5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853097; x=1775457897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a96MoiXGVi1nWQGSf0NykpdjOyEhXqCN2xxJgvuS1P4=;
        b=VP++gAq3lOFaGzeGXjq2ZdHj8CX09v4SxeCv/ff6Tkoa6nyQMdYtd16duIintexUHi
         v2fa2M+LVVJziTxBtHBuvi13a3XyJ5Jy1BZ3rEIGEwq4JpRPwIWckci1Q5htMidMi0Go
         J2G7CcILsAfcRqSiJGhFFGEFebvz/N4JoHJ/YbLqZIo/4aJBfyILn7X4UHhMYxabKUn2
         wiq3O8Qx5CLhrvVUrUP2Gu8iueBgzTiUXtM140Z/rli+eL5kBc5skgQ9C/LXvN3ZUyXA
         0rM48yWbc9RKaeGmgBQmGNtWQv/kgKO7oZSNpLbFeed7flyuQWz612bEaSxBL3Af4O9e
         4Fxg==
X-Gm-Message-State: AOJu0YysmO94dDjCYRLgS0fVStX4EsMsp+rggpJY8a6N/z6UbE+Zty3o
	YwTUgsbG9DLee5NMtpK6pKO6yDIsphrDvtSEQ08D5PCJ0tyzhyIBZm27DMdL26BluJNnN/nbTjy
	II5X+QqKeY6jc9qUFCTHwCsst7t0t29dH43B/
X-Gm-Gg: ATEYQzwwyq5auIA9hTSXwqZzrZppRz1+526IldCPfNNWPZYXVO7YAskWKSU2VRsA9F6
	PflNdS/VS7KgpsF7S8oY7t70/WRN6Jt4cFQR5D+DlA0CrQg+vX8pU+ViGJcqwkj+0KSYhAZ5gub
	Vft79CJjCYmQ9gkV2zn9E/ROXWW5/6a3/Y/K+SAI533emzoewd3rKGIzWbpqow2gQu175mbCn/T
	gxAuB1tJ23gfcvMPdjyaac6rgPPWCnJmazc1W8oKYWXTA3AEMAiXPUtwf06UR3H9sDppWHPKrfY
	vrITKI7/HxGoh4HzshTxJHY/30uJL53kDx7G6QIe
X-Received: by 2002:a05:600c:a11a:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48727ee5405mr128893075e9.29.1774853097365; Sun, 29 Mar 2026
 23:44:57 -0700 (PDT)
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
References: <20260330052137.9273-1-aghi.saksham5@gmail.com> <20260330052137.9273-2-aghi.saksham5@gmail.com>
In-Reply-To: <20260330052137.9273-2-aghi.saksham5@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Mon, 30 Mar 2026 12:14:44 +0530
X-Gm-Features: AQROBzACuqz14zrGf0MScQ4zcfEl0XradrJOOuPoe_9gEzS9eKQtLvpDqTk6Di4
Message-ID: <CAMhhD9jm401Up5BuOt+yLyrbEK_eyL5hwgHvWc+rP8HWjpNEsg@mail.gmail.com>
Subject: Re: [PATCH 2/3] erofs-utils: fix typos and enhance installation guide
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
	TAGGED_FROM(0.00)[bounces-3104-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5B61D3560E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Saksham.

This patch is repeated, you have send this two times.

Thanks,
Ajay Rajera

On Mon, 30 Mar 2026 at 10:52, Saksham <aghi.saksham5@gmail.com> wrote:
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

