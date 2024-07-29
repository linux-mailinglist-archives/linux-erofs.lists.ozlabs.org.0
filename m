Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2093FBF1
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 18:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722272301;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FnXkEnQvOoa+p5potMdGvAmp3ipaZJlNQnc1kt5taG24OcLrBAzV65zS0mp/vLcbM
	 y/PenljbpiG1UMw6E103zAalehc5LYxv3d8H1JXrHL3LTXH2pzswzpQ1QKY56H6mXb
	 EwYuCxR8L+iy3rkUg3FAZqN8EzIku1CNFGxI863dfCcGxkjZ2FShRQ03y1OeawsV7+
	 o2cnDxskEYdskwxb13u40mKnYEQvcKJ5XnVkP2x4OpMeZ87j98pmx5UGv+mH56WHcX
	 GJk5MGd+wa3K5eZUszLez31L5PxvI2w6XMYvzmpjOJINGzkfzGt2kcIc45CSURXs7m
	 NRFqfnXc/XSdg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXl194qqSz3cdy
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 02:58:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=DyTG9/In;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXl15140Dz3cYr
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 02:58:16 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3687ea0521cso2004755f8f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2024 09:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272292; x=1722877092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=jR0VuecQCbTFGa+kCr5TMqbbyl+YCWS+RgwM04uHBcAbWLlalJmEv5Juz9UTaEit+I
         jCcBkuStsrh+t+mzhAUwEzyZVA1yW3aeF6lv8STScsKUxF4R9B8tm3qV5iRCItij9f/M
         etAyo4fb3qYLBR6mzaMIlD/9UDB63CQvkI6cCQE0rxCvUtglleeVDhWe5ek0GaLKut0i
         I2QYzxXLQ7zo1Nw2Xlc9kkmH8XCM9X6dkxUAbOtqUc23FYEo4FOXptgwyWD0UzYUkeSb
         bQ30HrO5/eKqKtp/fDp94stMeyCuq9B6fKuDcFJFVqSiL/iH+InOD2OBaruUHj7dATH+
         mdtg==
X-Gm-Message-State: AOJu0YxQokwp3r6IQWCfdM7v3noz22p5SrPbKlfyqlAOoXiTS42gSu4J
	SB0De1g9R2/LjbFiLhfI6kpPZ7eDdu6QWO/mb92InSDHzF1/tQago8a/F1sHPzoo5fQBPhWXcvF
	5RWtvYV0RMNGhYIFjEjr4sAXnaSBcrvbBWhbebIf26kWgzI9euHWn
X-Google-Smtp-Source: AGHT+IH64Aa/t1OG2tAIyvdm44Gw4X9glX+ONcc1tTRWnR3s+Wu1ixkCtL6seIL00VgSYiXXMoa9S0Rloxt13eAM0eo=
X-Received: by 2002:a5d:6a02:0:b0:368:6655:b1e5 with SMTP id
 ffacd0b85a97d-36b5d2e82a9mr5999352f8f.63.1722272291370; Mon, 29 Jul 2024
 09:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240729112524.930460-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240729112524.930460-1-hsiangkao@linux.alibaba.com>
Date: Mon, 29 Jul 2024 09:57:59 -0700
Message-ID: <CAB=BE-RLKGVpoiCDL-ev5AnZzYe7hUFxgJVwJiVR4oB_ZJdD9g@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: uuid: fix compilation error if
 __NR_getrandom doesn't exist
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
