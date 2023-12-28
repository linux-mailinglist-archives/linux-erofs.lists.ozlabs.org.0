Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432D81F406
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 03:00:54 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=atTZdD8u;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T0sDN2gY6z30g7
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 13:00:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=atTZdD8u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T0sDG2VH2z2xHb
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Dec 2023 13:00:45 +1100 (AEDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-594c253f037so940754eaf.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Dec 2023 18:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703728843; x=1704333643; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XYXLeAK9wBLJ9SgEUKly8RlAfrBLaG5dorpT3mCDAA=;
        b=atTZdD8ukg0xK7++VA/nHcVJlU8159AX2P2GgISAuEyVrkaTrRKjdey0M4brBF8SGL
         9pEN3K+bH3HuJzdIxH5WKJ3GcrOB8weQFTh4yaJyrCEQOK7DXfOVQ4wyjwwcRfA51BHC
         PUMR9q8Fwa8GvX9gEbHHaLLJXDXW0wufvPeRFCvmRD44KylIXJRXjdpCAUTtKNZl/n8g
         vl/Lx8rTtN0FFZa25bpdBEXCTBxfBY0UIm7pLzQoyQRZVhsS1zGWhE9EYxCFNKHUwWJv
         mjQ0Erq/+tWHm4RMeo2KQVG/t7kNyWq10iMtmYrMeAB6N/dToSYpUvs0cypOKSGsxTdb
         JIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703728843; x=1704333643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XYXLeAK9wBLJ9SgEUKly8RlAfrBLaG5dorpT3mCDAA=;
        b=b56cDED+RKkUPK1TTKbFAUAuyzQ7vFrPOQsQ1ORrepVayizMgjL68KRgSeqljseBTU
         w8Owg1sJyRSU3M8jA3l4pGt3VLLRwTTJfgt1+GYh1P/UrUvmM0oFmzWIMhVoIovJwLBp
         NTB19QVzwZ3zV550Bqa9nJaK5kWjtz9BTGrKhZeKHp5MaqJL5tENYfBDz6cn7oI51fo1
         NRb//2CVOgfJBYkotuoouLYWHgTlaHfMCA+V+lPyLZXYff+EYMTlIXYsn5CTAHgCzNTG
         TEfnS98iluY0UXhCLRWPf03nUzNc3BTgdObnclvJBVz3czCtNIsL46O+BU42Qp0DzW9H
         EgIg==
X-Gm-Message-State: AOJu0YwPpx+X0lgNhOMRUI7wHK5ZyFwFnaMcVdxkWZnVg7peUwBLj15o
	CG8dy6cBoU2JivKQI62lI+4=
X-Google-Smtp-Source: AGHT+IGRshJlPiXSge4dnsgvoWquCvFxA6GM3UT2zroScMehPVdGEFbXAhjoMTYI/u47Cx59zwoCsQ==
X-Received: by 2002:a05:6358:2921:b0:170:bfb9:1cfc with SMTP id y33-20020a056358292100b00170bfb91cfcmr6974231rwb.1.1703728842738;
        Wed, 27 Dec 2023 18:00:42 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id p23-20020a635b17000000b005c66b54476bsm11505761pgb.63.2023.12.27.18.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 18:00:42 -0800 (PST)
Date: Thu, 28 Dec 2023 10:00:38 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix inconsistent per-file compression format
Message-ID: <20231228100038.00004fdf.zbestahu@gmail.com>
In-Reply-To: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
References: <20231227041718.1428868-1-hsiangkao@linux.alibaba.com>
	<20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
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
Cc: bugreport@ubisectech.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 27 Dec 2023 13:06:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS can select compression algorithms on a per-file basis, and each
> per-file compression algorithm needs to be marked in the on-disk
> superblock for initialization.
> 
> However, syzkaller can generate inconsistent crafted images that use
> an unsupported algorithm for specific inodes; thus, an unexpected
> "BUG: kernel NULL pointer dereference" can be raised.
> 
> Fix this by checking against `sbi->available_compr_algs` for each
> compressed inode.  Incorrect !erofs_sb_has_compr_cfgs preset bitmap
> is now fixed together since it was harmless previously.
> 
> Reported-by: <bugreport@ubisectech.com>
> Fixes: 14373711dd54 ("erofs: add on-disk compression configurations")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
