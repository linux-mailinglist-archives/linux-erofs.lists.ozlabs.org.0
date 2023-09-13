Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E879F4C3
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643101;
	bh=93dfwDN/Q5KvITJzy9NdfJ8srP0tgT/v0iFcyVLxsJQ=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lqEDLDQqF5kxjc8u1NPjlsohbWm4ID5nQGhJwSDRfLCCLNKHJfJ7S58WT/w6KFjvw
	 aRGWbexCE/uE3G43iOj95zDjMZiy9tyB0GVCQ0iYyZ5z1LQZJqfOMsGH19Boo+JRgA
	 zsAeb6M52i4V7La5+26DY2+jmdoXbGP8ndvlniCJZ3QTJJlK+seMvZsnmHGTCMFD86
	 i1HqPpqdxvInZr1khRQVLtV2+CxRNa9gFVWydElpLt8keinNRXBvga/Gg6/67QoEBs
	 Jvkfgaj+uhEL21eLYGhaHtfFALrLoxhOt05tfrWWrvXNSGkK3FN9Nd5LwbDZ/FgJ4X
	 aYcMh8zB5/xFw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF6N6xzXz3cD5
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:11:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a1vblFTt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::114a; helo=mail-yw1-x114a.google.com; envelope-from=3izmczqckcyojngbgrkmuumrk.iusrotad-kxulyroyzy.ufrghy.uxm@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF66224jz3cCw
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:26 +1000 (AEST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59285f1e267so26916307b3.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643083; x=1695247883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93dfwDN/Q5KvITJzy9NdfJ8srP0tgT/v0iFcyVLxsJQ=;
        b=eO4adO+CGpojCWaVLXvnbW3WzVIHl0A5OFVxhr28WsEPgneNx71GZtctnfaHr41AoJ
         bUl3/yz8VymdahYHXYJsQjblGLtwBS02yb+DiwDTzgxtJWRckJEBpDH0M2EwgGTxSK7m
         0x+Ka2+k1IoT14MvZHJJyIXxtu1aGiWsWiY/MlDdO9z7ZMIv27XtsbIoJYBBpAB5MTuB
         7J+2JXQzcVvt3s90xeI5ApwjkDmN2/E/zeaywHxJOATeyPtuJBAHxRKPoAn0HEmnf/w/
         gKk4EJ20xvutit4c+/j5l31GLjVe6k7CqKbA4W+WQhIUH1Skhc3M8mef5iksp0pVAAMC
         N4jQ==
X-Gm-Message-State: AOJu0YyCZygdwTdLYsQLQEdxzpEhtK7BmRqhwwto/bZ6xcSDmD+wCahP
	GMK6B+h/3gsA++cWimDwln/xcf6s8/uzrRNjCSQT7gZsWATRwMzOTJFyjAOe7ZWL+LMQcJCYRG9
	JOcx3hMV7ifbDFOLUCCj+EqjseXhZCcSVSV8LQgTr3A301nxlyclkKMmrOsT9ljYzkpaAxEUg
X-Google-Smtp-Source: AGHT+IEElXXX5swKl6KyFjYT0cXfV2RvqOoqRciwxP7cUDdQFtrGDXwhLRLqsAvoSbI9GfENqiMoucZ2zQg5
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a05:690c:290b:b0:59b:b0b1:d75a with SMTP
 id eg11-20020a05690c290b00b0059bb0b1d75amr563ywb.4.1694643083195; Wed, 13 Sep
 2023 15:11:23 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:11:00 -0700
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230913221104.429825-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-4-dhavale@google.com>
Subject: [PATCH v1 3/7] erofs-utils: lib: Fix memory leak if __erofs_battach() fails
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Need to free allocated buffer_head bh if __erofs_battach() fails.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/cache.c b/lib/cache.c
index 5205d57..a9948f0 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -282,8 +282,10 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 
 	ret = __erofs_battach(bb, bh, size, alignsize,
 			      required_ext + inline_ext, false);
-	if (ret < 0)
+	if (ret < 0) {
+		free(bh);
 		return ERR_PTR(ret);
+	}
 	return bh;
 }
 
-- 
2.42.0.283.g2d96d420d3-goog

