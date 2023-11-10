Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B91677E77F6
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 04:27:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AN37Xrh/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRPQ53CG2z3c8r
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 14:27:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AN37Xrh/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRPPx2yx8z30fk
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 14:26:59 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1642212b3a.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Nov 2023 19:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699586815; x=1700191615; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGqxz8Jd/zanbd/e+X5hQTmawezc5bW600nwJml/3VE=;
        b=AN37Xrh/e5V7GD0n+OhSQjgvsObBCC66YH2d6vTmWszfZIIut8QFDLxZKq78UcV1jb
         RLeLI0FyumeVIWLOG0FVLoP9NTZkA9NXNh4lXh4L1EOxl7JoltAZa86gY8hAXXnjQIqB
         MOwVlpQhfJyn0HT1oWOcfeVF8R9kK6D1/9KJi8vJMZLe7NU1LnS04rLbi7p7rRkn6V/V
         gj9mM4WBFA52kAnUQeoiP4jeH2DQRUYC7+FvjM7wFG2q/nhKQ+F011Iv/ymncgQrv5D7
         wvW1K/Dd33PyUrCMvjmWVx1bHYf4KazR9fCDjwtciZjygeM9Bsn71h3wkUZKtbNGskC4
         xdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699586815; x=1700191615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGqxz8Jd/zanbd/e+X5hQTmawezc5bW600nwJml/3VE=;
        b=DyOt6T7oB8xjDaQA7ZPr1IoVrvUVvru1hzxGCEbUbEONBCANiu4DZ22/7dlSsRdjkn
         a08m0v2prGyQYQ1BSPLNoH+rKZILoGcQdpLMervs9fF+Z1kFXlFl5XMUW7siPwqJpWM0
         vn6qMqmzWQFT8x9dEzyO7AAdovRyufGE72LKIIKe4gUkd2eJgyce2+3XjIafNIjcjqLn
         OgjYy7ItcOU4Jk16pTURXLHrov+mLUY4OYW8qjPj4afaSVSBRKL5jMrXq/ivRQdaz3gt
         R45s7ZWI2HjhzYufioaSWFZn9oHTPYFFVeVUm3zzpMKZq6xSt+iBMFfsUce02HN6sIjQ
         2e1g==
X-Gm-Message-State: AOJu0YxXRg3ftc8sEFWahleS+1r0OA0WAs8MhHvQ82byBgJD19svE09P
	1Rx33+BbWTPbEMEUiDLtmCw=
X-Google-Smtp-Source: AGHT+IHxpqm1RHfS/+2B2d2hW8vbZjUp8T1eU8hfkK8QRT8SVVQzoS1btARU1pAyNhXe60Uk74SgZQ==
X-Received: by 2002:a05:6a00:150f:b0:6be:5a1a:3bb8 with SMTP id q15-20020a056a00150f00b006be5a1a3bb8mr7785919pfu.28.1699586814850;
        Thu, 09 Nov 2023 19:26:54 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a00084400b006c4d2479c1asm455799pfk.219.2023.11.09.19.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 19:26:54 -0800 (PST)
Date: Fri, 10 Nov 2023 11:26:50 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Ferry Meng <mengferry@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: simplify erofs_read_inode()
Message-ID: <20231110112650.000045c5.zbestahu@gmail.com>
In-Reply-To: <20231109111822.17944-1-mengferry@linux.alibaba.com>
References: <20231109111822.17944-1-mengferry@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  9 Nov 2023 19:18:22 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
> there is a unique `union erofs_inode_i_u` so that we could parse
> the union directly.
> 
> Besides, it also replaces `inode->i_sb` with `sb` for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
