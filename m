Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A635B73098F
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jun 2023 23:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686776529;
	bh=jRBvz26B7FJMglNZBKLn17tA5D3hP38gzFd0XTOJXis=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=k3GuTLPIC4TtZDwGkHw7N1V4rhETHr8JjXbAutSSYiUnAnRDHvmssgMoXHOShVJvZ
	 3zqVoue+JECpt2fqmaNAjrJi19kG/yT9YvyS4Coht+HJKP7nqbBHrAWnekrDR1E+ty
	 Mjb8ZsJvKqTSgEtsme87JW8XtmbnJ4NArGGdwXDf8AX90jrUIyiMxQh34eimIyMxIN
	 5wkx1qRF9fa6jC/H79bALV9yYSKQn7LtieoWOcOc8HNLPmN/kTVerLxywsUFtJIiIH
	 BYphygsWmROVWd2HEwOitg5F3eowldZy6TnlZASyyLJplw7ZfzWAxHJYLmTBkJcBbA
	 DHEN/+SZQ7Qpw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhHt94TR0z30gt
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 07:02:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=ObICtXjU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhHt40K7tz307V
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 07:02:02 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30adc51b65cso6764258f8f.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jun 2023 14:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686776512; x=1689368512;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRBvz26B7FJMglNZBKLn17tA5D3hP38gzFd0XTOJXis=;
        b=Nc/X7W3YhSVo0YEmxZlmJm91Jpf6rMcG7LpFUHYe41cMgEV/673BxJ4rNbkdEnxsPD
         KPq1hkiAKEIo2JxxKXAdrdDtDV68wh2jM1Oq1fOBUb5mDdhiaRf9BG/wPYA0gYDPEY9p
         dmpblkQbYtIxLRSRTmXAkTeKA0A19C1VP3ylW9KQ+gRIyBhz7GM/89q8iZ/pEMfvgd4u
         qUbSzuQ//qtjrppgIs6hD9yTsF/PWNhRAEsp36tpA/DS7WVPMzPhEwY0EzPj1KHk9rxh
         WVvdR1AgJzJpMFjUeQXEk3qzT/cCu+Nhy3tvw784ljHSdhnjcGe4LIQIobGbgxStFbFd
         C6xg==
X-Gm-Message-State: AC+VfDxVdXCmjtu7KX8nnbU8jKH2DE5uyK+eSgAIhEfPLOOQ+ZHGniSX
	ViOv1gbMsjLDGXn363cSch8jPKwu49tChgvFw4xALS7RxNKCctpxf8uXhA==
X-Google-Smtp-Source: ACHHUZ7YwXTvBNY8HZ5/W7AYN8YELsUB09h9dMSTujb1whhuo2d62rKMw5keh9kdUKDY3DcVPL5ONKk7aV/wAMssap0=
X-Received: by 2002:a5d:44ca:0:b0:307:cb94:85de with SMTP id
 z10-20020a5d44ca000000b00307cb9485demr10808477wrr.11.1686776512005; Wed, 14
 Jun 2023 14:01:52 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 14:01:40 -0700
Message-ID: <CAB=BE-SoekaY1oS1wn383DtHngO2BO1-gsUY-STHk9ciKA1OYA@mail.gmail.com>
Subject: EROFS: Detecting atomic contexts
To: Gao Xiang <xiang@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
One of the partners reported that they are seeing the warning log
which points out that the sleeping function is being called from
invalid context. We have not seen this in internal testing and the
partner does not have a repro yet. Below is the log.

