Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79E79F4C2
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643095;
	bh=I4lTV01+BesOxGCb5nhocTFd2TUglI5zTUPUEGglgXY=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PfYC6klBqCYf5cDEt+akw4GCaqzK6yufXQ8ano6T4okuIeeqltqNSwZW9Y2bNDIgQ
	 IrsHEGVHsxTpkNmDIzmTuG7D+J7Dd7bHoA5qP18GIWntafy27AsnaiHj/gdw7HUYMF
	 uzcdIDiX1bNNRQhem0qGufj6H+wLLu7koY5/fi1CPOA5Yh+ZkOzUGxWFHLcJ5WUZij
	 RBnqx+HUFh0xkA9ajUaPm6qxlzcAm1VGhgHnSkNQK4El2dg6wOWDAA6MlSq50B8o1o
	 vlabUiD9jyP9FwGOn7vCP5Io0/Te1SKv4bJwL27Xo1rFdoQ94agfsSd523tS3UzFDG
	 tYxRjXU86sNVA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF6H3jnLz2ytV
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:11:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=TE1nepdi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3itmczqckcyghlezepiksskpi.gsqpmryb-ivsjwpmwxw.sdpefw.svk@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF645z2fz3c53
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:24 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d812e4d1256so361810276.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643081; x=1695247881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4lTV01+BesOxGCb5nhocTFd2TUglI5zTUPUEGglgXY=;
        b=HmRkTGvnbnzRs/toUb34K3rteo9Z7UnjJBVufY5iV4VOa8zmh0z75F4w+hBjXdB3b5
         YGP3cMZw3oL3lox85foyC9uARqIrklbk1Dy/M1Gogo2rjm1nFdpvFT8i4lX65Tj4vOI9
         ccGiwqiwm+kAVOmJxqPHRycgv3Tmv8TYf2ryRhx0nmAD3jk4AQQxkZZENLmWWcNgRII4
         EfR3HSl7BXuGQ/JQLktzphMjas1Sa1m3cUW39Zfh6XtOx7RGmzwnK0G3hzhSRInkjHsy
         v+EFoFCxjtKhdLk21VE1hiZg5FvjKA/0Q75DDkVboK15uzRCTbq1JWpI10hm0RB0Oml6
         csbA==
X-Gm-Message-State: AOJu0YzarzN1bktz/q4DUneChPsRIZqNR8Z6MiYxBOxGE2L0qEEi5Kl6
	wiSd5XYyZPIOcq7H7T9ylBUutuvffYLOXIS05iz88AsjqwCkJvpq1R8UF0mxDt2MmUTzC71yeQE
	mrTpD9ZgQ0+uOy/+FBL52plIzcx9ydsD8WhXIPRJAOlt5YFv+Rhm2nqodZhJNp/64zc2eH5dv
X-Google-Smtp-Source: AGHT+IGb7BTLvjKFCt2Sik+bZT5uEy3gW9xtwnB13tcKYfLYMgWMHvbDQJbxJnif13GWVNPmADCadhZ4zi02
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a25:6882:0:b0:d01:60ec:d0e with SMTP id
 d124-20020a256882000000b00d0160ec0d0emr91533ybc.9.1694643081476; Wed, 13 Sep
 2023 15:11:21 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:10:59 -0700
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230913221104.429825-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-3-dhavale@google.com>
Subject: [PATCH v1 2/7] erofs-utils: lib: Remove redundant line to get padding
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

padding is only used in the next if() block. Remove the redundant call.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/blobchunk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 86b29c1..fcc71b8 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -91,7 +91,6 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 
 	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
 	ret = fwrite(buf, chunksize, 1, blobfile);
-	padding = erofs_blkoff(sbi, chunksize);
 	if (ret == 1) {
 		padding = erofs_blkoff(sbi, chunksize);
 		if (padding) {
-- 
2.42.0.283.g2d96d420d3-goog

