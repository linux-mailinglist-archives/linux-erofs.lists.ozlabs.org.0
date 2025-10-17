Return-Path: <linux-erofs+bounces-1250-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42171BE90A2
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 15:49:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp5m912jvz3chb;
	Sat, 18 Oct 2025 00:49:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760708985;
	cv=none; b=aZNTofRWaumUuYl04OalyXiZoe3w15jI1horDSmgvKMKk2WIojHkXHCG87/Z8QBC8utiss0x6BKse/pBb6XfBtKQMF2p2yk6I5Jt+H+HBkoWdISjb7OSs53kxduiA5SNHhNSiibyKiwv9qzAENSXuEAVtk0GpEUIFpXNXJo8FT/jc9m9TRujarmBH32f75JCDD0IBqKp+kYuR8Xyd/yeCB1n2aFIObWj22LmAwHzvsCp6YkUyZ3LzU4BgCsVQr2LJyKZutn26KfaSBO4u52c8f1EoVseCfIj64bmfoyHjTs9lvMjvATuPWXtV0U+jcorCRJkELAavr9Kh1WiZoQW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760708985; c=relaxed/relaxed;
	bh=LCCTFhOpm5ZTT7S3/peueBw8Hng5N/dbi0f4vcLE3r8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=QdDBxKbL0ZK6m7XRxBu9+y41fLS1L7Xm0JP5w/YFASoQOtFw/SlrW53LSQXFs4o/k4QcU6CEVUzIZeHA6SMQ2OYRF036p/UGyNwt1QvZiEIU/AfkavNGFvOQRaDCyK5Vchf8OFyCwhcb7HfxfgZUECl/YHpEy5sm5y9rtJs9eVk/4emPVbg0PJKpM97+04VRmfGGmdXTH6kT3pM5YsWIpfq3xp+7ubcIT1w1/HhQclPA39KOmHg0g4vsNa4dRobuJYfBIkR07U2GCQIj0cYOCMKfdEku2cEA21zhDkSFlOkVw2e5+vu0sxuYvfqfTXT2W+IQAM9i+BlNgmBp2BJhog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=fail (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=piKF3E5N reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=piKF3E5N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp5m83BxNz3chR
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Oct 2025 00:49:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFAA04B443;
	Fri, 17 Oct 2025 13:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8400BC4CEFE;
	Fri, 17 Oct 2025 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760708982;
	bh=d0Lj/2AqY2X8XCUF/V0nGmJ12l2I6aL9uJ3UcdWXAAw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=piKF3E5NOTogSiG2bqw2AlRUUhPn2MnFQmyQHase3t8PHdRy01JpU7J8csTljlN9F
	 5qredvA7i+PtSPOuoAMsl1ERDx3Dlklt7HoMccXcSz/XoUvVeSZLbpH/bAmYz43xbs
	 kfvHuE512+fNJMnD/OXpj2N15LN/T8LVhVLi4nJ0=
Subject: Patch "minmax.h: move all the clamp() definitions after the min/max() ones" has been added to the 5.10-stable tree
To: David.Laight@ACULAB.COM, Jason@zx2c4.com,
	adilger.kernel@dilger.ca, agk@redhat.com, airlied@linux.ie,
	akpm@linux-foundation.org, alexander.deucher@amd.com,
	alexandre.torgue@st.com, amd-gfx@lists.freedesktop.org,
	andriy.shevchenko@linux.intel.com, anton.ivanov@cambridgegreys.com,
	arnd@kernel.org, artur.paszkiewicz@intel.com, axboe@kernel.dk,
	bp@alien8.de, brian.starkey@arm.com, bvanassche@acm.org,
	chao@kernel.org, christian.koenig@amd.com, clm@fb.com,
	coreteam@netfilter.org, dan.carpenter@linaro.org, daniel@ffwll.ch,
	dave.hansen@linux.intel.com, davem@davemloft.net,
	david.laight@aculab.com, dm-devel@redhat.com,
	dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
	dsterba@suse.com, dushistov@mail.ru, evan.quan@amd.com,
	farbere@amazon.com, fery@cypress.com,
	freedreno@lists.freedesktop.org, fw@strlen.de,
	gregkh@linuxfoundation.org, harry.wentland@amd.com,
	hch@infradead.org, hdegoede@redhat.com, herve.codina@bootlin.com,
	hpa@zytor.com, intel-linux-scu@intel.com, jack@suse.com,
	james.morse@arm.com, james.qian.wang@arm.com, jdelvare@suse.com,
	jdike@addtoit.com, jejb@linux.ibm.com, jmaloy@redhat.com,
	joabreu@synopsys.com, josef@toxicpanda.com, kadlec@netfilter.org,
	kbusch@kernel.org, keescook@chromium.org, kuba@kernel.org,
	kuznet@ms2.inr.ac.ru, linux-arm-kernel@lists.infradead.org,
	linux-erofs@lists.ozlabs.org, linux-mm@kvack.org,
	linux-staging@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-um@lists.infradead.org, linux@armlinux.org.uk,
	linux@rasmusvillemoes.dk, linux@roeck-us.net, liviu.dudau@arm.com,
	lorenzo.stoakes@oracle.com, luc.vanoostenryck@gmail.com,
	luto@kernel.org, maarten.lankhorst@linux.intel.com,
	malattia@linux.it, martin.petersen@oracle.com, mchehab@kernel.org,
	mcoquelin.stm32@gmail.com, mgross@linux.intel.com,
	mihail.atanassov@arm.com, minchan@kernel.org, mingo@redhat.com,
	mjguzik@gmail.com, mripard@kernel.org, nathan@kernel.org,
	ndesaulniers@google.com, ngupta@vflare.org, pablo@netfilter.org,
	pedro.falcato@gmail.com, peppe.cavallaro@st.com,
	peterz@infradead.org, pmladek@suse.com, qiuxu.zhuo@intel.com,
	rajur@chels, io.com@lists.ozlabs.org, richard@nod.at,
	robdclark@gmail.com, rostedt@goodmis.org, rric@kernel.org,
	ruanjinjie@huawei.com, sakari.ailus@linux.intel.com,
	sashal@kernel.org, sean@poorly.run, sergey.senozhatsky@gmail.com,
	snitzer@redhat.com, sunpeng.li@amd.com, tglx@linutronix.de,
	tipc-discussion@lists.sourceforge.net, tony.luck@intel.com,
	tytso@mit.edu, tzimmermann@suse.de, willy@infradead.org,
	x86@kernel.org, xiang@kernel.org, ying.xue@windriver.com,
	yoshfuji@linux-ipv6.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 17 Oct 2025 15:48:32 +0200
In-Reply-To: <20251017090519.46992-26-farbere@amazon.com>
Message-ID: <2025101732-maximize-compound-46ca@gregkh>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


This is a note to let you know that I've just added the patch titled

    minmax.h: move all the clamp() definitions after the min/max() ones

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     minmax.h-move-all-the-clamp-definitions-after-the-min-max-ones.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From prvs=378230090=farbere@amazon.com Fri Oct 17 11:13:38 2025
From: Eliav Farber <farbere@amazon.com>
Date: Fri, 17 Oct 2025 09:05:17 +0000
Subject: minmax.h: move all the clamp() definitions after the min/max() ones
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, <linux@armlinux.org.uk>, <jdike@addtoit.com>, <richard@nod.at>, <anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <mchehab@kernel.org>, <james.morse@arm.com>, <rric@kernel.org>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>, <evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>, <mihail.atanassov@arm.com>, <brian.starkey@arm.com>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>, <jdelvare@suse.com>, <linux@roeck-us.net>, <fery@cypress.com>, <dmitry.torokhov@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>, <rajur@chelsio
 .com>, <davem@davemloft.net>, <kuba@kernel.org>, <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>, <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <malattia@linux.it>, <hdegoede@redhat.com>, <mgross@linux.intel.com>, <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>, <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <xiang@kernel.org>, <chao@kernel.org>, <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <dushistov@mail.ru>, <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>, <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>, <akpm@linux-foundation.org>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>, <willy@infradead.org>, <farbere@amazon.com>,
  <sashal@kernel.org>, <ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>, <herve.codina@bootlin.com>, <Jason@zx2c4.com>, <keescook@chromium.org>, <kbusch@kernel.org>, <nathan@kernel.org>, <bvanassche@acm.org>, <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>, <linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>, <platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>, <linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>, <linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>, <tipc-discussion@
 lists.sourceforge.net>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, Pedro Falcato <pedro.falcato@gmail.com>
Message-ID: <20251017090519.46992-26-farbere@amazon.com>

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit c3939872ee4a6b8bdcd0e813c66823b31e6e26f7 ]