[17185.137395] [T701615] CpuMonitorServi: [name:core&]BUG: sleeping
function called from invalid context at kernel/locking/mutex.c:291
[17185.137427] [T701615] CpuMonitorServi: [name:core&]in_atomic(): 0,
irqs_disabled(): 0, non_block: 0, pid: 1615, name: CpuMonitorServi
[17185.137440] [T701615] CpuMonitorServi: [name:core&]preempt_count:
0, expected: 0
[17185.137447] [T701615] CpuMonitorServi: [name:core&]RCU nest depth:
1, expected: 0
[17185.137459] [T701615] CpuMonitorServi: CPU: 7 PID: 1615 Comm:
CpuMonitorServi Tainted: G S      W  OE
6.1.25-android14-5-maybe-dirty-mainline #1
[17185.137484] [T701615] CpuMonitorServi: Hardware name: MT6897 (DT)
[17185.137498] [T701615] CpuMonitorServi: Call trace:
[17185.137509] [T701615] CpuMonitorServi:  dump_backtrace+0x108/0x15c
[17185.137539] [T701615] CpuMonitorServi:  show_stack+0x20/0x30
[17185.137556] [T701615] CpuMonitorServi:  dump_stack_lvl+0x6c/0x8c
[17185.137578] [T701615] CpuMonitorServi:  dump_stack+0x20/0x48
[17185.137593] [T701615] CpuMonitorServi:  __might_resched+0x1fc/0x308
[17185.137618] [T701615] CpuMonitorServi:  __might_sleep+0x50/0x88
[17185.137634] [T701615] CpuMonitorServi:  mutex_lock+0x2c/0x110
[17185.137668] [T701615] CpuMonitorServi:  z_erofs_decompress_queue+0x11c/0xc10
[17185.137688] [T701615] CpuMonitorServi:
z_erofs_decompress_kickoff+0x110/0x1a4
[17185.137703] [T701615] CpuMonitorServi:
z_erofs_decompressqueue_endio+0x154/0x180
[17185.137721] [T701615] CpuMonitorServi:  bio_endio+0x1b0/0x1d8
[17185.137744] [T701615] CpuMonitorServi:  __dm_io_complete+0x22c/0x280
[17185.137767] [T701615] CpuMonitorServi:  clone_endio+0xe4/0x280
[17185.137779] [T701615] CpuMonitorServi:  bio_endio+0x1b0/0x1d8
[17185.137791] [T701615] CpuMonitorServi:  blk_update_request+0x138/0x3a4
[17185.137822] [T701615] CpuMonitorServi:  blk_mq_plug_issue_direct+0xd4/0x19c
[17185.137834] [T701615] CpuMonitorServi:  blk_mq_flush_plug_list+0x2b0/0x354
[17185.137843] [T701615] CpuMonitorServi:  __blk_flush_plug+0x110/0x160
[17185.137853] [T701615] CpuMonitorServi:  blk_finish_plug+0x30/0x4c
[17185.137863] [T701615] CpuMonitorServi:  read_pages+0x2fc/0x370
[17185.137878] [T701615] CpuMonitorServi:  page_cache_ra_unbounded+0xa4/0x23c
[17185.137888] [T701615] CpuMonitorServi:  page_cache_ra_order+0x290/0x320
[17185.137898] [T701615] CpuMonitorServi:  do_sync_mmap_readahead+0x108/0x2c0
[17185.137918] [T701615] CpuMonitorServi:  filemap_fault+0x19c/0x52c
[17185.137929] [T701615] CpuMonitorServi:  __do_fault+0xc4/0x114
[17185.137948] [T701615] CpuMonitorServi:  handle_mm_fault+0x5b4/0x1168
[17185.137959] [T701615] CpuMonitorServi:  do_page_fault+0x338/0x4b4
[17185.137980] [T701615] CpuMonitorServi:  do_translation_fault+0x40/0x60
[17185.137992] [T701615] CpuMonitorServi:  do_mem_abort+0x60/0xc8
[17185.138020] [T701615] CpuMonitorServi:  el0_da+0x4c/0xe0
[17185.138029] [T701615] CpuMonitorServi:  el0t_64_sync_handler+0xd4/0xfc
[17185.138040] [T701615] CpuMonitorServi:  el0t_64_sync+0x1a0/0x1a4

It's clear that we hit the warning because of
[17185.137447] [T701615] CpuMonitorServi: [name:core&]RCU nest depth:
1, expected: 0

The condition to schedule async work in erofs has been

        if (atomic_add_return(bios, &io->pending_bios))
                return;
        /* Use (kthread_)work and sync decompression for atomic contexts only */
        if (in_atomic() || irqs_disabled()) {
#ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
                struct kthread_worker *worker;

The condition has been in place since the patch [0] early 2021 so a
bit surprising that this was not reported before. However in_atomic()
documentation also warns already that it cannot detect all the atomic
contexts.

A proposed change like below can take care of it. I would like to know
what are your thoughts on it before sending in a fix.

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc4971ee26d2..39e9a4a68b60 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1317,7 +1317,7 @@ static void z_erofs_decompress_kickoff(struct
z_erofs_decompressqueue *io,
        if (atomic_add_return(bios, &io->pending_bios))
                return;
        /* Use (kthread_)work and sync decompression for atomic contexts only */
-       if (in_atomic() || irqs_disabled()) {
+       if (in_atomic() || irqs_disabled() || rcu_preempt_depth()) {
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
                struct kthread_worker *worker;

Thanks,
Sandeep.

[0] https://lore.kernel.org/all/20210317035448.13921-2-huangjianan@oppo.com/
