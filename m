Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B366F88DA27
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Mar 2024 10:22:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V4LmM3hGpz3ddR
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Mar 2024 20:22:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukeshu.com (client-ip=104.207.138.63; helo=mav.lukeshu.com; envelope-from=lukeshu@lukeshu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 574 seconds by postgrey-1.37 at boromir; Wed, 27 Mar 2024 20:22:23 AEDT
Received: from mav.lukeshu.com (mav.lukeshu.com [104.207.138.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V4LmH0PQbz3cM4
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Mar 2024 20:22:23 +1100 (AEDT)
Received: from lukeshu-thinkpad-e15 (unknown [IPv6:2601:281:8200:4f:aee0:10ff:fe55:8023])
	by mav.lukeshu.com (Postfix) with ESMTPSA id EEC308067A;
	Wed, 27 Mar 2024 05:12:44 -0400 (EDT)
From: Luke Shumaker <lukeshu@lukeshu.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/1] doc: magic: Fix the 'clear' example
Date: Wed, 27 Mar 2024 03:12:39 -0600
Message-ID: <20240327091239.4141736-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Luke T. Shumaker" <lukeshu@lukeshu.com>

---
 doc/magic.man | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/magic.man b/doc/magic.man
index b9845f5c..2ee28774 100644
--- a/doc/magic.man
+++ b/doc/magic.man
@@ -1,5 +1,5 @@
 .\" $File: magic.man,v 1.107 2024/03/01 02:57:32 christos Exp $
-.Dd February 29, 2024
+.Dd March 27, 2024
 .Dt MAGIC __FSECTION__
 .Os
 .\" install as magic.4 on USG, magic.5 on V7, Berkeley and Linux systems.
@@ -764,7 +764,7 @@ If you have a list of known values at a particular continuation level,
 and you want to provide a switch-like default case:
 .Bd -literal -offset indent
 # clear that continuation level match
-\*[Gt]18	clear
+\*[Gt]18	clear	x
 \*[Gt]18	lelong	1	one
 \*[Gt]18	lelong	2	two
 \*[Gt]18	default	x
-- 
2.44.0

