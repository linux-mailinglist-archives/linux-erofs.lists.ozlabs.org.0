Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D11715442
	for <lists+linux-erofs@lfdr.de>; Tue, 30 May 2023 05:51:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QVdjX1gpnz3f5P
	for <lists+linux-erofs@lfdr.de>; Tue, 30 May 2023 13:51:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=sMB3GVXI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=sMB3GVXI;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QVdjQ0gScz2xvF
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 May 2023 13:51:05 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b039168ba0so17643155ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 May 2023 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685418663; x=1688010663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdSfaMnDPST0yDYLJSRYlzRuDvLWC1Vb40RxZnWTJJg=;
        b=sMB3GVXIvnhuv1DLz+sWWRPtx/uMxhQZ5eOPyTSUzLPgAzS0zrGCZvTZ7ZfZcKSfSL
         jozrTBPVK8ZdkPEGOTvB1zRJxeuFhaEUPE2h0YyhFRKlf+hqKKMJgn06y5kpNbiNNNP5
         3kM1aGpXQbgBc7H3S6k3rTK7KOtWM8mPOqyUXF13XQLxOMTigWfVecURObLq//zHuQbN
         2t+nAVfnlOqEBUTy8vCHE8Y/KkBOif7GxWmhV2awX29pn99ALYaM/RL3Szi2cNug/69G
         xHn6uz6fXluT7ct80gePDHXtY8OpvFfjbwsSm/hzVPD8I1/elZbvXj4abOqaerlE8rwJ
         jyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685418663; x=1688010663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdSfaMnDPST0yDYLJSRYlzRuDvLWC1Vb40RxZnWTJJg=;
        b=DFw/BcXdYzhHcCqVIFB1qoSan3vS8VravXu7ZVqiNfGFCXHndMIeIjNxEvnKaK+3yT
         +ow3tqrEuOiN5cWpcllkBPBvLIhRdio8NSxBs22UkwTNFGm2gJcCbwTjRDqT+LMmEJNq
         YjwyYPn/x45XSEKGyfCuNd3yHLvnsUaw8fpXVbFot2ZEi5XBkmYOwogjhTvgnzVJSiAV
         W2K+EKqC5Pw3SmHcjAC5re2Tr9ie67AcxsjAoEG8uXWX7yZRvctgKSTd2GSwul3xmRzN
         Iv4JE4qjKJmiRGoiSRqQ6ByRmwv+5fuqHBiKM8hBlOV81XoCz8Q4TgMD8VHqDr9TMQU2
         SiNA==
X-Gm-Message-State: AC+VfDxvaGhKa0U9ORakYAI3x3hO9nW1X/UR2YrLaSFoU7CvKqc+QpSU
	+vYaKDltVgd81yWJgAllVNU=
X-Google-Smtp-Source: ACHHUZ7XVDki8DqkeubhoJtRERxWaQHLk4SCz22MgopWVgl7R4Ve74BEkesCe8JsM/BfbvDy+s8dew==
X-Received: by 2002:a17:902:ec8b:b0:1b0:4b65:79db with SMTP id x11-20020a170902ec8b00b001b04b6579dbmr1213007plg.63.1685418662981;
        Mon, 29 May 2023 20:51:02 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d68200b001b03842ab78sm3825471ply.89.2023.05.29.20.51.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 May 2023 20:51:02 -0700 (PDT)
Date: Tue, 30 May 2023 11:59:12 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 5/6] erofs: use struct lockref to replace handcrafted
 approach
Message-ID: <20230530115912.0000195a.zbestahu@gmail.com>
In-Reply-To: <20230529123727.79943-1-hsiangkao@linux.alibaba.com>
References: <2fa6114d-9de2-9a0d-ae89-c012914bf682@linux.alibaba.com>
	<20230529123727.79943-1-hsiangkao@linux.alibaba.com>
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

On Mon, 29 May 2023 20:37:27 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Let's avoid the current handcrafted lockref although `struct lockref`
> inclusion usually increases extra 4 bytes with an explicit spinlock if
> CONFIG_DEBUG_SPINLOCK is off.
> 
> Apart from the size difference, note that the meaning of refcount is
> also changed to active users. IOWs, it doesn't take an extra refcount
> for XArray tree insertion.
> 
> I don't observe any significant performance difference at least on
> our cloud compute server but the new one indeed simplifies the
> overall codebase a bit.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
