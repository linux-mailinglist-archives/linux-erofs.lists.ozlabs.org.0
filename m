Return-Path: <linux-erofs+bounces-1595-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7CCCDCFFF
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:32:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pJ2c79z2ySq;
	Thu, 25 Dec 2025 05:31:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601112;
	cv=none; b=VFMEBM6+Y9HGL6f8b3T6QJtma2JyJRTnRSH66zSvDY4BJWHIzxjHzZHpt1tVxMSyyVETsPERT71Lfp1KTkeoNjIrWFdH53A6M+Jr4r4GYMs3d+OdwrHTDP5KD3yVyadwV6Z4iEhTPkVM7A0hEAtbZdhETuXXX1OiQjv8JW3m5cILVdewiEim6eLwUdE92kOPhCTOLQdevccLypUBlGARs5gKr7tvkQaxh5QVUI5wB7K9/+pAWk4yOPL4EBMdN9LD9N8PqMRp5ryCGdaUPbInOMnsfbCv/DZJIJAecKRgq8QHLMkazJlU9rI7VjcBj9iligvQvEYJPkTWXIqWTEEvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601112; c=relaxed/relaxed;
	bh=Um6wW4cuWayYv/bXbL1oZDTRqCozW5yV9oNBXLG3syc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCLFwlL9m9VoiSb0QCDlbG8BvLUwBw2EGdwHw0ga7fjsHeK+xf7w5mpaKaKMI9KfHWihJb91ofgHrLTGFZzS2tZ32uvfWeQAfYZINJAgqbcoYpVySNh29kVIGP+cm0EErNWXsYfPdF5ypt9eqjvaJVZcn7MoUx0h/jJIBuOPZ4jg1iWeO0mj103Y74A/9yBy/pFZHPtThRvk2iDfqv9ANuARO7g+Q+sP8J5Ybq1KP3Ea7O3GMRKwaWfCiVZRiVE2NgsreqUYnVWrHz5sOuKl6hgKQlSfrGkidb4d6yy0eUx963MNsAZriJ14OX0wo0bVXkMTXI0Al/Lsq2z1piGzgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rOCwoO27; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rOCwoO27;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pF3rLjz2yS0
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:48 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601104; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Um6wW4cuWayYv/bXbL1oZDTRqCozW5yV9oNBXLG3syc=;
	b=rOCwoO27b4MKESHLYLjI5ccbTvqatQlr49WUnkhbIqNO1vLzDQi8sS5Y7bPASk62s0kKKMIo/irJvwldhMQDYjv51E56bi1gPN/pTiFUhFob72lb/9X8ZB9nuG8PlR6gmPXCJE5Pa2qTXC8NsplKrVxjPJHeIVJfMRGh7QFjI1o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc813f_1766601103 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/9] erofs-utils: lib: make the size of read data stored in buffer_ofs
Date: Thu, 25 Dec 2025 02:31:27 +0800
Message-ID: <20251224183131.2302377-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
References: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Source kernel commit: 5a8ffb1975c5b6511a996383fce7ad0f97132a5c

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 4981944ff965..585908f61623 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1369,7 +1369,7 @@ static int xattr_checkbuffer(struct erofs_xattr_iter *it,
 {
 	int err = it->buffer_size < value_sz ? -ERANGE : 0;
 
-	it->buffer_size = value_sz;
+	it->buffer_ofs = value_sz;
 	return !it->buffer ? 1 : err;
 }
 
@@ -1403,7 +1403,7 @@ static int inline_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
 			break;
 	}
 
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static int shared_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
@@ -1426,7 +1426,7 @@ static int shared_getxattr(struct erofs_inode *vi, struct erofs_xattr_iter *it)
 			break;
 	}
 
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
-- 
2.43.5


