Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43555E7297
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 05:55:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYdbT2dk0z3c6R
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 13:55:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ork+z5O8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ork+z5O8;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYdbN0hxSz3bcF
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Sep 2022 13:55:25 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d11so3240493pll.8
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Sep 2022 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Is4ZUuvsA3sjDvAuffgt8Yjeir7RGhGpld/940IgtKA=;
        b=ork+z5O8SaPp7wmqFpJ1fbIfEy21Bezflnx3W+MKpNishKPRFG1VbE4UdJSems1w5W
         aVDZ/V0iKcIpcOZ0cOq2uTymc73kly+coupqchS5MMHZHeDKPPKYBYQzfzhop0nZtgDF
         oGUwCQNJBGsuSGc4+Zwcxs1pq1glMrLaW/ADpL2L7LRDCkYLPhpApuzHWa9OEmnooBNb
         jdNbBUC5CJq5UbxpUXTde9wQg2oR6LxkC+2YMRn52zTLVUR7QiThk3eKzBLyhychmgOB
         Qpvd58fd5K7VuNNQdPF5UumyLryhWf7ttMqAyQdhug0m5on3KOPe1syo2XOCU/MvM9f9
         ZS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Is4ZUuvsA3sjDvAuffgt8Yjeir7RGhGpld/940IgtKA=;
        b=es/9Poriz51Wh8xvcD+JB4xMSPTXyyh8BeMvjNHolLf7NeyhNo9zPLZMCT/TQv5UMm
         LW3XTuaEYvlxQCV2kc3SMZ0If2cmUv+xL00dHluEDwYORYXx/EvI76jQsD73lwsKAWQO
         0r/RbiT7g/G7jEUItVog7arOm5tJfqmRa6Cj6CGlWne+u88oaaTzEGYqJwREscsYjItd
         tkN6qeuI76T6Msd/yB5QCkkFjVvhZFE76jaAI8Njj7GWTBbtgi1oT7+e1d9sNwAMMdmd
         W2/BNjwgXXdG2sL/7BHLjWt8wbrcy0a9s2z5VNNiwP2WNXOtD1uFSLO41yZSst6eE8iP
         C++w==
X-Gm-Message-State: ACrzQf3QYbv94CHAjfq+OIW2bv9mwcC+0QaAZxnbMhaJ+INZstjyJBmr
	t8OFD83B3A6Qrisa5NmBmLvt9YnlIds=
X-Google-Smtp-Source: AMsMyM4bHukWnITYIjGMHwOj87yAZ3XsOTst4unZ9qeD+zXCqaCppO8PmrHzdyO6bfX0BAo+llc7fw==
X-Received: by 2002:a17:90b:4b4c:b0:203:1eef:d810 with SMTP id mi12-20020a17090b4b4c00b002031eefd810mr19073797pjb.75.1663905323635;
        Thu, 22 Sep 2022 20:55:23 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a19-20020a621a13000000b0053e8fe8a705sm5371037pfa.17.2022.09.22.20.55.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Sep 2022 20:55:23 -0700 (PDT)
Date: Fri, 23 Sep 2022 11:58:05 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: introduce partial-referenced pclusters
Message-ID: <20220923115805.000051fe.zbestahu@gmail.com>
In-Reply-To: <20220923014915.4362-1-hsiangkao@linux.alibaba.com>
References: <20220923014915.4362-1-hsiangkao@linux.alibaba.com>
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

On Fri, 23 Sep 2022 09:49:15 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Due to deduplication for compressed data, pclusters can be partially
> referenced with their prefixes.
> 
> Together with the user-space implementation, it enables EROFS
> variable-length global compressed data deduplication with rolling
> hash.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/decompressor_lzma.c | 3 +++
>  fs/erofs/erofs_fs.h          | 7 ++++++-
>  fs/erofs/internal.h          | 4 ++++
>  fs/erofs/super.c             | 2 ++
>  fs/erofs/sysfs.c             | 2 ++
>  fs/erofs/zdata.c             | 1 +
>  fs/erofs/zmap.c              | 6 +++++-
>  7 files changed, 23 insertions(+), 2 deletions(-)
