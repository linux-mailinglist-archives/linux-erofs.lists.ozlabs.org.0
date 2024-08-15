Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD9953B64
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 22:23:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202405 header.b=LI5tQQWt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlGm66ctZz2ykZ
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 06:23:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.28.40.42
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202405 header.b=LI5tQQWt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=lists.ozlabs.org)
X-Greylist: delayed 453 seconds by postgrey-1.37 at boromir; Fri, 16 Aug 2024 06:23:27 AEST
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlGlz3yNmz2y8k
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 06:23:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1723752945;
	bh=rlCMvh1yarf8OiDcD/WoZJAX8poPXXwpdq0IILTjtcY=;
	h=Date:From:Cc:Subject:From;
	b=LI5tQQWtzdTjy96vntzdFvHLVXTxWTkDOkuSFM+9pZItliiGV+sBQ7UiVZWJ4HMnX
	 aca1RLLTEgKBbdZHl7UOBYhn3RisXmcgpzI5/icMgBPTelW42D1wX6QP98r3LWTJCn
	 l3HT8c/H+cgMqQx+T/vy2/dHwEauCQK7q7thgpgEqB1cALONTyuLGx6ZFGteaEPVIZ
	 2mLiIFYxhswN57+6pVnNkXp1Izllgi4hLlEr82vjUX7+pXTIgx5/qRDYQ03Ak6S4hN
	 aBHWWW88l9I1LZBtP5P9UXLhRYdYsU6M3H5qiE/KRpTlEOWViXsD1efU3Tf8/uIxKN
	 Oy/o4BeCCzTHA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E4EB4B666
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 22:15:44 +0200 (CEST)
Date: Thu, 15 Aug 2024 22:15:44 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: lib: exclude: #include PATH_MAX workaround
Message-ID: <xs4azw3vs7oryqnpkvzsl6qbmma6p646igoklia2fextt6pdiw@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20231221-2-4202cf-dirty
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fixes build on the hurd.

Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
---
 lib/exclude.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/exclude.c b/lib/exclude.c
index e3c4ed5..5f6107b 100644
--- a/lib/exclude.c
+++ b/lib/exclude.c
@@ -8,6 +8,7 @@
 #include "erofs/list.h"
 #include "erofs/print.h"
 #include "erofs/exclude.h"
+#include "erofs/internal.h"
 
 #define EXCLUDE_RULE_EXACT_SIZE	offsetof(struct erofs_exclude_rule, reg)
 #define EXCLUDE_RULE_REGEX_SIZE	sizeof(struct erofs_exclude_rule)
-- 
2.40.1
