Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E6420522
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 05:59:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HN6R507bmz2yPw
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 14:59:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gpEE9tML;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gpEE9tML; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HN6R162Nqz2xrH
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Oct 2021 14:59:09 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B11B611C7;
 Mon,  4 Oct 2021 03:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633319946;
 bh=+OnX9C5RMPpZh6BJMQow0X2L5eo6zl0R5BRIINNtYxo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gpEE9tMLL5CQu9q58pIQe7Oo44yPxsvEWm9xdYUhxeUSKuAnTl+ZfBmG2qjlYBYqY
 MiAHwA5fRML8/VzkRNREp3SEjEflVIukEnCHLCmi44HTOdJmcgQs9Ca89p4IqG1FGZ
 IbtEeTpEfnTBWSVUNHqVSo7r5f8VMSEdGmv/SKibJPHAWcDAG/ZnFhtG7yIxGeJzUb
 EIq2Pso8nSIEm2TDqEBqPyI8V3WdUVZdojuA/JL1nHOpHl9dX7y5Ggvoi1tigWqCsf
 a2xSnT46BnKFhK+T7sPhzCJcWw12DiCoXJYBGy0sU+sPnnH7cSHsfcyXKBf1S8Rsag
 NcCmPC0VApZag==
From: Gao Xiang <xiang@kernel.org>
To: selinux-refpolicy@vger.kernel.org
Subject: [PATCH] Add erofs as a SELinux capable file system
Date: Mon,  4 Oct 2021 11:59:01 +0800
Message-Id: <20211004035901.5428-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <8735pjoxbk.fsf@gmail.com>
References: <8735pjoxbk.fsf@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, David Michael <fedora.dm0@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

EROFS supported the security xattr handler from Linux v4.19.
Add erofs to the filesystem policy now.

Reported-by: David Michael <fedora.dm0@gmail.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 policy/modules/kernel/filesystem.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/modules/kernel/filesystem.te b/policy/modules/kernel/filesystem.te
index 7282acba8537..8109348f70de 100644
--- a/policy/modules/kernel/filesystem.te
+++ b/policy/modules/kernel/filesystem.te
@@ -24,6 +24,7 @@ sid fs gen_context(system_u:object_r:fs_t,s0)
 # Requires that a security xattr handler exist for the filesystem.
 fs_use_xattr btrfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr encfs gen_context(system_u:object_r:fs_t,s0);
+fs_use_xattr erofs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext4 gen_context(system_u:object_r:fs_t,s0);
-- 
2.20.1

