Return-Path: <linux-erofs+bounces-3101-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFJFM1gSymn54wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3101-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 08:04:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE80355D1A
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 08:04:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkgg85pVTz2xpt;
	Mon, 30 Mar 2026 17:04:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774850644;
	cv=pass; b=b3LljzcHEqHhuKskiFCztDumNyaAhY175SCEwjww2HWwf4KjXex7Z615SaiZuaQhFMUAdN1EEElOQioN05BeLamleHJDAHDF40jOBNjOZ2sF6LEwoaOXtof2jjHKTWi3o31yjQ1hd9dnYiHjgfhrik+X0fTXtHcOVOiLwb0jHFGFj4Jy6Y/Tu6+vV1FUc1VbX+KnnSo4ska8GklfV9vLRKA4YIwE//GI1DBINWn5LL+wGAIhrlcgMecNf7Awg5BEZA1f3r/1ZOIXiMQDp3ZO+Wf1sZPWSsGVPzdmqQsGaTa5+336gEdV5oK+2O3npJvVbYH/VX0L04mRUq0EbmgDhg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774850644; c=relaxed/relaxed;
	bh=QCCecy5K0RB6X0tgyJMQHZ4m2288b0qzvWqBRKTO9Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npADS4oXMHqdpN1nh+e5IOhrZlZiGYUN7fOnAS6DAAEkdlwyIQG2uPd8q1YJIjnhQZGwgxx6/yJu/DEezRlVzCJ897WwxZnoeHXxr5aQsv1o8hl+8w2swswNs0G1JgRvhcn0bpXKYf0I+1GMWXm3yWmApyxdmRiO1hqSjTLcJaC3v1SQN+fqIe3rElvbTxAYzWjxv3g7naCkpnkLRjnbS5oTdWX9LX8F3jYKEVD7b9HHP9zuOL+QDGSstT/YIaa4CXG9Qn1+nd478scqAYPv9X7fJf2Hw7AxnnHx+nnFhVWcVOqXG6VQfEBJUJuYBMEJ3V/GxaDxDG2fytgb4wm2kA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X32905J0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X32905J0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkgg73tt9z2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 17:04:02 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-43cfa33a983so510422f8f.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 23:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774850634; cv=none;
        d=google.com; s=arc-20240605;
        b=hO8vyQBgv/7TFdu6C/7QOoVDu+ZZD1h0PONryPN5oR1Mn1Q8nNopX+IHXXiD74eOhW
         pKI0UO56Q2X5cLWuCQYqNDI8Nn4fOjr9P2j7ek4kaaNPAm5zK8YKg6Vfkc0WEaJ7Xoxi
         Iy9hkis9B1BPfQM3UkyewjnmcF/dGFi+qSuLDeoAnyxI3QQJw6LhA55rrFYrDRI4WjfK
         QBO+NygMXPypqpxgvZJezTFe+Ba3QZahDB7DXlM80DiHhjrsnEAPsUGBi8qKFqq420o4
         daMPrskz7lVRw8gNUGzAOEHrS47Mx8trVsmlwPudFQUxacOqgR4xmPg0BKSZQen7cBIX
         rDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QCCecy5K0RB6X0tgyJMQHZ4m2288b0qzvWqBRKTO9Fw=;
        fh=9Wn/3jJ7cxXJ0f0APmYc1WKS3OekWYAY1EBckSr/YzQ=;
        b=T1BN+hiVdoMA/15+aZuvxSrwCe8bmiRcGFRmCQHGu+zPeN8RaUHQ6YqShXNVVRvMAh
         bSwWaU+k+GZA6LUE3KeW4IoUPK2EAmoJsE9Tdk8zE6v96RzVcZL51ulrhF0UPXF6IhIJ
         9Cq8smJ/HoYdmk9OWamhyQQjtYpmweQ529Zndab/ip+Cj5yYgYLUQIaGN3i+UrVjEcrE
         bJ0UtDTxISnZV/Ytt9Ez/CuiU4lZfbCRy7rYWo4YTq+ZE824W80tx8Rn2hG9qxaFeYdH
         yLzEM+yyWg8126yAm4a8kZzv6M8RbRl1WPNjm4GDlmEKwcyzne4brDeA2/cSxFBCKtoV
         f79g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774850634; x=1775455434; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCCecy5K0RB6X0tgyJMQHZ4m2288b0qzvWqBRKTO9Fw=;
        b=X32905J0qCjRXrjDGmNJhBzS7eyssXw0DlYlP7lgl6qxWLEbcTS8cy2JF4IN9qSjMo
         PNIszXxhob4yvls5BJ3NaywDBoYyJmkWyUDhJcL5s+2hhPEuFaOd6Ed0b3W7JRE9Y2Fc
         Y8Qc7iHFCQaQLmuWvzyj70svyx7VYdthc+iSR7uP0zAhWeDh+QkNMeZTSNbz6J6XxFu1
         Uid7IvqCLtFlkjR5w7zQ8gnG9JyDcQmLKnKFrVsrt55nfhL5smtvxb755+zeN+dCmX5F
         aJ3QorzF4clwf6eoTwW/mt/Ft2NkxMLzqesLs0FzJ1IBErIMx4+0ywZY7gA0Ix7hbUbA
         tCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774850634; x=1775455434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCCecy5K0RB6X0tgyJMQHZ4m2288b0qzvWqBRKTO9Fw=;
        b=hh5bNrrNz6FH/6ZybY4mfqoqg6RgywEYtZ0/nk85Osna6rmn+JZ8BuWF2ZXGopgZgB
         6+a0jNCSJ8vApSkUL++Toxn86WYX9GDPj2YNUFEEOzXRcXDp6c9IvyXT5kPiFP8l8u0M
         41jrLD7wBcVibxzLoURJDSlJTID1z7VH0ipW9jV7U3bE+ujgkMNsEi0KuuMirUBr3Leo
         +QtldrN1pUOpkSX6KR3ke4GH1DWvYBKH+P090yhE5RAupjtxPwMEk8CreER59sLfXkaJ
         bATxwv51mCpE3G3IydAp/UIqYmHidYBKdIVIwyWc1NzrT56RxYRt2X2fP+eMsLk0c6Tr
         4nXA==
