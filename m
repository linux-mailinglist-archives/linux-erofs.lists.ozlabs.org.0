Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A174FBE2
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 01:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689118722;
	bh=VlZMY7B4OQtHfVwCl2fGa87UX0dm/HNDQvgsMerbs4E=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Lquypofv6uHc+JGD85U6ob4VB3ipslsYEBtG6Uhsc+3IvRKlEp0skDaeAi1vzWpNS
	 b/tIzDBjLRyDZ48SlQpkseCRQagryLLV8WrotzLI29dafI2q+DdSzPLHa9wWDCJe0p
	 tW+b9faZ3YZs5smfPy76GMqR8zbYQtaWexalfWAD14mbqsi4Dg9gFfvcL61t/irJiO
	 I6wyDRGhG0ccVsHa+EJZht7Q7cWYFWIohbiOuz68uspjCHex12b6vPFTzhPfiNCHSU
	 pYS4XwuS0hYHz406B6gwusqsiKiYbVUhoMB7ec94Y0YUdqZRWNEgnUvL6EJaxixof4
	 RZ6me0iT9fJuA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0y4L2GnYz3bnw
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 09:38:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=6Ki0rULe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=39-etzackc6onrkfkvoqyyqvo.mywvsxeh-obypcvscdc.yjvklc.ybq@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0y4G3CWgz30PJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 09:38:36 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53450fa3a18so8770824a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 16:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689118711; x=1691710711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlZMY7B4OQtHfVwCl2fGa87UX0dm/HNDQvgsMerbs4E=;
        b=F6XuiTQdXq8RLmiuq+pupDRXkLZVCFpFluSU5upUN4JVjyeufKX348hNwgjfXl/IAo
         g5Ds9uMRXHoDYLzIbQBAJ0ZGBaY/ks74nwH/LW2rxgp3XarYhhiRDIlUyV3C+GDnSxyl
         Ph4JqvmHCghsr4xSv+8s/oL3cax2hTOJ2Qkz7snwsQgt9hopQAQ/A6TpepqR1WMkV460
         m6CZKC/waOuejy6P/CNn9oI1N81t/9CWF+aHTe5zPfwUz5ULRAtdvSTQa5T5WyPY96RG
         XPaA1ODSH/dC5ujxVOJj8pJnB1UB/COgMCn96psp8uCaqXbnRzevU/NdHBHH+0PmB8xy
         JSBg==
X-Gm-Message-State: ABy/qLYF8SVy1WyJfFPYWJDsikE57Ph4TU00/l+IV9PgykZJ07olemSn
	4Y10yyefTqrzFQo6rrzv8HHZvBbhA7hM
X-Google-Smtp-Source: APBJJlEh1KFYgX73qa7oSh36gSCXi/QGqv/5l19pZiBs2u+PQkzFrZtGOa0EdwtmAe2WF+om3uaJkkHyZ7t9
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:9511:0:b0:55c:2f9f:e427 with SMTP id
 p17-20020a639511000000b0055c2f9fe427mr4581555pgd.5.1689118711049; Tue, 11 Jul
 2023 16:38:31 -0700 (PDT)
Date: Tue, 11 Jul 2023 16:38:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711233816.2187577-1-dhavale@google.com>
Subject: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
Cc: Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mediatek@lists.infradead.org, kernel-team@android.com, linux-arm-kernel@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently if CONFIG_DEBUG_LOCK_ALLOC is not set

- rcu_read_lock_held() always returns 1
- rcu_read_lock_any_held() may return 0 with CONFIG_PREEMPT_RCU

This is inconsistent and it was discovered when trying a fix
for problem reported [1] with CONFIG_DEBUG_LOCK_ALLOC is not
set and CONFIG_PREEMPT_RCU is enabled. Gist of the problem is
that EROFS wants to detect atomic context so it can do inline
decompression whenever possible, this is important performance
optimization. It turns out that z_erofs_decompressqueue_endio()
can be called from blk_mq_flush_plug_list() with rcu lock held
and hence fix uses rcu_read_lock_any_held() to decide to use
sync/inline decompression vs async decompression.

As per documentation, we should return lock is held if we aren't
certain. But it seems we can improve the checks for if the lock
is held even if CONFIG_DEBUG_LOCK_ALLOC is not set instead of
hardcoding to always return true.

* rcu_read_lock_held()
- For CONFIG_PREEMPT_RCU using rcu_preempt_depth()
- using preemptible() (indirectly preempt_count())

* rcu_read_lock_bh_held()
- For CONFIG_PREEMPT_RT Using in_softirq() (indirectly softirq_cont())
- using preemptible() (indirectly preempt_count())

Lastly to fix the inconsistency, rcu_read_lock_any_held() is updated
to use other rcu_read_lock_*_held() checks.

Two of the improved checks are moved to kernel/rcu/update.c because
rcupdate.h is included from the very low level headers which do not know
what current (task_struct) is so the macro rcu_preempt_depth() cannot be
expanded in the rcupdate.h. See the original comment for
rcu_preempt_depth() in patch at [2] for more information.

[1]
https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
[2]
https://lore.kernel.org/all/1281392111-25060-8-git-send-email-paulmck@linux.vnet.ibm.com/

Reported-by: Will Shiu <Will.Shiu@mediatek.com>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 include/linux/rcupdate.h | 12 +++---------
 kernel/rcu/update.c      | 21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade90..0d1d1d8c2360 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,14 +319,11 @@ int rcu_read_lock_any_held(void);
 # define rcu_lock_acquire(a)		do { } while (0)
 # define rcu_lock_release(a)		do { } while (0)
 
-static inline int rcu_read_lock_held(void)
-{
-	return 1;
-}
+int rcu_read_lock_held(void);
 
 static inline int rcu_read_lock_bh_held(void)
 {
-	return 1;
+	return !preemptible() || in_softirq();
 }
 
 static inline int rcu_read_lock_sched_held(void)
@@ -334,10 +331,7 @@ static inline int rcu_read_lock_sched_held(void)
 	return !preemptible();
 }
 
-static inline int rcu_read_lock_any_held(void)
-{
-	return !preemptible();
-}
+int rcu_read_lock_any_held(void);
 
 static inline int debug_lockdep_rcu_enabled(void)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..b34fc5bb96cf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -390,8 +390,27 @@ int rcu_read_lock_any_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
 
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+int rcu_read_lock_held(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		return rcu_preempt_depth();
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_held);
+
+int rcu_read_lock_any_held(void)
+{
+	if (rcu_read_lock_held() ||
+	    rcu_read_lock_bh_held() ||
+	    rcu_read_lock_sched_held())
+		return 1;
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
+
+#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 /**
  * wakeme_after_rcu() - Callback function to awaken a task after grace period
  * @head: Pointer to rcu_head member within rcu_synchronize structure
-- 
2.41.0.255.g8b1d071c50-goog

