Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C07591D97
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 04:30:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M51b9133Wz304j
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 12:29:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=F4eH2Wrt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=F4eH2Wrt;
	dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M51Zx3yf8z2xmr
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Aug 2022 12:29:44 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id f65so3885875pgc.12
        for <linux-erofs@lists.ozlabs.org>; Sat, 13 Aug 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EWRb3xzt1/qhhxVA1jAy3hFLZWWthMpKCo18toOXOuM=;
        b=F4eH2WrtX6vScG4WaEYC6zzjdc57YxPaTZKJ7rA4yEVCEpXju/BWXKwG7ibQsSePYX
         5cfzEnmWNLsjq9i2S7cHRtlFMsDPxkEcrfcX7PcnrmK/GNCY0iY1B5F2x+me17cTg1b+
         ID54qk0FgQdV+NH9uDQ3pmIVck8DlaxabnoJoODSVxiqt/GcFCeilxMHNE4FZsQJLt5G
         vYZQTF/K9HkWb+cYhVjhO3oLi6hBBt1lG2BjPEFdGveDDjd4OsnmSPOYRhWsXM+Hlfou
         8fgph9kljYAd7tAfpMOZHDDHjmHiA9v+YX/hzY46ZuL8LXgkyQ4lRLz2zI5J2nqHq4xy
         OeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EWRb3xzt1/qhhxVA1jAy3hFLZWWthMpKCo18toOXOuM=;
        b=MRjWC57syWNpaCk8Gsk8irjVSGLFGdRnZ+C+KX3Eao0n7XV0pO00gvYLXphvzgCj31
         YtkCA459EuOTMy46HwLan1SmPQ5sF0v0C9BJev2dbFQe+3zmPk9YOqCis8/noT/IqmXP
         iKXmd95dFSpRIoewAkql/FWOho2RG0NTXzWdb3IhnrUdOAcF4W9gywFIw44roYVQBReS
         S6uAQb91GcgXngaySFT2ZHz/wZyRATwkdM3oJTR90vPmo/i0011dhSeBxI4t05bY4S4+
         eJDrHa/7ZM9ZFwhj8YHN4kH/Oi9edL50DOVZrRkje8DEXyCCjnM3fUDfE744dkGTBTZd
         KmOg==
X-Gm-Message-State: ACgBeo292cFgfxvakqN/KkyADda16tkIlPwBrCjvYOLEEvyhEUw2anO5
	LecCSvygRNl4Nam+Y+RcnFbMSDT+R81FwQ==
X-Google-Smtp-Source: AA6agR6FxAq/MX8sdjs6gMaKV416HdNKuARQg0HN64CZyGyTBmxeXXQsXZYdyNQSK7h3nBapprjMzw==
X-Received: by 2002:a63:e348:0:b0:41b:444f:ff5f with SMTP id o8-20020a63e348000000b0041b444fff5fmr8533127pgj.333.1660444181138;
        Sat, 13 Aug 2022 19:29:41 -0700 (PDT)
Received: from localhost.localdomain (catv-219-118-139-126.medias.ne.jp. [219.118.139.126])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b0016c3affe60esm4428074plh.46.2022.08.13.19.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 19:29:40 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: mkfs: updating man to use uid/gid offsetting support
Date: Sun, 14 Aug 2022 11:29:15 +0900
Message-Id: <20220814022915.7964-2-naoto.yamaguchi@aisin.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220814022915.7964-1-naoto.yamaguchi@aisin.co.jp>
References: <20220814022915.7964-1-naoto.yamaguchi@aisin.co.jp>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previous commit add support uid/gid offsetting.
This patch add information of these option to man/mkfs.erofs.1.

Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
---
 man/mkfs.erofs.1 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d811f20..cbc4ae2 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -108,11 +108,21 @@ You may give multiple `--exclude-regex` options.
 Specify a \fIfile_contexts\fR file to setup / override selinux labels.
 .TP
 .BI "\-\-force-uid=" UID
-Set all file uids to \fIUID\fR.
+Set all file uids to \fIUID\fR. 
 .TP
 .BI "\-\-force-gid=" GID
 Set all file gids to \fIGID\fR.
 .TP
+.BI "\-\-uid-offset=" UIDOFFSET
+Add \fIUIDOFFSET\fR to all file uids.
+When this option used combine with force-uid, the final file uids sets
+\fIUID\fR + \fIUIDOFFSET\fR.
+.TP
+.BI "\-\-id-offset=" GIDOFFSET
+Add \fIGIDOFFSET\fR to all file gids.
+When this option used combine with force-gid, the final file gids sets
+\fIGID\fR + \fIGID-OFFSET\fR.
+.TP
 .B \-\-help
 Display this help and exit.
 .TP
-- 
2.25.1

