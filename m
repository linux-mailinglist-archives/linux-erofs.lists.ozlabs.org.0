Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7A7803D3
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 04:33:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=U7tz5yRa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRmBR2zxrz3c5f
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 12:33:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=U7tz5yRa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRmBK4VD6z2xq8
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 12:32:55 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68891000f34so402849b3a.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692325972; x=1692930772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFph4ySbXN61+e7h1mFNXgd12ZG3z/7VSWDwoBYZoOA=;
        b=U7tz5yRaMnDX036ltTYyjQCbCNKEFwJ3tPrsxtspHowWVckoqdDfAsbj6WsVs8xkVN
         9GnhI9PdjGWy0HIZ5aRdEbmpP0sCE8jWQpmkLndwJpVoaoIVRAsyevoFM45/pf/YdCTx
         HRxGzy7+LlaR3rLr2Ouzu/yTFuYmiQMa09QUtKa2US2HVJ3+0zu60+PHm9i7Uuuh3Xjx
         4dcS6UurBHKiW7ZUA0OqV3rx9PEX4yjSQpm0x6xHhpuTn/gkk+x6jSl0qsjCdE1PeEB5
         YDdaeNZdTgboJy/IDqSrVZfSlGzhSvCRLv+bH/uqzE2AvyOssKvVMoUsX+NmP6UwzDh/
         scGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692325972; x=1692930772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFph4ySbXN61+e7h1mFNXgd12ZG3z/7VSWDwoBYZoOA=;
        b=cfzbQYPrfzTclE0Owk09m+MVpT5YxWdrD2k5Mbg4P8ci15Ygneyxf4cpGMr49Of6oA
         Ce4+MOYvYaGpzd40OWqaTfKAprRByIpH2ghRWrgX6x+i4yuvLdd1X9idIBIex38T5BFF
         ZvwwCtixm7nFCAXI8rWnEsNcV1r3UTisO8qWR69nP1/ORjOA+tdGa+XN5kbJlu4oxGBU
         Y919N0Z4oblSLPPhryDQzi+bC5ZC97OIGCz8hwcj33D+m7tCQaQ1JPUiPmQ0IEuhe0+F
         rxLnEjLvvatXaDPQ2RlxMtCTPBthw/63yDZFQx85lUN+1YqDYt3DRzULI2hzDDrTNVKq
         7uPw==
X-Gm-Message-State: AOJu0YzTpcyH/fxEvUdvfoB5FThhTgpYOIju/PmuxWKd63n3SWorZIRE
	WkN5aI1Jy60w/lCufesyYOc=
X-Google-Smtp-Source: AGHT+IHODvAieJuO26vD0JvupjsdEzzjtIEfZRq4RTLiBMYWXuobV4pJSOuIJl6iqIFoTgNTys+AkA==
X-Received: by 2002:a05:6a00:1912:b0:687:3bc2:58de with SMTP id y18-20020a056a00191200b006873bc258demr1515735pfi.6.1692325972269;
        Thu, 17 Aug 2023 19:32:52 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b0068713008f98sm424134pfb.129.2023.08.17.19.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 19:32:52 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:42:35 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 3/8] erofs: move preparation logic into
 z_erofs_pcluster_begin()
Message-ID: <20230818104235.00005603.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
	<20230817082813.81180-3-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Aug 2023 16:28:08 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Some preparation logic should be part of z_erofs_pcluster_begin()
> instead of z_erofs_do_read_page().  Let's move now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
