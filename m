Return-Path: <linux-erofs+bounces-3073-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0zXKJ7t6yGnbmgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3073-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 03:04:59 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B4350639
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 03:04:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjx4R64Llz2ygd;
	Sun, 29 Mar 2026 12:04:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::330" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774746295;
	cv=pass; b=cf8E7f51+kFaMq5rfDCQDRTp3sCLt0cDaOeqACNjsQ9v5uX55IvZ6sCnnl7wrDM880Zo/koI+Eo19SVPczc3WDUga9ZuO4TQwAF8ZugLKZskSsZjAYjikiYsgiwXA+EMlfA7Gn9fwfpkDsJmmUd+XeaXDgkbGDmd8xPpETUoodNsLJi2d7K0+gAEDP8A02SZa1ZHrC/wcv2xCxSHe1GA1YIQVtOnw5ElG5r3Lphb7FE5RvUUMf1w+qFYUP7lMDA5PAnfIs9uX6QLQ9hm9KrTsLyc0KnOt9Tq3+fzmfwlPJaDsV1ruqj9oGzNmYgqK++1Foh/fiAkh8RzvLeW5n+99g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774746295; c=relaxed/relaxed;
	bh=sNreSMZpBtA0cm7YcS5mSFx2U5astYECf8+l2/7kAQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KCLdNN+EO44WQl+qKo2azGxDP4oTeYOuSBx/DR+dG0kx5eZRRZANB29lzARlV3tlxyM3wA3AwIAshmHy9sQrNhRpOwk8R7Ki7yOCIg1ViYPR61yMHgpKqenguHkv0EG+WVvNUgAm/MIQob2Gqjb1GLdtvoAYdpJUGwrn/0MGk14+nNQct97wF6bN5m2TKRLdnpi1RgvRHNvcG9Q/CtZCtwtibvXGUTE0/73vhohK5vLqctdOkfIm5cDLpnPGNXbEpSZs2ozOB+qvVWLNUDwgY2G+A5iUBoyHmcluIv0g1bD9Lz7FeE5mjtHtQPTDQkoIqBYf1mUqCoPcVD3n3IloOg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlltbXEm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlltbXEm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjx4Q1cxZz2xVT
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 12:04:53 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4870206f73bso19483255e9.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 18:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774746290; cv=none;
        d=google.com; s=arc-20240605;
        b=G+JGOk5lUhfTjg0F9emsyq6W+1j0zE9SiGezwLdqO1Ef6q+ynVdKKq/n+jjD4q6qOc
         OKtTAjnJS9alwSDPuDYLGZpADt3XCjkvw00RE+5EvhoADg4HzrMJiJo3xvkNj36cKWYA
         B9TrGe7HRAs1vX1H+n1oiHmRtlzpOvMVeZa2CH4+qvT8u3X2AfJl1dWMdRfT0PWlOGnq
         m6gQQZE9EETdSQNTf0FIZX08hPHfGOy5SX1eKf3YzPgEMkm3pR/UiKawUaJJVLVks9Jl
         iedvJgrjy5qT8J69dGeLTxooCbximse74MUyhavvvWFE3Us0w+unlYIKC1mXQGsPLord
         grPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=sNreSMZpBtA0cm7YcS5mSFx2U5astYECf8+l2/7kAQU=;
        fh=XxvPZv+Lqi2RGFOO86L+41VbmBYsI66wQPz+68YTBQs=;
        b=ghNqAqttSOAPTbXfvxWWQLYEGy/onssGUOPggNv6OlEVGVeicisdWBSGZDSvcaW7V4
         3ToJUf8+xT/Ax4rJim/gOGrNlp1XYPs9n6hAGbXUXIxSUI9tF0Wbfd/HXasCK9fsRese
         csarkbKW7CC5eOKl1OGa/FoY54rCQP38vG41hJFU18346RZtMaPLOwbeDUPit1kXlLoG
         4Ane/YTD5f+ghdKYReCowZxYxhBqW1JSyX7o7zCDGHfzkkXtvDIoUmLvCHr7MHKoZI60
         D2tmZB4W6lhNApkQlRp5Jc1EtiDZ/es0KcxrmBEdQ3BKlGqmKZm8kx0gIYqdhXE70rC7
         FWUg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774746290; x=1775351090; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNreSMZpBtA0cm7YcS5mSFx2U5astYECf8+l2/7kAQU=;
        b=mlltbXEma1gTcyblIh2kxz9HUkCpIAJlEM6E7deo95T7QlN2/JkOlog/jSRPZDUB/A
         Q6i8f+Pv6BgzDVA2oT1VbvQjbU5V/+HeK0/nq7vAaHuQ6n1SR88QWS5ZXg/xsYuR5k5D
         9cKQ9kAfcuMiIA83VsvnSepHPOE/iHc/BAGSJjQ1VTPsgNpUqgev3F1LsZnuedsyNg1h
         Mfp4Xbi4/71lnd+X5E7XWo4RW93FOUU4UEvQdlH3bl9uQTvwSPaAWJnK79qocV4VYeMA
         LhJp08qXrNk7iyNfHOUEPJ4iqxk8juKLYvEA+2ftHkN8td3ry0gSlZEKqQps+MRHJCC2
         +0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774746290; x=1775351090;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNreSMZpBtA0cm7YcS5mSFx2U5astYECf8+l2/7kAQU=;
        b=Aip0RWjeo2GvapsKmqfGsJFBq3fIEc6/IZmRoNSSXenkFsjO8xLpx+pBX4x26PgU2V
         QkPRfawZ6kiWpkZn/nMffdiVLy3yIikFaZYR5P0t3y3cGfT0/pCyixn0pzu2gRxorQRU
         vxji0g3H7DuYH5DPwc158utgYs4Y3hBjfEthianj2yzClqLyS3T4KwZ0GmXuDUbEuyAh
         eChz+bc9RRQnl67xoQDUx6pjLNmfpLqk4jt++Td8R9ORYPe+ibSvSLlgXNEDvzkCJkAH
         lS0GmLX5PmMICTcSAA7Fnm99/A8VlCFln0IVsFJws41ElJvR6qeOoM2T+/aIoiaHaHd5
         aPDA==
