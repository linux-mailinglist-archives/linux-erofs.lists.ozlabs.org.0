Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CE89647C
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 08:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712125457;
	bh=SSFVRyprdNCoHzVtKa1oiAt2+jLPVv1TG3Dt0uYl8Qw=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=PdFI5Hg2Ue8AdUaXX4L5VTkxA4yhZ6c7ZPlY+kcay8QBaTHzQBWssICqGc/1h41cH
	 UbJHHs9htgLbkZ/tufmxqbtZpz7qIvZp8YLKc3dsvG/IF5ETqa7sWEAJ5WOiJFohat
	 wMpXoLfloxZ4vqEyhpWWxNjbyFprMcptaJXs5TLWO247wAn5e1eMp3c5aPM9EpSjVU
	 ydINTxB+tZAHMRgTbHzupiosu8b8BSpqtpdMwRPBCzDQeveHx2CVXwmDBSZ+KF4481
	 DgBH7gecDM1z59E7QRhjRqllXHrOBxm+TNpveMupNoQZTulAgYcgHIjF6KnGXyrHEE
	 ryBA/d3Wa3FTA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8ZTY5nYVz3cgk
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 17:24:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=dAoQq+ME;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3bpymzgckc1s6a3o3e79hh9e7.5hfebgnq-7kh8leblml.hse34l.hk9@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8ZTR08Kfz30PD
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 17:24:08 +1100 (AEDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so7303722276.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Apr 2024 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712125445; x=1712730245;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSFVRyprdNCoHzVtKa1oiAt2+jLPVv1TG3Dt0uYl8Qw=;
        b=tKzHmeB7D8oZjNk3hi7MPOFY63RV/Jflis9XRegdUrkEcUTVBL7BeEFcdS9Av5Vz78
         ET1dTJtje7wqm9/H3pKrWDLot2gO+/Y2UFRG9N9bNwneMM4wFju0lApr4EnLxJiitsYQ
         I3JU8PiczLUVWbENtY0BFA9MWRGMJz1uets6+m6iug2MM3HQNhrCCC64Zlt609n6/04q
         QJvxzNT3XCJZSG8p+YFf0gUe7/02LSsktORecbuK5ibBJHWM+wKTyFkVsiNNjAyApOr4
         0miK0d0huKK4CbLhlURnpXoFyV48lwus8qfUdNecAIOtKX3RFcHtcH1D1BRGCT/Yq6eM
         N0VQ==
X-Gm-Message-State: AOJu0Yxtjw6qifBk/ckzS294Beb84aDHSQmFZ/cWexOrD3Bg4DEKf6DV
	IsNoseaCWbIZn1Yf7+W4xwUYbDW2zWMKbAq9q1QDFRy4l/6u9p/6ShT3frh4gaV5a6bLnBhnC2t
	rPsC6bu6uJKDHDKc5mo0GX8uIyfy/xyILZig4eqi9R5odPbFcP3lpK/1EiUXbHuw8OWN4QUL0ru
	kT//+W7x7A3oenvqccJ3dJLCt2YHaps7nzmb98/xtUXmdmQg==
X-Google-Smtp-Source: AGHT+IFt2pM981YKL4lTOB/NAy2jStJ3wR7qPqb7qC7+41ppVJSM2NXGW2P+t/Ztlk+uSnzxhO/n4ZISNL8T
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:9324:8a19:f8f:8ba9])
 (user=dhavale job=sendgmr) by 2002:a05:6902:2485:b0:dcc:8927:7496 with SMTP
 id ds5-20020a056902248500b00dcc89277496mr1006517ybb.5.1712125444896; Tue, 02
 Apr 2024 23:24:04 -0700 (PDT)
Date: Tue,  2 Apr 2024 23:23:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403062357.1705807-1-dhavale@google.com>
Subject: [PATCH v1 0/1] erofs-utils: fix handling of sparse files
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
While working on a enhancement where blocks filled with zeros can be treated
as a hole (sparse file), I stumbled upon a bug. I found during mkfs.erofs,
the utility handles the sparse files by looking at the holes and marking them
as a `erofs_holechunk`. However the calculation of minextblks need to consider
the contiguous valid data blocks only else we end up wrongly merging the
blobchunks and creating inconsistent erofs image.

This can be easily reproduced with below script which creates a file and
punches few holes.

$ cat repro.sh
#!/bin/bash
dd if=/dev/urandom of=sample_sparse_file bs=4096 count=49
fallocate --punch-hole --offset 36864 --length 28672 sample_sparse_file
fallocate --punch-hole --offset 143360 --length 53248 sample_sparse_file
filefrag -v sample_sparse_file
mkdir erofs_image_data
cp --sparse=always sample_sparse_file erofs_image_data/
mkfs.erofs --chunksize=4096 problem_erofs.img erofs_image_data/

You can see that if you mount such image, you will have IO errors.

$ md5sum mountpt/*
md5sum: mountpt/sample_sparse_file: Input/output error

The patch addresses this by tracking the start of contiguous data blocks
and calculating minextblks correctly. So merging of chunks still happens
if possible.

Sandeep Dhavale (1):
  erofs-utils: lib: Fix calculation of minextblks when working with
    sparse files

 lib/blobchunk.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog

