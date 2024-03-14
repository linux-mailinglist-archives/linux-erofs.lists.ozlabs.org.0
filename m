Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A487C5CC
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 00:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1710458067;
	bh=47NgUQnVGQBbIng7KOEItYyrBF4Fqt+mN9GiaCGROqw=;
	h=Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=BnBMbOxtaAA5rH738aRVF3Zg2vLh1YnjP3QHn9FDOObCcTPpp4qxejEAShqi7mSZm
	 hqhBcCYyZundUFghxtBh0LqEFKesN20qXppdJLR3lcRUGAU7rjgMlvAlaLhcS3kmnU
	 7OIlGFn76WxVA3JkSVFaRSHGy0sOGMYGrjfimcxhPsLgr3zJ3bcQPqFsJvzQX/Oxmc
	 S7m+tRtpuzC/APRACeuptidSl7jO2yqNUlo2bJiN+Y/ekHOVRgJOAuILQJwMdCV406
	 MaZobZImTJbMbBnSZ3xD7UVjOliEHir5aOhjPr4m+SK8mjWvrXbj2LSoWb0pJqhwrK
	 XLokwajLnscSg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwjrM3RScz3cPm
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 10:14:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=r0KVuNwW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3xitzzqckc9e04xix813bb381.zb985ahk-1eb2f85fgf.bm8xyf.be3@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwjrC4yFvz3by8
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 10:14:18 +1100 (AEDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dc3645a6790so2436277276.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 14 Mar 2024 16:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458052; x=1711062852;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47NgUQnVGQBbIng7KOEItYyrBF4Fqt+mN9GiaCGROqw=;
        b=Nm6pPHe3FTwp/hqdqtOzIA8qa2n9RGNAzxrdyT7GpZOw99figiQy7IaqdDicsYJPu2
         QVBeRSfNsdqJ+zoy52cDLw5Y25qx1fODTLfEbMSMjATfNcXCP/nuunbAETmlEf5NpW4J
         r3p3S+OVNRJjn+dfSAeCHfpVxIq+xNuHbdR9D/eScG0sP/4J7J7vLSFA9jxGeW/UtPvV
         jgpnPr3yD1f7zf74pjnhCACU8EajEcUVs4mHG28Q1nJ3R2JzMKuwUPr+jpabLMUf3G1T
         UfQW7qqqs5vxLnSsgRU/v/AuGcQ21b9YWy1Sl2e1gLFQ+bT0VB+V9BOe3P+7Jg87SRn4
         L0+g==
X-Gm-Message-State: AOJu0YxH9Ty2RFqQMnfFs1lyKXt7+AMseCsFWU7sgSApBXuKFgfJCXYC
	Q/WN7cAgaqMD5zqLNLymYJp3d3Q8VSmWl1uQumWpwwjHG7VWDdgn7WEsi5N1+3lEmxrY+2ZzwvX
	1nZWZXdM24slCXN87mFi1pq97CfzEfQS5QWTtpCv5IdLdxhLOIQ8ZDZTJNqjFmY34xsIAINvjST
	FsKovxvv0NtzQgM89TmWo8GXsRcfXhIUHxef3utePsrHg3pQ==
X-Google-Smtp-Source: AGHT+IFD8eEM1mWFsmXcSWuwtn82SwzRLKc7S4RbEAwxb8zYChzqbLS1oTHAz/G5FnRguCxvTTZCMPQdU8eD
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:c8:ad31:2162:e917])
 (user=dhavale job=sendgmr) by 2002:a05:6902:100c:b0:dc6:ff2b:7e1b with SMTP
 id w12-20020a056902100c00b00dc6ff2b7e1bmr918025ybt.4.1710458052162; Thu, 14
 Mar 2024 16:14:12 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:14:06 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314231407.1000541-1-dhavale@google.com>
Subject: [PATCH] MAINTAINERS: erofs: add myself as reviewer
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I have been contributing to erofs for sometime and I would like to help
with code reviews as well.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f298c4187fb..b130340d71bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7875,6 +7875,7 @@ M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <chao@kernel.org>
 R:	Yue Hu <huyue2@coolpad.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
+R:	Sandeep Dhavale <dhavale@google.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 W:	https://erofs.docs.kernel.org
-- 
2.44.0.291.gc1ea87d7ee-goog

