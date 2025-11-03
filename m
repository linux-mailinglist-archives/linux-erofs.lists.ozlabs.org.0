Return-Path: <linux-erofs+bounces-1312-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CEC2B524
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tns4mFKz2yrm;
	Mon,  3 Nov 2025 22:27:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169233;
	cv=none; b=YvTKZxRfofACNfDiWMC357cAcwZdsRWWjGg0yxvyrMssxv9/cl2j8BD5Y4JNYTiKC5iPnpwkC/nMLB6Q6Ljj7jx8DK4EXhvOA9NDT7tuZ3TVhQn/VmHet8VzLl/R73QvddAwzRDxQnPP49IeM0jPJQyJq4t2ESmwdDPwxvHWzWJS+WVE32n4AHDig1pnMXzOtr2cSvfakHGkSLEsNB1hC6PbG5ulqASrSj07T9N8OXVePSDi0j3ux97JGY1VkHDXXlvEJGtyPpxpuIMtErXLzkpPY50VmTRpWc8MPkFuCqEEsIZmVdq3hRmoBS3QO11TzQ8RRPhkZXKvGMRIXhqlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169233; c=relaxed/relaxed;
	bh=P1884besVxCK7uDCfRdi4jufmgrkiJldpVEU8yvV0h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzuyY3oTC6bB9rV2ZwGN8GnEkB9abLcOC8IdOeWqsB9Khbjm0/i0RdF9eIZhNwp6ht+OBwMNAmqmlGRRbD+gBtVQjTfhuQFtG8LAJFL48cvwHdqaHwAiK3KxtxsVhGAEakn/IDvXbAs7cUYdA+/5zI5idQRRF3O2vJd4f99BiRKfA66b3vwupQSb6dNNhp6s4aMADwYR3gtaxyHW4vk14Swnz/U371viam/aCy3btqZR7x+Rmt3ZP3UN1XnWsjUbMRAYjbrA2yYH1+8594k5keKsWntMUomhJtPY6EPVkMsXBb+aamsrdZcjnbn76QrZzFypyL5oMia/3S1tB4Uobw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jLdXqD5l; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jLdXqD5l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tns0Rvjz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D8044345B;
	Mon,  3 Nov 2025 11:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE21C4CEFD;
	Mon,  3 Nov 2025 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169230;
	bh=7XvDmuLKWtrG8tCoP/2+H/Ukc4K30gpuVQ4WPA2E0lk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jLdXqD5l4Xp7KDST1IF1JQXGHsTch3QsJa+I3ofzc8gfQryyrnneR8N/I6s7hKetC
	 BFrHmiKj1wdpeC76SqGIPoko1Km7hHPkR0s1O3NaEryoOEda10C0l3Fz+TrAzfOIVL
	 E9+YjcIznWS82YD3+WBJDVthx0MkS94g4YuBBDOb1Hb2HKaMQ3z3ZcxhiswtBXTOq0
	 BuAIU/8QYb7SPzY6cnnnMtzMvkGBLGVtaPAstqThfphVP0+oJ6AaodsxzoBrXjnQi5
	 GkRonLkT/Ce79Z7YJzgDK1vTNBiRvcvNm5/AE18gfxbiG1Hlg30QV94YkWb+3I9XJK
	 GnVL/AHRfZe4g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:49 +0100
Subject: [PATCH 01/16] cred: add {scoped_}with_creds() guards
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-1-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7XvDmuLKWtrG8tCoP/2+H/Ukc4K30gpuVQ4WPA2E0lk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGxfdtUr4Hmjparc28LU2KdX86XOvFbRTs9PTr24I
 aZh6+HjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRSmb4p7WoYI2EzgP+yo22
 DCdF9vvXv9HlX3Re1yzg203+Q0unuzAyXGhTWzeVqc786WudX0Y3/2ROOMlg5ekSOSkveqPHDt1
 UdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

and implement with_kernel_creds() and scoped_with_kernel_creds() on top
of them.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index c4f7630763f4..1778c0535b90 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -192,11 +192,15 @@ DEFINE_CLASS(override_creds,
 	     revert_creds(_T),
 	     override_creds(override_cred), const struct cred *override_cred)
 
-#define with_kernel_creds() \
-	CLASS(override_creds, __UNIQUE_ID(cred))(kernel_cred())
+#define with_creds(cred) \
+	CLASS(override_creds, __UNIQUE_ID(label))(cred)
 
-#define scoped_with_kernel_creds() \
-	scoped_class(override_creds, __UNIQUE_ID(cred), kernel_cred())
+#define scoped_with_creds(cred) \
+	scoped_class(override_creds, __UNIQUE_ID(label), cred)
+
+#define with_kernel_creds() with_creds(kernel_cred())
+
+#define scoped_with_kernel_creds() scoped_with_creds(kernel_cred())
 
 /**
  * get_cred_many - Get references on a set of credentials

-- 
2.47.3


