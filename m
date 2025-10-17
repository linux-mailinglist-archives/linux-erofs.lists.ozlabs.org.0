Return-Path: <linux-erofs+bounces-1220-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086D5BE77AD
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 11:12:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnzcH57pzz3069;
	Fri, 17 Oct 2025 20:12:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760692351;
	cv=none; b=lVi1yVw3KIVu/XQG4AzTadVzcqfx5lbpblwlzQ/U7GyLEfzwo1HDrMAyDWlYaC5VKQM5DpcUJHTfv57RLeYDRHyEbpJXD51BEgeNrLw+ZYXRWgFb9SzrReqXakkOUr5gh+UI3XHR7Ux6zMbnuhhwOQM34w7sUs9hFKcQl5R613nnpPmX4khLeUozYCiBsFMTzN5JslBdY9jWHw3uBz2LBQlBuoIcLuzdOzlRk57aFoJo3MLD9mF1ogyfrJG0jLed9+EAXQdmCvWCY82XxFiCjWaVUxwaToTm6vUntqgy5eiDph//OEE+O61paYiVriBShhfDmnv1tEDaJEV9hGSKow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760692351; c=relaxed/relaxed;
	bh=0AzpApDbX8CFEbC2P7WHNPH2gra+XDIh1eSQ6GUhJZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyHS9gBqoZbsMQ8bWVSzELSxWTRd2eGB/jo5QhF3pDEz/c3Y6g0r6tnjjXrkN+bBE7JeY5DgYZ7/V+Ebl+zmw3GNu2yd0clUos0TvfiDXVYZYKQS60+3u4DrCKwojgPYDvKmFJsFQpKUJq1+154zNVuO5E5QWrSw5ChdMHfSoM2CcshyipsHJTolACQc9wmnjRaLkU+4c/9v8miZllsm1lJT5Jvpmuz25K0pfHCOymZo7DfypHQRThg0pU5tJu0WhFuAOWTKLvEjH4HcAWkvGdKTuHLr2VUEU28Cp1Eg9sBofmRYY2rk0mbof6EYy/c33tJG1pXfxC7LOPgE0qF4gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=jW1cbFKU; dkim-atps=neutral; spf=pass (client-ip=52.13.214.179; helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=378230090=farbere@amazon.com; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=jW1cbFKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.com (client-ip=52.13.214.179; helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=378230090=farbere@amazon.com; receiver=lists.ozlabs.org)
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnzcG5nLXz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 20:12:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1760692351; x=1792228351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AzpApDbX8CFEbC2P7WHNPH2gra+XDIh1eSQ6GUhJZw=;
  b=jW1cbFKUhgPEGP/5aD4qM+za1nsIOvlsrPowDbknt4eOO5UD7O6jTHhe
   vahQBnnaxGaS5uy6hFaTBGoNS3ek4ciZaB+7BhdUWMwXNuGaw0Djmjohr
   YoPu/pYhMRYD7U9nLTGm5XC22awVul1zEYFLNzfy+jeKWI8y3NTzXvCBz
   nG3oSEhb9fWqKwja7gosgzRzcak/RdWQ0UZGSLozVOFEfQcrHMN2l8KSD
   HEr0HTTwNpf4ezaAYHM9W6IF2zlEkDYwFuNNnrSJ5FhFbG+Vzuu/QalO6
   pezIvCrpsAEN0F31mugsJG1jnj3iU9BiO7Kc/vtlKQcOp/12OUPmmHnyY
   w==;
X-CSE-ConnectionGUID: bTqjfIDhQrKPx+D5VJtRrg==
X-CSE-MsgGUID: A/3LiItrTFOsBgjb3vL8og==
X-IronPort-AV: E=Sophos;i="6.19,236,1754956800"; 
   d="scan'208";a="5072939"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:12:28 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:28556]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 143397ca-ae35-4539-a40b-e7fd0de0bac1; Fri, 17 Oct 2025 09:12:28 +0000 (UTC)
X-Farcaster-Flow-ID: 143397ca-ae35-4539-a40b-e7fd0de0bac1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 17 Oct 2025 09:12:28 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 17 Oct 2025
 09:12:12 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<linux@armlinux.org.uk>, <jdike@addtoit.com>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <rric@kernel.org>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
	<evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
	<mihail.atanassov@arm.com>, <brian.starkey@arm.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <fery@cypress.com>,
	<dmitry.torokhov@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>,
	<dm-devel@redhat.com>, <rajur@chelsio.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <malattia@linux.it>,
	<hdegoede@redhat.com>, <mgross@linux.intel.com>, <intel-linux-scu@intel.com>,
	<artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>, <clm@fb.com>,
	<josef@toxicpanda.com>, <dsterba@suse.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<sergey.senozhatsky@gmail.com>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <kuznet@ms2.inr.ac.ru>,
	<yoshfuji@linux-ipv6.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>,
	<herve.codina@bootlin.com>, <Jason@zx2c4.com>, <keescook@chromium.org>,
	<kbusch@kernel.org>, <nathan@kernel.org>, <bvanassche@acm.org>,
	<ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <linux-mm@kvack.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<tipc-discussion@lists.sourceforge.net>
