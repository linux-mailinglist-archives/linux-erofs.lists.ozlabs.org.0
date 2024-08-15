Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64E95390D
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 19:33:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723743212;
	bh=B6SvPk6k8eQwlac6xAyfgf+HUTQZsBAGxCgYZcLkU1s=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Lxt82L+EvdsgLkZ5pJKQgNDn+ov8G5vOKlT6m0LwpbNRn9BIBufBpH3+G72m1jZD9
	 p9d1SseCcbt7bgdKjysUX5aEzDMKJ8Ki+O2dTaNcgL7lMVx2nvlltSec0CRETCVwcF
	 pxQH6d3fg900A5CZ7A8F60eKZ1rD69cNi7+At0jTwlLgeDpzLZOGC8uvZJIkpYDoPz
	 ZzEBIiDFtTHz4PR6ufSB63XvC8NTgZeXB7kVTUnnZeY1iA1eiH6Zu/JLn0LcPxQ1NO
	 viDHfuFyiv4nxq/oyGp1zinnitTnn5fwIKxpcB77ltMN7FjinTd5rOdirwZqhOfCOM
	 FgmU4PaYM1tqg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlBzw6LCxz2yk3
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 03:33:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=LXdPvs3g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlBzq53K5z2yZ7
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 03:33:26 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-429e29933aaso7835555e9.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743201; x=1724348001; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6SvPk6k8eQwlac6xAyfgf+HUTQZsBAGxCgYZcLkU1s=;
        b=LXdPvs3gdpFZpqDeCe1dYX9FkdOZn+iqXuqrfyfYXKTlU0OzVf/R1VmakR8WL7uvxF
         CNEmXTdeOJnnMT2BX9Sl88LSS76Lgyjzed2nPgqgO12mHMgsy5K1FfEbDDAa870Tsi/Y
         tEuWxhT6RwuTUOI9jazRKa0whX69GhENJbF+f0ym18At7NNlzXUsPUR3xAWilzZcixOQ
         JA+fX310m2jZG9mzXzSkBBmwYZ9mHu5ojG4mVOr8eaZs9TxAtST+qr0hN1OggkXCpLtM
         Zcz76BUvnxNKyviGVaJmFVuKsjT+MpHQC+9SZxD8uAYc4pXHbWY53l/szcHxR0vtL3QC
         hNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743201; x=1724348001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6SvPk6k8eQwlac6xAyfgf+HUTQZsBAGxCgYZcLkU1s=;
        b=k8TFNvbKu7zFjRmnzPKL5moyT/GyOFvykXkOeV4iLcarMCJrvr7/Szpe98XcqieQdj
         yw/xst8Mh3RTwTQxeAIxGaiU4ScWTh3fEKTAFlUIRYbEteK3CFw1QlhI4eZRpyyaMyx3
         JR8jIbPwhotgXAtiveqZpwZtISjomlb6dm8y/pkO2qMbFhvefQQiCc752TYp30ZVaEgP
         HdtUCbQsFIdxTqUsQLL6OZUG3+r09Yo9lSCbTW39he0JSNIuw0bhyLPoOvQPNeFUq17V
         MME8e+5oodO7EMiBvwLXEAD9wO7aCwrE+Zmax+Dg7bn5rsjLmA8Nz8RcLFYR1bpUzTYg
         eqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUqIpTXTYGbi2xKdzK+Kd3f6sJgTO07Dr9Ul2AS/DgCXfKtf/siCz9ex+x+D7xRYGxQKZJnkL+AczvypOT6kIH1mP5EBYZ0hR2AXgRK
X-Gm-Message-State: AOJu0YzicBbsr5QJxG0IpHsr280fjx3wu7zRl46JiivLgzov3SJdhMSQ
	L89T/eS50Pw6HOBY4fEhlLIoVVaukYLH7DEevJMGPDpNz9e5APixuX7fMEuOUdbsN9CcFvfEsfF
	gnEuClMd+K4Bot3BTqcMq8DC+/7BlU6wMFVWn
X-Google-Smtp-Source: AGHT+IEIZQh7IaEqJsqxbzpSl7b+LHCBFXJZxwUc5KAibQ6tql5CIKETHcGJbjBU3gqP1fXTixFm6yctQ9N9Muv3w28=
X-Received: by 2002:a5d:5a15:0:b0:366:f041:935d with SMTP id
 ffacd0b85a97d-371946bcb41mr79829f8f.60.1723743200452; Thu, 15 Aug 2024
 10:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240813102723.640311-1-guochunhai@vivo.com> <d6f177fe-0263-489b-968f-189a923e089b@linux.alibaba.com>
 <52c4bcf8-dfb2-43ac-9b94-91b4bd7821ba@vivo.com>
In-Reply-To: <52c4bcf8-dfb2-43ac-9b94-91b4bd7821ba@vivo.com>
Date: Thu, 15 Aug 2024 10:33:09 -0700
Message-ID: <CAB=BE-S4iH-+JupZ2N=Z7phx0E4jq61oq_GGbY16BdnWd95c+w@mail.gmail.com>
Subject: Re: [PATCH] erofs: allocate extra bvec pages from reserved buffer
 pool first by default
To: Chunhai Guo <guochunhai@vivo.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: "huyue2@coolpad.com" <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> I do not have a good number for it now. While the modification is minor
> and without any side effects. I suggest that we make the change.
>
> Thanks,

Hi Chunhai,
Even though it may not be easily visible in comprehensive tests like
app launch in android, probably it's worth trying with microbenchmark
and profile just this small function/path to quantify the benefits.

Thanks,
Sandeep.
