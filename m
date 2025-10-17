Return-Path: <linux-erofs+bounces-1198-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99640BE75B0
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 11:05:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnzSZ2C1nz2yMh;
	Fri, 17 Oct 2025 20:05:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760691950;
	cv=none; b=dF7bE28C/TfFB/yspkt2jv2+U1jBRIDav/Tr4FmU9TRnKRpDJlSYLsqO9BrZ3h0e7ypZ0dIYHfvv40lehjTiKXMIhMFI25bokHlKowA7C0F2/21fuSRmwbiArJVpqq3KS/gYuNWsf5DwQRg46LKf9cHaQWTrbY+fJQtbtQMoWeyU8ogB1e1L39/ZcMPwzyL8djtROUa4U2WBt5WHxvwyjZSGgkZ5UBa9SDLb4buyxCvDaLWVp05kxlFQu5jKkknEitK6mlJv30KbBPBwrL/u4V0rAeGzqHJzTG1VVqBbx0kCQpm+AjBt4oBo0i1ieq9iwDY6d5bLZuaVN9ITMnbBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760691950; c=relaxed/relaxed;
	bh=zbj2mTisKzioKQVYABevmwS3PD+KbTl4NbCfwfEx+Qc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/axSCcW4ti31Xx1B/qfhL8pSx0E67ViBKpDZ071Xg37S/d/l9IH4yIl+Q4W6AC/elPaHUDrITzhRycK8uHOztFBOTf86M0s2jOEFgV5LmHkQK2BXo95Dke4tfyY2so/mk4F2G4g/IpaAp6nAIAs+9qowIOCGKLiGAteVNhS4HYQBB8jD02qFD0ZbM/jaxkgbyeGR1OjDSUteqeiFbpWvcwA6yNVhCwyk84u/OjHWGZmW6/gm0POGTQYpJo3i1v77N3BOsTSb3RGTLsZkPph3gsIo/xOAmTVxDJHMhcL/QrNxHEnNc8ldJAYZ+N5QIRoYlLasHJG2NopXcyIIJ30AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=a5GucWfu; dkim-atps=neutral; spf=pass (client-ip=35.162.73.231; helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=378230090=farbere@amazon.com; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=a5GucWfu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.com (client-ip=35.162.73.231; helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=378230090=farbere@amazon.com; receiver=lists.ozlabs.org)
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnzSY0wGxz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 20:05:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1760691949; x=1792227949;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zbj2mTisKzioKQVYABevmwS3PD+KbTl4NbCfwfEx+Qc=;
  b=a5GucWfu0oMh/jrn679vsCIav2pZdaKRLpPYgrL2oErnEOEuOe5i0WKf
   YMxM3G7stVPmMGhE3zm8Xq11odLSGaZlnwTrjYwMxHXZzNP9GXVikcCCU
   ehpJZQB9VjujzUDriyoIy1qTzsVI1VOAYr8lc7hMDO/5ke1MiGyDFy688
   n+UsbeliSxhYVTzgitUfkvdhxmnO8Qh2cIXvNl68USq834Bm+seH8Jm3I
   aUPdgDM0iRh/BwamWbApbkRfPYmifIjADwY775yyqYQaK4pkis4TDkeDn
   nKxnBWt1pqkpu6onrPwaNxRbQwKP0eid6MbxswxLQ/xy63+CaL16eEDWI
   A==;
X-CSE-ConnectionGUID: sSNJqLpZTHKHoAwfMM8Y6A==
X-CSE-MsgGUID: BK1WnszkRHiFffu8t9LkpA==
X-IronPort-AV: E=Sophos;i="6.19,236,1754956800"; 
   d="scan'208";a="4877932"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:05:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:26941]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.61:2525] with esmtp (Farcaster)
 id 74f44794-e502-4348-a685-c94d2b887051; Fri, 17 Oct 2025 09:05:44 +0000 (UTC)
X-Farcaster-Flow-ID: 74f44794-e502-4348-a685-c94d2b887051
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 17 Oct 2025 09:05:38 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 17 Oct 2025
 09:05:23 +0000
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
Subject: [PATCH v2 00/27 5.10.y] Backport minmax.h updates from v6.17-rc7
Date: Fri, 17 Oct 2025 09:04:52 +0000
Message-ID: <20251017090519.46992-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This series backports 27 patches to update minmax.h in the 5.10.y
branch, aligning it with v6.17-rc7.

The ultimate goal is to synchronize all long-term branches so that they
include the full set of minmax.h changes.

- 6.12.y has already been backported; the changes are included in
  v6.12.49.
- 6.6.y has already been backported; the changes are included in
  v6.6.109.
- 6.1.y has already been backported; the changes are currently in the
  6.1-stable tree.
- 5.15.y has already been backported; the changes are currently in the
  5.15-stable tree.

The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness"), which
is missing in kernel 5.10.y.

