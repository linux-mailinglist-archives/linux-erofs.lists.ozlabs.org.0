Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5002958F64
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 23:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724187705;
	bh=+rOynEZazVZCmIjlopu3i3YsE6MMVc1xuEv6IBh4dSM=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=odS7mTCA25Go5pcSrY91pdd5Ja/tmAw+/h+lIbDKCxFBqH+rHlYFzKOI7xDOmszC6
	 UHcR1Wgy7lATKN0pehdW9miGzK+YW8jylDEy85yJXKNDgWSOybb8/5KKvwryPPkZUU
	 BOG1Px4ZF8ffflKloyVo3yjhHk4keLCsTZU0W7gxRFN+6nIWCnQljbGRO6WnUe5xde
	 kdLZx7gOKXrl9tzChcHwqVQTWylVX+QvcrvyQzDbRARi+aziUTdFS7yjf0zPwwccDs
	 zZ5x6qGfXCf7dYcp4hdb2psb2vjSoAA6kqummJPt7oWmXv1/GjusrnzV3WdIEUUt4f
	 QTbwqdXqSoDCA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpMMs5pLPz2yGs
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 07:01:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b49"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=GAYTs4e2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3matfzgckc4kqun8nyrt11tyr.p1zyv07a-r41s5yv565.1cyno5.14t@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpMMm6nrKz2yF4
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 07:01:39 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-e13c4519ed6so188026276.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724187696; x=1724792496; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rOynEZazVZCmIjlopu3i3YsE6MMVc1xuEv6IBh4dSM=;
        b=GAYTs4e2pCrblSazY5Wm8m6ldCTBekAFwbiWZC0fhxgz9DC0WSPdgN9CwOFFSEUaL+
         qUcCIQq78OE3V3cZjCpjjc6jrWksgarGl2gUAXZZ5+spbpqcWTHNMwrjFTTa7h8KKekD
         bJvI+MArAkV7gXCQC0j/clZKdHoJ4wbe+BMWh58wz3uGeuTy40gcS6ff+wSUksrxhGHb
         EgclAFUvQ830xF6WXnRR6uXfujzEz9jPlc1bO7a1UgY3S3YG+Bf9XQw0gYAuiB/GPVXh
         KPcIZbN/ZxdpYFFDggPBqauw+Rrzw52Dweoj0x3cAMdAp+q9Kfoml0zMrxyHu/6J4JT7
         S5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724187696; x=1724792496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rOynEZazVZCmIjlopu3i3YsE6MMVc1xuEv6IBh4dSM=;
        b=tjBidb1siiECGmbWj2I++cu97oSRAHwEFAHF8iS/2kJSmekhr04Bq4gmpbaXPGCY42
         Uk1Xiyrr1j8Q96BcAvgxBqoHD0D+oigsU/4C0lLD8gKLbkwoJVULzUOgkqAqlN0EyuIo
         rM5E/LITLeizV5ZUFYU7BvAjc3D/GvMhHJoLE9lB/2/0fYjwASKH3OiuzzdYck8VXtrp
         kkYFAmL6cy0moqxHInrvq+yTcYQxJJQ0C7HHklSGwvvF4+I95U0II6LpgSwd5P8EnR4I
         GzvFwGy+S6jVQnRDxUhwJbSbpQ7pJiuXVUHJ5jYeZAlHcMHLd9sGPhdM4tJaq1hjcHxO
         HA8w==
X-Gm-Message-State: AOJu0YxqI9gWL/zdOk8A5YVrNz2NOB+PPXVJq0eF34f9Uom07frXh4pe
	xNYq28ldqIWtaEqBychrsFMvt6badioduaD9+dbl8QEuUGe0LQ1p4ZpXxHF07P2pGPdZ36aTmaB
	iTJRcl/nK415q15UHG2GO1ZOHH0AhxmlVeU5xWf73zfb1ilKana5aa/180m+Di0HMy0npEzlZw2
	z22JRCm541D0gLncTZp5t7oeVn1WonrzA0U6d52XuS2ORUEA==
X-Google-Smtp-Source: AGHT+IGm7Xv2KG8IvKFdbn8vGWpC3JMJyECuYYKN5bkXa6xG5NHszSWzCwprPKiR5XfCEggTuDha7aWA4/VZ
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:d58e:af88:2a92:d1b3])
 (user=dhavale job=sendgmr) by 2002:a25:aa51:0:b0:e0b:f6aa:8088 with SMTP id
 3f1490d57ef6-e1666f0f648mr2277276.1.1724187696163; Tue, 20 Aug 2024 14:01:36
 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:01:23 -0700
In-Reply-To: <20240820210123.2684886-1-dhavale@google.com>
Mime-Version: 1.0
References: <20240820210123.2684886-1-dhavale@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820210123.2684886-2-dhavale@google.com>
Subject: [PATCH 1/1] erofs-utils: lib: actually skip the unidentified xattrs
To: linux-erofs@lists.ozlabs.org
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

parse_one_xattr() will return null if it detects unidentified xattr.
In such cases we need to skip this xattr which was our intention than
try to add it in erofs_xattr_add() which results in null pointer
dereference.

Fixes: 3037f8958f3b ("erofs-utils: skip all unidentified xattrs from local paths")
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/xattr.c b/lib/xattr.c
index 651657f..9f31f2d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -448,6 +448,9 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 			ret = PTR_ERR(item);
 			goto err;
 		}
+		/* skip unidentified xattrs */
+		if (!item)
+			continue;
 
 		ret = erofs_xattr_add(ixattrs, item);
 		if (ret < 0)
-- 
2.46.0.184.g6999bdac58-goog