At some point the definitions for clamp() got added in the middle of the
ones for min() and max().  Re-order the definitions so they are more
sensibly grouped.

Link: https://lkml.kernel.org/r/8bb285818e4846469121c8abc3dfb6e2@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/minmax.h |  109 ++++++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -99,22 +99,6 @@
 #define __careful_cmp(op, x, y) \
 	__careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
 
-#define __clamp(val, lo, hi)	\
-	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
-
-#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({				\
-	__auto_type uval = (val);						\
-	__auto_type ulo = (lo);							\
-	__auto_type uhi = (hi);							\
-	BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
-		"clamp() low limit " #lo " greater than high limit " #hi);	\
-	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
-		"clamp("#val", "#lo", "#hi") signedness error");		\
-	__clamp(uval, ulo, uhi); })
-
-#define __careful_clamp(val, lo, hi) \
-	__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
-
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
@@ -171,6 +155,22 @@
 	__careful_op3(max, x, y, z, __UNIQUE_ID(x_), __UNIQUE_ID(y_), __UNIQUE_ID(z_))
 
 /**
+ * min_t - return minimum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define min_t(type, x, y) __cmp_once(min, type, x, y)
+
+/**
+ * max_t - return maximum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define max_t(type, x, y) __cmp_once(max, type, x, y)
+
+/**
  * min_not_zero - return the minimum that is _not_ zero, unless both are zero
  * @x: value1
  * @y: value2
@@ -180,6 +180,22 @@
 	typeof(y) __y = (y);			\
 	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
 
+#define __clamp(val, lo, hi)	\
+	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
+
+#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({				\
+	__auto_type uval = (val);						\
+	__auto_type ulo = (lo);							\
+	__auto_type uhi = (hi);							\
+	BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
+		"clamp() low limit " #lo " greater than high limit " #hi);	\
+	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
+		"clamp("#val", "#lo", "#hi") signedness error");		\
+	__clamp(uval, ulo, uhi); })
+
+#define __careful_clamp(val, lo, hi) \
+	__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
+
 /**
  * clamp - return a value clamped to a given range with strict typechecking
  * @val: current value
@@ -191,28 +207,30 @@
  */
 #define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
 
