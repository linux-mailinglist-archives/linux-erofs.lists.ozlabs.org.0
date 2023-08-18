Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D87803A5
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 04:09:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=IoVLuigV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRlfy6bgvz3c4b
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 12:09:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=IoVLuigV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRlfp4Hcmz2ytK
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 12:09:04 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc3d94d40fso3658925ad.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692324539; x=1692929339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQO+tddRAnvm1Y0O/G7nm0nkNpa8hL+SzVrIhoe3Bps=;
        b=IoVLuigVtPp8DOJ8n1RJ6HzHQ/Ok9+SLuDZrW9U1AVkclsgcwXWTusdeHcF6vLF/PX
         aqwsIYUDtZeo8mHWtTovXbGbTYd+9a3NtYdz69CAVWKyYPP8pteI4yfC+rFnW9rGKa/Q
         7fMquqegQ1TAexaH85CDULvGDEqiMkzvhvWi7dy+gXggXiLeXMVWyZCZ8ON7lpK1xRxh
         9Z2pGKfzWG4QPVA13znLsmRV15lVVhGawimerL7jNBIrFk8qNuC+dFrlwoy8t1563bJH
         EXB7kO466AO8ceLM6vYAlarSJT4oVel1cE89rnkRu5QK42qLXqlHgAC8LWpOQSEK1/SE
         Os/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692324539; x=1692929339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQO+tddRAnvm1Y0O/G7nm0nkNpa8hL+SzVrIhoe3Bps=;
        b=KeZlEmvEd5vP0PdmMopgYIm6lsUDkCKiqne+HZS4N0Rp4XmpLF/UieQSSztPdtJPpm
         aR5f7AL6ie6T1LHIWC9uda7SugMf/XhR5tp5GT78UF0uyAi9MAXFNSWm50rFMawvSHLZ
         1oL8ZeMHGcvamn2rxg19hufZH5itXzmymspNrjMUKVViIJjoEBTis1km+ufLwoPgrjwN
         /GxFudIZ/oPgynrCMbQHi78e1THo1zhdyjcjmfLAiWo27RgVpDI9UDMf7gisCS73+TNm
         aDPY9Vd3c+BRHfUD8bWmcJT09k4jyMCRFCaprzYJYMGDBLmoPtUN2g+JggIfjipBTHr2
         JYWA==
X-Gm-Message-State: AOJu0YwdVeWPIuG+5zCXukF7Qi5QsmGgSmavWBIA8tLzRtdPdTKS6oAq
	D31H3QmFX6vHf5urnd/M5Gc=
X-Google-Smtp-Source: AGHT+IHnhLsteg+3d6QlKPIEsZ/4KsoKmpy4Nyss/dR1dGJ1hDQYRCwUOrhIBtysdviJXwgIyBK/0g==
X-Received: by 2002:a17:902:e811:b0:1b8:8af0:416f with SMTP id u17-20020a170902e81100b001b88af0416fmr1489153plg.1.1692324539441;
        Thu, 17 Aug 2023 19:08:59 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id bg5-20020a1709028e8500b001b8baa83639sm435806plb.200.2023.08.17.19.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 19:08:59 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:18:40 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/8] erofs: simplify z_erofs_read_fragment()
Message-ID: <20230818101840.0000524c.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Aug 2023 16:28:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> A trivial cleanup to make the fragment handling logic more clear.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
