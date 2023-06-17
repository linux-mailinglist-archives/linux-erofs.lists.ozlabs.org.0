Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF36733DA3
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jun 2023 04:33:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=d+KNGnzw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qjg7q2LGtz2xwH
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jun 2023 12:33:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=d+KNGnzw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qjg7k1LGqz30fx
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jun 2023 12:33:37 +1000 (AEST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-570114e1feaso16995327b3.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jun 2023 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686969211; x=1689561211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1BkZZKBocPMjpIloCCWwhc0v4h35bGIijW2xI7DyPo=;
        b=d+KNGnzwtOFQadj6izEIiICy1h5C9k4FzV9hMju6hbz/lutzJkjiT2tjpVGcBV4OSc
         /kWRkvxvuWSR3wymnq5a0njUh+/D/Rovs5hB44A1KShH8clas65qE/NnSIe+nxBx1pQ8
         5lQdNShp2uSEHNMaxLWb2819z7R7AzEZh8DolW7mLG8ajDSFboXH5gMBnA6bE2y+/Cuq
         0kouAFZ630C43H45PEVrGNWGc4oN5Gj/nGmwKjoBCO6JUFZ8gZFBabTdbrAnvHPeXWSo
         ksf71fUez1xC6Gc75Yxke0YQRi5HzmlLenWt3QkSDls7YlVaZHglPa9AXskVvJA8mYaH
         lmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686969211; x=1689561211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1BkZZKBocPMjpIloCCWwhc0v4h35bGIijW2xI7DyPo=;
        b=Nv1MJk4ETbrYEqjm5LtYOIxRcJx6NCePo6FASkaesL9hdeFx9w365wug9i+KfsLGVm
         g12sZEodQfd01x1TnUub4iRyJ4jKCh53MtSejt1phjozeQe1NxC2knEe91qmSrrgp0BR
         i+Ed83fNZVTZetgcRCxa4I2VaqqCbXNyuqo3diNltejSv0q+iIntBNJiRNiSHI+PUzmj
         DFXhXRDs8LwZI+9dhg8KvTTbl2iP6ndd/XyUa/yzerk/u57v8f9qlfOz4z3m3t/KCzfL
         A4JAr2nR975c53t07M7UPTdDzwiSBK2qxvoiAYyWJOWhw865OGm+8G/fE0EEweXziRDT
         h31g==
X-Gm-Message-State: AC+VfDy6xdPcD8CwK84b067izYkkDRCK9eH/2Fq1U2ZfvDBeOFSErm+6
	Zns7LQK/86Sl73nekHADGaA=
X-Google-Smtp-Source: ACHHUZ4AqYExU95b7oBPInYLWDLxvRTio8cafMb8K1qlc/HXf50p0gmJtH5sfa5+xJ+TnQOPrbuzUw==
X-Received: by 2002:a81:7209:0:b0:56d:31a1:bd9b with SMTP id n9-20020a817209000000b0056d31a1bd9bmr3535290ywc.41.1686969211647;
        Fri, 16 Jun 2023 19:33:31 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b001b176ba9f17sm1035922plg.149.2023.06.16.19.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Jun 2023 19:33:31 -0700 (PDT)
Date: Sat, 17 Jun 2023 10:42:01 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: clean up zmap.c
Message-ID: <20230617104201.00002120.zbestahu@gmail.com>
In-Reply-To: <20230615064421.103178-1-hsiangkao@linux.alibaba.com>
References: <20230615063219.87466-1-hsiangkao@linux.alibaba.com>
	<20230615064421.103178-1-hsiangkao@linux.alibaba.com>
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

On Thu, 15 Jun 2023 14:44:21 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Several trivial cleanups which aren't quite necessary to split:
> 
>  - Rename lcluster load functions as well as justify full indexes
>    since they are typically used for global deduplication for
>    compressed data;
> 
>  - Avoid unnecessary lines, comments for simplicity.
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
