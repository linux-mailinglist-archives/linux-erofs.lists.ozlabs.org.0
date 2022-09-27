Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1E5EBDEE
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 11:00:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4McD9t3x3nz3btV
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 19:00:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=g58BAz3l;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=g58BAz3l;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4McD9n4H5Wz3blg
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 19:00:44 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id w2so9162838pfb.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FoWxL7OPF5Vt7GG7PGeiRRE+3SfmYsfHI6XYr9SmeEo=;
        b=g58BAz3lJ7SA0EDVHpTmY6Ubk/YayOVdFDT7CqDjA5USIPw2pvaOfSVlU6iRsnuyuH
         /z6LdV+A60Z9+UVUyqBvbqmBHpgLj/EZhDFnRyR9Jt7MAL953z3E4JNB5SkDApgV9HLx
         b5JGpeSUucYff5i9roKkpZjcth92Qn3TUoYeJAsgyQzodstEbFiWkDCg3vZA5K2ObK25
         hX6OqLlOZ95F5ezbjJJfA432wiJAXE44YSKKgl/ukIP+3AP4vSVV1iUyx3eBUlAw5JUB
         J8oe4V1mf3tj803y0VfSj6bXQniY8zs26xv9DbwJwD13yMMkytA9HG9ASPO90nTY9TOa
         nR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FoWxL7OPF5Vt7GG7PGeiRRE+3SfmYsfHI6XYr9SmeEo=;
        b=PiFIbDpNNIPR3yghihLoPqPUeKP0ldmjTobZXxchpYwd8UAVe0tvwWXSG6JsF0W+Fj
         ghPyRYTMrE0A6aelMoZT3qUPPxIjS70WdueY75iVcwGJg/QzvkcrwGQaxDQRCC/KauPn
         mt2070zBGQH5hQOJPQd6P1zi+jD0XMDRVwQ6YkTN6SuNObzzpk+RO87tdJU25UGsnKaQ
         oItREjAGpm4bj1v8beaYFF8S/FP5CedhiOLd6nTzEyUbxHdvjcE9hzBs+nTLtlaIWLYI
         P0974hJnzMyjL78YM9BzxWwJtxW/b52vZ+AzxQQZl+Poxb5uVhcirB2AmS3+R/3lTudN
         0kZw==
X-Gm-Message-State: ACrzQf35WhD4G9WbBzNG4c3ihhkZ+fvyQPXOvuqlVWaYY1ljENh26nY2
	EmsweKfwHV6JROq8jQc/Rtw=
X-Google-Smtp-Source: AMsMyM4KHQVLxG6sNP6ySsjx+1ZLTwimQzqB0i4wiGvtNmhqYM6NfCsVjvFxefO3zWeNOF8BXzW+5w==
X-Received: by 2002:a63:6a85:0:b0:43b:dac2:ff0b with SMTP id f127-20020a636a85000000b0043bdac2ff0bmr24406872pgc.234.1664269241408;
        Tue, 27 Sep 2022 02:00:41 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001786b712bf7sm948900plg.151.2022.09.27.02.00.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Sep 2022 02:00:41 -0700 (PDT)
Date: Tue, 27 Sep 2022 17:03:29 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: clean up unnecessary code and comments
Message-ID: <20220927170329.000013b1.zbestahu@gmail.com>
In-Reply-To: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
References: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 27 Sep 2022 14:36:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Some conditional macros and comments are useless.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/internal.h |  2 --
>  fs/erofs/namei.c    | 11 +----------
>  fs/erofs/xattr.h    |  2 --
>  fs/erofs/zmap.c     |  3 +--
>  4 files changed, 2 insertions(+), 16 deletions(-)
>

