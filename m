Return-Path: <linux-erofs+bounces-752-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3EB19DFB
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 10:50:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwVd15vzLz3069;
	Mon,  4 Aug 2025 18:50:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.36.218.37
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754297429;
	cv=none; b=i5AMV2LFqCzOtcNeSmDTRxQO4z+Mjy8OvmwiG94EisO72KrdTG0TVaG58muTq+v3m6z6j82K1J9IEMi4SzQgYr+otOZlTCcZBC2qAWjYYZ+tyutgkt78G2UF2cGQchlN7nJwbu+7b0l2iyZKQGmjdErP763ca4yD9nN7vYU+hh56oawb+CLWfuySmOEU1NJe+n+Sw2Oh8Vdo52JhmnYnQiomyrDM3k9mr4zwXltZIqLQaxadBOQkf+qiO6uhO1vlDK0tlDY9A8G6PHMzUvpjdCobOZ8bwo+HQ4WkPVgv2Xpnlxdku4qidE7ZUAp2Xf1cSFdpcHGLRiBu5A58VEs0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754297429; c=relaxed/relaxed;
	bh=zP0Pc5mK4hGeyxAL3zP2y76aDtwZwIiE10g17gWzOPE=;
	h=Date:Cc:Message-Id:Mime-Version:Content-Type:To:From:Subject; b=B6iXDZoa47okKcyh7F8/zpzUZcs5kaxL+tgt3LGC/03W8eR0xEMWYOUREKobAM6Xm6JEpZ9reL/UKEgZhpu1Z6HgbSraQzgGy9+pxykotD782G+r7/OC+vG6w04uvx4FJ1DFk3/XDpKE8aYzXI3jfIV3VvU9CtZsvbjvRMsWiDqBoJ5xxmjC2hBQYrA2KT6DFTluZnN9viebkdA1q5jbIMxFq+DUQVqt2quS2JNHkZMpBgCGSXY0zZRhFSEQMJhifKs6IMXdPZqmekfi8TwCVUT6/8vbkC1F8TRnmezMnMQbxQILGD4axIyahrmU8Mxiuu6Z7j9VGJKMg1FlhS7dlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lixiang.com; dkim=pass (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=BuRrrqBE; dkim-atps=neutral; spf=pass (client-ip=101.36.218.37; helo=lf-2-37.ptr.blmpb.com; envelope-from=liujunli@lixiang.com; receiver=lists.ozlabs.org) smtp.mailfrom=lixiang.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lixiang.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=BuRrrqBE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lixiang.com (client-ip=101.36.218.37; helo=lf-2-37.ptr.blmpb.com; envelope-from=liujunli@lixiang.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 918 seconds by postgrey-1.37 at boromir; Mon, 04 Aug 2025 18:50:25 AEST
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwVcx6r5Mz2yLB
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 18:50:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1754296243;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=zP0Pc5mK4hGeyxAL3zP2y76aDtwZwIiE10g17gWzOPE=;
 b=BuRrrqBEjm8jwWbN6C+UKQaJpEzXnU0gxK6HFNLhaYeruri0qGeRPrKLlu3lBZ6tTX0XdT
 u475SqJPUJ5S+R1Maa4zJybLPfnYBl8KGNUOvGM7dU4BgNkQi+BH4gkRgu6i88QqZ83Ki6
 hAPI7/P/CWqvn3uxdM61MHAMq6whlfNabxRQCf0XPhFWVkhocF4RAfC3/LfonZd0x5pqOW
 JMr+b5z3Ej5k6oP8hQ6GpMAb72QQhRVtGyjGJA5C3/P7nxyQTrYoHrPhxo1Mb5ndHyKP/7
 sLPTH1AN6O1xjnHipfWljqcGH/ake3ZZCexxQ5+3B6qQ2HIgq/Bxe62+SgzSBQ==
Date: Mon,  4 Aug 2025 16:29:13 +0800
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+268906fb1+165b28+lists.ozlabs.org+liujunli@lixiang.com>
Content-Transfer-Encoding: 8bit
Received: from PC-YLX4T052.company.local ([58.33.109.195]) by smtp.feishu.cn with ESMTPS; Mon, 04 Aug 2025 16:30:41 +0800
X-Original-From: Junli Liu <liujunli@lixiang.com>
Cc: <linux-kernel@vger.kernel.org>, <gao.xiang@linux.alibaba.com>, 
	<linux-mediatek@lists.infradead.org>, <chao@kernel.org>, 
	<xiang@kernel.org>, <yangsonghua@lixiang.com>, 
	"Junli liu" <liujunli@lixiang.com>
Message-Id: <20250804082912.242580-1-liujunli@lixiang.com>
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
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary=0948fac8ab6a4a45ad985c6adc286ff39db934ee13aa86edea89220bbec4
To: <linux-erofs@lists.ozlabs.org>
From: "Junli Liu" <liujunli@lixiang.com>
Subject: [PATCH] erofs: Fix detection of atomic context to prevent sleeping in invalid context
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HTML_MESSAGE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--0948fac8ab6a4a45ad985c6adc286ff39db934ee13aa86edea89220bbec4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

From: Junli liu <liujunli@lixiang.com>

The current atomic context detection is insufficient and can lead to
sleeping function calls in invalid contexts, causing kernel warnings
and potential system instability. See the stacktrace [1]

The current implementation only checks rcu_read_lock_any_held(), which
behaves inconsistently across different kernel configurations:

- When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU critical
  sections by checking rcu_lock_map
- When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to "!preemptible()",
  which only checks preempt_count and misses RCU critical sections

This patch introduces z_erofs_in_atomic() to provide comprehensive atomic
context detection:

1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled, as RCU
   critical sections may not affect preempt_count but still require
   atomic handling

2. Always use async processing when CONFIG_PREEMPT_COUNT is disabled,
   as preemption state cannot be reliably determined

3. Fall back to standard preemptible() check for remaining cases

The function replaces the previous complex condition check and ensures
that z_erofs always uses (kthread_)work in atomic contexts to minimize
scheduling overhead and prevent sleeping in invalid contexts.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1] Problem stacktrace
[ 61.266692] BUG: sleeping function called from invalid context at kernel/l=
ocking/rtmutex_api.c:510
[ 61.266702] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107, na=
me: irq/54-ufshcd
[ 61.266704] preempt_count: 0, expected: 0
[ 61.266705] RCU nest depth: 2, expected: 0
[ 61.266710] CPU: 0 UID: 0 PID: 107 Comm: irq/54-ufshcd Tainted: G W O 6.12=
.17 #1
[ 61.266714] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[ 61.266715] Hardware name: schumacher (DT)
[ 61.266717] Call trace:
[ 61.266718] dump_backtrace+0x9c/0x100
[ 61.266727] show_stack+0x20/0x38
[ 61.266728] dump_stack_lvl+0x78/0x90
[ 61.266734] dump_stack+0x18/0x28
[ 61.266736] __might_resched+0x11c/0x180
[ 61.266743] __might_sleep+0x64/0xc8
[ 61.266745] mutex_lock+0x2c/0xc0
[ 61.266748] z_erofs_decompress_queue+0xe8/0x978
[ 61.266753] z_erofs_decompress_kickoff+0xa8/0x190
[ 61.266756] z_erofs_endio+0x168/0x288
[ 61.266758] bio_endio+0x160/0x218
[ 61.266762] blk_update_request+0x244/0x458
[ 61.266766] scsi_end_request+0x38/0x278
[ 61.266770] scsi_io_completion+0x4c/0x600
[ 61.266772] scsi_finish_command+0xc8/0xe8
[ 61.266775] scsi_complete+0x88/0x148
[ 61.266777] blk_mq_complete_request+0x3c/0x58
[ 61.266780] scsi_done_internal+0xcc/0x158
[ 61.266782] scsi_done+0x1c/0x30
[ 61.266783] ufshcd_compl_one_cqe+0x12c/0x438
[ 61.266786] __ufshcd_transfer_req_compl+0x2c/0x78
[ 61.266788] ufshcd_poll+0xf4/0x210
[ 61.266789] ufshcd_transfer_req_compl+0x50/0x88
[ 61.266791] ufshcd_intr+0x21c/0x7c8
[ 61.266792] irq_forced_thread_fn+0x44/0xd8
[ 61.266796] irq_thread+0x1a4/0x358
[ 61.266799] kthread+0x12c/0x138
[ 61.266802] ret_from_fork+0x10/0x20

Signed-off-by: Junli Liu <liujunli@lixiang.com>
---
 fs/erofs/zdata.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 792f20888..1883781c9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1432,6 +1432,16 @@ static void z_erofs_decompressqueue_kthread_work(str=
uct kthread_work *work)
 }
 #endif