CC: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mateusz Guzik
	<mjguzik@gmail.com>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 22/27 5.10.y] minmax.h: update some comments
Date: Fri, 17 Oct 2025 09:05:14 +0000
Message-ID: <20251017090519.46992-23-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017090519.46992-1-farbere@amazon.com>
References: <20251017090519.46992-1-farbere@amazon.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.116.181]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 10666e99204818ef45c702469488353b5bb09ec7 ]

- Change three to several.
- Remove the comment about retaining constant expressions, no longer true.
- Realign to nearer 80 columns and break on major punctiation.
- Add a leading comment to the block before __signed_type() and __is_nonneg()
  Otherwise the block explaining the cast is a bit 'floating'.
  Reword the rest of that comment to improve readability.

Link: https://lkml.kernel.org/r/85b050c81c1d4076aeb91a6cded45fee@AcuMS.aculab.com
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
---
 include/linux/minmax.h | 53 +++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 51b0d988e322..24e4b372649a 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,13 +8,10 @@
 #include <linux/types.h>
 
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - Retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
  * - Perform signed v unsigned type-checking (to generate compile
  *   errors instead of nasty runtime surprises).
  * - Unsigned char/short are always promoted to signed int and can be
@@ -31,25 +28,23 @@
  *   bit #0 set if ok for unsigned comparisons
  *   bit #1 set if ok for signed comparisons
  *
- * In particular, statically non-negative signed integer
- * expressions are ok for both.
+ * In particular, statically non-negative signed integer expressions
+ * are ok for both.
  *
- * NOTE! Unsigned types smaller than 'int' are implicitly
- * converted to 'int' in expressions, and are accepted for
- * signed conversions for now. This is debatable.
+ * NOTE! Unsigned types smaller than 'int' are implicitly converted to 'int'
+ * in expressions, and are accepted for signed conversions for now.
+ * This is debatable.
  *
- * Note that 'x' is the original expression, and 'ux' is
- * the unique variable that contains the value.
+ * Note that 'x' is the original expression, and 'ux' is the unique variable
+ * that contains the value.
  *
- * We use 'ux' for pure type checking, and 'x' for when
- * we need to look at the value (but without evaluating
- * it for side effects! Careful to only ever evaluate it
- * with sizeof() or __builtin_constant_p() etc).
+ * We use 'ux' for pure type checking, and 'x' for when we need to look at the
+ * value (but without evaluating it for side effects!
+ * Careful to only ever evaluate it with sizeof() or __builtin_constant_p() etc).
  *
- * Pointers end up being checked by the normal C type
- * rules at the actual comparison, and these expressions
- * only need to be careful to not cause warnings for
- * pointer use.
+ * Pointers end up being checked by the normal C type rules at the actual
+ * comparison, and these expressions only need to be careful to not cause
+ * warnings for pointer use.
  */
 #define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
 #define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
@@ -57,19 +52,19 @@
 	__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
 
 /*
- * To avoid warnings about casting pointers to integers
- * of different sizes, we need that special sign type.
+ * Check whether a signed value is always non-negative.
  *
- * On 64-bit we can just always use 'long', since any
- * integer or pointer type can just be cast to that.
+ * A cast is needed to avoid any warnings from values that aren't signed
+ * integer types (in which case the result doesn't matter).
  *
- * This does not work for 128-bit signed integers since
- * the cast would truncate them, but we do not use s128
- * types in the kernel (we do use 'u128', but they will
- * be handled by the !is_signed_type() case).
+ * On 64-bit any integer or pointer type can safely be cast to 'long'.
+ * But on 32-bit we need to avoid warnings about casting pointers to integers
+ * of different sizes without truncating 64-bit values so 'long' or 'long long'
+ * must be used depending on the size of the value.
  *
- * NOTE! The cast is there only to avoid any warnings
- * from when values that aren't signed integer types.
+ * This does not work for 128-bit signed integers since the cast would truncate
+ * them, but we do not use s128 types in the kernel (we do use 'u128',
+ * but they are handled by the !is_signed_type() case).
  */
 #ifdef CONFIG_64BIT
   #define __signed_type(ux) long
-- 
2.47.3


