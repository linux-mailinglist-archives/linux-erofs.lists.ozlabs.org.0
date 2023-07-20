Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128875A3D8
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jul 2023 03:22:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=fqSVCtza;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5w0K10VTz30fp
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jul 2023 11:22:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=fqSVCtza;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5w0C0DxZz2ys8
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jul 2023 11:22:16 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-765a1690003so28972185a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689816131; x=1690420931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVA6drGXi7u+m/uOyL9hmh7fUijxlyZAc3olxOhfruY=;
        b=fqSVCtzaW2L0CCx64PDoxXWac4ZRL5RO0YilB/Ap2YzVLI06cOHtMCeFWYBluMyw4a
         p5vMHnQlbBRR/DiLFtt0ZKUWoWekk6IBxTU4hI4OP80Sy6mCcHBpegvcL4+ODT8QgkpL
         gEeEfM8GEexXXtpcPjjeur2IeTHjb8lL4WRLYOzasQfv+Hx5szs+ABX1MFDEXBmC75AU
         6IAAFeSH6ddVvqZZEG7yo4z/l++2XMdsZJ4/0pUYR4TVNnZbFRT3tEHZIdfzxIqOzhKV
         xhLEkvjCfGXH69ICPWTLOaMNwc6H3mYp5N7SZ99N+dOJW4w1o7fGCyx/sAnhacWPFx+E
         gm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816131; x=1690420931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVA6drGXi7u+m/uOyL9hmh7fUijxlyZAc3olxOhfruY=;
        b=gnqXvn/DzERzsys5NmR2ozqIYC40OLyNKp8fgM4g5AXt2V/W5q9wH54RXz/erOGH14
         L2fXnBagNWKrs7PG+zWRr6y7qHCTnrkMWKSSinOrE6n1IJZWmWufiWdlNxjGqzKuImCi
         6XCnFAaFUwqaVOPpk+ga5sWyx3BLiCZR+wNVQ5C8XHnWRvtt18Nsdlffl/ckkl4vSERw
         3fhjNVPsf622lCgL3UWwakLsvgykog8suy+nmgD7WFy3BMFaVYReg1PWRmEuQfczd1C5
         FzYWOxXTVc+ULoqNEFkzbf4Uf8aHOcG5QNHfegTs0DU2tG1Mp8XlNti5htCs9QD77JLR
         P+7g==
X-Gm-Message-State: ABy/qLZZdfvrhhNvjpN71a7FDq4S0vA4ilZzQ69X+nQU/5kpwAVmVBcY
	aY1hSOEjpVIhnhNV9ppk0hQ=
X-Google-Smtp-Source: APBJJlFSznkdmTOuBiXGpiSdQW6Nu4yy4kwn1kB1lnPoqtt7sAGb1Vx3Hdov0iCVPjzHx4eRGRDa3w==
X-Received: by 2002:a05:620a:3915:b0:767:fec4:1eb9 with SMTP id qr21-20020a05620a391500b00767fec41eb9mr1244906qkn.69.1689816130773;
        Wed, 19 Jul 2023 18:22:10 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0f1700b00256b67208b1sm1772811pjy.56.2023.07.19.18.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jul 2023 18:22:10 -0700 (PDT)
Date: Thu, 20 Jul 2023 09:31:17 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix wrong primary bvec selection on deduplicated
 extents
Message-ID: <20230720093117.000072a1.zbestahu@gmail.com>
In-Reply-To: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
References: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
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
Cc: Shijie Sun <sunshijie@xiaomi.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 19 Jul 2023 14:54:59 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> When handling deduplicated compressed data, there can be multiple
> decompressed extents pointing to the same compressed data in one shot.
> 
> In such cases, the bvecs which belong to the longest extent will be
> selected as the primary bvecs for real decompressors to decode and the
> other duplicated bvecs will be directly copied from the primary bvecs.
> 
> Previously, only relative offsets of the longest extent was checked to
> decompress the primary bvecs.  On rare occasions, it can be incorrect
> if there are several extents with the same start relative offset.
> As a result, some short bvecs could be selected for decompression and
> then cause data corruption.
> 
> For example, as Shijie Sun reported off-list, considering the following
> extents of a file:
>  117:   903345..  915250 |   11905 :     385024..    389120 |    4096
> ...
>  119:   919729..  930323 |   10594 :     385024..    389120 |    4096
> ...
>  124:   968881..  980786 |   11905 :     385024..    389120 |    4096
> 
> The start relative offset is the same: 2225, but extent 119 (919729..
> 930323) is shorter than the others.
> 
> Let's restrict the bvec length in addition to the start offset if bvecs
> are not full.
> 
> Reported-by: Shijie Sun <sunshijie@xiaomi.com>
> Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

