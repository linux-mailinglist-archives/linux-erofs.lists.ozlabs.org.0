Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F47EBE86
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Nov 2023 09:24:25 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X9ZF18q1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SVbml5WRrz3cC7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Nov 2023 19:24:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X9ZF18q1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SVbmh1MDjz2xrD
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Nov 2023 19:24:19 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so6523466b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Nov 2023 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700036657; x=1700641457; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyJ4DPVRLakhxqk+gxq+y6tvx5PVcKkBNkvv/XiXT3Q=;
        b=X9ZF18q1TPd6YKcdwrdwN94w5ODYNEaefh43ue/jge+X291oUKjUHULxIU7hjzPhOH
         j0ycHCHdUN+k4Ah3GTDGjRnDY1G/q/q6Ce5C6SsTbOICk5aMjRpz0HqV3HYTcPLdTgon
         jDTxTaDVv4hbPH0ZrYYeisP4hbqmR1TtDKGOanh29avCGxBCgfxdq/Rjn5Cidmzs1IIP
         1WZV3i5stJI5/raJdXlqusAVFymDb8mGeCACm0Rp4gR6Mu0rULnm5cMJiZ44YUQU7vCw
         qj2uJ/T8rreTcf5wja30QlBHIuh3Y2je7ydZE2uTOnz4ZaFLBREQtmnQAKX84DovoYcU
         cqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700036657; x=1700641457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyJ4DPVRLakhxqk+gxq+y6tvx5PVcKkBNkvv/XiXT3Q=;
        b=LwGhqGDEaBjU7B5LRs0vxAQsfIpiffh5B+K50hPd1vLxQNbyfnMnLvVIw4xid7kdRY
         /3P5zVipumLawmwn0z8HYv/MuUPgRJRDdCGXVzondye35FvZp7uVuFYGTqHEN2TNb2Oo
         OZRD2SxCKHAPprYvYe+tdtx2ug66G7e98vMa795hjLrwDbEBJ5QfasGnGZD4C0K4fmrw
         R1h0hrIdnSLS64zxeMVX6bX75jVRCxaMpAUReYyLBWct24C+PBHpDfjknR7njLG7xLOZ
         fmJAqDiIpMX6N1UniEjudTEJnXFm/h9VDHx0fGGfC5mhQPZAVvVK1fOs4JMwhA8v7U1X
         WiFw==
X-Gm-Message-State: AOJu0Yxbj1on3QqVpizmEUw/CiT29+Y/aW7cBvumN+ub7Yns6OE90P1x
	XujE+Qtq2XnZ1rQevJ7rSyOJQT/tU2E=
X-Google-Smtp-Source: AGHT+IHVt9MiEUJXRHY2UsHbcltOn31YZypEzgo5oQtbC/2PCzt2UBAfu2XhiB/Lx8ZjXyt+rsTHMA==
X-Received: by 2002:aa7:8512:0:b0:6c6:2885:82c7 with SMTP id v18-20020aa78512000000b006c6288582c7mr12150186pfn.25.1700036657418;
        Wed, 15 Nov 2023 00:24:17 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78d17000000b0068bbd43a6e2sm2434629pfe.10.2023.11.15.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 00:24:17 -0800 (PST)
Date: Wed, 15 Nov 2023 16:24:13 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: lib: `fragment_size` should be 64 bits
Message-ID: <20231115162413.0000775b.zbestahu@gmail.com>
In-Reply-To: <20231115024952.1256243-1-hsiangkao@linux.alibaba.com>
References: <20231115024952.1256243-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 15 Nov 2023 10:49:52 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> `-Eall-fragments` is broken if i_size is more than 32 bits.
> 
> Fixes: fcaa988a6ef6 ("erofs-utils: add `-Eall-fragments` option")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
