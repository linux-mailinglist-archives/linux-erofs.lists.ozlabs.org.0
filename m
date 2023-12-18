Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E15C781652E
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Dec 2023 04:03:26 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CLffLb61;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Stl5504Whz3bfK
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Dec 2023 14:03:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CLffLb61;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Stl4x5bg2z2xm6
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Dec 2023 14:03:13 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d04c097e34so18937295ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 17 Dec 2023 19:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702868590; x=1703473390; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRiBBcZGcrpP0v/TFRrZqGYwkaK/3jatn87Bdd5lS5A=;
        b=CLffLb61g4V5dYeXuNFAbieQ+yt7HTi8ZLwLdNnuHmn7B0HiUiXN4haTANVW7OG7Me
         zmj9VamLMCISuE6L4o5V8ZCBRHAUgXQn+bGzEmIEfd7HHq2vjHv+t3PL54ixbA3WJ7b5
         LNtydCyEYsx3d/xgMa85sKOtlLvwfpE3kVr0aFB29tfJWu6s5HmhxTQJDTk/AKRu5s3g
         HTvC9CR7gVbzZj6H99NZeUh9jwUXKp/9KhQYptIifM1HeNxM49BU77QYZhA9N6i+flOF
         b+pcxjQMBwcHzfY71HJs3uylEJmpwizXchpw5gRJd/Mjwh+F5AgsNaHCDDaxUUXPmYcg
         RYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702868590; x=1703473390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRiBBcZGcrpP0v/TFRrZqGYwkaK/3jatn87Bdd5lS5A=;
        b=P73hi4Hhkesb75lrx5dgiR1uFZcP6BZLMMOB8wH+p1blXarpX9RCnogpC/inMZ6/R5
         rXQABi5sqAS8B6yxFyXH45yGEsoPyabMF1BPAYhM6kTNae1skP6AFyTs5bjLJWmSwbjN
         R+WR71g4+zGQ5HEcjevhhQcU8ojBqIEszqlOBorSqpv/lubj6GwNdYvGGA1SUabXB605
         xHHriprhrb+WbdlQ9jSYbUV3O/5F3UtXZn+PhUDbG6VBtIdbE+tJF6FuFYkQqZkdSKXU
         YrjxiUp+ARsHrBXklW5iqR4tfjvv3Iw8sQErdeoerFJGMcVhhSQPxi+RHK6E5GI0Mb1Y
         R5ug==
X-Gm-Message-State: AOJu0YyqE+iJl0Rv7zdtTsi7wK++qEi+1011L45hX/+fe01FdcFIX1PT
	+daCEYhPyzOp/u2KC4jquqY=
X-Google-Smtp-Source: AGHT+IFKKF360nqQq89H8+YRJ/5p436D7TyDqT5K/xLbvCj/TEgVertdIXIcQg7YWtGK9UqvV6WWRg==
X-Received: by 2002:a17:902:d505:b0:1d3:4cbb:3017 with SMTP id b5-20020a170902d50500b001d34cbb3017mr11895395plg.42.1702868590216;
        Sun, 17 Dec 2023 19:03:10 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d3564cf109sm2429482plb.11.2023.12.17.19.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 19:03:09 -0800 (PST)
Date: Mon, 18 Dec 2023 11:03:04 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix ztailpacking for subpage compressed blocks
Message-ID: <20231218110304.00005be9.zbestahu@gmail.com>
In-Reply-To: <20231214161337.753049-1-hsiangkao@linux.alibaba.com>
References: <20231214161337.753049-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 15 Dec 2023 00:13:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> `pageofs_in` should be the compressed data offset of the page rather
> than of the block.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
