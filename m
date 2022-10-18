Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771260333E
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 21:18:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsNvK3SyGz3c8j
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 06:18:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UXY+7vEz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=fmdefrancesco@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UXY+7vEz;
	dkim-atps=neutral
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsNv81FgWz2xYy
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 06:18:43 +1100 (AEDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so13004896wmb.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Oct 2022 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjbO23Kmf5BvgFjN1z1uqLCDsbhW7avPARU1Jkeq+U8=;
        b=UXY+7vEzyyIUoZX8qENreyalPp7Pp825/HqaRmLaEqpWo5oNCBaiF0clpYwqRJbSZI
         k/TLs9qHgGX4qNPPusnZLHw4DJ/Dbw/+328xIOxXuHtiB/hgoK2x2V3XyVKfZA3euQEn
         wHYqk5agUu/WYCqKgThBUNTcg6+wZ++PbaX3QU+rn/FW7ht8pheHqE5phRJ/dDkXXwnv
         v3jbSRU/B6Crab0IZYlwwQoTFO+ZSt8jdtbhK6c9caBo9ilnoNEPawfaJBfE/SQinFjz
         0hl3K+M/EAqr/oOJQjgMoWHPHCgmARNzjE48bvIogdHB9p0/CRg0rOXIQAcycMOVilEz
         oC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjbO23Kmf5BvgFjN1z1uqLCDsbhW7avPARU1Jkeq+U8=;
        b=ZQwyP18VzkQXS/C+AaiKQKUGKGbHihCuboReoo/ITnz/TVgRPHSqFszNauYTpdftqN
         YXtTSV/10KCSTpHupAG6tquUUSYjCqd8ClYefRzj1k8I3zKbXErgiECdUBAhlFCDZ3I/
         bTYLtnQ4O3s2f1JHpIKMy+TCwPK1tM37DBZhuIaOmBBTPMyDocg+lpjPyhpEdew43dgF
         88MwCb0Nk5rgHD5rA63QKr8ERsqBaN3y7VtSWqd9YAopq92G4PM77quG5LRILo2VYb4a
         1N1ZGvuGSN/GVQRJHY4gcTUPB+ZOEX1uSEOADCS8Jhz2Sj+UaSTaqEspX6BGxe86/oG2
         yBaQ==
X-Gm-Message-State: ACrzQf31rMAGN0mtPixnbe7xSUhAOIR6RpQIF5spX5lAzFR5hFAXsYTi
	Q4Zw173saZF59QlhDF2fqmA=
X-Google-Smtp-Source: AMsMyM6LhEUEwAFsNy/Sd6G0ILdt2v+yd4rHRoFcgt61bvHIHmyHdNCg5dxP5r8XFEEEQ+zER6NUNw==
X-Received: by 2002:a05:600c:1d17:b0:3c5:d7ca:190c with SMTP id l23-20020a05600c1d1700b003c5d7ca190cmr3095244wms.137.1666120716649;
        Tue, 18 Oct 2022 12:18:36 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0022c906ffedasm11937506wrv.70.2022.10.18.12.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:18:35 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Date: Tue, 18 Oct 2022 21:18:49 +0200
Message-ID: <9108233.CDJkKcVGEf@mypc>
In-Reply-To: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: ira.weiny@intel.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tuesday, October 18, 2022 12:53:13 PM CEST Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 8 ++------
>  fs/erofs/internal.h | 3 +--
>  fs/erofs/xattr.c    | 8 ++++----
>  fs/erofs/zmap.c     | 4 ++--
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 

I just realized that you know the code of fs/erofs very well. I saw a Gao 
Xiang in MAINTAINERS, although having a different email address.

Therefore, I'm sure that everybody can trust that you checked everything is 
needed to assure the safety of the conversions.

However, an extended commit message would have prevented me to send you the 
previous email with all those questions / objections.

Thanks,

Fabio