In mainline, this change enables min()/max()/clamp() to accept mixed
argument types, provided both have the same signedness. Without it,
backported patches that use these forms may trigger compiler warnings,
which escalate to build failures when -Werror is enabled.

The first two patches in this series were added to prevent build
failures caused by changes introduced later in minmax.h.

 - Commit 92d23c6e9415 ("overflow, tracing: Define the is_signed_type()
   macro once") is needed for commit 75ca38c1960f ("minmax: allow
   min()/max()/clamp()").

 - Commit cea628008fc8 ("btrfs: remove duplicated in_range() macro") is
   needed for commit f9bff0e31881 ("minmax: add in_range() macro").

The changes were tested using `make allyesconfig` and
`make allmodconfig` for arm64, arm, x86_64 and i386 architectures.

Changes in v2:
The series was updated after initially backporting and approving the
newer long-term branches.

Andy Shevchenko (2):
  minmax: deduplicate __unconst_integer_typeof()
  minmax: fix header inclusions

Bart Van Assche (1):
  overflow, tracing: Define the is_signed_type() macro once

David Laight (11):
  minmax: allow min()/max()/clamp() if the arguments have the same
    signedness.
  minmax: fix indentation of __cmp_once() and __clamp_once()
  minmax: allow comparisons of 'int' against 'unsigned char/short'
  minmax: relax check to allow comparison between unsigned arguments and
    signed constants
  minmax.h: add whitespace around operators and after commas
  minmax.h: update some comments
  minmax.h: reduce the #define expansion of min(), max() and clamp()
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  minmax.h: move all the clamp() definitions after the min/max() ones
  minmax.h: simplify the variants of clamp()
  minmax.h: remove some #defines that are only expanded once

Herve Codina (1):
  minmax: Introduce {min,max}_array()

Jason A. Donenfeld (2):
  minmax: sanity check constant bounds when clamping
  minmax: clamp more efficiently by avoiding extra comparison

Johannes Thumshirn (1):
  btrfs: remove duplicated in_range() macro

Linus Torvalds (8):
  minmax: avoid overly complicated constant expressions in VM code
  minmax: add a few more MIN_T/MAX_T users
  minmax: simplify and clarify min_t()/max_t() implementation
  minmax: make generic MIN() and MAX() macros available everywhere
  minmax: don't use max() in situations that want a C constant
    expression
  minmax: simplify min()/max()/clamp() implementation
  minmax: improve macro expansion and type checking
  minmax: fix up min3() and max3() too

Matthew Wilcox (Oracle) (1):
  minmax: add in_range() macro

 arch/arm/mm/pageattr.c                        |   6 +-
 arch/um/drivers/mconsole_user.c               |   2 +
 arch/x86/mm/pgtable.c                         |   2 +-
 drivers/edac/sb_edac.c                        |   4 +-
 drivers/edac/skx_common.h                     |   1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
 .../drm/arm/display/include/malidp_utils.h    |   2 +-
 .../display/komeda/komeda_pipeline_state.c    |  24 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   6 -
 drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
 drivers/hwmon/adt7475.c                       |  24 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 drivers/md/dm-integrity.c                     |   6 +-
 drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  18 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/fjes/fjes_main.c                  |   4 +-
 drivers/nfc/pn544/i2c.c                       |   2 -
 drivers/platform/x86/sony-laptop.c            |   1 -
 drivers/scsi/isci/init.c                      |   6 +-
 .../pci/hive_isp_css_include/math_support.h   |   5 -
 fs/btrfs/ctree.h                              |   2 -
 fs/btrfs/extent_io.c                          |   1 +
 fs/btrfs/file-item.c                          |   1 +
 fs/btrfs/misc.h                               |   2 -
 fs/btrfs/raid56.c                             |   1 +
 fs/btrfs/tree-checker.c                       |   2 +-
 fs/erofs/zdata.h                              |   2 +-
 fs/ext2/balloc.c                              |   2 -
 fs/ext4/ext4.h                                |   2 -
 fs/ufs/util.h                                 |   6 -
 include/linux/compiler.h                      |  15 +
 include/linux/minmax.h                        | 267 ++++++++++++++----
 include/linux/overflow.h                      |   1 -
 include/linux/trace_events.h                  |   2 -
 kernel/trace/preemptirq_delay_test.c          |   2 -
 lib/btree.c                                   |   1 -
 lib/decompress_unlzma.c                       |   2 +
 lib/logic_pio.c                               |   3 -
 lib/vsprintf.c                                |   2 +-
 lib/zstd/zstd_internal.h                      |   2 -
 mm/zsmalloc.c                                 |   1 -
 net/ipv4/proc.c                               |   2 +-
 net/ipv6/proc.c                               |   2 +-
 net/netfilter/nf_nat_core.c                   |   6 +-
 net/tipc/core.h                               |   2 +-
 net/tipc/link.c                               |  10 +-
 49 files changed, 312 insertions(+), 169 deletions(-)

-- 
2.47.3