X-Gm-Message-State: AOJu0Yz/3lf44+ZzsSJbcCcuofDTaIjWLINIeH9pLtWcy1M4wZe1qtwV
	vSRINvA6FNCVzG0rqfvm0EYx/TIG/THQiPbbg21EHfBJ0XFzt8x6mjT2eauUzRkpqqFrqegzi+v
	ST1HhyVvUEcQWYky2riQrjWx6BE4796o=
X-Gm-Gg: ATEYQzwhfTXlh8PyoYOMd0hUWShq4C9zXKftwQyID8erKM9JtX7WasLOvlohZa8rSTs
	KlmlmZWYwgkFlxGn8/BXfjmOUFIM43IQYQmyRwiXRUOpJOVYkCru1etb1wP2PnjoMujaxtfAuKa
	BcRbXDi8lzXChX3eRMpbU+VxS25QoEuI5+X+5fdgzjJkxZFzW7M/A0hDzG6/bZNRECoVd/0GE51
	2cxzH3lIeCmD8aOg0snpWjpamjhZv1bKMzJL6T7rK3ibD/lK1uIH/svB1L1Vq9WDoH4jGOW3VY1
	u8WfnH08l8Pp9iVvEKW7dhRy+EJ3OIlnYNwEDw1p
X-Received: by 2002:a05:6000:238a:b0:43b:9386:966b with SMTP id
 ffacd0b85a97d-43b9ea467f9mr19414259f8f.33.1774850634071; Sun, 29 Mar 2026
 23:03:54 -0700 (PDT)
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
References: <20260330052127.9173-1-aghi.saksham5@gmail.com> <20260330052127.9173-2-aghi.saksham5@gmail.com>
In-Reply-To: <20260330052127.9173-2-aghi.saksham5@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Mon, 30 Mar 2026 11:33:42 +0530
X-Gm-Features: AQROBzBF2R-xNC1vzlTuR4oEq9xP9GLV5YSqNocziquXrrp8VL7OQA7tOKsa9eA
Message-ID: <CAMhhD9jqTmpjT2RicT=rdmwHT7XduUvXcgjoCrEEFcZK77hRtw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3101-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 7FE80355D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Saksham,

The typo fixes are correct, but as Gao Xiang sir mentioned, we aren't
accepting patches for README or docs/INSTALL.md since the website
supersedes them.

If this documentation does move to the website later, a few minor
notes on your patch:
Missed signed-off-by tag again.
Typos: Missed adjacent grammar bugs (e.g: "big pclusters has been introduced").
Quick Start: Missing build-essential in the apt-get list.
Multithreading: Instructions are contradictory (it tells users to use
--enable-multithreading but notes it's on by default). Also, the
existing README still incorrectly claims it's disabled by default,
which this patch missed.

Thanks for the effort and I'd suggest focusing on code-level contributions.

Best regards,
Ajay Rajera

On Mon, 30 Mar 2026 at 10:51, Saksham <aghi.saksham5@gmail.com> wrote:
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

