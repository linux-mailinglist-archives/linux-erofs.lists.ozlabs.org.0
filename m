Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F697E596
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 07:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727068737;
	bh=DQxotKSCm7fESVn0Wq87NBtzZMu5Vi4aOIOVZMx7Zgo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LwxFrWKNlKeiNF8TRTbir8Y2tmpjQkZ9U7zO5Dw1XHBXfnWtgQGeYOkcMq1dSCZSI
	 teKaZhZCG14LCl1hbkzQTFlQ6V7sr3ecR0jWkMrmygL+MRFiDXpYi1NgYSyd/LtPE2
	 mb7q8d8ij+ONdkU3uhv93WrAOpB+VlLYrqu4RFGAZLMaK57vGoubdec7LETJvZamuW
	 SiPmlG7VezMFPY0Nd9k7pb+zhyIC5929P8cVxCXeQffOIn2E4ixPsw6QrDe0Z2NOUJ
	 zLdwcQ+hWp/eB9qO/OtW51rbClqy9JNFGxNgLzvzj4LU5GNNp3lKfH2lP2AJKZ6n5y
	 An62Hcwu+sNyQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBrrK54QLz2yVX
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 15:18:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727068735;
	cv=none; b=om5ei0po66ZiitWbup3+f8YBM61/sd6SP8oMmVGRPeApFfEIhbcPAArAydO5JGste1BPj2mlLIto7L0qnh9PDcsn4NgaKDvkxs0hFXNuvK3CsdP+BHOStDWptFf1TB2854KiWgFFZVX6Wocv107/xVwwMh5SbidYoXbdHhZ7fuhHXdqp6jYkNA6x2WJFUWJrldBz+R2tfImLEl18iWDS8obDhKqBZSJz/53uxy2MKLBh5Xlik1bK+/DgZBUkITLxVVY9aWy//SNiEGGgNz5CJgvB6pr0MgmtzSpNeI+FNv6ul4iElqb26r+7BZqb4oBvw3pVLAbC0LEwuRo5Z3PDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727068735; c=relaxed/relaxed;
	bh=DQxotKSCm7fESVn0Wq87NBtzZMu5Vi4aOIOVZMx7Zgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPfTiXSYF4YTQFkx1Wb4ULZcCSQuXgHtGVUpT6gusWCkpstLa2P13qbTzns7CpzolMZbNRsYrOg/a4hsRIS6d2BaoCjRR2msU8vQSBdL3/cl/YgTk8ErCqdCGH20Ph80lgqondwUtLcp5KkT0raAP7+0EfQ+OGVutt4e2VMyISa3Bv9M+tnmiBrAGk4k5YAZ4P+2exGw+I7UNEpWn+YhfDY2GFBkTn/WP+xQ9ey7PPb3YccHUHsEATkZgutdgHf+pq6NUvqN7FNWl7ootHSZwCMPEwJ9tYfMF6KSPUqYKvqtj5bBkVp2FeSDnW+7COv0FKUHcsFUh5YVy7Gx3ZZrkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=nAkgKmrt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org) smtp.mailfrom=orbstack.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=nAkgKmrt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=orbstack.dev (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBrrH08f9z2yNJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 15:18:53 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2053a0bd0a6so38492255ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1727068729; x=1727673529; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQxotKSCm7fESVn0Wq87NBtzZMu5Vi4aOIOVZMx7Zgo=;
        b=nAkgKmrtDUfSbhxpcnnnd3X6X0t5qz0FkH4aYYsSRGAr+A1xzKvgffOKj6OOV+fTEC
         U0DUdgRTW+T/3uBkX3rJxEfaLxbYBw48nGy5+T/anu1XwMSZRqIo6JXjSzhJpS+R4x7Z
         RiWEq1rPcEaDib+24JuEe9TYsKh+0TKNqSldtL8sGX7a8BZfK0qcbyVl3Co/XwgNVdgd
         eZ9qo0R3uiLLRQ+HRZBPM0ifnp44WweTvIkdkjWfAAdN3c8g1xXywIDuGTBoDFgv4aOG
         b7e84KF2OgEV8QaArWtJNgGnyC7/HHwg/OkxzJqgv6iP2xmDauH36eRymjmIxws+3BKY
         wF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727068729; x=1727673529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQxotKSCm7fESVn0Wq87NBtzZMu5Vi4aOIOVZMx7Zgo=;
        b=ull5lDbwiC12BnLssYBLdQbR4RAh8fGBUTj1gnakUbJO/sYU5QIMuSc2YsnsO6e79o
         QymZzS3r9EOKTSTFbkF2MIORa6HrAzYAT7f1mWMnhcS2r+V5rcor8lODQynxNfvS7Mgo
         lcT+OboksQKqm+xMb46E3X/PS9p0FyCaeYi4bNsh8sLRe3Gpor3p4lwirltn1qbWUFK2
         bZTbW1tkOrGtiCDaatnb9RH9BCmXeRNedrJzwe1GTcX67EUvNymeXrg2dXH/r8eTe9a9
         DfmU+W8R8w8PdNx4fdcXCGR4V6A79x5wM7ThwcYS8Py2L5X2dYml8Ba5xGMpvsZtHtwT
         7YiA==
X-Gm-Message-State: AOJu0YwtH7JZcIvqixmqVDVG6EkZHeNQOZ+zLt1C6gXnmCiMk5Cjb/fp
	sHQXVu1hKIlUMaNlVSMQi0ODfSFIMj4g8/xgK5gknP/UjUFlT4SZ1e/qkwiyR2WGcN6NDvAdAO+
	rXPyqSgRqu3lz2cjx9U6KH1xt8pvOYBRFRVdAMH8ed8j6CWQes8BApqnm6DLRzOFdCiyCYUIje6
	gCI1K7SPwhu5z6h/VSy9s03sGD8J5JeyESwxrrXnZQqshX
X-Google-Smtp-Source: AGHT+IFk5tvWDuNIe63V4mJ1X2hhnzQjqAqM8jWEHpbmpKz5l3nlaj5GvAwt7YB7JFJSm8pDXvyokA==
X-Received: by 2002:a17:902:ea06:b0:205:4721:1a7 with SMTP id d9443c01a7336-208d839d7c5mr136861725ad.31.1727068728927;
        Sun, 22 Sep 2024 22:18:48 -0700 (PDT)
Received: from arch.. ([143.198.151.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc504sm125634985ad.26.2024.09.22.22.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 22:18:48 -0700 (PDT)
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v2] erofs-utils: lib: fix compressed packed inodes
Date: Sun, 22 Sep 2024 22:17:29 -0700
Message-ID: <20240923051759.7563-2-danny@orbstack.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <CAEFvpLeBDf_BjwJJRc3Ecn7DMZNkFYsAri6=dy7ERQ2SFLmhFA@mail.gmail.com>
References: <CAEFvpLeBDf_BjwJJRc3Ecn7DMZNkFYsAri6=dy7ERQ2SFLmhFA@mail.gmail.com>
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
From: danny--- via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: danny@orbstack.dev
Cc: Danny Lin <danny@orbstack.dev>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Danny Lin <danny@orbstack.dev>

Commit 2fdbd28 fixed uncompressed packed inodes by not always writing
compressed data, but it broke compressed packed inodes because now
uncompressed file data is always written after the compressed data.

The new error handling always rewinds with lseek and falls through to
write_uncompressed_file_from_fd, regardless of whether the compressed
data was written successfully (ret = 0) or not (ret = -ENOSPC). This
can result in corrupted files.

Fix it by simplifying the error handling to better match the old code.

Fixes: 2fdbd28 ("erofs-utils: lib: fix uncompressed packed inode")
Co-authored-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Danny Lin <danny@orbstack.dev>
---
 lib/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index bc3cb76..4c37a0d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1927,7 +1927,9 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 
 		DBG_BUGON(!ictx);
 		ret = erofs_write_compressed_file(ictx);
-		if (ret && ret != -ENOSPC)
+		if (!ret)
+			goto out;
+		if (ret != -ENOSPC)
 			 return ERR_PTR(ret);
 
 		ret = lseek(fd, 0, SEEK_SET);
@@ -1937,6 +1939,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 	ret = write_uncompressed_file_from_fd(inode, fd);
 	if (ret)
 		return ERR_PTR(ret);
+out:
 	erofs_prepare_inode_buffer(inode);
 	erofs_write_tail_end(inode);
 	return inode;
-- 
2.46.1