-/*
- * ..and if you can't take the strict
- * types, you can specify one yourself.
- *
- * Or not use min/max/clamp at all, of course.
- */
-
 /**
- * min_t - return minimum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
+ * clamp_t - return a value clamped to a given range using a given type
+ * @type: the type of variable to use
+ * @val: current value
+ * @lo: minimum allowable value
+ * @hi: maximum allowable value
+ *
+ * This macro does no typechecking and uses temporary variables of type
+ * @type to make all the comparisons.
  */
-#define min_t(type, x, y) __cmp_once(min, type, x, y)
+#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
 
 /**
- * max_t - return maximum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
+ * clamp_val - return a value clamped to a given range using val's type
+ * @val: current value
+ * @lo: minimum allowable value
+ * @hi: maximum allowable value
+ *
+ * This macro does no typechecking and uses temporary variables of whatever
+ * type the input argument @val is.  This is useful when @val is an unsigned
+ * type and @lo and @hi are literals that will otherwise be assigned a signed
+ * integer type.
  */
-#define max_t(type, x, y) __cmp_once(max, type, x, y)
+#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
 
 /*
  * Do not check the array parameter using __must_be_array().
@@ -257,31 +275,6 @@
  */
 #define max_array(array, len) __minmax_array(max, array, len)
 
-/**
- * clamp_t - return a value clamped to a given range using a given type
- * @type: the type of variable to use
- * @val: current value
- * @lo: minimum allowable value
- * @hi: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of type
- * @type to make all the comparisons.
- */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
-
-/**
- * clamp_val - return a value clamped to a given range using val's type
- * @val: current value
- * @lo: minimum allowable value
- * @hi: maximum allowable value
- *
- * This macro does no typechecking and uses temporary variables of whatever
- * type the input argument @val is.  This is useful when @val is an unsigned
- * type and @lo and @hi are literals that will otherwise be assigned a signed
- * integer type.
- */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
-
 static inline bool in_range64(u64 val, u64 start, u64 len)
 {
 	return (val - start) < len;


Patches currently in stable-queue which might be from farbere@amazon.com are

queue-5.10/minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
queue-5.10/minmax-add-a-few-more-min_t-max_t-users.patch
queue-5.10/minmax-improve-macro-expansion-and-type-checking.patch
queue-5.10/minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
queue-5.10/minmax.h-simplify-the-variants-of-clamp.patch
queue-5.10/minmax-add-in_range-macro.patch
queue-5.10/minmax.h-move-all-the-clamp-definitions-after-the-min-max-ones.patch
queue-5.10/minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
queue-5.10/minmax-don-t-use-max-in-situations-that-want-a-c-constant-expression.patch
queue-5.10/minmax.h-remove-some-defines-that-are-only-expanded-once.patch
queue-5.10/minmax.h-use-build_bug_on_msg-for-the-lo-hi-test-in-clamp.patch
queue-5.10/minmax-simplify-min-max-clamp-implementation.patch
queue-5.10/minmax-deduplicate-__unconst_integer_typeof.patch
queue-5.10/minmax-simplify-and-clarify-min_t-max_t-implementation.patch
queue-5.10/minmax.h-add-whitespace-around-operators-and-after-commas.patch
queue-5.10/minmax-sanity-check-constant-bounds-when-clamping.patch
queue-5.10/minmax-avoid-overly-complicated-constant-expressions-in-vm-code.patch
queue-5.10/minmax-make-generic-min-and-max-macros-available-everywhere.patch
queue-5.10/minmax-fix-up-min3-and-max3-too.patch
queue-5.10/minmax.h-reduce-the-define-expansion-of-min-max-and-clamp.patch
queue-5.10/minmax-fix-header-inclusions.patch
queue-5.10/minmax-introduce-min-max-_array.patch
queue-5.10/btrfs-remove-duplicated-in_range-macro.patch
queue-5.10/overflow-tracing-define-the-is_signed_type-macro-once.patch
queue-5.10/minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
queue-5.10/minmax-clamp-more-efficiently-by-avoiding-extra-comparison.patch
queue-5.10/minmax.h-update-some-comments.patch

