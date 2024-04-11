Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25148A1CF2
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 20:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712858438;
	bh=+xoq/sXDkK3DSRmnUSU07f6nURlDA/s2BY7gqYG2upo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RnHZMobNoFq4Tz1Y/QmeXQXGLl6ApjBhNKQzwBk+4vh0C13ZQhUNux8ynukSrWYb1
	 wwhDuSrKQ+mCi5FWiP9g1H5dL7KyG9vKTrKBnaC+e8EkWEtPZSsiHVpj9TY4WEc2y7
	 oBPOPlKhEmMWJZ+uc90t5ud81Ku42i3v7hsE1W+wvSNwnmdAFUXYwOAomd5LYkkhjC
	 bevH7F6U5L3Z6kYjggc3psWqPN4dwM6IV0hyAsnvAzJmyuD3TlR3j/wQPmsDJ75/RM
	 qrkk6BiR4p2lHSOwz7HDk32NSgS/E051jb+FNLbQnI6nfkw4VzcyEWZlfNXL7WEaPR
	 rr/T6YIn2oSYA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VFnYL4c9gz3vXM
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Apr 2024 04:00:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=DIPSqE/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VFnYD2K4Hz3d2c
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Apr 2024 04:00:31 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3455ff1339dso24442f8f.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Apr 2024 11:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858425; x=1713463225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xoq/sXDkK3DSRmnUSU07f6nURlDA/s2BY7gqYG2upo=;
        b=siD1oOOYOfCYHyUavVhah7E7VRVf8XEC7S+9dmp32OeHUuU+12NAy0+97Y+PlyXiy9
         +Y6p017UeWr1uNNusl7WWB4FXiur7ZCn8PpADXgplob4myxdgzS3fqQ4DPYEKUSyeb4w
         BAoGd8tLwldXuteRebL4WBRGtcV0ci0nBWGryfey5Q+BQz+tnpINh3FWVk4VJtfhtqmM
         TzXeJbTgEW9VPZ9G3gSkO+loupERzSoI4ECvJR5SS8bfqp6DZu8ryLgvdqjsejJ46phY
         i0ID3zMgGuUaoqXbKjbdMAo/xItCc+J8bI4mJPK7h0Z8dcTOJHJZnOPBajK8Uf2C2k6C
         ABjA==
X-Gm-Message-State: AOJu0YxH0DdDOPfNeD/3jUKmBHsYYpioXrPahKDdrOBeFnAVyHRkxK37
	qVeqDJ703I8KPPRzpZB9mdt7mrXK2s2qzwYd+TZkRkncP+6FXX1GDR6yHLVyM/l/LRDB64vLDHj
	p46RUDVOwDiU0uILEY5pvKJDPc6sJC/E/mc5ZR65pcLnxkS63wQ==
X-Google-Smtp-Source: AGHT+IGJO7I8CxPoUmprcshcJLp+kZvBlwDNXiTz0/Hr/iCaoSJ/QEJGs7YKWYUmlUoDKof9j181bsemnA5JjqTdIqs=
X-Received: by 2002:adf:fa8b:0:b0:346:c912:3e97 with SMTP id
 h11-20020adffa8b000000b00346c9123e97mr215057wrr.44.1712858425093; Thu, 11 Apr
 2024 11:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240411100039.197417-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240411100039.197417-1-hsiangkao@linux.alibaba.com>
Date: Thu, 11 Apr 2024 11:00:12 -0700
Message-ID: <CAB=BE-S8JrXQ7e22Ja4P_hZe9dz3Pa0wfd=eA_553LQjDexDhQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix tarerofs 32-bit overflows
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

Looks good.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
