Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82FA80C184
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Dec 2023 07:51:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IAFyFMvF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SpXTJ59Ssz3vvg
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Dec 2023 17:51:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IAFyFMvF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SpXT95qwBz3vst
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Dec 2023 17:51:08 +1100 (AEDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b9ef61b6b8so2053631b6e.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 10 Dec 2023 22:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702277463; x=1702882263; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YctzTYntyd51jqXxmWwWW3nRDYDfU3b8oocrWrVlruk=;
        b=IAFyFMvFidfr1h3JsMscAt8n5gPItt19hirnJqiuzX8lnE8fhJCjGZOuNV4f+jO8ux
         OBM2pY4phjpJFJT8D86/INxCbiE4zrKcSkTCSEeAckIGN4Z7DIeSZ1cHczRmb87hcm7m
         Hr96G4NCh6Ivf3J4jihgjcbKl9jLcgMjmJckNrdsuqjtMvyr3IXpTIlTZs5ySlHzbkdh
         cO2WwyKceySKOVEfwZvgen9jFgwndtdL60Mqf1X4sIGyb8yd5P9SClE+3QRg4F/Sd8PB
         jgxIRqdb8LzyE9p0LFiEgVjmn0Ugk1XoOpGAYFwzBUvcr/5snUTdeGalMVcxQhbPkhZQ
         0OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702277463; x=1702882263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YctzTYntyd51jqXxmWwWW3nRDYDfU3b8oocrWrVlruk=;
        b=alAgYs2tDkKx9TnJpMo1QgScjaCgQadRUt9IEdVSEohK6mvbgSzAsEOAvpiMtSlnG7
         EpL9IBMFnV7dMFMPSsCdI914aIAYn7a9l8asSWN5lfkhJAvMUzalOM9xRnERyv002aWy
         w7MkNWsYduBHYbA7TIXk3GjWwm7zD4Vkxxz2Ht9zEvDVB8i0uqKDJAtqVQtJU8RmXDWr
         3iiKrrRrM2JIQW86VTneB7z70iJNXNbHN84jmXHue3ELB06BRFY3NCfGgiAzxYFPoCzB
         iAhfPGnDRxz6AtE9RnoNwZUmQEGNuAqF0Yr5AEzGwl4SRaJEGBDOmRnMS+aEXxpTNs10
         bcew==
X-Gm-Message-State: AOJu0Ywgdi6E3PSLY4kLx6FSbbg4LXhBwGX/BjvDlcSB+tVCIfMxjI1T
	9ZS/5CiKXn2KT17f3+9Tqlk=
X-Google-Smtp-Source: AGHT+IGeRQ1ftbcejenpH4uWLA+egcIaOW1gMT6Mg14LZVgPoMPZGIReGmd8m7mRuhAK6i30LrPfhQ==
X-Received: by 2002:a05:6808:208a:b0:3b9:f08f:6846 with SMTP id s10-20020a056808208a00b003b9f08f6846mr5059593oiw.18.1702277462917;
        Sun, 10 Dec 2023 22:51:02 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id 64-20020a630043000000b005c65d432119sm5533968pga.67.2023.12.10.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:51:02 -0800 (PST)
Date: Mon, 11 Dec 2023 14:50:57 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 0/5] erofs: basic sub-page compressed data support
Message-ID: <20231211145057.000067eb.zbestahu@gmail.com>
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed,  6 Dec 2023 17:10:52 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi folks,
> 
> Recently, there are two new cases so that we need to add a preliminary
> sub-page block support for compressed files;
> 
>  - As Android folks requested, Android ecosystem itself is now switching
>    to 16k page size for their arm64 devices.  They needs an option of
>    4k-block image compatibility on their new 16k devices;
> 
>  - Some arm64 cloud servers use 64k page size for their optimized
>    workloads, but 4k-block EROFS container images need to be parsed too.
> 
> So this patchset mainly addresses the requirements above with a very
> very simple approach as a start: just allocate short-lived temporary
> buffers all the time to keep compressed data if sub-page blocks are
> identified.  In other words, no inplace/cache decompression for
> the preliminary support.
> 
> This patchset survives EROFS stress test on my own testfarms.
> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (5):
>   erofs: support I/O submission for sub-page compressed blocks
>   erofs: record `pclustersize` in bytes instead of pages
>   erofs: fix up compacted indexes for block size < 4096
>   erofs: refine z_erofs_transform_plain() for sub-page block support
>   erofs: enable sub-page compressed block support
> 
>  fs/erofs/decompressor.c |  81 +++++++++------
>  fs/erofs/inode.c        |   6 +-
>  fs/erofs/zdata.c        | 224 ++++++++++++++++++----------------------
>  fs/erofs/zmap.c         |  32 +++---
>  4 files changed, 169 insertions(+), 174 deletions(-)
> 

Reviewed-by: Yue Hu <huyue2@coolpad.com>
