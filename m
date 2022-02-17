Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 716204B9B5B
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 09:45:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzpLJ6bl9z3cBs
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 19:45:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=eu04KKrP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=eu04KKrP; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzpLG21phz30QD
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Feb 2022 19:45:09 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 h14-20020a17090a130e00b001b88991a305so8812895pja.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Feb 2022 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vRMP65X1KTPzXnQp4TilmV5JeVYIdJMmr+qprYcnP70=;
 b=eu04KKrPpKadhY8AJpPoOWCtPYKdMqhe8iaJuMQC4U5DeWYLEJknJvmDT/yypn/X19
 qLCy0DBFdxnArIDZLK+RmDtg1iBYcHweBaSnTPANtIx6hoSF30ioqfKwNbOTrkkA2VSP
 i1mYzv4W/nKQqhjgeDb8hIT4voirBJa+R7vD8ap+A7RTJIiOyTm+q36TSSD9C76/PIh/
 EskbA11lAthjXX2tsPeENmXRY6+VOtFBVCzmcbW1IuC8po//ly2GpQeU9M5cs82al9na
 Iz2hWAbWDvbYgsq12wCdOtpU55N02+qjDWx0ee7na1fLbEFsdzMXf1uIfHeglb89I/rv
 NFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vRMP65X1KTPzXnQp4TilmV5JeVYIdJMmr+qprYcnP70=;
 b=Rg9V30YN/fVsl+eJstSvivMlCkE9nTH0Yje7F6JPStVS6LYByEoYCoJZTB6mQNMbvO
 eEkJKnbsor3qOw3wIjb6CzRkK/adXAGQUSw4iwEAuDLMqIw8VsXW1KiWhrtPDo3q+gRO
 1XbI5DgoB3UrlQzVqqV2Ue6pvKPpM9ZvsJhlHVVGtxUTMQI5yJziT3ZmBPpux22cnrVY
 4MnseKQ4DxeiE3uzLw1YbGo1MaPBFNaa17/tBGTacpdNNcpkwqP1faGbRQaCgx+y5BXO
 ZZ8mWMwQmZ3v9fO7MomVggDjjOEi/GC145poMb8ycFD3gNybPB430iSbsqvTBVYD7Jn3
 Aavw==
X-Gm-Message-State: AOAM533aOdW5Qi81iXfCIIS3d+kihHYjjlHTYI0Uh9iHF+uT5wi012km
 LzZtRv16BVYwLOT8nMteS2Y=
X-Google-Smtp-Source: ABdhPJxRzF2fpYag9dBo20ile5BY7cvOmgeu5vbnQc0eDkDw6JLcsG+tesmP51ZVotMU0kD7PENQDA==
X-Received: by 2002:a17:90b:4b12:b0:1b9:8932:d47c with SMTP id
 lx18-20020a17090b4b1200b001b98932d47cmr6362479pjb.50.1645087506661; 
 Thu, 17 Feb 2022 00:45:06 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id h15sm3827218pfh.143.2022.02.17.00.45.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Feb 2022 00:45:06 -0800 (PST)
Date: Thu, 17 Feb 2022 16:43:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 0/2] erofs-utils: refine tailpcluster compression
 approach
Message-ID: <20220217164323.000019f1.zbestahu@gmail.com>
In-Reply-To: <20220216122845.47819-1-hsiangkao@linux.alibaba.com>
References: <20220216122845.47819-1-hsiangkao@linux.alibaba.com>
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
Cc: geshifei@coolpad.com, liuchao@coolpad.com, zhangwen@coolpad.com,
 Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 16 Feb 2022 20:28:43 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi,
> 
> This patchset refines tailpcluster compression. Firstly, instead of
> compressing into many 4KiB pclusters, it compresses into 2 pclusters
> as I already mentioned in the previous comment [1].
> 
> Secondly, it fixes up EOF lclusters which was disabled on purpose before
> in order to achieve better inlining performance for small compressed data,
> which matches the new kernel fix [2].
> 
> Still take linux-5.10.87 as an example (75368 inodes in total):
> linux-5.10.87 (erofs, lz4hc,9 4k tailpacking)	391696384 => 331292672
> linux-5.10.87 (erofs, lz4hc,9 8k tailpacking)	368807936 => 321961984
> linux-5.10.87 (erofs, lz4hc,9 16k tailpacking)	345649152 => 313344000
> linux-5.10.87 (erofs, lz4hc,9 32k tailpacking)  338649088 => 309055488
> 
> (There is still another improvement working in progress..)
> 
> Thanks,
> Gao Xiang
> 
> [1] https://lore.kernel.org/r/YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local 
> [2] https://lore.kernel.org/r/20220203190203.30794-1-xiang@kernel.org
> 
> changes since v1 (reported by Yue Hu):
>  - fall back to uncompressed data if EOF lcluster inline is no possible;
>  - fix `ret' signedness.
> 
> Gao Xiang (2):
>   erofs-utils: lib: get rid of a redundent compress round
>   erofs-utils: lib: refine tailpcluster compression approach
> 
>  include/erofs/compress.h |   1 +
>  include/erofs/internal.h |   4 +
>  lib/compress.c           | 156 +++++++++++++++++++++++++++------------
>  lib/inode.c              |   9 ++-
>  4 files changed, 119 insertions(+), 51 deletions(-)
> 

Tested-by: Yue Hu <huyue2@yulong.com>
