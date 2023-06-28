Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F377409D2
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 09:49:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=NrRK+CSI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrYcg6h55z30MS
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 17:49:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=NrRK+CSI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrYcb639Kz2yGY
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 17:49:01 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668709767b1so3569762b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687938538; x=1690530538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl6zRFJwJX4TVX+FX/9X3H88Ay6pIJMzZMs21mv/0NU=;
        b=NrRK+CSI8eMfYu5Gq2CbMcDfu2x1Yaste+JlD6ixflAlT8E7k3m5Cv7WrKS25tHsmG
         8LnIvoCx9M6SGUMMt96qW/nM53mULeJ+Qwtr4UB+cccFziwMcjQtadh5F5Ql9C6FhCYj
         zCcJFRRvpsDR1hCeNfoLdJavBTBGxtQJs9uSM4ADudz0FgR2mu9cDkYM7oAbrE+Jwx2t
         anIUNGPDGNpopmLbLabw3j6Hh4YElBpWZRJ7FnVYAhPMgBRPLDeZ5SV3R5Ix3nHnDlw8
         ANfIIh3SMvmcO5KqfI8Icank/drf1oRTv8xw9kPkyMvz6ubhr/kgtMXHmIMAOQxZ1bZw
         7mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938538; x=1690530538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl6zRFJwJX4TVX+FX/9X3H88Ay6pIJMzZMs21mv/0NU=;
        b=WGVxVkHKMcEp31yapmnZGoUDS2usKXfDJ6xjjM8mnyG9mLQntehFOAcgxxff/ASkJc
         FlFFmas8AnnO7C8de1ux8dsFx0V+iWSEZUU8HAsiriMrelnwOKWY3mOQvdfy2gVrrQp2
         5xL6R9qBEiHwc2gpdPzGZ7//IfGR778H8hErroKw99WCUaVV4DSBGNGSWTGLtdkiOCL6
         qgcAU3yPh+GGXAMITp2Bnxs2aC0z6ZFrwMVSYoczDQH4bLQEcrNHk/TAWm86d2qpF4Q0
         e6rkbTH91CzGFmdiLA3ZJvZxokyabSA3C+wS8cFaoNGW5I8QTx1VDp2C0ZmsL3/+CK2o
         Jd6w==
X-Gm-Message-State: AC+VfDyUf9aPZgq5vdLagXPmcLr6FltcUpEo6Ys94nYHwoI/6SLfzoJa
	odZ0Qh1MCzLoVyrZd2M+Qao=
X-Google-Smtp-Source: ACHHUZ6JRGIUhgEO5FJSQSbiiil8v67RVs0NzWdjFNveJ+SE3EwyVqvk0R0XDfh2xtMRMHlWi+ekJA==
X-Received: by 2002:a05:6a20:7da1:b0:123:9582:e9fb with SMTP id v33-20020a056a207da100b001239582e9fbmr18239344pzj.50.1687938538548;
        Wed, 28 Jun 2023 00:48:58 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001b1a2bf5277sm914932plb.39.2023.06.28.00.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Jun 2023 00:48:58 -0700 (PDT)
Date: Wed, 28 Jun 2023 15:57:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: get rid of the remaining kmap_atomic()
Message-ID: <20230628155742.0000038e.zbestahu@gmail.com>
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
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

On Wed, 28 Jun 2023 00:12:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> It's unnecessary to use kmap_atomic() compared with kmap_local_page().
> In addition, kmap_atomic() is deprecated now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