=20
+/* Use (kthread_)work in atomic contexts to minimize scheduling overhead *=
/
+static inline bool z_erofs_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
 {
@@ -1446,8 +1456,8 @@ static void z_erofs_decompress_kickoff(struct z_erofs=
_decompressqueue *io,
=20
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use (kthread_)work and sync decompression for atomic contexts only */
-	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
+
+	if (z_erofs_in_atomic()) {
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
 		struct kthread_worker *worker;
=20
--=20
2.25.1

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
Disclaimer: This email is intended to be read only by the designated recipi=
ent of the document and has high confidentiality requirements. Anyone else =
is prohibited from using, opening, copying or forwarding any of the content=
s inside. If this email was sent to you by mistake, please contact the send=
er of the email and delete this file immediately. Confidentiality and legal=
 privileges are not waived or lost by misdirected emails. Any views or opin=
ions expressed in the email are those of the author and do not necessarily =
represent those of the Company.


--0948fac8ab6a4a45ad985c6adc286ff39db934ee13aa86edea89220bbec4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>From: Junli liu <liujunli@lixiang.com>
<br>
<br>The current atomic context detection is insufficient and can lead to
<br>sleeping function calls in invalid contexts, causing kernel warnings
<br>and potential system instability. See the stacktrace [1]
<br>
<br>The current implementation only checks rcu_read_lock_any_held(), which
<br>behaves inconsistently across different kernel configurations:
<br>
<br>- When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU critic=
al
<br>  sections by checking rcu_lock_map
<br>- When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to "!preemptible()=
",
<br>  which only checks preempt_count and misses RCU critical sections
<br>
<br>This patch introduces z_erofs_in_atomic() to provide comprehensive atom=
ic
<br>context detection:
<br>
<br>1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled, as RCU
<br>   critical sections may not affect preempt_count but still require
<br>   atomic handling
<br>
<br>2. Always use async processing when CONFIG_PREEMPT_COUNT is disabled,
<br>   as preemption state cannot be reliably determined
<br>
<br>3. Fall back to standard preemptible() check for remaining cases
<br>
<br>The function replaces the previous complex condition check and ensures
<br>that z_erofs always uses (kthread_)work in atomic contexts to minimize
<br>scheduling overhead and prevent sleeping in invalid contexts.
<br>
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<br>[1] Problem stacktrace
<br>[ 61.266692] BUG: sleeping function called from invalid context at kern=
el/locking/rtmutex_api.c:510
<br>[ 61.266702] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107=
, name: irq/54-ufshcd
<br>[ 61.266704] preempt_count: 0, expected: 0
<br>[ 61.266705] RCU nest depth: 2, expected: 0
<br>[ 61.266710] CPU: 0 UID: 0 PID: 107 Comm: irq/54-ufshcd Tainted: G W O =
6.12.17 #1
<br>[ 61.266714] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
<br>[ 61.266715] Hardware name: schumacher (DT)
<br>[ 61.266717] Call trace:
<br>[ 61.266718] dump_backtrace+0x9c/0x100
<br>[ 61.266727] show_stack+0x20/0x38
<br>[ 61.266728] dump_stack_lvl+0x78/0x90
<br>[ 61.266734] dump_stack+0x18/0x28
<br>[ 61.266736] __might_resched+0x11c/0x180
<br>[ 61.266743] __might_sleep+0x64/0xc8
<br>[ 61.266745] mutex_lock+0x2c/0xc0
<br>[ 61.266748] z_erofs_decompress_queue+0xe8/0x978
<br>[ 61.266753] z_erofs_decompress_kickoff+0xa8/0x190
<br>[ 61.266756] z_erofs_endio+0x168/0x288
<br>[ 61.266758] bio_endio+0x160/0x218
<br>[ 61.266762] blk_update_request+0x244/0x458
<br>[ 61.266766] scsi_end_request+0x38/0x278
<br>[ 61.266770] scsi_io_completion+0x4c/0x600
<br>[ 61.266772] scsi_finish_command+0xc8/0xe8
<br>[ 61.266775] scsi_complete+0x88/0x148
<br>[ 61.266777] blk_mq_complete_request+0x3c/0x58
<br>[ 61.266780] scsi_done_internal+0xcc/0x158
<br>[ 61.266782] scsi_done+0x1c/0x30
<br>[ 61.266783] ufshcd_compl_one_cqe+0x12c/0x438
<br>[ 61.266786] __ufshcd_transfer_req_compl+0x2c/0x78
<br>[ 61.266788] ufshcd_poll+0xf4/0x210
<br>[ 61.266789] ufshcd_transfer_req_compl+0x50/0x88
<br>[ 61.266791] ufshcd_intr+0x21c/0x7c8
<br>[ 61.266792] irq_forced_thread_fn+0x44/0xd8
<br>[ 61.266796] irq_thread+0x1a4/0x358
<br>[ 61.266799] kthread+0x12c/0x138
<br>[ 61.266802] ret_from_fork+0x10/0x20
<br>
<br>Signed-off-by: Junli Liu <liujunli@lixiang.com>
<br>---
<br> fs/erofs/zdata.c | 14 ++++++++++++--
<br> 1 file changed, 12 insertions(+), 2 deletions(-)
<br>
<br>diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
<br>index 792f20888..1883781c9 100644
<br>--- a/fs/erofs/zdata.c
<br>+++ b/fs/erofs/zdata.c
<br>@@ -1432,6 +1432,16 @@ static void z_erofs_decompressqueue_kthread_work=
(struct kthread_work *work)
<br> }
<br> #endif
<br>=20
<br>+/* Use (kthread_)work in atomic contexts to minimize scheduling overhe=
ad */
<br>+static inline bool z_erofs_in_atomic(void)
<br>+{
<br>+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
<br>+		return true;
<br>+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
<br>+		return true;
<br>+	return !preemptible();
<br>+}
<br>+
<br> static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue =
*io,
<br> 				       int bios)
<br> {
<br>@@ -1446,8 +1456,8 @@ static void z_erofs_decompress_kickoff(struct z_e=
rofs_decompressqueue *io,
<br>=20
<br> 	if (atomic_add_return(bios, &io->pending_bios))
<br> 		return;
<br>-	/* Use (kthread_)work and sync decompression for atomic contexts only=
 */
<br>-	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
<br>+
<br>+	if (z_erofs_in_atomic()) {
<br> #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
<br> 		struct kthread_worker *worker;
<br>=20
<br>--=20
<br>2.25.1</p><meta data-version=3D"editor_version_1.2.12"/><div data-zone-=
id=3D"0" data-line-index=3D"0" data-line=3D"true" style=3D"white-space: pre=
-wrap; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><br></div><d=
iv data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" style=3D"whi=
te-space: pre-wrap; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"=
><div style=3D"text-align: left;"><span style=3D"font-size: 12px;"><span st=
yle=3D"font-family: helvetica;"><span style=3D"color: rgb(143, 149, 158);">=
=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
</span></span></span></div></div><div data-zone-id=3D"0" data-line-index=3D=
"2" data-line=3D"true" style=3D"white-space: pre-wrap; margin-top: 4px; mar=
gin-bottom: 4px; line-height: 1.6;"><div style=3D"text-align: left;"><span =
style=3D"font-size: 12px;"><span style=3D"color: rgb(143, 149, 158);">Discl=
aimer: This email is intended to be read only by the designated recipient o=
f the document and has high confidentiality requirements. Anyone else is pr=
ohibited from using, opening, copying or forwarding any of the contents ins=
ide. If this email was sent to you by mistake, please contact the sender of=
 the email and delete this file immediately. Confidentiality and legal priv=
ileges are not waived or lost by misdirected emails. Any views or opinions =
expressed in the email are those of the author and do not necessarily repre=
sent those of the Company.</span></span><span style=3D"font-size: 12px;"><s=
pan style=3D"font-family: helvetica;"><span style=3D"color: rgb(143, 149, 1=
58);">
</span></span></span></div></div><div data-zone-id=3D"0" data-line-index=3D=
"3" data-line=3D"true" style=3D"white-space: pre-wrap; margin-top: 4px; mar=
gin-bottom: 4px; line-height: 1.6;"><br></div>
--0948fac8ab6a4a45ad985c6adc286ff39db934ee13aa86edea89220bbec4--

