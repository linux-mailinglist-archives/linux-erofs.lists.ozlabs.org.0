Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4579F4C7
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643122;
	bh=KQCeDJayjacRGiTOvOa8EV92G+cn8qrjSsG8QL7Onxk=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Aq7O0DBA10uiiHtLZZ3M9rDvY7w1EyR19l+RFOCPBOYKKThAc2iyhFfShsDtaKyl/
	 rqJTZsiEFziumxSpS4G2cRYaBVgpyT9OuYuJRZeRU97M9ZQH6oEzoQD0BnFxRlAMo7
	 FzbzfzlFc8t32Ej7P7KcIk6arcXcJlb4FQCnYghFPbPtO8MBA4fEWoyb8Wkqzkw/Hd
	 jSAY9rgwruGpi9Iwz6ueEui7yn8LH8KgztSjUWdE58/s+Ne5a93pfNwW+jfFE0lPUa
	 FU7Ve0GbKsxwiuW4B3OrEZMMIVUJeAATzmd1fOvDltNba5n9IKzCeD3xCaFG6NxVmR
	 rScWJQTwA4rpw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF6p6ctzz3cF1
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:12:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=k5ufEMIS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3kjmczqckczequninyrtbbtyr.pbzyvahk-rebsfyvfgf.bmynof.bet@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF6D6v0pz3cG0
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:32 +1000 (AEST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso4094997b3.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643091; x=1695247891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQCeDJayjacRGiTOvOa8EV92G+cn8qrjSsG8QL7Onxk=;
        b=rxglCmfDxNjOsa/ahbY3VEisxuUPeFvp+WKnQZhOhmRc2Peph3JhZtdPsbBU3CyPdV
         z1S6fs6lfwIQP01rLTrnFY9eVRMcLp/YnNKEIPbOhfThV1XxGT4wIriwZEsTYfB3cypt
         jCq1D9mQ6WqMGo3RSDHkDbvNCspjD6KF6M/kOrCPVvVCKK4IoeTE0sY2bIONEPx11GSX
         KGtgqH6YLPF1SXu1dN0ea+fZ/uDKDYpJc6uaPvuWTj8PWAdLDiY0P/eW9jNXsKxK9Wlv
         LY4z08k1101qE/2HorIyqAPgejvDJKjkXrXt1Cw1kug0atheBV7iH8/i7bYOINhM9NID
         wCTA==
X-Gm-Message-State: AOJu0YzFTtXnhBdYOUbSikSXP9YIGTAr26PtkX2RjH+0YlFSzk17+ubz
	MgC9KfuQ9O9Qv61yetbx71PFq+muanOVgmF0uIWZ2tSN1wdvy3Mk3WM8Ihde1IWrqujDVlaJnTM
	8jfRGtOHoK85SSK/f/Tbw2LjpIQ36UIFG+mtdBcsMj96X9Pc+Q2HbSmVG4w1Q743C1V8fVkoX
X-Google-Smtp-Source: AGHT+IF26DsCpY49bm7wyHYhXVw1BNanK4RbzyZ01vuBdPzOukBnoJluuixD3M0DxCFGwBlhWedlpspVdhHg
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a05:690c:ed5:b0:59b:eace:d46f with SMTP id
 cs21-20020a05690c0ed500b0059beaced46fmr11868ywb.8.1694643090904; Wed, 13 Sep
 2023 15:11:30 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:11:04 -0700
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230913221104.429825-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-8-dhavale@google.com>
Subject: [PATCH v1 7/7] erofs-utils: lib: tar: Initialize the variable to
 avoid using garbage value
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

The value in variable 'e' is checked without initializing and can
wrongly signify end of tar 2 empty blocks.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index b58bfd5..c4c89ec 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -549,7 +549,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 	char path[PATH_MAX];
 	struct erofs_pax_header eh = tar->global;
 	struct erofs_sb_info *sbi = root->sbi;
-	bool e, whout, opq;
+	bool whout, opq, e = false;
 	struct stat st;
 	erofs_off_t tar_offset, data_offset;
 
-- 
2.42.0.283.g2d96d420d3-goog

