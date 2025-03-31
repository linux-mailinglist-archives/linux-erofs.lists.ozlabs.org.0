Return-Path: <linux-erofs+bounces-127-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EED51A75DC9
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 04:20:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQvx75mljz2xjQ;
	Mon, 31 Mar 2025 13:20:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743387627;
	cv=none; b=ELGSjVzSLAzqho8wHzKg5yQKJSP6jG4FFMkylDpyK2HxwnvywbrLUqG7t1ZbfcnVzcM5nAmcx98OHHOfJmUqDsRjEAU0ZEgyhdHykQZH8tLoV5L/bp+KMTF4FxtREE5C7cjSwtWfgy2jXsVS8VOkQOLLegt+WcEZCw3sVkCI4RGUzo9vbjO/xNLy8NywQ/6ZcFDi+1VBI8bl7AndyN8y5aQqIakIy+MbgN/tqX0kiBwdzyO1ySUMwGOitbNDj4d6QTdqRYoDEPwiP3OO/A4+Oq8GlhqJ22rTii0cAI3fzgHn3jz8eO5KhVQS6utnQQMAiONNn9zAEmOYOmamtHFRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743387627; c=relaxed/relaxed;
	bh=CE/nyia5DEOnQIZIUnbMXDCnBfii1l2JD0CpWO2H6MY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WZ/hACw8hV6T/elPjTvPllhDhUUzcNgVVh/7B6uL7lKBLRWULC6UJmA0LnBs7n1yqHVqkeyvUKCz8YvbWWbqEQzpPPo1xMrqk6bnAHg3Ew5IDochNJTN6VN3MgINp8LPGBsN/0JqCudjQGj00gj8L65l0gVfymz4bqQ+kGG/OZc7Y9BC7/gmeSDGEvdfOJN6igaBO5Afbz5nAhdj8QgtAQLn9og9dOivn0AyNT9tIheqgxlf/0vevyBsCPLurnENkURfmeznP0d8Sv65KK2yLnpGnoQ9X+rd4pYMFoVWknhLQRWQz7oO+x5/lA74dUIMd+tIero0hjjHwhHZ7UkjeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=nVPy1yMd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=35vvpzwckc8suyrcr2vx55x2v.t532z4be-v85w92z9a9.5g2rs9.58x@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=nVPy1yMd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=35vvpzwckc8suyrcr2vx55x2v.t532z4be-v85w92z9a9.5g2rs9.58x@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQvx62jWhz2xjK
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 13:20:25 +1100 (AEDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso10909333a91.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Mar 2025 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743387623; x=1743992423; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CE/nyia5DEOnQIZIUnbMXDCnBfii1l2JD0CpWO2H6MY=;
        b=nVPy1yMd7fhD0x/sQUu0p3JOa5QBg7fCB1Zcf6YfGJFSm5FM+haH+rZSmhqWlZjJ+z
         sgP1t2mKpf8ZNzBI1Yds7mi/ZMx3JThYKjpV/OH0EzOZ96xrll7IFSjIXyKAf8dG2hkE
         knlYl6sGGQdDKVtx/4vBbqFReJ72a8gOncqhTLyS1fSzDPQXrXshV58Ho3GivzWtx3rU
         A4XB9BjHtYQDdWx+6WKD3ij/FTpkJw5Ze5aJ/6i4PKRBAPJoGA58VLjRDnbppnm+dxsm
         PsYk7wKB54ZDnEfqzleyNhLJj5Aqp8MJkFJUSk/7uzptM9Cmug4yPU3xDZTs1yWlqP+/
         e9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743387623; x=1743992423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE/nyia5DEOnQIZIUnbMXDCnBfii1l2JD0CpWO2H6MY=;
        b=CtUzWZe6oYymX5dtChRJpM8TZkT86Ne5lsqpdV/MGdwPrkqdOdFHgn2anJy9xZoViA
         xSMk3E7qvXBuJZL2dlKNs3BL6nEpI8rCvvj1h7h61X5rUuXKVlC1plvr/kscw8ATzidT
         6Ud7CcPDNpaB9MvQWwS8RV0y3Yp85d6LKSiDlyvMoAezckP5R5KRhbPXmt/HLDh+Le31
         nancgDZlr4RM68HcT1NUCG0Vc/6RPh2En6L+7T/Dt1f4FUiU3YDA59KFG0dciRmGxMHS
         2qhhIHal5HxVLITA4iRRtBwvbnEoAH6Cvj7rQ24xpntZnG1ZMCEwLZGNNxJZyHbkIwCD
         BDhg==
X-Gm-Message-State: AOJu0YyjC6NN+v0Lxs3UqZEGqPyPiqPt/TAnQX7cKskJMM94PNzgFGFV
	rGybmUUnbvJNbKQTbdIZnlSSekR336UlW6o22gm1W9NWp4WoSl2UUgGmRu3RHcAevT8o4z8gd1E
	1xk1IOukMLQEkHS4KrxYZQFDZUoCyVVWqq9b9e0ge/0noa8jB567HD6g7hsWzRg7HZneXkZcttg
	h5qibtBl1yLg6j5BSaL0Ozg1dtiGSqrwKE9LOcB5NnH/gB9w==
X-Google-Smtp-Source: AGHT+IHr5kzCuFJpX8RIEt+C13OGCbfgVGDGu5VAxthGCbZAVACvbaHVl3cvJRmLj2GVMsvQphxnC1sEjgqk
X-Received: from pjc3.prod.google.com ([2002:a17:90b:2f43:b0:2fe:7f7a:74b2])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d48:b0:2fe:b774:3ec8
 with SMTP id 98e67ed59e1d1-305321471fcmr9826794a91.23.1743387622875; Sun, 30
 Mar 2025 19:20:22 -0700 (PDT)
Date: Sun, 30 Mar 2025 19:20:07 -0700
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250331022011.645533-1-dhavale@google.com>
Subject: [PATCH v1 0/1] erofs: start per-CPU workers on demand
From: Sandeep Dhavale <dhavale@google.com>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

erofs currently starts per-CPU workers on module_init() which is not
necessary. This starting of resources on cpu hotplug and unplug
shows up in Android where the erofs in built-in and erofs is
not yet being used.

Following patch moves the creation of per-CPU workers on the first
mount and they are removed when on the last unmount.

I tested this with erofs-utils test as well as running reads on
erofs mountpoint while running aggressive cpu online/offline in a
loop, withoutn any issue.

Thanks,
Sandeep.

Sandeep Dhavale (1):
  erofs: lazily initialize per-CPU workers and CPU hotplug support

 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    | 27 +++++++++++++++++++++++++++
 fs/erofs/zdata.c    | 35 +++++++++++++++++++++++------------
 3 files changed, 55 insertions(+), 12 deletions(-)

-- 
2.49.0.472.ge94155a9ec-goog


