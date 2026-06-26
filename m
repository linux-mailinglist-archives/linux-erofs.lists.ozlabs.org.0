Return-Path: <linux-erofs+bounces-3763-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ujkDSzpPWql8AgAu9opvQ
	(envelope-from <linux-erofs+bounces-3763-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 04:51:24 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69B6C9DEA
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 04:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LX+p6AYU;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3763-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3763-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmgD55ylHz2yYd;
	Fri, 26 Jun 2026 12:51:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782442277;
	cv=none; b=f/dXczTT0rU0AgnnBjc7Wn4rzxfQbRX+zO4D7+3Q0oS+g044uiOYakgkhxPnlh5noEaFr/Ihl6wzvZTRHT/hfUO80VsggEaNgso0XBPCGzb2hLS2JqMkxozL2Tfg8kc7cdYMqAQTiyyo4rjBLpHVmMwBPlNjbXntKwJU7cT3RLPSUaSharweuFUGQsabQOgeQl+6xwQ33qYoIYxiqduv45Erp0KTzH62ALcyo2X72WM7o0A7KDvYtmEQ9PVvt0kqm0sk/GbL95nM4X9gMN8TSxd7W5y3b65PWSh6kVvfN1pk0IfBrPiuo6/8XX+C5+WROOzz2lo2Dhkbj7+TPoA+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782442277; c=relaxed/relaxed;
	bh=gc0GetBc82q9jqkpgNqhqiXV0eYJkD/oJEECTUUA+nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imMC6/IbiJsEyXRDelkHilO89dDVkHKXYo7hpJjs4eg+PDmQ76uBPmAsJPaTMDkmWAZz3MIuhkVtH1mrLD18KnWaOvzdbfRB6qxV/yhr91uL+2AmqWOvhdh5Vbob9MhP1jsXQ+Pm7CXfdL9ytgvDJ2aZx0GEU4mKlrj2ezIXj+1OVkrc9jROJVNBNAtGtZko7a6KZDcQB9jsS8j2Fp7jMrwpIJEX7bZlssUD48U+EAjBY1yYHbyAiZyMZt8WSgbLDWoKtrDHjp5BpLgkAw0+wOxPynSkTmfFch6Qh9IPNREqaJxvyC+vW5sxuPItq4mwNGykW4Tgub6o+wpMSHX0MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LX+p6AYU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmgD12b9Nz2yVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 12:51:12 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-37de8008910so239930a91.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2026 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442269; x=1783047069; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gc0GetBc82q9jqkpgNqhqiXV0eYJkD/oJEECTUUA+nk=;
        b=LX+p6AYUj2SuUOZS26eIhOGlrFizHu887wlF2s/I/oS5e9jx/QkES2ERy7uFAWVF21
         AZAsypwEh/F2YQaT9L+E6idHkQt+daJknsTyfJy11lPMvIhec3C/ihPiOglxwXzw48Es
         V1QbNsWFSc0GSo+HXG6VpXfjiVqPpi33KQsFesOnOyBeYT6Uc1FVg1BilIHsqj5SK++k
         XK0HHEfAfJtjRgRkkqZNGOXkKLsvmyzXo+Xlz01Z5tobZu3QgifYNawCZ7RVRGFLhs2g
         8aSOVYyB76225dGHzfLUqSbBUEC/LlkgBVNqv1CHmrBPOhYh9hNYwOZhtUXAlIW8fFTO
         hAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442269; x=1783047069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc0GetBc82q9jqkpgNqhqiXV0eYJkD/oJEECTUUA+nk=;
        b=JEKog3dZzkF0P7D3Wb8lVOdpWdMxELdq8vK6RLlGBBmbAoDJoEfEXG2FAGWCfc/mRi
         nW5xIPYkcJiVAxWlD8El9TlZa9301YQ6lhReRuwpHDPq5yhUpJ0B1hHKhWY4rQjKRvY+
         yHQ+fZ/qO4zaVyZlz+qJpHsH3fjUEd6W28vAaX88Tgh4dg1ls8k1HLelWHPOSJ8GVZ8t
         RfIcdBtOufBhsZ6/kyogWejv57BXGGzQhQ5uC8WeuKR2l3ZJhkB6L+OoOo7eubzhyTnI
         +IyCZj1PQP3n5kQG+j6WBMNO6jBUVD3+NUAAFh4CzdoAefIvGUsvBDP7SLZ2+ZBLz++2
         3/rg==
X-Gm-Message-State: AOJu0Yxj2e0TsP7rOP59VcZEws9O+M4CMATYAMpNxVv1MtlUZ9U08tYL
	nVc19rkVQPFEISucbsqiA9+KBaL8nVKSHSLyuy3tmUaOiUXvx8ZtAbbgg6ISFIdXgI8=
X-Gm-Gg: AfdE7cm3xN+95YFU8zCPqYQRw8dClnUn7dDu34dd3ZBLq1XNpSun8EeRs0scR3puIov
	1xDoAhnmZ8n12wUBQhkcyCf0I7d4L8Ays7qnGsP1sOdyMTJJQen7kcFKAjgoHiTw6T/NRKQqW/T
	ZIZMThuSQ5cC7JUyACYwH+p5ZoM7cZ0E/ZlyloyGVewv/8i7o3WSoUo5YPXjFTVxj6iCZ8jeFW3
	KuFJk9pdV1emkSu7UWra1n2keQil5klm7RLnkWwJp6mKl46x1072ctHhJwvwH16V+LdhB2l/BOr
	sSsEgRzwqPwY4sUbZEndSLcPTv6htCfC0B/b3HkYFFb8Y+RmxXUIoWuxXoEhC7XtRkDgAwxZINh
	2KvV6Moej1Tt5GGvvmwnQlafA7earJotEVgRXyTrmQLY6ad8yLkp4pG8B3Y1h44pKE3NGONXlGF
	fBiOr0relqRfsRNIBawbeTSj6IwU9rbvrKfO3xnJ0aLUfitnGQ+w==
X-Received: by 2002:a17:90b:1648:b0:37c:18e0:90e4 with SMTP id 98e67ed59e1d1-37df9f28202mr4260858a91.2.1782442269326;
        Thu, 25 Jun 2026 19:51:09 -0700 (PDT)
Received: from ZYF-PC.localdomain ([124.70.231.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b6788csm2876863a91.16.2026.06.25.19.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:51:08 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH 1/2] erofs-utils: tests: register chunk-based inode test
Date: Fri, 26 Jun 2026 10:50:24 +0800
Message-ID: <20260626025025.805563-1-stopire@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-3763-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C69B6C9DEA

Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <stopire@gmail.com>
---
maybe just squash it with previous patch...

 tests/Makefile.am | 3 +++
 tests/erofs/031   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index cd1971a..a1e31fb 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -129,6 +129,9 @@ TESTS += erofs/029
 # 030 - regression test for NULL dentry on hardlink-to-root tar entry
 TESTS += erofs/030
 
+# 031 - test chunk-based inodes
+TESTS += erofs/031
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999
 
diff --git a/tests/erofs/031 b/tests/erofs/031
index 3b2a059..f8ede34 100755
--- a/tests/erofs/031
+++ b/tests/erofs/031
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: MIT
 #
 # Test chunk-based mapping with shared chunks across inodes
-- 
2.54.0