X-Forwarded-Encrypted: i=1; AJvYcCVUi/V2Ahjx5fg2VM9WgYAZtHT/S5Sii0z5JMbyd5huiyqMM30Vsy+XRmuqZ33c7IuyHRUfD4OvGGK3mA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFhXW/2fFrpmI346/iw1e3iVxP6mAhJkd63GFd+fLfcbDT4NPh
	f5bzlgrl/3ZG8P3Y8Fohm+MJ/GrqjRNbhtN1DiMowwLnpf2EXaHfIFww9OvvkWDieItr/ysnUsD
	xXwT2ka4TWBP8Jue+6Vfg7zBBZP6AOq0=
X-Gm-Gg: ATEYQzwGH2Ph1Y7urD/8dJk50Ra1XwcGtSvb2znLYNsBk9ZxTLRje/uffr5R8O+fHfN
	mS0Uuxo88Liuo9jAsLMGJKq51+aYJKKKW6SRNLo7EPydMRvB7SFTtP+fY7LgT1x8mZKawY3zja4
	aQ21Exj8jmo+66NxKcrniGQh4heVThMgoz/yN76w2F/lbP9j1uJuzOgWb1ipULQmYlCv60Ax1WW
	qVHtLKLJVF5JQLDmnkvo7vyw7ebI84dBu5skAhvxvhfRuzREd5VU757itiVD17yIkNRBFA0FYww
	OCiQKEK4AcaNNfTEFace3ASHTkY0RmLz2UI1YyOKuCbSVS4sx8A=
X-Received: by 2002:a05:600c:c102:b0:485:3812:36f6 with SMTP id
 5b1f17b1804b1-48727f7bd61mr91625075e9.21.1774746289645; Sat, 28 Mar 2026
 18:04:49 -0700 (PDT)
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
References: <20260328201555.5192-1-aghi.saksham5@gmail.com> <CAMhhD9gRZTgxOqVJ0np9JO4kUuNBao2e2WEMmhfGCjwzdogqiw@mail.gmail.com>
In-Reply-To: <CAMhhD9gRZTgxOqVJ0np9JO4kUuNBao2e2WEMmhfGCjwzdogqiw@mail.gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sun, 29 Mar 2026 06:34:39 +0530
X-Gm-Features: AQROBzDWPnUwEg3f2Z5J1LvPYcXANHbdbACdbBzZ3xxTfS4F7RVR580R0pBIakc
Message-ID: <CAMhhD9jUqxY3H7Let-cnpaOh3vijL7jJ78=9zEjw0yDRA8F6WA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-3073-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,install.md:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AB7B4350639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi,
Also, I noticed your commit message is missing a Signed-off-by tag.
This is required before any patch can be merged.

Thanks,
Ajay Rajera

