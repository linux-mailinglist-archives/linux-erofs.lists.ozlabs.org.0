Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 6F26B8CDBC3
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 23:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1716498130;
	bh=M/HmLCH3c19lmt27AHsRHJHVrvbHM1vlAkuL9TrnErI=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=b+ufS9UJwfuJR5mWQJ0f+FKEe3VEq7YOkWQ4EZ4dAPteDZItJB6hB9rU5R3e/UIMT
	 56x/ZIOnHthUc1qVO+d7rsIkZi4xJ1fcL33coQ8pv2uOg+HJTk/zpsTWVCrLb7yhZ7
	 qNQ1ulLJM64HBJEISpu5ICn0dAQSdPP8mfQzfDWBU98kjS6NdFbJO82AeEW0AlWgye
	 K8kU1eic0yjv33nK1FRJMdo4BkXPHrcgc9s49tqdLPP08rLI+gCuvJfO6+a6hXq+Rb
	 J0eFAT2zYydHGxo+62i/16+wduxaHWq6JulZADLNSPOzeM5pELeKSgRKxbFegRI22i
	 ddfMbsmxUh/7g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlgbQ0clbz87Wh
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 07:02:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=COvykfuB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3s65pzgckc4gptm7mxqs00sxq.o0yxuz69-q30r4xu454.0bxmn4.03s@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vlgb16Lrsz3wRQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 07:01:48 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-df773f9471fso91734276.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2024 14:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498100; x=1717102900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/HmLCH3c19lmt27AHsRHJHVrvbHM1vlAkuL9TrnErI=;
        b=S6abf9uahFS8n385eOxvi+ff7E8YQPspWF7oOe0qdBvF9+VXCq5/bzNMNe8tnDs3yJ
         hbbEdU67JXWgZQ4/oCYMglMUFhAfQ7Uh4gPTO4UI3jDvZQHhzIPmzAFg03LSRUONaUsj
         nlK30O0xkPoqdMglFsOH58tMrgCqFpSMd+fbeDCZZ0xzXmfSa1Fj+I/UE3XN6c7oXZU9
         AcuoSfPtlDnvvUbNMA+70ApTx3Ixb2fSBS80pD+NQQP+5F757LUivBlywzmpKLO/yn82
         4J282aiFsa+HQQfRlb3SN27+BkuCYJcl593hKXFHPpnwh0+//83V3cc5KqxDVKLK5rli
         gS6w==
X-Gm-Message-State: AOJu0Ywnol2EbVNtpCm63JHOiokfvFjWs1zbqoZ+pJ2HOw30Vs9pRWJb
	l4NTs4F7s19YEZ68bYda9JC4OWELowb+ORx6UGE0zZxMG7DPmh3u1gtAMeQJMe4IMoCzWrVkEYV
	qWkAbkrDQfxmFPZpAPDBvmZ6IJJiVjFRotEE5q8W98Yq8RzZ7+q812WVwk71k/aLiUVJQEAL3/q
	piRq4L26uXyn0HzZQbSsW5JWzKz5e0LqA8oEopMynghr5UDw==
X-Google-Smtp-Source: AGHT+IGsAlnBucIKnBiVf4FOzY8jbAVd623MElLOINWi0LW5FvSZqEdG5DNEmog0hl/ubbFyMuv5QlCG7Qf+
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:a2ff:32db:ca12:f9f5])
 (user=dhavale job=sendgmr) by 2002:a25:ad96:0:b0:df4:9d0c:5c60 with SMTP id
 3f1490d57ef6-df7721f55c3mr85519276.7.1716498099012; Thu, 23 May 2024 14:01:39
 -0700 (PDT)
Date: Thu, 23 May 2024 14:01:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523210131.3126753-1-dhavale@google.com>
Subject: [PATCH 0/2] erofs-utils: improve performance of mkfs with dedupe
To: linux-erofs@lists.ozlabs.org
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, junbeom.yeom@samsung.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I got a report from AOSP user that performance of mkfs.erofs with dedupe
option that mkfs.erofs time increased to very high number. For example
creation of 8GB uncompressed erofs image increased from 36seconds to
27minutes when dedupe was enabled. After profiling mkfs.erofs for sample
data, I observed that the actual increased in time was coming from
erofs_blob_exit() and debugging further it showed that real inefficiency
was coming from hashmap_iter_first() which starts scanning for the first
element from tablepos = 0 always.

The following patches solve this by
- creating a helper function to disable hashmap shrinking
- using hashmap_iter_next() to avoid scanning from 0 and as rehashing is
  disabled it is guaranteed to go through all the elements even while
  doing hashmap_remove().

Test results now show order of magnitude improvements for larger
filesystem size.

You can verify the improvements with below steps

$ mkdir fs_data
$ dd if=/dev/urandom of=fs_data/random_file.bin bs=1M count=8192
$ time mkfs.erofs --chunksize=4096 erofs_dedupe.img fs_data

fs_size  Before   After   Improvement
1G       23s      7s	  3.2x
2G       81s      15s	  5.4x
4G       272s     31s     8.77x
8G       1252s    61s     20.52x

Thanks,
Sandeep

Sandeep Dhavale (2):
  erofs-utils: lib: provide helper to disable hashmap shrinking
  erofs-utils: lib: improve freeing hashmap in erofs_blob_exit()

 include/erofs/hashmap.h | 4 ++++
 lib/blobchunk.c         | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.45.1.288.g0e0cd299f1-goog

