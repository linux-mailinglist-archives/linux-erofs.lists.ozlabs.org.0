Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3088964F9
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 08:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712127252;
	bh=Knp12ve1h4XYxDWkPcO8HJCqS7YHfXXAeRXp5HccigA=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nnDdcDcvH4FKf0EjSTmIGarAOMUOs76ZFeIS7x/NtgA14QPCS59Ad5BHSZnQ2wpMS
	 RYWcbF23uLMjNcXsngYfuJD6bT0u/gAAK8dxVLQo8JCofNutiyOFvBbIlFPTMi3zzE
	 0LIufRLBr+QsjbYmve40NCQF9dW85dJrFj5UhvJftGIhqY2F3F7aP4Zmcy9a3o2dY6
	 84AXZrGlXrzAYB3rSXzN9Olep5U/DmssEDO86fSYYKDbt3LODnq7o/mfxw+6fvacr4
	 Fbw+dzXfyck0SPqC8lFWEfT8KS0TJcnLdMC+gW/X6jRBL2KA342tUBvSHr9qK6InOW
	 ZsSAXLQBV+r2Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8b836rr3z3cZM
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 17:54:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=q+4ipaOV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8b7z5LkSz3bsd
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 17:54:06 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-41569865b2fso18777675e9.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Apr 2024 23:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712127240; x=1712732040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Knp12ve1h4XYxDWkPcO8HJCqS7YHfXXAeRXp5HccigA=;
        b=CtnAky74FJiPOyF1kLnEyFExOuBMPXQ1RpjypduLWXUKmSJR4GVQpOjaYbAp28O83I
         pq+0ULb3zGaQVFz5z5ooIQawU/KI1t0+d3cn4MZz7wQfbi4zzRvaBnKWPEK86+hG3kIH
         A4YTts4Ld2F/p3j6TxxuwuyPHL7vB6mee8VLMBR73tURqve+7svbgjpIbFxtI0jI9ID8
         ehvaKIjQli8rJC6+rQ3iO/Iar9koieNLOLvZ2jJ/WgCTS0ZM+nUmdhEtf4gxCk5amNi4
         7K/Aq6cYFK9B9szQDNpHmf3D6Rf1t6Vo0UzQr2gEYK8LLo9gbcxt5lmcABWOppVJoKDl
         /50Q==
X-Gm-Message-State: AOJu0YzVPF1XWvtotVwH3kk/xCAVeJSk5Gs9h53sMkNN71LEqJH1IkAI
	Vb0I+WEWdpmPozlS99zbYnD4foOotWa/ovB4AorvOcScnxsV0Q50pMq6qnqQo1yF28gcT9mnyYo
	wTMNdVl1V7nHskgkUIufQHjOIIE+Yho3tfEdm
X-Google-Smtp-Source: AGHT+IFynkPrGf+m394VbXtGe7ZGLUvfbxsTHWF+utr8xPwSPVywXVwyrCethGQDJWZW+X4nTZLpOVBWwrxCN+NIHLQ=
X-Received: by 2002:a05:6000:ed1:b0:341:b4bf:f0bc with SMTP id
 ea17-20020a0560000ed100b00341b4bff0bcmr9137092wrb.71.1712127240221; Tue, 02
 Apr 2024 23:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240403062357.1705807-1-dhavale@google.com> <20240403062357.1705807-2-dhavale@google.com>
 <db0f374f-6fc8-406e-ade8-19500b06ae66@linux.alibaba.com>
In-Reply-To: <db0f374f-6fc8-406e-ade8-19500b06ae66@linux.alibaba.com>
Date: Tue, 2 Apr 2024 23:53:48 -0700
Message-ID: <CAB=BE-S37x8YNfWKk+Q4vUTtvTQY+YS2EnKt06qDs9=AcxHULg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] erofs-utils: lib: Fix calculation of minextblks
 when working with sparse files
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,
Thank you for the review. I will update and send the v2.

Thanks,
Sandeep.