On Sun, 29 Mar 2026 at 06:26, Ajay Rajera <newajay.11r@gmail.com> wrote:
>
> Hi,
> The two "plusters" -> "pclusters" typo fixes are correct.
> But for the INSTALL.md changes, there are few concerns:
>
> - The Quick Start section only covers Debian/Ubuntu and mixes required
>   and optional deps (e.g. libselinux1-dev is off by default). It also
>   duplicates the existing build instructions already in the file.
>
> - The multithreading section is already documented in the README
>   (lines 91-93), so adding it to INSTALL.md feels redundant.
>
> It is better to split the typo fixes into their own patch so
> they can be applied independently of the INSTALL.md additions.
>
> Thanks,
> Ajay Rajera
>
> On Sun, 29 Mar 2026 at 01:46, Saksham <aghi.saksham5@gmail.com> wrote:
> >
> > This patch addresses several issues in the README and docs/INSTALL.md
> > to improve the overall documentation quality and provide a better
> > experience for new users and developers.
> >
> > First, multiple instances of "plusters" were found in the README file.
> > These were typos for "pclusters" (physical clusters), which is a key
> > concept in EROFS for block-level compression and data management.
> > Correcting these ensures technical accuracy and avoids confusion
> > for users trying to understand the filesystem's behavior, especially
> > regarding the "big pcluster" feature introduced in Linux 5.13.
> >
> > Specifically:
> > - Fixed "big plusters" to "big pclusters" in the section describing
> >   high-compression image generation.
> > - Fixed "4k plusters" to "4k pclusters" in the compression hints
> >   example section.
> >
> > Second, the installation documentation in docs/INSTALL.md was updated
> > to provide a more streamlined onboarding process. A "Quick Start"
> > section was added at the top, listing all common prerequisites for
> > Debian-based systems (Ubuntu, etc.). This allows users to quickly
> > get all necessary libraries (lz4, xz, uuid, fuse, etc.) and build
> > the project with a single set of commands.
> >
> > Third, a new section was added to docs/INSTALL.md regarding
> > multithreading support. While multithreading is enabled by default
> > in mkfs.erofs if the compiler and environment support it, it was
> > not explicitly documented in the INSTALL guide. The new section
> > explains how to explicitly enable it with --enable-multithreading
> > or disable it with --disable-multithreading, providing users with
> > more control over their build configuration.
> >
> > These changes ensure that the documentation remains up-to-date
> > with the latest features of erofs-utils and provides clear
> > instructions for both new and experienced users.
> > ---
> >  README          |  4 ++--
> >  docs/INSTALL.md | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/README b/README
> > index 1ca376f..6f9e761 100644
> > --- a/README
> > +++ b/README
> > @@ -122,7 +122,7 @@ images.  Users may prefer smaller images for archiving purposes, even if
> >  random performance is compromised with those configurations, and even
> >  worse when using 4KiB blocks.
> >
> > -In order to fulfill users' needs, big plusters has been introduced
> > +In order to fulfill users' needs, big pclusters has been introduced
> >  since Linux 5.13, in which each physical clusters will be more than one
> >  blocks.
> >
> > @@ -159,7 +159,7 @@ write a compress-hints file like below:
> >  and specify with `--compress-hints=` so that ".so" files will use
> >  "lz4hc,12" compression with 4k pclusters, ".txt" files will use
> >  "lzma,9" compression with 32k pclusters, files  under "/sbin" will use
> > -the default "lzma" compression with 4k plusters and other files will
> > +the default "lzma" compression with 4k pclusters and other files will
> >  use "lzma" compression with 16k pclusters.
> >
> >  Note that the largest pcluster size should be specified with the "-C"
> > diff --git a/docs/INSTALL.md b/docs/INSTALL.md
> > index 2e818da..d96b15c 100644
> > --- a/docs/INSTALL.md
> > +++ b/docs/INSTALL.md
> > @@ -4,6 +4,26 @@ source.
> >  See the [README](../README) file in the top level directory about
> >  the brief overview of erofs-utils.
> >
> > +## Quick Start
> > +
> > +For those who want a quick build, ensure that the following prerequisites are
> > +installed (on Debian/Ubuntu):
> > +
> > +``` sh
> > +$ sudo apt-get install autoconf automake libtool pkg-config uuid-dev \
> > +                       liblz4-dev liblzma-dev libfuse-dev zlib1g-dev \
> > +                       libselinux1-dev libzstd-dev
> > +```
> > +
> > +Then, run the following commands to build and install:
> > +
> > +``` sh
> > +$ ./autogen.sh
> > +$ ./configure
> > +$ make
> > +# make install
> > +```
> > +
> >  ## Dependencies & build
> >
> >  LZ4 1.9.3+ for LZ4(HC) enabled [^1].
> > @@ -45,6 +65,18 @@ $ make
> >  Additionally, you could specify liblzma target paths with
> >  `--with-liblzma-incdir` and `--with-liblzma-libdir` manually.
> >
> > +## How to build with multithreading
> > +
> > +To enable multithreading support for mkfs.erofs, use the following:
> > +
> > +``` sh
> > +$ ./configure --enable-multithreading
> > +$ make
> > +```
> > +
> > +Note that multithreading is enabled by default if the compiler supports it.
> > +To disable it explicitly, use `--disable-multithreading`.
> > +
> >  ## How to build erofsfuse
> >
> >  It's disabled by default as an experimental feature for now due
> > --
> > 2.53.0
> >
> >

