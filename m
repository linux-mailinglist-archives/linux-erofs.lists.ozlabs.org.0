Return-Path: <linux-erofs+bounces-754-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E9B19EF6
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 11:46:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwWt86VMBz30Yb;
	Mon,  4 Aug 2025 19:46:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.36.218.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754300816;
	cv=none; b=exUpQvAAlBd3e8/NffargyFTFgXkWdMxSw3W3gqR1f69vq0DmBa7KpvVmu0YVzl/GcUKUqOyvim6B0KP/2pQazwtAN7vXwNIgq7JkQZlhd/Euz52R4u10ASGDNraTshzXokK3AT/xuwEslVVDbMiE4ikhfzY9IPgEGv4Md7GZTf8kxFNUc3GpNTZaw7cPc9NMyJOtzWeG3CwuKiZqnNgY18KUItMfG3r4awdwixyibC/gzfODeELPHgdGLYY7fekbJOJbNKLrttWq8FBn+nfmh6sEd1ZnOH63+1od88CgXrqnha0Y9Nu9k/E7t5DC5ZKcZhiSrm3vYPZ6dBC0x+cUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754300816; c=relaxed/relaxed;
	bh=eTtBouiPcuO1vnvhYaGg0gydb3FQa81D2ULvJnG6mWo=;
	h=Date:To:Cc:From:Content-Type:Subject:Mime-Version:Message-Id; b=L/4bianf3cKObD2+8PAafNOqcinYxIz4Su5zUUJehztzUgv2sDUk+JUkrOTLRO/Sl1iEqNP7T9QsIGeMwFrPY9SCjUcMxlOIoNZNZ0djjNeMfjsF478TSxxQRcg90Y3VVH5RLePMvuOocM8Ekkbrbw36bUJO5Be2/0FIelbLBNcOzu0RzL3OWCYviOzb6nXwEeyMjLzVo43zVePthxmRUi46VzDA9bThxULUGC7ba0kVuPzZN2n53Id0fW/ZbdCqbtp5YTm61jD7McAKDRjPYDM6gzkw17a366gNzKrLviCxlldGRcGk6OVccslmLQcUaZcBiUp650ZdhjiX6E0Nrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lixiang.com; dkim=pass (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=uhg910oh; dkim-atps=neutral; spf=pass (client-ip=101.36.218.33; helo=lf-2-33.ptr.blmpb.com; envelope-from=liujunli@lixiang.com; receiver=lists.ozlabs.org) smtp.mailfrom=lixiang.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lixiang.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=uhg910oh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lixiang.com (client-ip=101.36.218.33; helo=lf-2-33.ptr.blmpb.com; envelope-from=liujunli@lixiang.com; receiver=lists.ozlabs.org)
Received: from lf-2-33.ptr.blmpb.com (lf-2-33.ptr.blmpb.com [101.36.218.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwWt604Jjz3069
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 19:46:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1754300554;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eTtBouiPcuO1vnvhYaGg0gydb3FQa81D2ULvJnG6mWo=;
 b=uhg910ohwKggnxVCPrWeXhyt4XxmQVRD05lncZrQvGBEgRW0Jruhi5++c2mk4N0Sc+4Zru
 8GX547U8kmb6L7tc/p7M9vA3A77wrDfUcd7Ejta/TE8p56FeBrwC96sHDbUsBM6WhsCoil
 g3bqfWEXc8d1ci21+lC+q/Ya/suyHUdInPqn7eJwQSQl9dMiJ+3IxNFBetJUp4q2nP9FhC
 7LiepQ9feAhA8r03BBzRUGnSG7nALZtJLPQMg5j7uwO3QO2O2Gz5ecStdxUvy97q1KGXAR
 VAyIEmwaRK34D047S9dFgVZnEd+H7E3gYfNnudfUCfAK8Dk9E2h6jOShVPmO+g==
Date: Mon,  4 Aug 2025 17:38:12 +0800
X-Lms-Return-Path: <lba+268908088+54e1c2+lists.ozlabs.org+liujunli@lixiang.com>
To: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc: <xiang@kernel.org>, <chao@kernel.org>, <yangsonghua@lixiang.com>, 
	"Junli Liu" <liujunli@lixiang.com>
From: "Junli Liu" <liujunli@lixiang.com>
Content-Type: multipart/alternative;
 boundary=335a754728878a2e4651eaa1d3d2d16a1569e66f81f5bf8e88d2ec9b24f6
Subject: [PATCH v2] erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC
X-Original-From: Junli Liu <liujunli@lixiang.com>
Content-Transfer-Encoding: 8bit
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
Message-Id: <20250804093811.295563-1-liujunli@lixiang.com>
Received: from PC-YLX4T052.company.local ([58.33.109.195]) by smtp.feishu.cn with ESMTPS; Mon, 04 Aug 2025 17:42:31 +0800
X-Mailer: git-send-email 2.25.1
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HTML_MESSAGE,MSGID_FROM_MTA_HEADER,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--335a754728878a2e4651eaa1d3d2d16a1569e66f81f5bf8e88d2ec9b24f6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Since EROFS handles decompression in non-atomic contexts due to
uncontrollable decompression latencies and vmap() usage, it tries
to detect atomic contexts and only kicks off a kworker on demand
in order to reduce unnecessary scheduling overhead.

However, the current approach is insufficient and can lead to
sleeping function calls in invalid contexts, causing kernel
warnings and potential system instability. See the stacktrace [1]

The current implementation only checks rcu_read_lock_any_held(),
which behaves inconsistently across different kernel configurations:

- When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU
  critical sections by checking rcu_lock_map
- When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to
  "!preemptible()", which only checks preempt_count and misses
  RCU critical sections

This patch introduces z_erofs_in_atomic() to provide comprehensive
atomic context detection:

1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled,
   as RCU critical sections may not affect preempt_count but still
   require atomic handling

2. Always use async processing when CONFIG_PREEMPT_COUNT is disabled,
   as preemption state cannot be reliably determined

3. Fall back to standard preemptible() check for remaining cases

The function replaces the previous complex condition check and ensures
that z_erofs always uses (kthread_)work in atomic contexts to minimize
scheduling overhead and prevent sleeping in invalid contexts.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1] Problem stacktrace
BUG: sleeping function called from invalid context at
kernel/locking/rtmutex_api.c:510
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107,
name: irq/54-ufshcd
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 0

Link: https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmc=
k-laptop
Signed-off-by: Junli Liu <liujunli@lixiang.com>
---
 fs/erofs/zdata.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 792f20888..2d7329700 100644
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
@@ -1446,8 +1456,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs=
_decompressqueue *io,
=20
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	/* Use (kthread_)work and sync decompression for atomic contexts only */
-	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
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


--335a754728878a2e4651eaa1d3d2d16a1569e66f81f5bf8e88d2ec9b24f6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>Since EROFS handles decompression in non-atomic contexts due to
<br>uncontrollable decompression latencies and vmap() usage, it tries
<br>to detect atomic contexts and only kicks off a kworker on demand
<br>in order to reduce unnecessary scheduling overhead.
<br>
<br>However, the current approach is insufficient and can lead to
<br>sleeping function calls in invalid contexts, causing kernel
<br>warnings and potential system instability. See the stacktrace [1]
<br>
<br>The current implementation only checks rcu_read_lock_any_held(),
<br>which behaves inconsistently across different kernel configurations:
<br>
<br>- When CONFIG_DEBUG_LOCK_ALLOC is enabled: correctly detects RCU
<br>  critical sections by checking rcu_lock_map
<br>- When CONFIG_DEBUG_LOCK_ALLOC is disabled: compiles to
<br>  "!preemptible()", which only checks preempt_count and misses
<br>  RCU critical sections
<br>
<br>This patch introduces z_erofs_in_atomic() to provide comprehensive
<br>atomic context detection:
<br>
<br>1. Check RCU preemption depth when CONFIG_PREEMPTION is enabled,
<br>   as RCU critical sections may not affect preempt_count but still
<br>   require atomic handling
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
<br>BUG: sleeping function called from invalid context at
<br>kernel/locking/rtmutex_api.c:510
<br>in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 107,
<br>name: irq/54-ufshcd
<br>preempt_count: 0, expected: 0
<br>RCU nest depth: 2, expected: 0
<br>
<br>Link: https://lore.kernel.org/r/58b661d0-0ebb-4b45-a10d-c5927fb791cd@pa=
ulmck-laptop
<br>Signed-off-by: Junli Liu <liujunli@lixiang.com>
<br>---
<br> fs/erofs/zdata.c | 13 +++++++++++--
<br> 1 file changed, 11 insertions(+), 2 deletions(-)
<br>
<br>diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
<br>index 792f20888..2d7329700 100644
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
<br>@@ -1446,8 +1456,7 @@ static void z_erofs_decompress_kickoff(struct z_e=
rofs_decompressqueue *io,
<br>=20
<br> 	if (atomic_add_return(bios, &io->pending_bios))
<br> 		return;
<br>-	/* Use (kthread_)work and sync decompression for atomic contexts only=
 */
<br>-	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
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
--335a754728878a2e4651eaa1d3d2d16a1569e66f81f5bf8e88d2ec9b24f6--

