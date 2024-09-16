Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7926979C23
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 09:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726472373;
	bh=WohYSK31clllGiH95dMbXWRXBt/EhC1bH9X+zlyrT9k=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=NIv6+0YsitLRnYU6z4s4zSr59rHljYO7bKcoK8Qj+ejPYu5zuy8WDmHp770UMG3Ni
	 r3EUSPz/75hK2rJpS8p1zuu8IlunU/+mRsnr/MEeiPbO/b1nGiYr8KVZwoS2p0grKi
	 7fChcdraAIAbwdUnnJG3raQDXgM41A5RhFdJZMKsIc8jfDF6LFyeR5UY7Tpr+JnuES
	 IU9taAZyymWMiKTRDW5HjvYiB/NUWB/AClRneXEHadWYEr0F0uTZAJ6ndlmCCmgyhW
	 Fhonm10zyIIn2xozyZn7qt9pNVSDSveay81Biae13Fx1V4yzUuAwZBf4pe9h8R76Fk
	 u+bPNeJME+KqQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6cHn6V3dz2yhG
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 17:39:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726472371;
	cv=none; b=HPdD5cTp2bepKbqetRhU/ARhz99aw1+VCgw/35eXIK8Ir7O/gZbjnneY2JKUgErvb3IbaGnsHLeL+pENlPf0W1iBr59C7lqa0gFkwxqMebJlqJL77sox4TuuANZG+d02s2Qsnh9RhxRIvtcff/C3hdDjo5gWIB8TmTsFfeg0A3f+EUOwRl2ro8QIqd2xxsgwfn5V6wKiaGBJ6MP1cSW1Eux2/j3R1fw1D3CUaZucCnuk417G1oPuW9+Jwr2lXuftm7zylr5DO8eLgzhrMfsCf6NMuIzjBGKuIDGjXKY9LnEFXvpnzXiA92q17nAeiRQJIkAr6fRlJZkUqXJY6Cygkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726472371; c=relaxed/relaxed;
	bh=WohYSK31clllGiH95dMbXWRXBt/EhC1bH9X+zlyrT9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUvKeCKKOrKsiu2E14qKYuEnfYqa8Ow0SUJxY7XLjcvkWN/9NC5e8OB7weYZmvSPLn3AiVL2rCcjNRLD4MiaZbPKlLNqtzRIz7KukY2+VcsyBtHM5nDTvxSNTpczNdOuMAV2bKP3L51VR53l0zpGTLOJPHmxGWYStCUSvt5BbuliwE44XjuHSUgYp4SLvvt2OJxFO5GIEzUtF1MCQWyQLsOhyKd57mRl0XlkN6q9jhS6HfKNAKFnLktW3cVw2B5nYIRBsBDWUKxeXADpWe5qSEHzU0Pib3Se0t8KRLe/+v0nuJDjVkFQf0255jt/2w558OQt2hLH2JiajqAXjyIMtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=LsV0JCj+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org) smtp.mailfrom=orbstack.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=LsV0JCj+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=orbstack.dev (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6cHk4pZCz2xs8
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 17:39:29 +1000 (AEST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7ac83a98e5eso98169085a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1726472365; x=1727077165; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WohYSK31clllGiH95dMbXWRXBt/EhC1bH9X+zlyrT9k=;
        b=LsV0JCj+pyEloQzh6E9RqEGMDkVb3dY6lwzRmJEWZmVD8ca4F8kCci//4xRub0YUis
         lCv65UMjaU5XSST5Km9pEujGCbMx/2A0t8K0PhUjZ7CK99LtoWPKcIRVyfqVh7Xf0AKs
         FMekxfbdi/73bIH4pIuJF1POET796FxfXgbY6/BE6ibmJ4d4sHbbwjjQyDoMukOh/7HV
         HdisD57OnBHXN8zKGpw5H3rg+10HDA3ZwqmnIXZnHf6R8oGTE09Lyeu1KbU9j/89t9ti
         62KOrWLJIT8nFQnaXChEbt2mXrgKSXc3Ea7lj0NDn8Uf21i5rJaR2fiB+xtGiQvuGXeC
         +Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472365; x=1727077165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WohYSK31clllGiH95dMbXWRXBt/EhC1bH9X+zlyrT9k=;
        b=oD7ajEILK5Dl5C8f3QFEseGs1R/68omB70JNqNIp1ktzULvwoXEKVBr2xanPKVkjf1
         jYAel310DYRearaGH4l3mLXfWuX0BizklE/6MZSBZH1sB9A26wTJj/CLIslLWeaXuSoL
         B7iefQW/VtWG7EYyuWK4AsD69BPsXxN7jpX3wD9jVDQC8Lq8xau+yLX67VfdrocPP3gK
         eOGG8nJ1RH8FmCAnz5rgRHDm7YHwx1re5i6ca6w5Ko8H6H/snrosUYROw1yhc/uswbcY
         VXqMA3tr/nWCO6sY76qaLosu0Roo79Rl4/F8/hBM9oh2+KyqK5/PBhrWRnhfjixHImjM
         X58g==
X-Gm-Message-State: AOJu0YzEHnYpNx/SUmU/efgqe/LSLsj8ccjKeFoVOqkVQh7Kp+SzcfUZ
	xOqP0bqAoAqE4gIuw52z1/Bc5rqza+HA4uBC9+baVOKwXJbk+3zEa4wS9X3xLF6b1ZGV0i0tyaP
	dRxE2YdYoWclkFvy6F3e/+9x/i1w8dSfid203NL+H6pmMSOQe7H1SPjTD+2oZdW6l9JMbn9M/YA
	q2tICbHfDe1IbiNkN/GvRKMGKS6UDKoNh7vBh+3B6Jgqtr
X-Google-Smtp-Source: AGHT+IFfe01SIEuw5FYE8AOr6ZFEZlvQHDENoka75R7Kh9fuWpXQJRl7AlEOCQf54hxtnRy4R6CVhw==
X-Received: by 2002:a05:620a:29c7:b0:7a9:ab71:f7f2 with SMTP id af79cd13be357-7a9e60bb820mr2511745285a.15.1726472365293;
        Mon, 16 Sep 2024 00:39:25 -0700 (PDT)
Received: from arch.. ([38.42.120.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3eb632cdsm224411785a.115.2024.09.16.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:39:25 -0700 (PDT)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix compressed packed inodes
Date: Mon, 16 Sep 2024 00:38:30 -0700
Message-ID: <20240916073835.77470-1-danny@orbstack.dev>
X-Mailer: git-send-email 2.46.0
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
From: Danny Lin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Danny Lin <danny@orbstack.dev>
Cc: Danny Lin <danny@orbstack.dev>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Commit b9b6493 fixed uncompressed packed inodes by not always writing
compressed data, but it broke compressed packed inodes because now
uncompressed file data is always written after the compressed data.

The new error handling always rewinds with lseek and falls through to
write_uncompressed_file_from_fd, regardless of whether the compressed
data was written successfully (ret = 0) or not (ret = -ENOSPC). This
can result in corrupted files.

Fix it by simplifying the error handling to better match the old code.

Fixes: b9b6493 ("erofs-utils: lib: fix uncompressed packed inode")
Signed-off-by: Danny Lin <danny@orbstack.dev>
---
 lib/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index bc3cb76..797c622 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1927,14 +1927,16 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 
 		DBG_BUGON(!ictx);
 		ret = erofs_write_compressed_file(ictx);
-		if (ret && ret != -ENOSPC)
-			 return ERR_PTR(ret);
+		if (ret == -ENOSPC) {
+			ret = lseek(fd, 0, SEEK_SET);
+			if (ret < 0)
+				return ERR_PTR(-errno);
 
-		ret = lseek(fd, 0, SEEK_SET);
-		if (ret < 0)
-			return ERR_PTR(-errno);
+			ret = write_uncompressed_file_from_fd(inode, fd);
+		}
+	} else {
+		ret = write_uncompressed_file_from_fd(inode, fd);
 	}
-	ret = write_uncompressed_file_from_fd(inode, fd);
 	if (ret)
 		return ERR_PTR(ret);
 	erofs_prepare_inode_buffer(inode);
-- 
2.46.0

