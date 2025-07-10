Return-Path: <linux-erofs+bounces-576-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3515AFFB07
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:36:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd69G4mh6z30MY;
	Thu, 10 Jul 2025 17:36:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752132994;
	cv=none; b=MYh7KTENAaRZ3B69lVL4ysACCzuT38HXR8Rh4+lckwXPsa8MKhWEpsaEmU3KZG5gEkTUHP+Mf2mbzVkxKnZSyyCHAPl6av4Qu0BgiJAttvkvr0YuuLFgZpxdRU3bimOtlHKRxWrNAzYlf8SvyAiN4EqufZLHyMpR5C/IRdS9CMBj/C6ivSZeaEFvcJNngFcL8lAnD15I4S6gwxyZomw0+RXLlU9wcNGHadL0Cx1Xl1Di9seL27s9MYSj7myb1tdmTUaqOibPc1djijwGY4mTXX5p+SuGO/A7EzBZiroKuC6riVPT0lX3dPJDIg4fvb4FFe9nEJFuR2mLWH7FspXqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752132994; c=relaxed/relaxed;
	bh=D+lClq7/s6w840WXa+oot6gvJxolaiUqzeJLD5Hz8V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsMV/cxXxae8tyQjOpN1tk8CCuAYcTJ5t5c0YsA/BCbysVUNWeo748J+bcu6ojhCbScn0eXvKoVj9C4xgQtNJ2MPMqvMsW+5QPUsCxc44+QXsjiy/vDtWCp1Ccetuy8AOMWdlMv9KYHLAKIWWU3B8HoDikvSR2dWWXmMuPyyPLcDpUv1uXq1oh4mqJY07qcUf3jAKNrSEGX3fFnqy8cgvAhNNLzUqhAXul8mMoL8yp09EIfH8Wuy7TtHrK0AOt5IXah4fQNelvMxpj4mkTc/2VLS53zSs+TZI1dOFHE7prqFbmOAJj5SLU3/PtwamQXvCOy5/0ZSU/09AAyd2MPgug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LdnGQlBQ; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LdnGQlBQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd69G0PBVz2yMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:36:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 843025C6BD8;
	Thu, 10 Jul 2025 07:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4448FC4CEE3;
	Thu, 10 Jul 2025 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132991;
	bh=GMlzRaxdgPmvNaWpauij4PKvNlwpIxfD/Me2XO52+XA=;
	h=From:To:Cc:Subject:Date:From;
	b=LdnGQlBQ/PjAKADHhN9GqTbXiiwJoMbuB1Etc4dBbZOg5TULyRfBX/zWv+DeOIB52
	 BX2wB7XJ+DNRUoqyBfMK0ulwfVrlQ1v4Ul7lv9s1LczYOspq8PwISWwoA/sEysx6SI
	 jdUw9REfMjctqRbeyD5suIdyIgV1JuSZ3w1ZTD7rKl8X7FVh11chPzcmXsOY5KS+jD
	 xTfUQMgTIOxNK5c23Ui3bzPes0k2EDc2/JFBsvOey2IhnCpI/bRhv8QWYgkcNyv9oh
	 l0bj5WlevUB6qrobgyHnJSA8LSowhs1Y4BsS3XBJYHjNej5p3elzXBUWpG1mSThX0B
	 rlA0aPqCAl2Mw==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] erofs: allow readdir() to be interrupted
Date: Thu, 10 Jul 2025 15:36:18 +0800
Message-ID: <20250710073619.4083422-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In a quick slow device, readdir() may loop for long time in large
directory, let's give a chance to allow it to be interrupted by
userspace.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 2fae209d0274..cff61c5a172b 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -58,6 +58,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
+		/* allow readdir() to be interrupted */
+		if (fatal_signal_pending(current)) {
+			err = -ERESTARTSYS;
+			break;
+		}
+		cond_resched();
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
-- 
2.49.0


