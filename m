Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 89310967E5F
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725250311;
	bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=evaiNvNID0IEUS5xlAujUhtGHHTPKb+fhgBZo/GLiI7Cit3jgX3wbe5WvJ7Z3NNIW
	 48VaQg5VnsFyrfP7Cc3iR/V1y1vxSRSnh17RbRVoTWpwtw2LUKJbCeONEPWFjRNT7J
	 dFwvnPq6QiUB0JK1gRQcDFqpaKo4xZE0UF1f1KAgVuUxX9iTC0Teswv2POgtg70cXe
	 7rCcfRuDMDcGhRcZtzO4tahyyHvVPJSV5SZpPcQQBKqJyuqa9zYqJ5YNjb/u+gbygt
	 S3Y1FOwdrnFVEA0cYu5ukh5MkZzPgDMsPMZypRWU+xoF0OcFKpATOjOuE+H+7mMjWe
	 4KUMY+Exf0/Dw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxwLb5YNrz2yJ9
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 14:11:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725250309;
	cv=none; b=GprMW5P1Zb6CgrSkcUqqqtLbHYl42WWaXN4mFE7/sdX2/pwKXbRJ2Ba5XGqS5zmZse7QzKTOeY4Llr3yulcOQUScjKRj5f44VYjw5BJR/Qm4aRBzN13ZF7GnkKx0UGmqwqbgeP2e9Let2BG0LZ0OYMee0rIHnBhggs4ehnTpcPTWCew+MsyYVRSiGuT1iwz6dr95K6d5geqNMnEsEY42EAKDL8Zo0euGpcj9S/ob/Fk/gMvXJX/etQ3cCa7ZTbRf2v5GITGlqdVmquDNSYnVtGBAtsASTLWuOPncpdiYTc83sFy6SrymbetZ/8YKdyXOdgIrTTO00saaOZwfmD/Tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725250309; c=relaxed/relaxed;
	bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=FGDKRfOShi3UzwRme+lMV4FMRCMQ0egBmGloYcHGAzSuhURl6LHLqV1U5LmfKwBbF+R9v9+Qsq+6kUYr4QOTccQQfQWgH2UzRxq3Fw+xf5R3l6TXwgjm8ojY4ZQIJCqDZYGKaJIZMcZICybapwZLIPn/ixEiESPebRMcNn8xLpT2PCaaViq3PK8W2soA+ZMiiKEZLAfFKtg48/s/UVKXgwkyvCAbKpw0y5lOff9xUU9g8xLpqFQsYEsqFeYOTjXx1WJ3DSnak3ANoxdPbSkorQCUdZzqKI5NmmR/BRg/DnAEUaIytb6bYSQwMMSMqxM/A+g6al+SS9DtVaKat77X7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=TkRlSELK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=TkRlSELK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxwLX4X71z2xJV
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 14:11:48 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-7d4c923a3d7so443282a12.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Sep 2024 21:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725250303; x=1725855103; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=TkRlSELK0F6i/FfrL9nFww0ZBXj/CusS5o+2EQtHYb2WDB7LC5Xt8AyO58zE+CyNJk
         NXUHfqUzigxrSC4jLZ9FqE38NL+51ltML5JVr7kOcPmpaQpXtPN5Z7cvWMCgtstXDLuk
         lCF8q9Gal3vb4lr5mg7uSxeW69mv8FHpl6d8dFp3b5ZHVEbTWwx0LtUvezH2gnOX1hEB
         CRH4oo0NoTh7+Fi8k2SW/aXhsfO4fbeLkICaj/xRbrrxqJye2BtmLK43TM5eQRnJUyk0
         S2jAHztKKiR/dgePvAccDHWCrVEy7Of6X7y9Uw+1Tyq9uxWXWOX9YMYICdi0+O9xvyWF
         gj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725250303; x=1725855103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=v0iHZYI6fr+jMGUpWtwE1oysZGoP9GISrAKMRiIjLZQDX8BfRfTGxczedBjotv1OGW
         VdO/qtLANqOwMuHtmgl/EFE32J72JgXsr1OPGDpuHYFXaFsHhpzdJ3ZBa0n7ORQjjQ2k
         b6OxdjT6c/yEj8CcFP9I52CCz4uqKAZMpTvJpd++Z4PFjiTWD83QaraRNGIz73F3JsFa
         NcoltZ8daXNV0/897ryyQID6lS8+o2W0LBTqC2Eyme6cxYcFSf+oO7aoWwwFrFnbZezk
         me38Cwm6wSxnV5ZKiAzWdJgGR4NJ73LH4thkOy5b42xKQZj6HDqm1C+Xh/onv3E285HN
         FZFw==
X-Gm-Message-State: AOJu0Yx0hVclRmClRdGYxIhuWl2+06+grpcHVxSXRqaEqxa62rDqerpR
	6/LxrVz4rXq46hCiqgnDTZI+MSQy9cuMA109EVfQZkvF/P+V33eL/pVYhe1K+KFdzK1OiRHZ+uS
	C0v+75La+jSRE914jknHk5aOj3FAJehf/bm0y
X-Google-Smtp-Source: AGHT+IErP80g0TsP9SLnDEA8znXKCZFsQKgYrAPROqAoutzo7mYcs5UeyLpD1pkgx52HWZCKAIeg/oiWCN9HxbfP5uo=
X-Received: by 2002:a05:6a21:6b0a:b0:1c4:9ef6:499b with SMTP id
 adf61e73a8af0-1ced62a0dcbmr4201357637.29.1725250303019; Sun, 01 Sep 2024
 21:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
Date: Sun, 1 Sep 2024 21:11:31 -0700
Message-ID: <CAB=BE-ShG+2o88LTDi9Me47F=-qh-NptQx_H5ch+eXkT4p7B0Q@mail.gmail.com>
Subject: Re: [PATCH] erofs: clean up erofs_register_sysfs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
