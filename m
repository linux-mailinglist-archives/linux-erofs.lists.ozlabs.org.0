Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010715FD3A7
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Oct 2022 06:01:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mnwmd4dxTz3c5q
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Oct 2022 15:01:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bVBw7C8D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bVBw7C8D;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MnwmS4FzHz2xyB
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Oct 2022 15:00:55 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id l6so549804pgu.7
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Oct 2022 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nYgul3lRujwJ42qoSZFE7XqKEVJqKbhFZR9KfaZtrc=;
        b=bVBw7C8D1QsTwnxtTu2VbnPbvtBoJsylLA2bb5saGEr/LADu/nDnjBfkQYU74tY/RD
         zgGp+wA/wbUJ9jwqOZAY5xLIyHv2+bW2GtWW/C6yg+JEpkQuXakt7x0nwcznKjlFJCWd
         TxH64TBFCSorvvWtz+3Xh756oqsGn/7AW2wveQVYInNYxN5J2oMFqD7GE0pLz6GGBrFk
         Lg821dE9bI1oH1UBFmwZDdzBn9KunBfIbsbfLapKRJOSZeJATIOoxCYahSXWM6g3TvRG
         eGpZCX1NCWSk74TnRpbI/ukzJl3Zqk4dBIiokYNsXC/OVI4wCyeckIcHPpvlTdQyliIo
         U+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nYgul3lRujwJ42qoSZFE7XqKEVJqKbhFZR9KfaZtrc=;
        b=1kqFus12/J8qCr2px8oqIRPdo3rD3RnbOdWwpNSPEzPcRHw6FFu8Ugl25XQSmaBw/T
         4+RLt7EZ/Fwjrxdy2xfUfnrtHY51r8H+yM+neHMvAWGtrqAY6LpNtViinqbDfwQ4kEG0
         8Vl39U5lNF2Mhk0Ba4/060PsoWehFSHv8WtQAjY5BXDEi/Y4XwjyMpAZDElcFcuTU1J1
         ZD5jAewlT1Mv5hhwNo1g2pz9C2CuXOlCMIe/OGd6PA9N3Vb8Qqe7rjSQraEl8vySGmsM
         WPZryVFAo2JckUvPL/KS6ot0DVoW3Noyjq9zwXeuQyF2jR3Iz97yL3xsKAi+2GIdBvwK
         qkOA==
X-Gm-Message-State: ACrzQf0mrB9vkuAQG80IbRxGKu3fkugc4xCWgQZNqGdzPFyxT2b+sVaB
	fuH8BlRHD3PbIMYOWfrQdmcbSuJ7INY=
X-Google-Smtp-Source: AMsMyM4reVa9+WLBPTDNvTyFvHkCAaJfcz8htYBU7GHW8n2qQzOw97qmWiw0SMeooWNgKNSrEGu91A==
X-Received: by 2002:a65:4c46:0:b0:460:f598:d038 with SMTP id l6-20020a654c46000000b00460f598d038mr20775242pgr.99.1665633651030;
        Wed, 12 Oct 2022 21:00:51 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a348e00b001f2ef3c7956sm2177823pjb.25.2022.10.12.21.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:00:50 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: avoid unnecessary insert behavior when not deduplicating
Date: Thu, 13 Oct 2022 12:00:11 +0800
Message-Id: <20221013040011.31944-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

We should do nothing in dedupe inserting when it's not configured.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/dedupe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dedupe.c b/lib/dedupe.c
index 7962014..9cad905 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -99,7 +99,7 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 {
 	struct z_erofs_dedupe_item *di;
 
-	if (e->length < window_size)
+	if (!dedupe_subtree || e->length < window_size)
 		return 0;
 
 	di = malloc(sizeof(*di) + e->length - window_size);
-- 
2.17.1

