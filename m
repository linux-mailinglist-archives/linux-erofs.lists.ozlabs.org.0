Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E127D7B54
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 05:43:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ALMmmM9t;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGBTH6xLHz2ykV
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 14:42:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ALMmmM9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGBTB3fP0z2xTm
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Oct 2023 14:42:52 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so409795b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Oct 2023 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698291769; x=1698896569; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hgyXtgeuM91v2O73kk15NKizTKA7Lbg0Ot69X2U/sA=;
        b=ALMmmM9tSmN28lRuiFo+snl3N48Qp6sUTZX5aEvjhz11MUcXSwOb3VYl4m46GOhLrb
         cTfp11qhGG1h0W1uIwPh6PNd6EhdZHep9kVi43zA2/HkYTTzVnt5xtUQVDPsFtk+mC9F
         Sutol8uTcne1smzt5GWqX4KNqjuCmtQV6aBEYNHmqnXcvu8zjr8CMdoXSC1bo4Glc5vF
         7myTl9y/SvP7o4j1Rjeo/6VGXYo4A2nSauh8QH8omk4CRPFdZOr9clTgqJWVoU+giUlz
         u8959B25MnU/pjzaG67FdaW79TguZnWYBOko3vu8Q8XDHTDYRYR1slYVixNIKhBQt/Ic
         dTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698291769; x=1698896569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hgyXtgeuM91v2O73kk15NKizTKA7Lbg0Ot69X2U/sA=;
        b=fQWnP4LhJlPfPsfUEt6psmJygHSUByws8GXXI087Loh8FNHVuRUJkViQ8Uu44Eg6Sf
         wpx5Pma5OcvUEEbHO/GveUEdiTHQgLfdmlPPRtVWyXPeFPJKojJoJDh09bA/9xhpQtB/
         lprgEXQBCseCHAeD1t0gj2/tJcShVvs5vBg5zvzQOprMPlfv0DI49qI+dYCqiTd425J8
         EkOIFBQxDANvJOMmYgISo20XDDFUzybxmcXuz4JC+AWKTQs2yufJtaJ9tVkBEd7xENH+
         nzU6UphvfBYuFC5rk9haRyQ/KCUyAdyUjqNsQ2X684mGx/cOsCd1HMFj0Gr+EzG6CAR3
         YyHQ==
X-Gm-Message-State: AOJu0YzF6UH0o7e4TKOidnCxs5xdI82B4tuH0Iga1bzOGbJ0dBz/pUd8
	V86JWemAgqK0ujnQQenLqDY=
X-Google-Smtp-Source: AGHT+IHb1rT1mMR/a4wm/RAs/zjlnUHIOtmM+SDlLHDdDV0xv7S/22W13cSN2JKBOzR82eQ/upo57A==
X-Received: by 2002:a05:6a00:1ad4:b0:68f:cc47:fcc8 with SMTP id f20-20020a056a001ad400b0068fcc47fcc8mr15418709pfv.14.1698291769506;
        Wed, 25 Oct 2023 20:42:49 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h26-20020aa796da000000b0069343e474bcsm10128924pfq.104.2023.10.25.20.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 20:42:49 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:42:45 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Ferry Meng <mengferry@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: tidy up redundant includes
Message-ID: <20231026114245.00005aa4.zbestahu@gmail.com>
In-Reply-To: <20231026021627.23284-2-mengferry@linux.alibaba.com>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
	<20231026021627.23284-2-mengferry@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 26 Oct 2023 10:16:27 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> - Remove unused includes like <linux/parser.h> and <linux/prefetch.h>;
> 
> - Move common includes into "internal.h".
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
