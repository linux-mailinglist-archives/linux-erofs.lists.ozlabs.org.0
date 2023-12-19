Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A887E818148
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Dec 2023 07:01:02 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S/E4fnGo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SvQzc2WsFz30Qk
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Dec 2023 17:01:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S/E4fnGo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SvQzV6pV8z2yhT
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Dec 2023 17:00:54 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28b0c586c51so1754165a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 18 Dec 2023 22:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702965650; x=1703570450; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sw1JqA4SOSsEH4EJuu0jI7RMTeqWzL3Xx/MlvK3d4U=;
        b=S/E4fnGoOVdXP4axcaROZ3iJqv7Nx+Agq+HtViRNHNoKG5Kq35h4ZvGEfp7iheAasq
         xPDt3XZYWy/yEB+jRs+p7vUN/x8HnN/wxG6SWB2k3oW7RcM2a0PTXnJ8JvMR6QUqCJft
         y0Kcjd0t6hKgCzjrviejH2TkS3PRCT4aMNpnSwDhugPtbp56bjVJOK0S21OahRFtOp9Y
         0GejjSSis4ec/5oXv0pYxwo7IL7Ql6jY4XI7BWQaFN/huPav17jBmeMGr7zy1G1aGfET
         RyzTAl5swCekl6N3XmsCelQgzopgsT6CUOa/ucTXvv7QgJR6t2Y3FzIf74qHPZod61Ep
         yL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702965650; x=1703570450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sw1JqA4SOSsEH4EJuu0jI7RMTeqWzL3Xx/MlvK3d4U=;
        b=M7Wg4uY3S++rgx0a8UulzM1RGyNAw+DidjNO2dt9Of9wNQXBVPSnhOEGVGBday8li6
         rHbzbqrHWHjFc6KfU/k94iRqFruQLDwKfqlSxTOPva3rKUlGJhxv3BikaS4v7zB4CB6B
         5n9xQHopsHzGIcU/tpKfdJ7gLi4I031GKdlqXFwZKDMHBtU5lLA5oXUPKcCPXUr8lyHm
         pmC6goYCGNLx8lzFcrW/fWWNlv/B9Sth0oDtrGIXzaBwv7RrerevlkHyt3NWQwqXulsp
         05CykVIMoe9aJn033t0MGEfmfCPvLXmt8wD+LvSWrpfB0oxIm+896dDj/cQEyXAILE+r
         Op4g==
X-Gm-Message-State: AOJu0YzhvaJ9bm9Kw9jUL1zPWPJ2/vihbaLFzbxZrUVivRLrThk8hk/W
	FSxLHeIXQsqFB3ZXHPtIB+FH1GSn9i8=
X-Google-Smtp-Source: AGHT+IGQ8k09au+8hI5bvA7BW7Z9OutkqWvQeUXhvzVF0XSSjVlJLkYREx/4YS5Dmf2qQww5kupGcQ==
X-Received: by 2002:a17:902:dac7:b0:1d3:ddab:1e44 with SMTP id q7-20020a170902dac700b001d3ddab1e44mr152576plx.126.1702965649767;
        Mon, 18 Dec 2023 22:00:49 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001cf5d0e7e05sm20020290plh.109.2023.12.18.22.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 22:00:49 -0800 (PST)
Date: Tue, 19 Dec 2023 14:00:44 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 2/3] erofs-utils: lib: split vle_compress_one()
Message-ID: <20231219140044.00006ca6.zbestahu@gmail.com>
In-Reply-To: <20231218145710.132164-2-hsiangkao@linux.alibaba.com>
References: <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
	<20231218145710.132164-1-hsiangkao@linux.alibaba.com>
	<20231218145710.132164-2-hsiangkao@linux.alibaba.com>
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

On Mon, 18 Dec 2023 22:57:09 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Split compression for each extent into a new helper for later reworking.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
