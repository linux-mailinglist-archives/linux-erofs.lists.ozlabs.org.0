Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B47BF9EB
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Oct 2023 13:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1696937988;
	bh=Q1uNUR3p+bsLHCGpAyDRwIF8oWu4vkq7rZA5Irlgj0g=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=dVrFAWKr6nIXa9WCCC8zTlWpGriWcMwmLP4b+q3EQHXwX8s1KElApAIzY0aYEpBsM
	 OFuNMuKzix+vFvq0aLZ5REcPX3GX7Q2hQ9RrBNEMyDUNmZj1c9M+i3LmOB3vxobsJ9
	 ikZ2BN/xY5VX7Z26IvZLCZgnm1mnEmUTqkTve1C3Guw7BZrT+djztqMeHNlckipYvV
	 HGbfD8HPxLMqivZN/Ts5zihhve62Ye7Ri2e67hvJfrYO57uR18sOEvTeXc57jDU7lU
	 wKvoBTJzHJP6B10H6u4DP/GBVupEUIatkmrVN4QI23dA8qJX3q84Jj0Z7fpxwqGmQd
	 QIzl0rx4Fmu7w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S4Ypr2sWXz3c13
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Oct 2023 22:39:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=antgroup.com (client-ip=140.205.0.220; helo=out0-220.mail.aliyun.com; envelope-from=tiwei.btw@antgroup.com; receiver=lists.ozlabs.org)
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S4Ypl4kstz303d
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Oct 2023 22:39:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.UxYjvU3_1696937965;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.UxYjvU3_1696937965)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 19:39:34 +0800
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs: fix inode metadata space layout description in documentation
Date: Tue, 10 Oct 2023 19:39:15 +0800
Message-Id: <20231010113915.436591-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
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
From: Tiwei Bie via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Xattrs, extents, data inline are _placed after_, not _followed by_ the
corresponding inode. This patch fixes it.

Fixes: fdb0536469cb ("staging: erofs: add document")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 Documentation/filesystems/erofs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index f200d7874495..57c6ae23b3fc 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -199,7 +199,7 @@ may not. All metadatas can be now observed in two different spaces (views):
                                         |                  |
                                         |__________________| 64 bytes
 
-    Xattrs, extents, data inline are followed by the corresponding inode with
+    Xattrs, extents, data inline are placed after the corresponding inode with
     proper alignment, and they could be optional for different data mappings.
     _currently_ total 5 data layouts are supported:
 
-- 
2.34.1

